# Rubrikker for Obligatorisk Oppgave 1 (Revidert)

Her følger rubrikker for hver deloppgave i den reviderte obligatoriske oppgaven. Hver deloppgave gir maksimalt 3 poeng. For å bestå oppgaven kreves det minst 60% av den totale poengsummen for de obligatoriske oppgavene.

## Del 1: Datamodellering

### Oppgave 1.1: Entiteter og attributter

*   **3 poeng:** Alle sentrale entiteter (Sykkel, Stasjon, Lås, Kunde, Utleie) er identifisert. Relevante attributter er definert for hver entitet.
*   **2 poeng:** De fleste sentrale entiteter er identifisert, men noen mangler eller er slått sammen. De fleste relevante attributter er definert.
*   **1 poeng:** Noen entiteter er identifisert, men det er vesentlige mangler. Få eller irrelevante attributter er definert.
*   **0 poeng:** Ikke besvart eller helt misforstått.

### Oppgave 1.2: Datatyper og `CHECK`-constraints

*   **3 poeng:** Passende PostgreSQL-datatyper er valgt for alle attributter, med gode begrunnelser. Fornuftige `CHECK`-constraints er lagt til for å sikre dataintegritet. ER-diagrammet er komplett og korrekt.
*   **2 poeng:** Passende datatyper er valgt for de fleste attributter, men noen valg er dårlig begrunnet. `CHECK`-constraints mangler eller er ufullstendige. ER-diagrammet har mindre feil eller mangler.
*   **1 poeng:** Datatyper er valgt, men mange er lite passende. `CHECK`-constraints mangler helt. ER-diagrammet er mangelfullt eller har store feil.
*   **0 poeng:** Ikke besvart eller helt misforstått.

### Oppgave 1.3: Primærnøkler

*   **3 poeng:** Egnede primærnøkler (naturlige eller surrogat) er valgt for alle entiteter, med gode begrunnelser. ER-diagrammet er korrekt oppdatert.
*   **2 poeng:** Primærnøkler er valgt for de fleste entiteter, men noen valg er svakt begrunnet. ER-diagrammet har mindre feil eller mangler.
*   **1 poeng:** Primærnøkler er valgt, men valgene er dårlige eller mangler for flere entiteter. ER-diagrammet er ikke oppdatert eller har store feil.
*   **0 poeng:** Ikke besvart eller helt misforstått.

### Oppgave 1.4: Forhold og fremmednøkler

*   **3 poeng:** Alle relevante forhold er korrekt identifisert med riktig kardinalitet. Fremmednøkler er korrekt implementert. ER-diagrammet er komplett og korrekt.
*   **2 poeng:** De fleste forhold er korrekt identifisert, men det er feil i kardinalitet eller implementering av fremmednøkler. ER-diagrammet har mindre feil eller mangler.
*   **1 poeng:** Få forhold er identifisert, eller det er store feil i kardinalitet og fremmednøkler. ER-diagrammet er mangelfullt eller har store feil.
*   **0 poeng:** Ikke besvart eller helt misforstått.

### Oppgave 1.5: Normalisering

*   **3 poeng:** Vurderingen av 1NF, 2NF og 3NF er korrekt og godt begrunnet. Modellen er på 3NF.
*   **2 poeng:** Vurderingen er delvis korrekt, men mangler dybde eller har mindre feil.
*   **1 poeng:** Vurderingen er overfladisk eller feilaktig.
*   **0 poeng:** Ikke besvart eller helt misforstått.
## Del 2: Database-implementering

### Oppgave 2.1: SQL-skript for database-initialisering

*   **3 poeng:** SQL-skriptet oppretter alle tabeller korrekt i henhold til datamodellen. `INSERT`-setningene er korrekte og tilstrekkelig med testdata er lagt inn.
*   **2 poeng:** SQL-skriptet har mindre feil, f.eks. i tabell- eller kolonnedefinisjoner. Noe testdata mangler.
*   **1 poeng:** SQL-skriptet har store feil og klarer ikke å opprette databasen korrekt. Mye testdata mangler.
*   **0 poeng:** Ikke besvart eller helt misforstått.

### Oppgave 2.2: Kjøre initialiseringsskriptet

