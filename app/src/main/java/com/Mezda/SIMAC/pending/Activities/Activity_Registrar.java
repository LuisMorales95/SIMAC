package com.Mezda.SIMAC.pending.Activities;

import android.Manifest;
import android.app.DatePickerDialog;
import android.app.Dialog;
import android.app.DialogFragment;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.SharedPreferences;
import android.content.pm.PackageManager;
import android.os.AsyncTask;
import android.os.Build;
import android.os.Bundle;
import android.support.annotation.RequiresApi;
import android.support.v4.app.ActivityCompat;
import android.support.v4.content.ContextCompat;
import android.support.v7.app.AppCompatActivity;
import android.telephony.TelephonyManager;
import android.text.Editable;
import android.text.TextWatcher;
import android.util.Log;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.Spinner;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.Mezda.SIMAC.utils.HTTPPARAMS;
import com.Mezda.SIMAC.R;

import com.Mezda.SIMAC.UserData;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.params.HttpParams;
import org.apache.http.util.EntityUtils;
import org.json.JSONArray;
import org.json.JSONException;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import cn.pedant.SweetAlert.SweetAlertDialog;

public class Activity_Registrar extends AppCompatActivity {
	
	static ImageView fechaimagen;
	static EditText editFecha;
	final int PHONERQUESTPERCODE = 1002;
	Activity_Login log = new Activity_Login();
	String Telefono;
	int Genero = 0;
	ArrayAdapter<CharSequence> langAdapter;
	String[] GetColonias, GetColoniasId;
	Spinner spinner;
	ImageView nombreimagen, Apellidoimagen, imagedirecion, correoimagen, CorrioVerifyimagen;
	ImageView backtologin, buttoncambiargenero, Sexoimagen, enviar;
	EditText editnombre, editApellido, editDireccion, editDireccionNumExt, editCorreo, editCorreoVerify;
	EditText[] editTexts;
	SweetAlertDialog pdialogerror, pdialogExito, pdialogmastarde;
	SharedPreferences preferences;
	private int currentApiVersion;
	private String valid_email;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_registrar);
		currentApiVersion = android.os.Build.VERSION.SDK_INT;
		final int flags =
				View.SYSTEM_UI_FLAG_LAYOUT_STABLE
						| View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION
						//| View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN
						| View.SYSTEM_UI_FLAG_HIDE_NAVIGATION
						//| View.SYSTEM_UI_FLAG_FULLSCREEN
						| View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY;
		if (currentApiVersion >= Build.VERSION_CODES.KITKAT) {
			getWindow().getDecorView().setSystemUiVisibility(flags);
			final View decorView = getWindow().getDecorView();
			decorView
					.setOnSystemUiVisibilityChangeListener(new View.OnSystemUiVisibilityChangeListener() {
						@Override
						public void onSystemUiVisibilityChange(int visibility) {
							if ((visibility & View.SYSTEM_UI_FLAG_FULLSCREEN) == 0) {
								decorView.setSystemUiVisibility(flags);
							}
						}
					});
		}
		getSupportActionBar().hide();
		backtologin = (ImageView) findViewById(R.id.backtologin);
		buttoncambiargenero = (ImageView) findViewById(R.id.buttoncambiargenero);
		Sexoimagen = (ImageView) findViewById(R.id.Sexoimagen);
		enviar = (ImageView) findViewById(R.id.enviar);
		
		editFecha = (EditText) findViewById(R.id.editFecha);
		
		editnombre = (EditText) findViewById(R.id.editnombre);
		editApellido = (EditText) findViewById(R.id.editApellido);
		editDireccion = (EditText) findViewById(R.id.editDireccion);
		editDireccionNumExt = (EditText) findViewById(R.id.editDireccionNumExt);
		editCorreo = (EditText) findViewById(R.id.editCorreo);
		editCorreoVerify = (EditText) findViewById(R.id.editCorreoVerify);
		
		nombreimagen = (ImageView) findViewById(R.id.nombreimagen);
		Apellidoimagen = (ImageView) findViewById(R.id.Apellidoimagen);
		fechaimagen = (ImageView) findViewById(R.id.fechaimagen);
		imagedirecion = (ImageView) findViewById(R.id.imagedirecion);
		correoimagen = (ImageView) findViewById(R.id.correoimagen);
		CorrioVerifyimagen = (ImageView) findViewById(R.id.CorrioVerifyimagen);
		
		
		editTexts = new EditText[]{
				editnombre,
				editApellido,
				editFecha,
				editDireccion,
				editDireccionNumExt,
				editCorreo,
				editCorreoVerify,
		};
		setOnKeyListener();
		setOnClickListener();
		
		
		spinner = (Spinner) findViewById(R.id.colonia);
		spinner.setClickable(false);
		
		if (Genero == 0) {
			Sexoimagen.setImageResource(R.drawable.ic_gender_male);
		}
		preferences = getSharedPreferences("Credenciales", MODE_PRIVATE);
		new Spinnerfill(findViewById(android.R.id.content)).execute();
		pdialogerror = new SweetAlertDialog(this, SweetAlertDialog.ERROR_TYPE);
		pdialogExito = new SweetAlertDialog(this, SweetAlertDialog.SUCCESS_TYPE);
		pdialogmastarde = new SweetAlertDialog(this, SweetAlertDialog.NORMAL_TYPE);
		
		
	}
	
	
	// code here
	
	
	// code here
	
	@Override
	public void onBackPressed() {
	
	}
	
	private boolean premission() {
		if (ContextCompat.checkSelfPermission(this, Manifest.permission.READ_PHONE_STATE)
				!= PackageManager.PERMISSION_GRANTED) {
			ActivityCompat.requestPermissions(this, new String[]{
					Manifest.permission.READ_PHONE_STATE
			}, PHONERQUESTPERCODE);
			return false;
		} else {
			TelephonyManager mTelephonyManager;
			mTelephonyManager = (TelephonyManager) getSystemService(Context.TELEPHONY_SERVICE);
			Telefono = mTelephonyManager.getLine1Number();
			String[] array = Telefono.split("");
			Telefono = "(" + array[4] + array[5] + array[6] + ")" + array[7] + array[8] + array[9] + " " + array[10] + array[11] + array[12] + array[13];
			return true;
		}
	}
	
	public void fill() {
		langAdapter = new ArrayAdapter<CharSequence>(this, R.layout.spinner_text, GetColonias);
		langAdapter.setDropDownViewResource(R.layout.simple_spinner_dropdown);
		spinner.setAdapter(langAdapter);
	}
	
	public void setOnKeyListener() {
		
		editnombre.addTextChangedListener(new CustomTextWatcher() {
			@Override
			public void onTextChanged(CharSequence s, int start, int before, int count) {
				if (editnombre.getText().toString().isEmpty()) {
					nombreimagen.setImageResource(R.drawable.ic_menu_accountsignup);
				} else {
					nombreimagen.setImageResource(R.drawable.ic_menu_accountsignup_green);
				}
				super.onTextChanged(s, start, before, count);
			}
		});
		editApellido.addTextChangedListener(new CustomTextWatcher() {
			@Override
			public void onTextChanged(CharSequence s, int start, int before, int count) {
				if (editApellido.getText().toString().isEmpty()) {
					Apellidoimagen.setImageResource(R.drawable.ic_menu_apellido);
				} else {
					Apellidoimagen.setImageResource(R.drawable.ic_menu_apellido_green);
				}
				super.onTextChanged(s, start, before, count);
			}
		});
		editDireccion.addTextChangedListener(new CustomTextWatcher() {
			@Override
			public void onTextChanged(CharSequence s, int start, int before, int count) {
				if (editDireccion.getText().toString().isEmpty()) {
					imagedirecion.setImageResource(R.drawable.ic_menu_home);
				} else {
					if (!editDireccion.getText().toString().isEmpty() && !editDireccionNumExt.getText().toString().isEmpty()) {
						imagedirecion.setImageResource(R.drawable.ic_menu_home_green);
					}
				}
				super.onTextChanged(s, start, before, count);
			}
		});
		
		
		editDireccionNumExt.addTextChangedListener(new CustomTextWatcher() {
			@Override
			public void onTextChanged(CharSequence s, int start, int before, int count) {
				if (editDireccionNumExt.getText().toString().isEmpty()) {
					imagedirecion.setImageResource(R.drawable.ic_menu_home);
				} else {
					if (!editDireccion.getText().toString().isEmpty() && !editDireccionNumExt.getText().toString().isEmpty()) {
						imagedirecion.setImageResource(R.drawable.ic_menu_home_green);
					}
				}
				super.onTextChanged(s, start, before, count);
			}
		});
		editCorreo.addTextChangedListener(new CustomTextWatcher() {
			@Override
			public void onTextChanged(CharSequence s, int start, int before, int count) {
				if (editCorreo.getText().toString().isEmpty()) {
					correoimagen.setImageResource(R.drawable.ic_menu_email);
				} else {
					correoimagen.setImageResource(R.drawable.ic_menu_email_green);
				}
				super.onTextChanged(s, start, before, count);
			}
			
			@Override
			public void afterTextChanged(Editable s) {
				Is_Valid_Email(editCorreo);
			}
			
			public void Is_Valid_Email(EditText edt) {
				if (edt.getText().toString() == null) {
					edt.setError("Invalid Email Address");
					valid_email = null;
				} else if (validateEmail(edt.getText().toString()) == false) {
					edt.setError("Invalid Email Address");
					valid_email = null;
				} else {
					valid_email = edt.getText().toString();
				}
			}
			
			public boolean validateEmail(String email) {
				
				Pattern pattern;
				Matcher matcher;
				String EMAIL_PATTERN = "^[_A-Za-z0-9-]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{3,})$";
				pattern = Pattern.compile(EMAIL_PATTERN);
				matcher = pattern.matcher(email);
				return matcher.matches();
				
			}
			
		});
		editCorreoVerify.addTextChangedListener(new CustomTextWatcher() {
			@Override
			public void onTextChanged(CharSequence s, int start, int before, int count) {
				if (editCorreoVerify.getText().toString().isEmpty()) {
					CorrioVerifyimagen.setImageResource(R.drawable.ic_menu_verifyemail);
				} else {
					if (editCorreoVerify.getText().toString().equals(editCorreo.getText().toString())) {
						CorrioVerifyimagen.setImageResource(R.drawable.ic_menu_verifyemail_green);
					} else {
						CorrioVerifyimagen.setImageResource(R.drawable.ic_menu_verifyemail);
						editCorreoVerify.setError("Correo no coincide");
					}
				}
				super.onTextChanged(s, start, before, count);
			}
		});
		
	}
	
	public void setOnClickListener() {
		buttoncambiargenero.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View view) {
				if (Genero == 0) {
					Sexoimagen.setImageResource(R.drawable.ic_gender_female);
					Genero = 1;
				} else if (Genero == 1) {
					Sexoimagen.setImageResource(R.drawable.ic_gender_male);
					Genero = 0;
				}
			}
		});
		backtologin.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View view) {
				finish();
			}
		});
		
		editFecha.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View view) {
				DialogFragment newFragment = new DatePickerFragment();
				newFragment.show(getFragmentManager(), "datePicker");
			}
		});
		enviar.setOnClickListener(new View.OnClickListener() {
			@RequiresApi(api = Build.VERSION_CODES.LOLLIPOP)
			@Override
			public void onClick(View view) {
				
				int verify = 0;
				for (int i = 0; i < editTexts.length; i++) {
					if (!editTexts[i].getText().toString().isEmpty()) {
						
						verify++;
					} else {
						editTexts[i].setError("Campos Requeridos");
					}
				}
				if (verify == editTexts.length) {
					final int item = spinner.getSelectedItemPosition();
					if (editCorreo.getText().toString().equals(editCorreoVerify.getText().toString())) {
						final ProgressDialog pDialog = new ProgressDialog(Activity_Registrar.this);
						// Showing progress dialog before making http request
						pDialog.setMessage("Creando...");
						pDialog.setCancelable(false);
						pDialog.show();

//                      TODO: Volly Post Request and getting values
						
						RequestQueue queue = Volley.newRequestQueue(getApplicationContext());
						String url = UserData.SERVER_ADDRESS + "JSONInsertUser.php";
						StringRequest postRequest = new StringRequest(Request.Method.POST, url,
								new Response.Listener<String>() {
									@Override
									public void onResponse(String response) {
										String resultado = "";
										try {
											
											JSONArray jsonArray = new JSONArray(response);
											resultado = jsonArray.getJSONObject(0).getString("EXITO");
											
											if (resultado.equals("SI")) {
												pDialog.dismiss();
												final android.app.AlertDialog.Builder builder = new android.app.AlertDialog.Builder(Activity_Registrar.this);
												builder.setMessage("Su cuenta fue creada exitosamente.")
														.setTitle("Aviso")
														.setCancelable(false)
														.setPositiveButton(android.R.string.ok, new DialogInterface.OnClickListener() {
															@Override
															public void onClick(DialogInterface dialogInterface, int i) {
																finish();
															}
														}).show();
												builder.create();
												
											} else if (resultado.equals("NOVALIDO")) {
												pDialog.dismiss();
												final android.app.AlertDialog.Builder builder = new android.app.AlertDialog.Builder(Activity_Registrar.this);
												builder.setMessage("Correo Invalido!")
														.setTitle("Aviso")
														.setCancelable(false)
														.setPositiveButton(android.R.string.ok, new DialogInterface.OnClickListener() {
															@Override
															public void onClick(DialogInterface dialogInterface, int i) {
																editCorreo.setError("Correo vinculado a otra cuenta");
																editCorreoVerify.setText("");
															}
														}).show();
												builder.create();
												
											} else {
												pDialog.dismiss();
												final android.app.AlertDialog.Builder builder = new android.app.AlertDialog.Builder(Activity_Registrar.this);
												builder.setMessage("Error en el servidor intente mas tarde!")
														.setTitle("Error 144")
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
								},
								new Response.ErrorListener() {
									@Override
									public void onErrorResponse(VolleyError error) {
										pDialog.dismiss();
										final android.app.AlertDialog.Builder builder = new android.app.AlertDialog.Builder(Activity_Registrar.this);
										builder.setMessage("Error en el servidor intente mas tarde!")
												.setTitle("Error 144")
												.setCancelable(false)
												.setPositiveButton(android.R.string.ok, new DialogInterface.OnClickListener() {
													@Override
													public void onClick(DialogInterface dialogInterface, int i) {
														finish();
													}
												}).show();
										builder.create();
										Log.d("Error.Response", error.toString());
									}
								}
						) {
							@Override
							protected Map<String, String> getParams() {
								Map<String, String> params = new HashMap<String, String>();
								params.put("nombre", editnombre.getText().toString());
								params.put("ApellidoM", editApellido.getText().toString());
								params.put("fecha", editFecha.getText().toString());
								params.put("sexo", String.valueOf(Genero));
								params.put("telefono", UserData.Telefono);
								params.put("direccion", editDireccion.getText().toString());
								params.put("numext", editDireccionNumExt.getText().toString());
								params.put("colonia", GetColoniasId[item]);
								params.put("correo", editCorreo.getText().toString());
								return params;
							}
						};
						queue.add(postRequest);
						
						
					} else {
						
						final android.app.AlertDialog.Builder builder = new android.app.AlertDialog.Builder(Activity_Registrar.this);
						builder.setMessage("Verifique que los correos coincidan")
								.setTitle("Correo no Coinciden")
								.setCancelable(false)
								.setPositiveButton(android.R.string.ok, new DialogInterface.OnClickListener() {
									@Override
									public void onClick(DialogInterface dialogInterface, int i) {
										editCorreo.setError("Correo no Coinciden");
										editCorreoVerify.setError("Correo no Coinciden");
									}
								}).show();
						builder.create();
						
					}
					
				} else {
					
					final android.app.AlertDialog.Builder builder = new android.app.AlertDialog.Builder(Activity_Registrar.this);
					builder.setMessage("Verifique los campos esten llenos")
							.setTitle("Campos Vacios")
							.setCancelable(false)
							.setPositiveButton(android.R.string.ok, new DialogInterface.OnClickListener() {
								@Override
								public void onClick(DialogInterface dialogInterface, int i) {
									editCorreo.setError("Correo no Coinciden");
									editCorreoVerify.setError("Correo no Coinciden");
								}
							}).show();
					builder.create();
					
				}
			}
		});
	}
	
	public static class DatePickerFragment extends DialogFragment implements DatePickerDialog.OnDateSetListener {
		
		public Dialog onCreateDialog(Bundle savedInstanceState) {
			// Use the current date as the default date in the picker
			final Calendar c = Calendar.getInstance();
			int year = c.get(Calendar.YEAR);
			int month = c.get(Calendar.MONTH);
			int day = c.get(Calendar.DAY_OF_MONTH);
			return new DatePickerDialog(getActivity(), this, year, month, day);
		}
		
		public void onDateSet(DatePicker view, int year, int month, int day) {
			String monthstring, daystring;
			if (month < 10) {
				monthstring = "0" + month;
			} else {
				monthstring = String.valueOf(month);
			}
			if (day < 10) {
				daystring = "0" + day;
			} else {
				daystring = String.valueOf(day);
			}
			editFecha.setText(String.valueOf(year) + "-" + monthstring + "-" + daystring + " 00:00:00");
//            editFecha.setText(daystring + "/" + monthstring + "/" + String.valueOf(year));
			editFecha.setError(null);
			fechaimagen.setImageResource(R.drawable.ic_menu_calendar_green);
		}
	}
	
	private class Spinnerfill extends AsyncTask<Void, Boolean, Boolean> {
		int STATUS = 0;
		private View ROOTVIEW;
		
		public Spinnerfill(View ROOTVIEW) {
			this.ROOTVIEW = ROOTVIEW;
		}
		
		@Override
		protected Boolean doInBackground(Void... voids) {
			// ++ ARRAY DE PARAMETROS QUE VAS A MANDAR AL WEB SERVICE ++
			ArrayList<NameValuePair> datatosend = new ArrayList<>();
			
			// ++ CONECCION PARA MANDAR LOS PARAMETROS ++
			HttpParams httpRequestParams = HTTPPARAMS.GETHTTPREQUESTPARAMS();
			HttpClient client = new DefaultHttpClient(httpRequestParams);
			HttpPost post = new HttpPost(UserData.SERVER_ADDRESS + "JSONSelectColonia.php");
			
			// ++ RESPONSE FROM SERVER ++
			HttpResponse httpResponse = null;
			String responsedecoded = "";
			
			try {
				post.setEntity(new UrlEncodedFormEntity(datatosend));
				httpResponse = client.execute(post);
				HttpEntity httpEntity = httpResponse.getEntity();
				responsedecoded = EntityUtils.toString(httpEntity, "UTF-8");
				JSONArray jsonArray = new JSONArray(responsedecoded);
				GetColonias = new String[jsonArray.length()];
				GetColoniasId = new String[jsonArray.length()];
				for (int i = 0; i < jsonArray.length(); i++) {
					GetColoniasId[i] = jsonArray.getJSONObject(i).getString("Id");
					GetColonias[i] = jsonArray.getJSONObject(i).getString("Colonia");
				}
				STATUS = 1;
			} catch (Exception e) {
				e.printStackTrace();
			}
			if (STATUS == 1) {
				return true;
			} else {
				return false;
			}
		}
		
		@Override
		protected void onPostExecute(final Boolean result) {
			if (result) {
				spinner.setClickable(true);
				fill();
				//Snackbar.make(ROOTVIEW,"Exito",Snackbar.LENGTH_LONG).show();
				//startActivity(new Intent(Activity_Registrar.this,Activity_Main.class));
				//finish();
			} else {
				//Snackbar.make(ROOTVIEW,"Usuario/Contraseña Incorrecto",Snackbar.LENGTH_LONG).show();
				
			}
		}
	}
	
	public class CustomTextWatcher implements TextWatcher {
		
		@Override
		public void beforeTextChanged(CharSequence s, int start, int count, int after) {
		
		}
		
		@Override
		public void onTextChanged(CharSequence s, int start, int before, int count) {
		
		}
		
		@Override
		public void afterTextChanged(Editable s) {
		
		}
	}
}