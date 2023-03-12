package Security;

import java.util.Scanner;
import java.util.Random;

/**
 * Generates passwords based on users choice.
 * 
 * @author Andreas Oswald
 */

public class SecretGen {

	public static void main(String[] args) {
		
		String password = "";
		Random r = new Random();
		int type = 0;
		
		String numChars = "0123456789";
		String alphaLow = "abcdefghijklmnopqrstuvwxyz";
		String alphaHigh = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
		String specialChars = "#&%$§?!";
		
		String medium = numChars + alphaLow;
		String high = medium + specialChars;
		String maximum = high + alphaHigh;
		
		System.out.println("Bitte wählen Sie eine Sicherheitsstufe: Gering(1), Mittel(2), Hoch(3), Stark(4)");
		
		Scanner s = new Scanner(System.in);
		type = s.nextInt();
		s.close();
		
		switch(type) {
		
		case 1:
			for (int i = 0; i < 4; i++) {
				char entry = numChars.charAt(r.nextInt(numChars.length()));
				password += entry;
			}
			break;
		
		case 2:
			for (int i = 0; i < 6; i++) {
				char entry = medium.charAt(r.nextInt(medium.length()));
				password += entry;
			}
			String part1a = password.substring(0,3);
			String part1b = password.substring(3);
			password = part1a + "-" + part1b;
			break;
			
		case 3:
			for (int i = 0; i < 9; i++) {
				char entry = high.charAt(r.nextInt(high.length()));
				password += entry;
			}
			String part2a = password.substring(0,3);
			String part2b = password.substring(3,6);
			String part2c = password.substring(6);
			password = part2a + "-" + part2b + "-" + part2c;
			break;
			
		case 4:
			for (int i = 0; i < 16; i++) {
				char entry = maximum.charAt(r.nextInt(maximum.length()));
				password += entry;
			}
			String part3a = password.substring(0,4);
			String part3b = password.substring(4,8);
			String part3c = password.substring(8,12);
			String part3d = password.substring(12);
			password = part3a + "-" + part3b + "-" + part3c + "-" + part3d;
			break;
			
		default:
			System.out.println("Ungültige Eingabe. Bitte 1, 2, 3 oder 4 eingeben.");
			System.exit(0);
			
		}
		
		System.out.printf("Ihr gewünschtes Passwort lautet: %s", password + "\n");

	}

}
