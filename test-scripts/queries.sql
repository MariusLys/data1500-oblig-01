-- ============================================================================
-- TEST-SKRIPT FOR OBLIG 1
-- ============================================================================

-- Kjør med: docker-compose exec postgres psql -h -U admin -d data1500_db -f test-scripts/queries.sql

-- En test med en SQL-spørring mot metadata i PostgreSQL (kan slettes fra din script)
select nspname as schema_name from pg_catalog.pg_namespace;


-- Del 5: SQL-spørringer


-- Oppgave 5.1: Vis alle sykler
SELECT *
FROM sykkel;

-- Oppgave 5.2: Etternavn, fornavn og mobilnummer for alle kunder
SELECT etternavn, fornavn, mobilnummer
FROM kunde
ORDER BY etternavn, fornavn;

-- Oppgave 5.3: Sykler tatt i bruk etter 1. april 2023
SELECT *
FROM sykkel
WHERE innkjopsdato > DATE '2023-04-01';

-- Oppgave 5.4: Antall kunder i bysykkelordningen
SELECT COUNT(*) AS antall_kunder
FROM kunde;

-- Oppgave 5.5: Alle kunder og antall utleier per kunde
SELECT
    k.kunde_id,
    k.etternavn,
    k.fornavn,
    COUNT(u.utleie_id) AS antall_utleier
FROM kunde k
         LEFT JOIN utleie u ON u.kunde_id = k.kunde_id
GROUP BY k.kunde_id, k.etternavn, k.fornavn
ORDER BY k.etternavn, k.fornavn;

-- Oppgave 5.6: Kunder som aldri har leid sykkel
SELECT
    k.kunde_id,
    k.etternavn,
    k.fornavn
FROM kunde k
         LEFT JOIN utleie u ON u.kunde_id = k.kunde_id
WHERE u.utleie_id IS NULL;

-- Oppgave 5.7: Sykler som aldri har vært utleid
SELECT
    s.sykkel_id,
    s.modell
FROM sykkel s
         LEFT JOIN utleie u ON u.sykkel_id = s.sykkel_id
WHERE u.utleie_id IS NULL;

-- Oppgave 5.8: Sykler som ikke er levert tilbake etter ett døgn
SELECT
    u.utleie_id,
    s.sykkel_id,
    s.modell,
    k.fornavn,
    k.etternavn,
    u.utlevert_tidspunkt
FROM utleie u
         JOIN sykkel s ON s.sykkel_id = u.sykkel_id
         JOIN kunde k ON k.kunde_id = u.kunde_id
WHERE u.innlevert_tidspunkt IS NULL
  AND u.utlevert_tidspunkt <= NOW() - INTERVAL '1 day';
