# Besvarelse - Refleksjon og Analyse

**Student:** Marius Lysenstøen

**Studentnummer:** malys3373

**Dato:** 1. mars 2026

---

## Del 1: Datamodellering

### Oppgave 1.1: Entiteter og attributter

**Identifiserte entiteter:**

Kunde, Stasjon, Sykkel, Lås, Utleie

**Attributter for hver entitet:**

- Kunde: kunde_id, fornavn, etternavn, mobilnummer, epost 
- Stasjon: stasjon_id, navn, adresse, lengdegrad, breddegrad
- Sykkel: sykkel_id, stasjon_id, laas_id, aktiv
- Lås: laas_id, aktiv
- Utleie: utleie_id, kunde_id, sykkel_id, utlevert_tidspunkt, innlevert_tidspunkt, leiebelop

---

### Oppgave 1.2: Datatyper og `CHECK`-constraints

**Valgte datatyper og begrunnelser:**

- Kunde: 
  - kunde_id: **SERIAL** - Denne får en surrogatønkkel, fordi det er stabilt og effektivt i relasjoner. 
  - fornavn: **varchar(50)** - Dette er et kort tekstfelt, med en begrenset lengde.
  - etternavn: **varchar(50)** - Samme begrunnelse som fornavn. 
  - mobilnummer: **varchar(15)** - Siden telefonnummere kan inneholde landskoder, f.eks. "+47", og ledende nuller. 
  - epost: **varchar(254)** - Dette er maks lengde for epost i praksis (RFC) og er vanlig i databaser.
  
- Stasjon:
  - stasjon_id: **SERIAL** - Surrogatnøkkelen.
  - navn: **varchar(100)** - Navn på stasjonen, grei lengde. 
  - adresse: **varchar(200)** - Adressen eller området som tekst, grei lengde. 
  - breddegrad: **numeric(9,6)** - For en presis GPS-lagring.
  - lengdegrad: **numeric(9,6)** - For en presis GPS-lagring.

- Lås:
  - laas_id: **SERIAL** - Surrogatnøkkel
  - stasjon_id: **BIGINT** - Denne blir en FK til stasjon.
  - posisjon_nr: **INTEGER** - Plass eller nummer på låsen på stasjonen.
  - aktiv: **BOOLEAN** - Om den er aktiv eller utleid (True eller false).

- Sykkel:
  - sykkel_id: **SERIAL** - Surrogatnøkkel.
  - stasjon_id: **BIGINT** - FK til stasjon når sykkelen står parkert (NULL når den er utleid).
  - laas_id: **BIGINT** - FK til lås når sykkelen er låst (NULL når den er utleid).
  - aktiv: **varchar(20)** - For en enkel status, som "tilgjengelig", "utleid", osv..

- Utleie:
  - utleie_id: **SERIAL** - Surrogatnøkkel.
  - kunde_id: **BIGINT** - Blir FK til kunde.
  - sykkel_id: **BIGINT** - Blir FK til sykkel.
  - utlevert_tidspunkt: **TIMESTAMPTZ** - Dette blir et tidsstempel med tidssone.
  - innlevert_tidspunkt: **TIMESTAMPTZ** - Null når sykkeen ikke er levert ennå.
  - leiebelop: **NUMERIC(10,2)** - For penger med 2 desimaler. Dette unngår avrundingsfeil.

**`CHECK`-constraints:**

```
Kunde:
  - CHECK (mobilnummer ~ '^\+?[0-9]{8,15}$') - Det må se ut som et mobilnummer (tillater + og 8-15 siffer), og skal sikre at ikke bokstaver blir lagret.
  - CHECK (epost ~* '^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$') - Skal passe på at mail er i henhold til et bestemt format.
  - CHECK (length(trim(fornavn)) > 0) - Sjekker at fornavn ikke står tom.
  - CHECK (length(trim(etternavn)) > 0) - - Sjekker at etternavn ikke står tom.
```
```
Stasjon:
  - CHECK (breddegrad BETWEEN -90 AND 90)
  - CHECK (lengdegrad BETWEEN -180 AND 180)
  (Begge disse sjekker etter gyldige koordinater)
```

```
Lås:
  - CHECK (posisjon_nr > 0) - Posisjon må være positiv
  
```

```
Sykkel:
  - CHECK (status IN ('tilgjengelig','utleid','service')) - Sjekker status
```

