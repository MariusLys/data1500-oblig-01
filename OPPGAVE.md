# Obligatorisk Oppgave 1: Bysykkel-databasen

**Emne:** DATA1500 Databaser

**Innleveringsfrist:** søndag 1. mars 2026 kl. 23:59 i Canvas

**Vurdering:** Bestått / Ikke bestått

## Introduksjon

I denne obligatoriske oppgaven skal du designe og implementere en relasjonsdatabase for et bysykkelsystem. Oppgaven vil ta deg gjennom hele prosessen fra datamodellering til implementering og bruk av databasen. Du vil anvende kunnskapen du har tilegnet deg fra kapitlene 1, 9, 12, 11, 6, 7, 8 og 3 i pensum og de fire første oppgavesettene.

Formålet med oppgaven er å gi deg en praktisk forståelse av sentrale konsepter i databasedesign og -bruk. Det forventes at du jobber selvstendig og gjør et ærlig forsøk på å løse alle deloppgavene. Arbeidsmengden er estimert til 20-25 timer for en nybegynner i faget.

KI er kun anbefalt for å søke for forklaring av begreper og meget spesifikke ting i forhold til SQL syntaksen. Ikke bruk KI ved å legge inn oppgaveteksten og levere svarene fra KI direkte som din besvarelse. Vi (lærer og TA) kan i visse tilfeller henvende oss til studentene, og be studentene om å forklare deres besvarelsen muntlig. Tenk på at hovedformålet til et universitet er å forberede studenter til arbeidslivet og hovedformålet for deg, som student, burde være mest mulig læring. Det er klare indikasjoner i mange studier at overdrevet bruk av KI vil vesentlig synke dine muligheter til å oppnå en tilfredsstillende kompentanse innen relevante fagområder i dette studiet. 

## Case: Bysykkelutleie

Et nytt bysykkelsystem skal lanseres i byen din. Systemet består av et antall sykkelstasjoner, der kunder kan leie og levere sykler. Hver sykkel har en unik ID og er parkert på en (sykkel-)stasjon og låst fast med en lås. 

Kundene kan registrere seg i systemet med mobilnummer, epost, fornavn og etternavn. Når en kunde skal leie en sykkel, står kunden ved en stasjon og låser opp sykkel. Da registreres utleietidspunktet (f. eks. ulevert). Når sykkelen leveres tilbake, registreres innleveringstidspunktet (f. eks. innlevert). 

Systemet må holde styr på hvilke sykler som er tilgjengelige på hvilke stasjoner (sted), og hvilke sykler som er utleid.

En kunde skal betale for tidrommet (tidsintervall) når sykkelen låses opp fra et sykkelstativ og til kunden setter sykkelen fast i en lås ved et sykkelstativ. Leieperioden avsluttes ved å sette sykkelen fast i en lås og kunden får en bekreftelse i mobilapplikasjonen om at sykkelen er levert. Leiebeløpet belastes betalingskort og registreres på den gjeldende utleie.

Hint: Tenk at en stasjon har mange låser og hver sykkel blir låst med en tilfeldig lås på en spesifikk stasjon. En sykkel som er utleid, kan modelleres med at den har ingen stasjon og lås registrert (NULL) og innleveringstidspunktet for utleien også er uten en tidsverdi (NULL). Pass på å ikke ta med irrelevante entiteter, for eksempel, det er ikke nødvendig å lage entiteter for beregning av pris, det er nok med å registrere leiebeløpet.


## Oppsett av prosjektet

Denne repository-en inneholder en `docker-compose.yml`-fil for å sette opp en PostgreSQL-database, en `README.md` med **VIKTIGE** opplysninger om frister, og flere mapper: `init-scripts`, `test-scripts`, og `data`. Du skal legge dine SQL-skript i disse mappene som beskrevet i oppgavene under.

## Deloppgaver

### Del 1: Datamodellering

I denne delen skal du designe datamodellen for bysykkelsystemet.

**Oppgave 1.1: Entiteter og attributter**

Basert på case-beskrivelsen, identifiser de sentrale entitetene i systemet. For hver entitet, definer relevante attributter som beskriver egenskapene til entiteten. Begrunn valgene dine.

**Oppgave 1.2: Datatyper og `CHECK`-constraints**

