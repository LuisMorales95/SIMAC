package com.example.josel.apptest.Activitys;

import android.app.ProgressDialog;
import android.content.DialogInterface;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;

import com.android.volley.AuthFailureError;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.example.josel.apptest.R;
import com.example.josel.apptest.UserData;

import org.json.JSONArray;
import org.json.JSONException;

import java.util.HashMap;
import java.util.Map;

public class Activity_Get_ValidationCode extends AppCompatActivity {
	EditText get_validation_code_code;
	Button get_validation_code_send;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_get_validationcode);
		get_validation_code_code = (EditText) findViewById(R.id.get_validation_code_code);
		get_validation_code_send = (Button) findViewById(R.id.get_validation_code_send);
		get_validation_code_send.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View view) {
				
				if (get_validation_code_code.getText().length() == 10) {
					final ProgressDialog progressDialog = new ProgressDialog(Activity_Get_ValidationCode.this);
					progressDialog.setMessage("Validando Cuenta");
					progressDialog.setCancelable(false);
					progressDialog.show();
					RequestQueue requestQueue = Volley.newRequestQueue(getApplicationContext());
					String Url = UserData.SERVER_ADDRESS + "validateaccount.php";
					StringRequest postrequest = new StringRequest(Request.Method.POST, Url, new Response.Listener<String>() {
						@Override
						public void onResponse(String response) {
							try {
								JSONArray jsonArray = new JSONArray(response);
								String exito = jsonArray.getJSONObject(0).getString("EXITO");
								if (exito.equals("SI")) {
									progressDialog.dismiss();
									final android.app.AlertDialog.Builder builder = new android.app.AlertDialog.Builder(Activity_Get_ValidationCode.this);
									builder.setMessage("Cuenta Activada")
											.setTitle("Aviso")
											.setCancelable(false)
											.setPositiveButton(android.R.string.ok, new DialogInterface.OnClickListener() {
												@Override
												public void onClick(DialogInterface dialogInterface, int i) {
													finish();
												}
											}).show();
									builder.create();
								} else if (exito.equals("NO")) {
									progressDialog.dismiss();
									final android.app.AlertDialog.Builder builder = new android.app.AlertDialog.Builder(Activity_Get_ValidationCode.this);
									builder.setMessage("Codigo Invalido")
											.setTitle("Aviso")
											.setCancelable(false)
											.setPositiveButton(android.R.string.ok, new DialogInterface.OnClickListener() {
												@Override
												public void onClick(DialogInterface dialogInterface, int i) {
													finish();
												}
											}).show();
									builder.create();
								} else {
									progressDialog.dismiss();
									final android.app.AlertDialog.Builder builder = new android.app.AlertDialog.Builder(Activity_Get_ValidationCode.this);
									builder.setMessage("Error en Servidor")
											.setTitle("Aviso")
											.setCancelable(false)
											.setPositiveButton(android.R.string.ok, new DialogInterface.OnClickListener() {
												@Override
												public void onClick(DialogInterface dialogInterface, int i) {
													finish();
												}
											}).show();
									builder.create();
								}
								
							} catch (JSONException e) {
								e.printStackTrace();
							}
						}
					}, new Response.ErrorListener() {
						@Override
						public void onErrorResponse(VolleyError error) {
							progressDialog.dismiss();
							final android.app.AlertDialog.Builder builder = new android.app.AlertDialog.Builder(Activity_Get_ValidationCode.this);
							builder.setMessage("Error en Envio")
									.setTitle("Aviso")
									.setCancelable(false)
									.setPositiveButton(android.R.string.ok, new DialogInterface.OnClickListener() {
										@Override
										public void onClick(DialogInterface dialogInterface, int i) {
											finish();
										}
									}).show();
							builder.create();
						}
					}) {
						@Override
						protected Map<String, String> getParams() throws AuthFailureError {
							Map<String, String> params = new HashMap<String, String>();
							params.put("telefono", UserData.Telefono);
							params.put("code", get_validation_code_code.getText().toString());
							return params;
							
						}
					};
					requestQueue.add(postrequest);
				} else {
					final android.app.AlertDialog.Builder builder = new android.app.AlertDialog.Builder(Activity_Get_ValidationCode.this);
					builder.setMessage("Codigo debe ser de 10 Caracteres")
							.setTitle("Aviso")
							.setCancelable(false)
							.setPositiveButton(android.R.string.ok, null).show();
					builder.create();
				}
				
			}
		});
	}
}
