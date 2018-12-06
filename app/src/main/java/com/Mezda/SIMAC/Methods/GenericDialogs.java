package com.Mezda.SIMAC.Methods;

import android.app.Activity;
import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.Context;
import android.widget.Toast;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

import static com.Mezda.SIMAC.Methods.VolleySingleton.*;

public class GenericDialogs {
	
	public static void AlertDialog(Activity context,
	                               String aTitulo,
	                               String aMensaje,
	                               String aMetodoAceptar,
	                               String tagConfirmar,
	                               String aMetodoNegar,
	                               String tagNegar) {
		
		Toast.makeText(SuperContext(),"Dialogo Generico",Toast.LENGTH_LONG).show();
		AlertDialog.Builder builder = new AlertDialog.Builder(context);
		builder.setTitle(aTitulo);
		builder.setMessage(aMensaje);
		builder.setPositiveButton(tagConfirmar, (dialog, which) -> {
			try {
				Class<?> noparams[] = {};
				Object object = context.getClass().newInstance();
				Method method = object.getClass().getDeclaredMethod(aMetodoAceptar, noparams);
				method.invoke(object);
			} catch (NoSuchMethodException e) {
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			} catch (InstantiationException e) {
				e.printStackTrace();
			} catch (InvocationTargetException e) {
				e.printStackTrace();
			}
		});
		builder.setNegativeButton(tagNegar, (dialog, which) -> {
			try {
				Class<?> noparams[] = {};
				Object object = context.getClass().newInstance();
				Method method = object.getClass().getDeclaredMethod(aMetodoNegar, noparams);
				method.invoke(object);
				
			} catch (NoSuchMethodException e) {
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			} catch (InstantiationException e) {
				e.printStackTrace();
			} catch (InvocationTargetException e) {
				e.printStackTrace();
			}
		});
		AlertDialog alertDialog= builder.create();
		alertDialog.show();
	}
	public static ProgressDialog ProgressDialog(Context context, String Message){
		ProgressDialog progressDialog = new ProgressDialog(context);
		progressDialog.setMessage(Message);
		progressDialog.setCancelable(false);
		return progressDialog;
	}
}
