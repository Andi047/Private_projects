#include <iostream>
#include <string>
using namespace std;

const double fahrk_A = 3.99;
const double fahrk_B = 4.5;
const double fahrk_C = 5.99;
double preis;

char eingabe;
double einwurf;
double einwurf_tmp;
bool isValid = false;

double wechselgeld;
void calcWechsel(double coins);


int main()
{
    while (isValid != true) {

        cout << "Bitte wählen Sie eine Zone (1 / 2 / 3):" << endl;
        cout << "Zum Abbrechen bitte 'q' drücken.";
        cin >> eingabe;

        cout << "Gewählte Zone: " << eingabe << endl;

        switch (eingabe) {
            case '1':
                preis = fahrk_A;
                isValid = true;
                break;
            case '2':
                preis = fahrk_B;
                isValid = true;
                break;
            case '3':
                preis = fahrk_C;
                isValid = true;
                break;
            case 'q':
                cout << "Abbruch Programm.";
                isValid = true;
                exit(0);
                break;
            default:
                cout << "Ungültigte Eingabe. ";
        }

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

    return EXIT_SUCCESS;
}

void calcWechsel(double coins)
{
    wechselgeld = coins - preis;
    cout << "Sie erhalten als Wechselgeld: " << wechselgeld << endl;
}
