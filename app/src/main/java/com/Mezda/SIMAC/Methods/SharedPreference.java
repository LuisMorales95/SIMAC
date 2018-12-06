package com.Mezda.SIMAC.Methods;

import android.content.Context;
import android.content.SharedPreferences;

import com.Mezda.SIMAC.UserData;

import static com.Mezda.SIMAC.Methods.VolleySingleton.SuperContext;

public class SharedPreference {
	
	public static void SETSharedPreferences(String Tag, String Value) {
		SharedPreferences preferences = SuperContext().getSharedPreferences(UserData.Credential, Context.MODE_PRIVATE);
		SharedPreferences.Editor editor = preferences.edit();
		editor.putString(Tag, Value);
		editor.apply();
	}
	
	public static String GETSharedPreferences(String Tag, String Value) {
		SharedPreferences preferences = SuperContext().getSharedPreferences(UserData.Credential, Context.MODE_PRIVATE);
		return preferences.getString(Tag, Value);
	}
	
}