```
Uleie:
  - CHECK (innlevert_tidspunkt IS NULL OR innlevert_tidspunkt > utlevert_tidspunkt) - Innlevering etter utleie.
  - CHECK (leiebelop IS NULL OR leiebelop >= 0) - Leiebeløpet kan ikke være negativt.
```


**ER-diagram:**
- Er-diagram med entiteter og attributter:
![img_1.png](img_1.png)
---

### Oppgave 1.3: Primærnøkler

**Valgte primærnøkler og begrunnelser:**

[Skriv ditt svar her - forklar hvilke primærnøkler du har valgt for hver entitet og hvorfor]

**Naturlige vs. surrogatnøkler:**

[Skriv ditt svar her - diskuter om du har brukt naturlige eller surrogatnøkler og hvorfor]

**Oppdatert ER-diagram:**

[Legg inn mermaid-kode eller eventuelt en bildefil fra `mermaid.live` her]

---

### Oppgave 1.4: Forhold og fremmednøkler

**Identifiserte forhold og kardinalitet:**

[Skriv ditt svar her - list opp alle forholdene mellom entitetene og angi kardinalitet]

**Fremmednøkler:**

[Skriv ditt svar her - list opp alle fremmednøklene og forklar hvordan de implementerer forholdene]

**Oppdatert ER-diagram:**

[Legg inn mermaid-kode eller eventuelt en bildefil fra `mermaid.live` her]

---

### Oppgave 1.5: Normalisering

**Vurdering av 1. normalform (1NF):**

[Skriv ditt svar her - forklar om datamodellen din tilfredsstiller 1NF og hvorfor]

**Vurdering av 2. normalform (2NF):**

[Skriv ditt svar her - forklar om datamodellen din tilfredsstiller 2NF og hvorfor]

**Vurdering av 3. normalform (3NF):**

[Skriv ditt svar her - forklar om datamodellen din tilfredsstiller 3NF og hvorfor]

**Eventuelle justeringer:**

[Skriv ditt svar her - hvis modellen ikke var på 3NF, forklar hvilke justeringer du har gjort]

---

## Del 2: Database-implementering

### Oppgave 2.1: SQL-skript for database-initialisering

**Plassering av SQL-skript:**

[Bekreft at du har lagt SQL-skriptet i `init-scripts/01-init-database.sql`]

**Antall testdata:**

- Kunder: [antall]
- Sykler: [antall]
- Sykkelstasjoner: [antall]
- Låser: [antall]
- Utleier: [antall]

---

### Oppgave 2.2: Kjøre initialiseringsskriptet

**Dokumentasjon av vellykket kjøring:**

[Skriv ditt svar her - f.eks. skjermbilder eller output fra terminalen som viser at databasen ble opprettet uten feil]

**Spørring mot systemkatalogen:**

```sql
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public' 
  AND table_type = 'BASE TABLE'
ORDER BY table_name;
```

**Resultat:**

```
[Skriv resultatet av spørringen her - list opp alle tabellene som ble opprettet]
```

---

## Del 3: Tilgangskontroll

### Oppgave 3.1: Roller og brukere

**SQL for å opprette rolle:**

```sql
[Skriv din SQL-kode for å opprette rollen 'kunde' her]
```

**SQL for å opprette bruker:**

```sql
[Skriv din SQL-kode for å opprette brukeren 'kunde_1' her]
```

**SQL for å tildele rettigheter:**

```sql
[Skriv din SQL-kode for å tildele rettigheter til rollen her]
```

---

### Oppgave 3.2: Begrenset visning for kunder

**SQL for VIEW:**

```sql
[Skriv din SQL-kode for VIEW her]
```

**Ulempe med VIEW vs. POLICIES:**

[Skriv ditt svar her - diskuter minst én ulempe med å bruke VIEW for autorisasjon sammenlignet med POLICIES]

---

## Del 4: Analyse og Refleksjon

### Oppgave 4.1: Lagringskapasitet

**Gitte tall for utleierate:**

- Høysesong (mai-september): 20000 utleier/måned
- Mellomsesong (mars, april, oktober, november): 5000 utleier/måned
- Lavsesong (desember-februar): 500 utleier/måned

**Totalt antall utleier per år:**

[Skriv din utregning her]

**Estimat for lagringskapasitet:**

