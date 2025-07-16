#include "CEasy.h"

FKT_PARAMETER(quadrat, seitenlaenge)
    DEF_ZAHL(flaeche)
    flaeche = MULTIPLIZIERE(seitenlaenge, seitenlaenge)
    ZAHL_AUSGABE(flaeche)
ENDE


FKT_EINFACH(zeigeInfo)
    ZUWEISUNG(TEXT(info), "CEasy 1.0")
    TEXT_AUSGABE(info)
ENDE


FKT_EINFACH(istKleiner)
    DEF_ZAHL(messung)
    ZUWEISUNG(messung, 4.775)

    DEF_ZAHL(eingabe)
    ZAHL_EINGABE(eingabe)

    FALLS(eingabe, >, messung)
        SCHREIBE("Eingabe größer als Messung")
    SONST
        SCHREIBE("Eingabe kleiner als Messung")
    ENDE
ENDE

HAUPTFKT_START
    RUFE_FKT_PARAM(quadrat, 4.5)
    RUFE_FKT_EINF(zeigeInfo)
    RUFE_FKT_EINF(istKleiner)
HAUPTFKT_ENDE