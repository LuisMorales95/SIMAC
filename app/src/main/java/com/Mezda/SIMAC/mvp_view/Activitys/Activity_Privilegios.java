package com.Mezda.SIMAC.mvp_view.Activitys;

import android.annotation.SuppressLint;
import android.app.ProgressDialog;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.constraint.ConstraintLayout;
import android.support.design.widget.Snackbar;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.Button;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.TextView;

import com.Mezda.SIMAC.mvp_view.Fragments.Fragment_AdministrarUsuarios;
import com.Mezda.SIMAC.Methods.HTTPPARAMS;
import com.Mezda.SIMAC.Objects.LosUsuarios;

import com.Mezda.SIMAC.R;
import com.Mezda.SIMAC.UserData;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.params.HttpParams;
import org.apache.http.util.EntityUtils;
import org.json.JSONArray;

import java.util.ArrayList;

public class Activity_Privilegios extends AppCompatActivity {
	
	LosUsuarios m;
	RadioButton radiociudadano, radiotrabajador, radioadministrador;
	TextView opciones_nombre;
	Button opcion_cambiar;
	RadioGroup opciongroup;
	int opcionselected;
	int opcionstarted;
	ConstraintLayout outside;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_privilegios);
		
		radiociudadano = findViewById(R.id.radiociudadano);
		radiotrabajador = findViewById(R.id.radiotrabajador);
		radioadministrador = findViewById(R.id.radioadministrador);
		opciones_nombre = (TextView) findViewById(R.id.opciones_nombre);
		opcion_cambiar = (Button) findViewById(R.id.opcion_cambiar);
		opciongroup = (RadioGroup) findViewById(R.id.opcionesgroup);
		outside = (ConstraintLayout) findViewById(R.id.outsideopciones);
		
		m = Fragment_AdministrarUsuarios.lista_usuario.get(Fragment_AdministrarUsuarios.usuarioSeleciondo);
		
		String Nombre = m.getNombre() + " " + m.getApellidop();
		
		opciones_nombre.setText(Nombre);
		switch (Integer.valueOf(m.getFk_id_rol())) {
			case 1:
				radiociudadano.setChecked(true);
				opcionstarted = 1;
				opcionselected = 1;
				break;
			case 2:
				radiotrabajador.setChecked(true);
				opcionstarted = 2;
				opcionselected = 2;
				break;
			case 3:
				radioadministrador.setChecked(true);
				opcionstarted = 3;
				opcionselected = 3;
				break;
		}
		opciongroup.setOnCheckedChangeListener(new RadioGroup.OnCheckedChangeListener() {
			@Override
			public void onCheckedChanged(RadioGroup radioGroup, int i) {
				RadioButton rb = (RadioButton) findViewById(i);
				int opcion = rb.getId();
				switch (opcion) {
					case R.id.radiociudadano:
						opcionselected = 1;
						break;
					case R.id.radiotrabajador:
						opcionselected = 2;
						break;
					case R.id.radioadministrador:
						opcionselected = 3;
						break;
				}
			}
		});
		opcion_cambiar.setOnClickListener(new View.OnClickListener() {
			@SuppressLint("StaticFieldLeak")
			@Override
			public void onClick(final View view) {
				if (opcionstarted == opcionselected) {
					Snackbar.make(view, "Esta eligiendo la misma opcion", Snackbar.LENGTH_SHORT).show();
				} else {
					new AsyncTask<Void, Boolean, Boolean>() {
						ProgressDialog progressDialog;
						
						@Override
						protected void onPreExecute() {
							progressDialog = new ProgressDialog(Activity_Privilegios.this);
							progressDialog.setMessage("Realizando Cambios");
							progressDialog.setCancelable(false);
							progressDialog.show();
						}
						
						@Override
						protected Boolean doInBackground(Void... voids) {
							ArrayList<NameValuePair> datatosend = new ArrayList<>();
							datatosend.add(new BasicNameValuePair("id", m.getId_usuario()));
							datatosend.add(new BasicNameValuePair("rol", String.valueOf(opcionselected)));
							HttpParams httpRequestParams = HTTPPARAMS.GETHTTPREQUESTPARAMS();
							HttpClient client = new DefaultHttpClient(httpRequestParams);
							HttpPost post = new HttpPost(UserData.SERVER_ADDRESS + "updateRol.php");
							
							HttpResponse httpResponse = null;
							String responsedecoded = "";
							
							try {
								post.setEntity(new UrlEncodedFormEntity(datatosend));
								httpResponse = client.execute(post);
								HttpEntity httpEntity = httpResponse.getEntity();
								responsedecoded = EntityUtils.toString(httpEntity, "UTF-8");
								JSONArray jsonArray = new JSONArray(responsedecoded);
								String respuesta = jsonArray.getJSONObject(0).getString("EXITO");
								if (respuesta.equals("SI")) {
									
									return true;
								}
								httpEntity.consumeContent();
							} catch (Exception e) {
								e.printStackTrace();
							}
							return false;
						}
						
						@Override
						protected void onPostExecute(Boolean aBoolean) {
							if (aBoolean) {
								progressDialog.dismiss();
								Intent intent = new Intent();
								intent.putExtra("id", "value");
								setResult(RESULT_OK, intent);
								finish();
								
							} else {
								progressDialog.dismiss();
								Snackbar.make(view, "Intente mas tarde", Snackbar.LENGTH_LONG).show();
							}
						}
					}.execute();
				}
			}
		});
		outside.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View view) {
				finish();
			}
		});
	}
	
}
