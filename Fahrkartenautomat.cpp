#include <iostream>
#include <string>
using namespace std;

double fahrk_A = 3.99;
double fahrk_B = 4.5;
double fahrk_C = 5.99;
double preis;

char eingabe;
double einwurf;
double einwurf_tmp;

double wechselgeld;
void calcWechsel(double coins);


int main() {
    cout << "Bitte wählen Sie eine Zone (A / B / C):" << endl;
    cin >> eingabe;

    cout << "Gewählte Zone: " << eingabe << endl;

    switch (eingabe) {
        case 'A':
            preis = fahrk_A;
            break;
        case 'B':
            preis = fahrk_B;
            break;
        case 'C':
            preis = fahrk_C;
            break;
        default:
            cout << "Falsche Eingabe. Programm Ende.";
            exit(0);
    }

    cout << "Bitte zahlen Sie: " << preis << endl;
    cout << "Geben Sie dabei den Wert so ein: X.XX" << endl;

    cin >> einwurf;
    einwurf_tmp = einwurf;

    while (einwurf_tmp < preis) {

        cout << "Die Menge an eingeworfenem Geld reicht nicht." << endl;
        cout << "Bitte geben Sie zusätzliches Geld hinzu." << endl;

        cin >> einwurf;
        einwurf_tmp += einwurf;
    }

    calcWechsel(einwurf_tmp);

    return 0;
}

void calcWechsel(double coins) {
    wechselgeld = coins - preis;
    cout << "Sie erhalten als Wechselgeld: " << wechselgeld << endl;
}
