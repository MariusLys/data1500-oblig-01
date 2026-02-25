-- ============================================================================
-- DATA1500 - Oblig 1: Arbeidskrav I våren 2026
-- Initialiserings-skript for PostgreSQL
-- Fil: init-scripts/01-init-database.sql
-- ============================================================================

BEGIN;

-- ---------------------------------------------------------------------------
-- Rydd opp (i riktig rekkefølge pga. FKs)
-- ---------------------------------------------------------------------------
DROP TABLE IF EXISTS utleie CASCADE;
DROP TABLE IF EXISTS sykkel CASCADE;
DROP TABLE IF EXISTS laas CASCADE;
DROP TABLE IF EXISTS stasjon CASCADE;
DROP TABLE IF EXISTS kunde CASCADE;

-- ---------------------------------------------------------------------------
-- Del 1) Tabeller
-- ---------------------------------------------------------------------------

CREATE TABLE kunde (
                       kunde_id      BIGSERIAL PRIMARY KEY,
                       fornavn       VARCHAR(50)  NOT NULL CHECK (length(trim(fornavn)) > 0),
                       etternavn     VARCHAR(50)  NOT NULL CHECK (length(trim(etternavn)) > 0),
                       mobilnummer   VARCHAR(15)  NOT NULL CHECK (mobilnummer ~ '^\+?[0-9]{8,15}$'),
  epost         VARCHAR(254) NOT NULL CHECK (epost ~* '^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$')
);

CREATE TABLE stasjon (
                         stasjon_id BIGSERIAL PRIMARY KEY,
                         navn       VARCHAR(100) NOT NULL,
                         adresse    VARCHAR(200) NOT NULL
);

CREATE TABLE laas (
                      laas_id      BIGSERIAL PRIMARY KEY,
                      stasjon_id   BIGINT NOT NULL REFERENCES stasjon(stasjon_id),
                      posisjon_nr  INTEGER NOT NULL CHECK (posisjon_nr > 0),
                      aktiv        BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE sykkel (
                        sykkel_id     BIGSERIAL PRIMARY KEY,
                        laas_id       BIGINT NULL REFERENCES laas(laas_id),
                        status        VARCHAR(20) NOT NULL CHECK (status IN ('tilgjengelig','utleid','service')),
                        modell        VARCHAR(100) NOT NULL,
                        innkjopsdato  DATE NOT NULL
);

-- En lås kan maks ha én sykkel (men mange sykler kan være "utleid" med NULL laas_id)
CREATE UNIQUE INDEX sykkel_unique_laas
    ON sykkel(laas_id)
    WHERE laas_id IS NOT NULL;

CREATE TABLE utleie (
                        utleie_id          BIGSERIAL PRIMARY KEY,
                        kunde_id           BIGINT NOT NULL REFERENCES kunde(kunde_id),
                        sykkel_id          BIGINT NOT NULL REFERENCES sykkel(sykkel_id),
                        start_stasjon_id   BIGINT NOT NULL REFERENCES stasjon(stasjon_id),
                        slutt_stasjon_id   BIGINT NOT NULL REFERENCES stasjon(stasjon_id),
                        utlevert_tidspunkt TIMESTAMPTZ NOT NULL,
                        innlevert_tidspunkt TIMESTAMPTZ NULL,
                        leiebelop          NUMERIC(10,2) NULL CHECK (leiebelop IS NULL OR leiebelop >= 0),
                        CHECK (innlevert_tidspunkt IS NULL OR innlevert_tidspunkt > utlevert_tidspunkt)
);

-- ---------------------------------------------------------------------------
-- Del 2) Testdata
-- ---------------------------------------------------------------------------

-- 2.1 Kunder (minst 5)
INSERT INTO kunde (fornavn, etternavn, mobilnummer, epost) VALUES
                                                               ('Ole',  'Hansen',    '+4791234567', 'ole.hansen@example.com'),
                                                               ('Kari', 'Olsen',     '+4792345678', 'kari.olsen@example.com'),
                                                               ('Per',  'Andersen',  '+4793456789', 'per.andersen@example.com'),
                                                               ('Lise', 'Johansen',  '+4794567890', 'lise.johansen@example.com'),
                                                               ('Anna', 'Nilsen',    '+4796789012', 'anna.nilsen@example.com');