*   **3 poeng:** Viser til vellykket kjøring av skriptet med `docker-compose`. Spørringen mot systemkatalogen er korrekt og viser de forventede tabellene.
*   **2 poeng:** Viser til vellykket kjøring, men dokumentasjonen er mangelfull. Spørringen mot systemkatalogen er feil eller mangler.
*   **1 poeng:** Klarer ikke å vise til vellykket kjøring av skriptet.
*   **0 poeng:** Ikke besvart.

## Del 3: Tilgangskontroll

### Oppgave 3.1: Roller og brukere

*   **3 poeng:** Rollen `kunde` og brukeren `kunde_1` er korrekt opprettet. Rettighetene for `kunde`-rollen er fornuftig begrenset.
*   **2 poeng:** Rollen og brukeren er opprettet, men det er mindre feil i tildelingen av rettigheter.
*   **1 poeng:** Forsøk på å opprette rolle og bruker, men med store feil.
*   **0 poeng:** Ikke besvart eller helt misforstått.

### Oppgave 3.2: Begrenset visning for kunder

*   **3 poeng:** `VIEW`-et er korrekt implementert og begrenser en kundes tilgang til egne utleier. Ulempen med `VIEW` vs. `POLICIES` er godt forklart.
*   **2 poeng:** `VIEW`-et er implementert, men har mindre feil. Forklaringen på ulempen er mangelfull.
*   **1 poeng:** Forsøk på å lage `VIEW`, men det fungerer ikke som forventet. Forklaringen på ulempen mangler.
*   **0 poeng:** Ikke besvart eller helt misforstått.

## Del 4: Analyse og Refleksjon

### Oppgave 4.1: Lagringskapasitet

*   **3 poeng:** Estimatet for lagringskapasitet er fornuftig og utregningen er vist og korrekt basert på de gitte tallene.
*   **2 poeng:** Utregningen av lagringskapasitet har mindre feil.
*   **1 poeng:** Utregningen av lagringskapasitet er mangelfull eller har store feil.
*   **0 poeng:** Ikke besvart eller helt misforstått.

### Oppgave 4.2: Flat fil vs. relasjonsdatabase

*   **3 poeng:** Problemene med redundans og inkonsistens er godt illustrert med eksempler fra den gitte CSV-filen. Forklaringen på fordelene med en indeks er korrekt og detaljert.
*   **2 poeng:** Problemene er greit illustrert, men mangler dybde. Forklaringen på fordelene med en indeks er overfladisk.
*   **1 poeng:** Illustrasjonen er mangelfull. Forklaringen på fordelene med en indeks er feil eller mangler.
*   **0 poeng:** Ikke besvart eller helt misforstått.

### Oppgave 4.3: Datastrukturer for logging

*   **3 poeng:** En passende datastruktur (f.eks. heap-fil, LSM-tree) er foreslått, med en god begrunnelse knyttet til skrive- og leseoperasjoner.
*   **2 poeng:** En mindre egnet datastruktur er foreslått, eller begrunnelsen er svak.
*   **1 poeng:** Svaret er irrelevant eller viser liten forståelse.
*   **0 poeng:** Ikke besvart eller helt misforstått.

### Oppgave 4.4: Validering i flerlags-systemer

*   **3 poeng:** Svaret argumenterer for validering i flere/alle lag, med en god begrunnelse for hvorfor hvert lag er viktig.
*   **2 poeng:** Svaret argumenterer for validering i ett eller to lag, men mangler en helhetlig forståelse.
*   **1 poeng:** Svaret er svakt og viser liten forståelse for problemstillingen.
*   **0 poeng:** Ikke besvart eller helt misforstått.

### Oppgave 4.5: Refleksjon over læringsutbytte

*   **3 poeng:** Refleksjonen er personlig, relevant og viser en god forståelse for hvordan oppgaven har bidratt til å oppnå læringsmålene.
*   **2 poeng:** Refleksjonen er noe overfladisk, men viser en viss forståelse.
*   **1 poeng:** Refleksjonen er irrelevant eller viser liten forståelse.
*   **0 poeng:** Ikke besvart.

## Del 5: SQL-spørringer og Automatisk Testing

*   **3 poeng:** Alle spørringene er korrekte og består de automatiske testene.
*   **2 poeng:** De fleste spørringene er korrekte, men noen feiler i de automatiske testene.
*   **1 poeng:** Få av spørringene er korrekte.
*   **0 poeng:** Ikke besvart eller helt misforstått.

