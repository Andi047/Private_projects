#include "CEasy.h"


FKT_EINFACH(bubblesort)
    DEF_LISTE(arr) 5,2,7,1,3,5,8,6 LISTE_ENDE

    DEF_BOOLEAN(getauscht)
    LAUFVARIABLE(i)
    LAUFVARIABLE(j)

    SCHLEIFE(i, <, 8)
        ZUWEISUNG(getauscht, FALSCH)

        SCHLEIFE(j, <, 8-i)
            FALLS(LISTE(arr,i), >, LISTE(arr, j+1))
                VERTAUSCHE(i,j)
                ZUWEISUNG(getauscht, WAHR)
            ENDE
            INKREMENTIERE(j)
        ENDE
    
        FALLS(getauscht, IST, FALSCH)
            ABBRUCH
        ENDE

        INKREMENTIERE(i)
    ENDE
ENDE


HAUPTFKT_START
    RUFE_FKT_EINF(bubblesort)
    AUSGABE_LISTE(arr, 8)
HAUPTFKT_ENDE