package com.Mezda.SIMAC.utils;

import java.util.regex.Pattern;

public class HTMLSimplifier {
	
	public static String eliminadorHTML(String HTML) {
		String texto_final = "";
		Boolean escribir = true;
		String[] informacion = HTML.split(Pattern.quote(""));
		for (int i = 0; i < informacion.length; i++) {
			if (informacion[i].equals("<")) {
				escribir = false;
			} else if (informacion[i].equals(">")) {
				escribir = true;
			} else if (escribir) {
				texto_final += informacion[i];
			}
		}
		return texto_final;
	}
	
}