## Del 6: Bonusoppgaver (Valgfri)

### Oppgave 6.1: Trigger for lagerbeholdning

*   **3 poeng:** Triggeren er korrekt implementert og fungerer som forventet.
*   **2 poeng:** Triggeren er implementert, men har mindre feil eller mangler.
*   **1 poeng:** Forsøk på å implementere trigger, men med store feil.
*   **0 poeng:** Ikke besvart.

### Oppgave 6.2: Presentasjon

*   **3 poeng:** Presentasjonen er klar, konsis og viser god forståelse for datamodellen og designvalgene.
*   **2 poeng:** Presentasjonen er grei, men mangler dybde eller er uklar på enkelte punkter.
*   **1 poeng:** Presentasjonen er mangelfull eller viser liten forståelse.
*   **0 poeng:** Ikke besvart.

---

## Oppsummering

**Totalt antall obligatoriske deloppgaver:** 21

**Totalt antall bonusoppgaver:** 2

**Maksimal poengsum (obligatorisk):** 63 poeng (21 deloppgaver × 3 poeng)

**Maksimal poengsum (med bonus):** 69 poeng (23 deloppgaver × 3 poeng)

**Bestått-krav:** Minst 38 poeng (60% av 63) fra de obligatoriske oppgavene

**Vurdering:** Bestått / Ikke bestått

---

## Veiledning for læringsassistenter

Ved vurdering av besvarelsene, vær oppmerksom på følgende:

### 1. Automatisk testing av SQL-spørringer

For Del 5 (SQL-spørringer) kan læringsassistenter bruke det automatiske test-skriptet for å validere studentenes løsninger:

```bash
docker-compose exec postgres psql -U admin -d oblig01 -f test-scripts/test-queries.sql
```

Dette skriptet vil kjøre alle testene og gi tilbakemelding på hvilke spørringer som er korrekte. Merk at studenter kan ha alternative løsninger som også er korrekte, så bruk skjønn hvis en spørring feiler testen men likevel er faglig forsvarlig.

### 2. Konsistens

Vurder om studentens løsning er konsistent gjennom hele oppgaven. For eksempel, hvis en student har valgt en bestemt datamodell i Del 1, bør denne modellen være reflektert i SQL-skriptene i Del 2.

### 3. Forståelse

Vurder om studenten viser forståelse for de underliggende konseptene, ikke bare om løsningen er teknisk korrekt. Refleksjonsspørsmålene er spesielt viktige for å vurdere dette.

### 4. Dokumentasjon

Vurder om studenten har dokumentert sine valg og begrunnelser på en klar og forståelig måte. God dokumentasjon er en viktig del av profesjonell databaseutvikling.

### 5. Funksjonalitet

For SQL-skriptene, test om de faktisk fungerer som forventet. Bruk gjerne automatiserte tester der det er mulig.

### 6. Kreativitet

Gi uttelling for kreative løsninger, så lenge de er faglig forsvarlige. Det finnes ofte flere riktige måter å løse et problem på.

### 7. Forbedringer fra original versjon

Den reviderte versjonen av oppgaven inkluderer følgende forbedringer:

- **Oppgave 1.2:** Nå kreves det `CHECK`-constraints for dataintegritet
- **Oppgave 1.5:** Ny oppgave om normalisering
- **Oppgave 4.1:** Gitte tall for utleierate (forenkler oppgaven)
- **Oppgave 4.2:** Ferdig CSV-fil i `data/`-mappen (forenkler oppgaven)
- **Oppgave 4.3:** Hint om relevante datastrukturer
- **Del 5:** Automatisk test-script for validering av SQL-spørringer
- **Del 6:** Valgfrie bonusoppgaver for de sterkeste studentene

### 8. Bonusoppgaver

Bonusoppgavene teller ikke mot bestått-kravet, men kan gi uttelling for en bedre karakter i emnet totalt sett. Vurder bonusoppgavene strengt, og gi kun full poengsum til svært gode løsninger.

Ved tvil om vurdering, diskuter med faglærer eller andre læringsassistenter for å sikre konsistent vurdering på tvers av alle besvarelser.