For hver attributt du identifiserte i forrige oppgave, velg en passende PostgreSQL-datatype. Legg til `CHECK`-constraints der det er fornuftig for å sikre dataintegritet (f.eks. for mobilnummer eller epost). Begrunn valgene dine. Tegn et ER-diagram (gjerne med `mermaid.live`) som viser entitetene og attributtene med datatyper.

**Oppgave 1.3: Primærnøkler**

For hver entitet, velg en eller flere attributter som kan fungere som primærnøkkel. Vurder om det finnes naturlige nøkler, eller om du må introdusere surrogatnøkler. Oppdater ER-diagrammet med primærnøklene.

**Oppgave 1.4: Forhold og fremmednøkler**

Definer forholdene mellom entitetene. Angi kardinalitet (en-til-en, en-til-mange, mange-til-mange) for hvert forhold. Introduser fremmednøkler der det er nødvendig for å implementere forholdene. Oppdater ER-diagrammet med forholdene og fremmednøklene. `mange-til-mange` forhold skal "løses opp" med en koblingstabell (assosiativ entitet).

**Oppgave 1.5: Normalisering**

Vurder datamodellen din opp mot 1., 2. og 3. normalform. Forklar hvorfor modellen din tilfredsstiller (eller ikke tilfredsstiller) hver av disse normalformene. Hvis modellen ikke er på 3NF, juster den slik at den blir det.

### Del 2: Database-implementering

I denne delen skal du implementere databasen i PostgreSQL.

**Oppgave 2.1: SQL-skript for database-initialisering**

Skriv SQL-kommandoer for å opprette tabellene i databasen, basert på ER-diagrammet fra Del 1. Legg til `INSERT`-setninger for å populere databasen med testdata (det finnes flere måter å generere mockup-data på; søk gjerne med KI for å få hjelp til dette):

- Minst 5 kunder
- Minst 100 sykler
- Minst 5 sykkelstasjoner
- Minst 100 låser (20 per stasjon)
- Minst 50 utleier

Lagre alle SQL-kommandoene i en fil med navnet `01-init-database.sql` i mappen `init-scripts`.

**Oppgave 2.2: Kjøre initialiseringsskriptet**

Bruk `docker-compose` til å starte PostgreSQL-databasen. Verifiser at `01-init-database.sql`-skriptet kjøres uten feil og at tabellene blir opprettet og populert med data. Inkluder en spørring mot systemkatalogen i PostgreSQL for å vise alle tabellene som er opprettet.

### Del 3: Tilgangskontroll

I denne delen skal du implementere tilgangskontroll i databasen.

**Oppgave 3.1: Roller og brukere**

Opprett en ny rolle `kunde` i tillegg til `admin`-rollen. Opprett en eksempelbruker `kunde_1` og gi denne brukeren `kunde`-rollen. Sørg for at `kunde`-rollen kun har lesetilgang til relevante tabeller og visninger.

**Oppgave 3.2: Begrenset visning for kunder**

Lag en `VIEW` som gjør at en kunde kun kan se sine egne utleier. Nevn minst én ulempe med å bruke en `VIEW` for autorisasjon sammenlignet med å bruke `POLICY`.

### Del 4: Analyse og Refleksjon

I denne delen skal du analysere ulike aspekter ved databasen og reflektere over sentrale konsepter.

**Oppgave 4.1: Lagringskapasitet**

Anta følgende utleierate for syklene gjennom et helt år:

- **Høysesong (mai-september):** 20000 utleier per måned
- **Mellomsesong (mars, april, oktober, november):** 5000 utleier per måned
- **Lavsesong (desember-februar):** 500 utleier per måned

Estimer den nødvendige lagringskapasiteten for data i PostgreSQL-databasen for det første driftsåret. Vis utregningen din.

**Oppgave 4.2: Flat fil vs. relasjonsdatabase**

I mappen `data` finner du filen `utleier.csv` som inneholder 10 utleier i et flatt format. Illustrer med eksempler fra denne filen hvilke problemer denne strukturen medfører (redundans, inkonsistens). Forklar hvorfor en indeks ville gjort en spørring for å finne alle utleier for en gitt sykkel mer effektiv.

**Oppgave 4.3: Datastrukturer for logging**

Hvis du skulle logge alle hendelser i databasen (innlogginger, innsettinger, oppdateringer etc.), hvilken datastruktur ville vært best egnet? Begrunn svaret ditt med tanke på skrive- og leseoperasjoner. (Hint: Vurder datastrukturer som er optimalisert for "append-only"-operasjoner, som f.eks. en log-structured merge-tree (LSM-tree) eller en enkel heap-fil).

