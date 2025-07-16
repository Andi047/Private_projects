#include "CEasy.h"


FKT_EINFACH(potenz)
    DEF_ZAHL(num)
    ZUWEISUNG(num,1)

    LAUFVARIABLE(i)
    SCHLEIFE(i, <, 10)
        num = ADDIERE(num, 1)
        num = MULTIPLIZIERE(num, 3)
        ZAHL_AUSGABE(num)
        INKREMENTIERE(i)
    ENDE
ENDE

FKT_EINFACH(rechner)
    ZUWEISUNG(TEXT(hinweis), "Wählen Sie 1, 2 oder 3:")

    DEF_ZAHL(eingabe) ZUWEISUNG(eingabe, 0.0)
    TEXT_EINGABE(eingabe)

    AUSWAHL(eingabe)
        OPTION(1)
            ZUWEISUNG(TEXT(eins), "Berechne Quadrat...")
            ABBRUCH
        OPTION(2)
            ZUWEISUNG(TEXT(zwei), "Berechne mit PI...")
            ABBRUCH
        OPTION(3)
            ZUWEISUNG(TEXT(drei), "Rechne modulo 3...")
            ABBRUCH
        STANDARD
            ZUWEISUNG(TEXT(error), "Weder 1, 2 oder 3 erkannt. Ende.")
    ENDE
ENDE


HAUPTFKT_START
    RUFE_FKT_EINF(potenz)
    RUFE_FKT_EINF(rechner)
HAUPTFKT_ENDE