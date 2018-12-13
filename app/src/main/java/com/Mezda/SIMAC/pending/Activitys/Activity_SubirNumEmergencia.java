package com.Mezda.SIMAC.pending.Activitys;

import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.drawable.BitmapDrawable;
import android.os.AsyncTask;
import android.os.Bundle;
import android.os.StrictMode;
import android.support.v7.app.AppCompatActivity;
import android.util.Base64;
import android.view.View;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;


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
import org.apache.http.protocol.BasicHttpContext;
import org.apache.http.protocol.HttpContext;
import org.apache.http.util.EntityUtils;
import org.json.JSONArray;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

public class Activity_SubirNumEmergencia extends AppCompatActivity {
	
	ImageButton AgregarImagen;
	ImageView AgregarNumero_Imagen;
	Button Enviar_NumeroEmergenica;
	TextView AgregarNumero_Nombre, AgregarNumero_Telefono, AgregarNumero_Extension;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_subirnumemergencia);
		
		AgregarNumero_Nombre = findViewById(R.id.AgregarNumero_Nombre);
		AgregarNumero_Telefono = findViewById(R.id.AgregarNumero_Telefono);
		AgregarNumero_Extension = findViewById(R.id.AgregarNumero_Extension);
		Enviar_NumeroEmergenica = findViewById(R.id.Enviar_NumeroEmergenica);
		AgregarNumero_Imagen = findViewById(R.id.AgregarNumero_Imagen);
		AgregarImagen = findViewById(R.id.AgregarImagen);
		
		AgregarImagen.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View view) {
				agarrarnuevaimage();
			}
		});
		Enviar_NumeroEmergenica.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View view) {
				if (AgregarNumero_Nombre.getText().toString().isEmpty() ||
						AgregarNumero_Telefono.getText().toString().isEmpty() ||
						AgregarNumero_Imagen.getDrawable() == null) {
					final AlertDialog.Builder builder = new AlertDialog.Builder(Activity_SubirNumEmergencia.this);
					builder.setMessage("Se Requiere como minimo: \n\n- Nombre \n- Telefono \n- Imagen")
							.setTitle("Estado")
							.setCancelable(false)
							.setPositiveButton(android.R.string.ok, null);
					AlertDialog dialog = builder.create();
					dialog.show();
				} else {
					
					Bitmap image = ((BitmapDrawable) AgregarNumero_Imagen.getDrawable()).getBitmap();
					new subir_numeroemergencia(
							AgregarNumero_Telefono.getText().toString(),
							AgregarNumero_Extension.getText().toString(),
							AgregarNumero_Nombre.getText().toString(),
							image.toString(),
							image
					).execute();
				}
			}
		});
	}
	
	private void agarrarnuevaimage() {
		StrictMode.VmPolicy.Builder builder = new StrictMode.VmPolicy.Builder();
		StrictMode.setVmPolicy(builder.build());
		Intent getIntent = new Intent(Intent.ACTION_GET_CONTENT);
		getIntent.setType("image/*");
		
		Intent pickIntent = new Intent(Intent.ACTION_PICK, android.provider.MediaStore.Images.Media.EXTERNAL_CONTENT_URI);
		pickIntent.setType("image/*");
		
		Intent chooserIntent = Intent.createChooser(getIntent, "Select Image");
		chooserIntent.putExtra(Intent.EXTRA_INITIAL_INTENTS, new Intent[]{pickIntent});
		startActivityForResult(Intent.createChooser(chooserIntent, "Nueva Foto de Perfil"), 1306);
	}
	
	@Override
	protected void onActivityResult(int requestCode, int resultCode, Intent data) {
		super.onActivityResult(requestCode, resultCode, data);
		if (requestCode == 1306 && resultCode == RESULT_OK) {
			if (data == null) {
				return;
			}
			try {
				InputStream inputStream = getApplicationContext().getContentResolver().openInputStream(data.getData());
				Bitmap maped = BitmapFactory.decodeStream(new BufferedInputStream(inputStream));
				Bitmap dstBmp;
				if (maped.getWidth() >= maped.getHeight()) {
					dstBmp = Bitmap.createBitmap(
							maped,
							maped.getWidth() / 2 - maped.getHeight() / 2,
							0,
							maped.getHeight(),
							maped.getHeight()
					);
				} else {
					dstBmp = Bitmap.createBitmap(
							maped,
							0,
							maped.getHeight() / 2 - maped.getWidth() / 2,
							maped.getWidth(),
							maped.getWidth()
					);
				}
				AgregarNumero_Imagen.setImageBitmap(dstBmp);
				
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			}
			
			Toast.makeText(getBaseContext(), "obtuvo imagen", Toast.LENGTH_LONG).show();
		}
		
	}
	
	
	private class subir_numeroemergencia extends AsyncTask<Void, Boolean, Boolean> {
		String telefono;
		String extencion;
		String NombreEme;
		String url;
		Bitmap image;
		ProgressDialog progressDialog;
		
		public subir_numeroemergencia(String telefono, String extencion, String nombreEme, String url, Bitmap image) {
			this.telefono = telefono;
			this.extencion = extencion;
			NombreEme = nombreEme;
			this.url = url;
			this.image = image;
		}
		
		@Override
		protected void onPreExecute() {
			super.onPreExecute();
			progressDialog = new ProgressDialog(Activity_SubirNumEmergencia.this);
			progressDialog.setMessage("Subiendo Informacion...");
			progressDialog.setCancelable(false);
			progressDialog.show();
		}
		
		@Override
		protected Boolean doInBackground(Void... voids) {
			ByteArrayOutputStream os = new ByteArrayOutputStream();
			image.compress(Bitmap.CompressFormat.JPEG, 100, os);
			String encodedimage = Base64.encodeToString(os.toByteArray(), Base64.DEFAULT);
			
			HttpClient httpc = new DefaultHttpClient();
			HttpContext localc = new BasicHttpContext();
			HttpPost httppost = new HttpPost(UserData.SERVER_ADDRESS + "JSONInsertNEmergencia.php");
			HttpResponse response = null;
			String res = null;
			
			try {
				List<NameValuePair> params = new ArrayList<NameValuePair>();
				params.add(new BasicNameValuePair("telefono", telefono));
				params.add(new BasicNameValuePair("extencion", extencion));
				params.add(new BasicNameValuePair("NombreEme", NombreEme));
				params.add(new BasicNameValuePair("urlimagen", url));
				params.add(new BasicNameValuePair("image", encodedimage));
				httppost.setEntity(new UrlEncodedFormEntity(params));
				
				response = httpc.execute(httppost, localc);
				HttpEntity entity = response.getEntity();
				res = EntityUtils.toString(entity, "UTF-8");
				
				JSONArray jsonArray = new JSONArray(res);
				String Contrasena = jsonArray.getJSONObject(0).getString("EXITO");
				if (Contrasena.equals("SI")) {
					return true;
				} else {
					return false;
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			return false;
			
		}
		
		@Override
		protected void onPostExecute(Boolean aBoolean) {
			super.onPostExecute(aBoolean);
			progressDialog.dismiss();
			if (aBoolean) {
				final AlertDialog.Builder builder = new AlertDialog.Builder(Activity_SubirNumEmergencia.this);
				builder.setMessage("Solicitud Realizado Exitosamente")
						.setTitle("Estado")
						.setCancelable(false)
						.setPositiveButton(android.R.string.ok, new DialogInterface.OnClickListener() {
							@Override
							public void onClick(DialogInterface dialogInterface, int i) {
								Intent intent = new Intent();
								intent.putExtra("id", "value");
								setResult(RESULT_OK, intent);
								finish();
							}
						});
				AlertDialog dialog = builder.create();
				dialog.show();
			} else {
				final AlertDialog.Builder builder = new AlertDialog.Builder(Activity_SubirNumEmergencia.this);
				builder.setMessage("Solicitud Fallida Intente Mas Tarde")
						.setTitle("Estado")
						.setCancelable(false)
						.setPositiveButton(android.R.string.ok, null);
				AlertDialog dialog = builder.create();
				dialog.show();
			}
		}
	}
	
}
