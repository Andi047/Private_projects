#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>


/*
CEasy vereinfacht C, indem sämtliche Kommandos
in deutsche Makrobefehle konvertiert werden.

In BASIC-ähnlicher Syntax wird geschrieben,
Blöcke werden dabei gebildet.

Ziel ist es, sämtliche Sonderzeichen wie
eckige Klammern oder Prozent, Dollar etc.
nicht mehr eintragen zu müssen.

Um es einfach zu halten, wird auf Integerzahlen
verzichtet und als Standard auf Double gesetzt.

Auch werden Definitionen und Zuweisungen (mit
Ausnahme der char-Arrays) immer getrennt.

IDEEN:
- Makrosprache, die die Portierung von COBOL vereinfachen kann ?
*/

// Befehl, der einen Abschnitt immer beendet
#define ENDE }

// main-Funktion
#define HAUPTFKT_START int main() {
#define HAUPTFKT_ENDE return EXIT_SUCCESS; }

// Ein- & Ausgabe von Double-Zahlen
#define ZAHL_EINGABE(x) scanf("%lf", &x);
#define ZAHL_AUSGABE(x) printf("%f\n", x);

// Ein- & Ausgabe von char-Arrays
#define TEXT_EINGABE(x) scanf("%s", &x);
#define TEXT_AUSGABE(x) printf("%s\n", x);
#define SCHREIBE(text) printf("%s\n", text);

// Leere Variablen für Parameteruebergabe TODO
#define LISTE(name) (name)[()]

// Variablen (Definition & Initialisierung getrennt)
#define DEF_ZAHL(name) double name;
#define ZUWEISUNG(variable, wert) variable = wert;
#define DEF_BOOLEAN(name) bool name;

// Arrays
#define DEF_LISTE(name) int name[] = {
#define LISTE_ENDE };
#define LISTE(name,wert) name[(wert)]

// Strings
#define TEXT(name) char name[]

// Bedingungen
#define FALLS(a,b,c) if (a b c) {
#define SONST } else {
#define ABBRUCH break;
#define FAHRE_FORT continue;

// Schleifen
#define SCHLEIFE(start,bedingung,stopp) for (start; start bedingung stopp;) {
#define SOLANGE(a,b,c) while (a b c) {
#define LAUFVARIABLE(name) volatile int name = 0;

// Switch
#define AUSWAHL(variable) switch((int) variable) {
#define OPTION(wert) case(wert):
#define STANDARD default:

// Funktionen
#define RUFE_FKT_PARAM(name, parameter) name(parameter);
#define RUFE_FKT_EINF(name) name();
#define FKT_EINFACH(name) void name() {
#define FKT_PARAMETER(name, bezeichner) name(double bezeichner) {

// Grundrechenarten
#define ADDIERE(x,y) x + y;
#define SUBTRAHIERE(x,y) x - y;
#define MULTIPLIZIERE(x,y) x * y;
#define DIVIDIERE(x,y) x / y;

// Mathe-Hilfsmakros
#define PI 3.14159
#define MODULO(x,y) x % y;
#define MAXIMUM(x,y) ((x)<=(y) ?(y) :(x))
#define MINIMUM(x,y) ((x)<(y) ?(x) : (y))

// Hilfskonstrukte
#define VERTAUSCHE(x,y) { double tmp; tmp = x; x = y; y = tmp; }
#define INKREMENTIERE(x) x++;
#define DEKREMENTIERE(x) x--;
#define AUSGABE_LISTE(name, laenge_liste) \
    for (int i = 0; i < laenge_liste; i++) {\
        printf("%d ",i);\
    }

// Boole'sche Ausdrücke
#define WAHR true
#define FALSCH false
#define IST ==
#define UNGLEICH !=
#define UND &&
#define ODER ||
#define NICHT !