[Skriv din utregning her - vis hvordan du har beregnet lagringskapasiteten for hver tabell]

**Totalt for første år:**

[Skriv ditt estimat her]

---

### Oppgave 4.2: Flat fil vs. relasjonsdatabase

**Analyse av CSV-filen (`data/utleier.csv`):**

**Problem 1: Redundans**

[Skriv ditt svar her - gi konkrete eksempler fra CSV-filen som viser redundans]

**Problem 2: Inkonsistens**

[Skriv ditt svar her - forklar hvordan redundans kan føre til inkonsistens med eksempler]

**Problem 3: Oppdateringsanomalier**

[Skriv ditt svar her - diskuter slette-, innsettings- og oppdateringsanomalier]

**Fordeler med en indeks:**

[Skriv ditt svar her - forklar hvorfor en indeks ville gjort spørringen mer effektiv]

**Case 1: Indeks passer i RAM**

[Skriv ditt svar her - forklar hvordan indeksen fungerer når den passer i minnet]

**Case 2: Indeks passer ikke i RAM**

[Skriv ditt svar her - forklar hvordan flettesortering kan brukes]

**Datastrukturer i DBMS:**

[Skriv ditt svar her - diskuter B+-tre og hash-indekser]

---

### Oppgave 4.3: Datastrukturer for logging

**Foreslått datastruktur:**

[Skriv ditt svar her - f.eks. heap-fil, LSM-tree, eller annen egnet datastruktur]

**Begrunnelse:**

**Skrive-operasjoner:**

[Skriv ditt svar her - forklar hvorfor datastrukturen er egnet for mange skrive-operasjoner]

**Lese-operasjoner:**

[Skriv ditt svar her - forklar hvordan datastrukturen håndterer sjeldne lese-operasjoner]

---

### Oppgave 4.4: Validering i flerlags-systemer

**Hvor bør validering gjøres:**

[Skriv ditt svar her - argumenter for validering i ett eller flere lag]

**Validering i nettleseren:**

[Skriv ditt svar her - diskuter fordeler og ulemper]

**Validering i applikasjonslaget:**

[Skriv ditt svar her - diskuter fordeler og ulemper]

**Validering i databasen:**

[Skriv ditt svar her - diskuter fordeler og ulemper]

**Konklusjon:**

[Skriv ditt svar her - oppsummer hvor validering bør gjøres og hvorfor]

---

### Oppgave 4.5: Refleksjon over læringsutbytte

**Hva har du lært så langt i emnet:**

[Skriv din refleksjon her - diskuter sentrale konsepter du har lært]

**Hvordan har denne oppgaven bidratt til å oppnå læringsmålene:**

[Skriv din refleksjon her - koble oppgaven til læringsmålene i emnet]

Se oversikt over læringsmålene i en PDF-fil i Canvas https://oslomet.instructure.com/courses/33293/files/folder/Plan%20v%C3%A5ren%202026?preview=4370886

**Hva var mest utfordrende:**

[Skriv din refleksjon her - diskuter hvilke deler av oppgaven som var mest krevende]

**Hva har du lært om databasedesign:**

[Skriv din refleksjon her - reflekter over prosessen med å designe en database fra bunnen av]

---

## Del 5: SQL-spørringer og Automatisk Testing

**Plassering av SQL-spørringer:**

[Bekreft at du har lagt SQL-spørringene i `test-scripts/queries.sql`]


**Eventuelle feil og rettelser:**

[Skriv ditt svar her - hvis noen tester feilet, forklar hva som var feil og hvordan du rettet det]

---

## Del 6: Bonusoppgaver (Valgfri)

### Oppgave 6.1: Trigger for lagerbeholdning

**SQL for trigger:**

```sql
[Skriv din SQL-kode for trigger her, hvis du har løst denne oppgaven]
```

**Forklaring:**

[Skriv ditt svar her - forklar hvordan triggeren fungerer]

**Testing:**

[Skriv ditt svar her - vis hvordan du har testet at triggeren fungerer som forventet]

---

### Oppgave 6.2: Presentasjon

**Lenke til presentasjon:**

[Legg inn lenke til video eller presentasjonsfiler her, hvis du har løst denne oppgaven]

**Hovedpunkter i presentasjonen:**

[Skriv ditt svar her - oppsummer de viktigste punktene du dekket i presentasjonen]

---

**Slutt på besvarelse**