**Oppgave 4.4: Validering i flerlags-systemer**

Anta at bysykkelsystemet har en web-applikasjon med et applikasjonslag (f.eks. i Java) som kommuniserer med databasen. Hvor er det mest hensiktsmessig å validere input fra brukeren (f.eks. ved registrering av en ny kunde)? I nettleseren, i applikasjonslaget, i databasen, eller i flere/alle lag? Begrunn svaret ditt.

**Oppgave 4.5: Refleksjon over læringsutbytte**

Skriv en kort refleksjon over hva du har lært så langt i emnet, og hvordan denne oppgaven har bidratt til å oppnå læringsmålene.

### Del 5: SQL-spørringer og Automatisk Testing

I denne delen skal du skrive SQL-spørringer for å hente ut informasjon fra databasen. Legg alle spørringene i en fil med navnet `queries.sql` i mappen `test-scripts`.

**Oppgave 5.1:** Lag en spørring som viser alle sykler.

**Oppgave 5.2:** Lag en spørring som viser etternavn, fornavn og mobilnummer for alle kunder, sortert alfabetisk på etternavn.

**Oppgave 5.3:** Lag en spørring som viser alle sykler som er tatt i bruk etter 1. april 2023 (juster datoen til dine testdata).

**Oppgave 5.4:** Lag en spørring som viser antallet kunder i bysykkelordningen.

**Oppgave 5.5:** Lag en spørring som viser alle kunder og teller opp antallet utleieforhold for hver kunde. Oversikten skal også vise kunder som ennå ikke har leid sykkel.

**Oppgave 5.6:** Lag en spørring som gir en oversikt over hvilke kunder som aldri har leid en sykkel.

**Oppgave 5.7:** Lag en spørring som viser hvilke sykler som aldri har vært utleid.

**Oppgave 5.8:** Lag en spørring som viser hvilke sykler, med informasjon om kunden, som ikke er levert tilbake etter ett døgn.

**Automatisk testing:**

For å teste om SQL-spørringene dine er korrekte, kan du kjøre følgende kommando fra terminalen i prosjektmappen:

```bash
docker-compose exec postgres psql -U admin -d oblig01 -f test-scripts/test-queries.sql
```

Denne kommandoen kjører `test-queries.sql`-skriptet, som inneholder både dine spørringer og tester som validerer resultatene. Du vil få tilbakemelding i terminalen om testene bestås eller ikke.

### Del 6: Bonusoppgaver (Valgfri)

**Oppgave 6.1: Trigger for lagerbeholdning**

Implementer en trigger som automatisk oppdaterer en lagerbeholdningstabell for sykler hver gang en sykkel blir leid eller levert tilbake. Dette gir en sanntidsoversikt over tilgjengelige sykler på hver stasjon.

**Oppgave 6.2: Presentasjon**

Lag en kort presentasjon (5-10 minutter) der du presenterer datamodellen din og forklarer de viktigste designvalgene du har tatt. Presentasjonen kan leveres som en video eller holdes for læringsgruppen din.

## Vurdering og Bestått-krav

Oppgaven vurderes med **Bestått / Ikke bestått**. Hver deloppgave gir maksimalt 3 poeng. Det er totalt 23 deloppgaver (21 obligatoriske + 2 bonusoppgaver), som gir en maksimal poengsum på 69 poeng for alle oppgaver, eller 63 poeng for kun de obligatoriske oppgavene.

For å bestå oppgaven kreves det **minst 60% av den totale poengsummen for de obligatoriske oppgavene**, det vil si **38 poeng av 63 mulige**.

Bonusoppgavene kan gi inntil 6 ekstra poeng, men disse teller ikke mot bestått-kravet.

Se rubrikk-dokument `RUBRIKK.md` for detaljerte vurderingskriterier for hver deloppgave.

## Innlevering

Oppgaven leveres som et Git-repository som inneholder:

1. `init-scripts/01-init-database.sql` - SQL-skript for database-initialisering
2. `test-scripts/queries.sql` - SQL-spørringer
3. `besvarelse-refleksjon.md` - Besvarelser på refleksjonsspørsmål og analyseoppgaver
4. ER-diagrammer (som kode i Markdown-formatet eller bildefiler laget med  mermaid.live)
5. Eventuell annen dokumentasjon
6. (Valgfri) Video eller presentasjonsfiler for bonusoppgave 6.2

**Lykke til!**
