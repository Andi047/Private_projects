#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include <stdint.h>

/*
C-ISA ermöglicht das Lernen von Assembler, indem
eine Pseudo-Syntax die Prinzipien von Mnemotics
auf C überträgt. Es ist eine Simulation.

C-ISA kennt 4 Register (vordef. Integer) und
simuliert eine 8-Bit CPU.
Es stehen 256 Byte für den RAM zur Verfügung
(Adressen 0x00-0xFF).

Dabei wird auf program counter und stack pointer
verzichtet. Es können nur Integer-Werte verrechnet
werden.
*/

// TODO
// Arbeitsspeicher
#define MEM 256
uint16_t RAM[MEM];

// Statusregister
bool carry_bit = false;
bool negative_bit = false;

// Register
// TODO: R0 für Null-Konstante ?
// TODO: weitere spezialisierte Register ?
uint16_t R1,R2,R3,R4;


#define PROGRAM_START int main() { // TODO ggf. "ASSEMBLER"
#define PROGRAM_END return EXIT_SUCCESS; } // TODO ggf. "ECALL"
// TODO define für Fehlschlag, falls aufgerufen (falls vorhanden in Assembler ?)

// TODO: Idee für Direktaddressierung
// void *addr = (void*)0x02FA;

// Definiert Textblock (nicht im Code!)
//#define TXT(name, inhalt) char name[] = "inhalt";



// BEFEHLSSATZ

// Lädt einen Integer direkt in ein Register
#define LDI(reg_name, int_wert) reg_name = int_wert;

// Lädt den Inhalt einer angegeb. Adresse in ein Register
#define LDS(reg_name, adresse) reg_name = RAM[adresse];

// Speichert den Wert in einem Register in den RAM
#define STS(hex_adresse, reg_name) RAM[hex_adresse] = reg_name;

// Berechnet bool. UND und legt Ergebnis in register_a
#define AND(reg_a, reg_b) reg_a = reg_a & reg_b;

// Wechselt in die angegebene Prozedur, falls neg_bit = true
#define BRIM(prozedur_name) if(negative_bit == true) goto prozedur_name;

// Jump if not equal
#define JPNE(reg_a, reg_b, prozedur_name) if(reg_a != reg_b) {goto prozedur_name;}

// Inkrementiert den Wert im angegebenen Register
#define INC(reg_name) reg_name++;

// Gebe Statusregister aus
#define PRS() printf("Carry: %d/ Negative: %d\n", carry_bit, negative_bit);

#define NEG(reg_name) reg_name = -reg_name; negative_bit = true;

// Addiert a + b und lädt Ergebnis in a
#define ADD(reg_a, reg_b) reg_a += reg_b;

// Subtrahiert a - b, Ergebnis in Register TODO Reihenfolge Parameter ?
#define SUB(reg_a, reg_b) if (reg_b > reg_a) {negative_bit == true;} reg_a -= reg_b;

// Gibt Integer an einer spezifischen RAM-Adresse aus
#define PRM(ram_adresse) \
{ uint32_t num = RAM[ram_adresse]; \
printf("RAM an Adresse %d enthält %d\n", ram_adresse, num); }

// Gibt den Inhalt eines Register auf der CLI aus
#define PRR(reg_name) \
{ int32_t rg_num = reg_name; \
printf("Register %d enthält: %d\n", reg_name, rg_num); }