-- 2.2 Stasjoner (minst 5) – legger inn 5 som i CSV-en
INSERT INTO stasjon (navn, adresse) VALUES
                                        ('Sentrum Stasjon',       'Karl Johans gate 1 Oslo'),
                                        ('Universitetet Stasjon', 'Blindern Oslo'),
                                        ('Grünerløkka Stasjon',   'Thorvald Meyers gate 10 Oslo'),
                                        ('Aker Brygge Stasjon',   'Stranden 1 Oslo'),
                                        ('Majorstuen Stasjon',    'Bogstadveien 50 Oslo');

-- 2.3 Låser (minst 100 = 20 per stasjon)
-- Lager 20 låser per stasjon_id 1..5 => 100 totalt
INSERT INTO laas (stasjon_id, posisjon_nr, aktiv)
SELECT s.stasjon_id,
       p.posisjon_nr,
       TRUE
FROM stasjon s
         CROSS JOIN generate_series(1, 20) AS p(posisjon_nr)
ORDER BY s.stasjon_id, p.posisjon_nr;

-- 2.4 Sykler (minst 100)
-- Viktig: hver sykkel får unik laas_id 1..100 (ingen duplikater)
INSERT INTO sykkel (laas_id, status, modell, innkjopsdato)
SELECT
    gs AS laas_id,
    'tilgjengelig' AS status,
    CASE (gs % 3)
        WHEN 0 THEN 'City Bike Pro'
        WHEN 1 THEN 'Urban Cruiser'
        ELSE 'EcoBike 3000'
        END AS modell,
    (DATE '2023-01-01' + (gs % 180)) AS innkjopsdato
FROM generate_series(1, 100) AS gs;

-- Overstyrer de første 6 syklene slik at de matcher “modell + innkjøpsdato” som i CSV-eksempelet
UPDATE sykkel SET modell='City Bike Pro',  innkjopsdato=DATE '2023-03-15' WHERE sykkel_id=1;
UPDATE sykkel SET modell='Urban Cruiser',  innkjopsdato=DATE '2023-04-20' WHERE sykkel_id=2;
UPDATE sykkel SET modell='EcoBike 3000',   innkjopsdato=DATE '2023-02-10' WHERE sykkel_id=3;
UPDATE sykkel SET modell='Urban Cruiser',  innkjopsdato=DATE '2023-05-05' WHERE sykkel_id=4;
UPDATE sykkel SET modell='City Bike Pro',  innkjopsdato=DATE '2023-01-20' WHERE sykkel_id=5;
UPDATE sykkel SET modell='EcoBike 3000',   innkjopsdato=DATE '2023-06-01' WHERE sykkel_id=6;

-- 2.5 Utleier (minst 50)
-- Lager 50 utleier. Noen blir "aktive" (innlevert NULL) og da settes sykkel til utleid + laas_id NULL.
INSERT INTO utleie (
    kunde_id, sykkel_id, start_stasjon_id, slutt_stasjon_id,
    utlevert_tidspunkt, innlevert_tidspunkt, leiebelop
)
SELECT
    ((gs - 1) % 5) + 1 AS kunde_id,
    ((gs - 1) % 100) + 1 AS sykkel_id,
    ((gs - 1) % 5) + 1 AS start_stasjon_id,
    ((gs) % 5) + 1      AS slutt_stasjon_id,
    (TIMESTAMPTZ '2023-06-01 08:00:00+00' + (gs || ' hours')::interval) AS utlevert_tidspunkt,
    CASE
    WHEN gs % 10 = 0 THEN NULL
    ELSE (TIMESTAMPTZ '2023-06-01 08:00:00+00' + (gs || ' hours')::interval + ((10 + (gs % 80)) || ' minutes')::interval)
END AS innlevert_tidspunkt,
  CASE
    WHEN gs % 10 = 0 THEN NULL
    ELSE round((20 + (gs % 60))::numeric, 2)
END AS leiebelop
FROM generate_series(1, 50) AS gs;

-- Sett status/laas_id på sykler som har aktive utleier (innlevert NULL)
UPDATE sykkel s
SET status = 'utleid', laas_id = NULL
WHERE EXISTS (
    SELECT 1
    FROM utleie u
    WHERE u.sykkel_id = s.sykkel_id
      AND u.innlevert_tidspunkt IS NULL
);

COMMIT;

SELECT 'Database initialisert!' as status;
