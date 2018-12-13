package com.Mezda.SIMAC.pending.Activitys;

import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Context;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.constraint.ConstraintLayout;
import android.support.v7.app.AppCompatActivity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import com.Mezda.SIMAC.utils.HTTPPARAMS;
import com.Mezda.SIMAC.data.dao.Comentario;
import com.Mezda.SIMAC.UserData;
import com.Mezda.SIMAC.R;

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

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import static com.Mezda.SIMAC.utils.SharedPreference.*;

public class Activity_Comments extends AppCompatActivity {
	public static int commentposition;
	static public List<Comentario> lista_de_comentarios;
	static TextView comentario_amount;
	static EditText comentario_text;
	private static ProgressDialog pDialog;
	private static CustomListAdapter adapter;
	ListView comentario_list;
	Button comentario_envia;
	
	private static void hidePDialog() {
		if (pDialog != null) {
			pDialog.dismiss();
			pDialog = null;
		}
	}
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_comment);
		lista_de_comentarios = new ArrayList<Comentario>();
		pDialog = new ProgressDialog(this);
		// Showing progress dialog before making http request
		pDialog.setMessage("Loading...");
		pDialog.show();
		ConstraintLayout outsidecomment = (ConstraintLayout) findViewById(R.id.outsidecomment);
		outsidecomment.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View view) {
				finish();
			}
		});
		comentario_amount = findViewById(R.id.comentario_amount);
		comentario_list = findViewById(R.id.comentario_list);
		comentario_text = findViewById(R.id.comentario_text);
		comentario_envia = findViewById(R.id.comentario_envia);
		comentario_amount.setText("");
		new jalar_comentarios(getCurrentFocus(), String.valueOf(commentposition), lista_de_comentarios).execute();
		adapter = new CustomListAdapter(this, lista_de_comentarios);
		comentario_list.setAdapter(adapter);
		
		
		comentario_envia.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View view) {
				if (comentario_text.getText().toString().isEmpty()) {
					
					Toast.makeText(getApplicationContext(), "Escriba su Comentario", Toast.LENGTH_SHORT).show();
				} else {
					Toast.makeText(getApplicationContext(), "Enviando Comentario", Toast.LENGTH_SHORT).show();
					Date c = Calendar.getInstance().getTime();
					SimpleDateFormat df = new SimpleDateFormat("dd-MMM-yyyy");
					String date = df.format(c);
					new insertar_comentarios(getCurrentFocus(), String.valueOf(commentposition), GETSharedPreferences("ID", ""), comentario_text.getText().toString(), date).execute();
				}
				
			}
		});
	}
	
	public static class jalar_comentarios extends AsyncTask<Void, Boolean, Boolean> {
		
		View rootview;
		String noticia_id;
		List<Comentario> Lista_de_comentario;
		
		public jalar_comentarios(View rootview, String noticia_id, List<Comentario> lista_de_comentario) {
			this.rootview = rootview;
			this.noticia_id = noticia_id;
			Lista_de_comentario = lista_de_comentario;
		}
		
		@Override
		protected Boolean doInBackground(Void... voids) {
			ArrayList<NameValuePair> datatosend = new ArrayList<>();
			datatosend.add(new BasicNameValuePair("id_noticia", noticia_id));
			HttpParams httpRequestParams = HTTPPARAMS.GETHTTPREQUESTPARAMS();
			HttpClient client = new DefaultHttpClient(httpRequestParams);
			HttpPost post = new HttpPost(UserData.SERVER_ADDRESS + "comentarios.php");
			// ++ RESPONSE FROM SERVER ++
			HttpResponse httpResponse = null;
			String responsedecoded = "";
			
			try {
				post.setEntity(new UrlEncodedFormEntity(datatosend));
				httpResponse = client.execute(post);
				HttpEntity httpEntity = httpResponse.getEntity();
				responsedecoded = EntityUtils.toString(httpEntity, "UTF-8");
				JSONArray jsonArray = new JSONArray(responsedecoded);
				for (int i = 0; i < jsonArray.length(); i++) {
					Comentario comentario = new Comentario();
					comentario.setId_comentario(jsonArray.getJSONObject(i).getString("id_comentario"));
					comentario.setImageUrl(jsonArray.getJSONObject(i).getString("ImgURL"));
					comentario.setName(jsonArray.getJSONObject(i).getString("Nombre") + " " + jsonArray.getJSONObject(i).getString("ApellidoP"));
					comentario.setComment(jsonArray.getJSONObject(i).getString("comentario"));
					comentario.setFecha(jsonArray.getJSONObject(i).getString("fecha"));
					comentario.setId_usuario(jsonArray.getJSONObject(i).getString("id"));
					Lista_de_comentario.add(comentario);
				}
				httpEntity.consumeContent();
				return true;
			} catch (Exception e) {
				e.printStackTrace();
			}
			return false;
			
		}
		
		@Override
		protected void onPostExecute(final Boolean result) {
			if (result) {
				hidePDialog();
				if (lista_de_comentarios.size() > 0) {
					comentario_amount.setText(lista_de_comentarios.size() + " Comentarios");
				} else {
					comentario_amount.setText("Ningun Comentario");
				}
				adapter.notifyDataSetChanged();
			} else {
				/*TODO: Poner dialogo de que no se pudo obtener informacion*/
			}
		}
	}
	
	public static class insertar_comentarios extends AsyncTask<Void, Boolean, Boolean> {
		
		View rootview;
		String noticia_id, usuario_id, comentario, fecha;
		
		public insertar_comentarios(View rootview, String noticia_id, String usuario_id, String comentario, String fecha) {
			this.rootview = rootview;
			this.noticia_id = noticia_id;
			this.usuario_id = usuario_id;
			this.comentario = comentario;
			this.fecha = fecha;
		}
		
		@Override
		protected Boolean doInBackground(Void... voids) {
			ArrayList<NameValuePair> datatosend = new ArrayList<>();
			datatosend.add(new BasicNameValuePair("id_noticia", noticia_id));
			datatosend.add(new BasicNameValuePair("id_usuario", usuario_id));
			datatosend.add(new BasicNameValuePair("comentario", comentario));
			datatosend.add(new BasicNameValuePair("fecha", fecha));
			HttpParams httpRequestParams = HTTPPARAMS.GETHTTPREQUESTPARAMS();
			HttpClient client = new DefaultHttpClient(httpRequestParams);
			HttpPost post = new HttpPost(UserData.SERVER_ADDRESS + "insertcomentario.php");
			// ++ RESPONSE FROM SERVER ++
			HttpResponse httpResponse = null;
			String responsedecoded = "";
			
			try {
				post.setEntity(new UrlEncodedFormEntity(datatosend));
				httpResponse = client.execute(post);
				HttpEntity httpEntity = httpResponse.getEntity();
				responsedecoded = EntityUtils.toString(httpEntity, "UTF-8");
				JSONArray jsonArray = new JSONArray(responsedecoded);
				String respuesta = jsonArray.getJSONObject(0).getString("EXITO");
				httpEntity.consumeContent();
				if (respuesta.equals("SI")) {
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
		protected void onPostExecute(final Boolean result) {
			if (result) {
				comentario_text.setText("");
				lista_de_comentarios.clear();
				new jalar_comentarios(rootview, String.valueOf(commentposition), lista_de_comentarios).execute();
			} else {
				/*TODO: Poner dialogo de que no se pudo obtener informacion*/
			}
		}
	}
	
	public static class delete_comentario extends AsyncTask<Void, Boolean, Boolean> {
		
		View rootview;
		String comentario_id;
		
		public delete_comentario(View rootview, String comentario_id) {
			this.rootview = rootview;
			this.comentario_id = comentario_id;
		}
		
		@Override
		protected Boolean doInBackground(Void... voids) {
			ArrayList<NameValuePair> datatosend = new ArrayList<>();
			datatosend.add(new BasicNameValuePair("id_comentario", comentario_id));
			HttpParams httpRequestParams = HTTPPARAMS.GETHTTPREQUESTPARAMS();
			HttpClient client = new DefaultHttpClient(httpRequestParams);
			HttpPost post = new HttpPost(UserData.SERVER_ADDRESS + "delete_comentario.php");
			// ++ RESPONSE FROM SERVER ++
			HttpResponse httpResponse = null;
			String responsedecoded = "";
			
			try {
				post.setEntity(new UrlEncodedFormEntity(datatosend));
				httpResponse = client.execute(post);
				HttpEntity httpEntity = httpResponse.getEntity();
				responsedecoded = EntityUtils.toString(httpEntity, "UTF-8");
				JSONArray jsonArray = new JSONArray(responsedecoded);
				String respuesta = jsonArray.getJSONObject(0).getString("EXITO");
				httpEntity.consumeContent();
				if (respuesta.equals("SI")) {
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
		protected void onPostExecute(final Boolean result) {
			if (result) {
				lista_de_comentarios.clear();
				new jalar_comentarios(rootview, String.valueOf(commentposition), lista_de_comentarios).execute();
			} else {
				/*TODO: Poner dialogo de que no se pudo obtener informacion*/
			}
		}
	}
	
	public class CustomListAdapter extends BaseAdapter {
		private Activity activity;
		private List<Comentario> list_comentario;
		
		private LayoutInflater inflater;
		
		public CustomListAdapter(Activity activity, List<Comentario> list_comentario) {
			this.activity = activity;
			this.list_comentario = list_comentario;
		}
		
		@Override
		public int getCount() {
			return list_comentario.size();
		}
		
		@Override
		public Object getItem(int position) {
			return list_comentario.get(position);
		}
		
		@Override
		public long getItemId(int i) {
			return 0;
		}
		
		@Override
		public View getView(int position, View view, ViewGroup viewGroup) {
			if (inflater == null) inflater = (LayoutInflater) activity.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
			if (view == null) view = inflater.inflate(R.layout.plantilla_comentario, null);
			TextView comentario_name = view.findViewById(R.id.comentario_name);
			TextView comentario_description = view.findViewById(R.id.comentario_description);
			TextView comentario_date = view.findViewById(R.id.comentario_date);
			ImageView comentario_trash = view.findViewById(R.id.comentario_trash);
			final Comentario comment = list_comentario.get(position);
			
			comentario_name.setText(comment.getName());
			comentario_description.setText(comment.getComment());
			comentario_date.setText(comment.getFecha());
			if (comment.getId_usuario().equals(GETSharedPreferences("ID", ""))) {
				comentario_trash.setVisibility(View.VISIBLE);
				comentario_trash.setClickable(true);
			} else {
				comentario_trash.setVisibility(View.INVISIBLE);
				comentario_trash.setClickable(false);
			}
			comentario_trash.setOnClickListener(new View.OnClickListener() {
				@Override
				public void onClick(View view) {
					new delete_comentario(getCurrentFocus(), comment.getId_comentario()).execute();
				}
			});
			return view;
		}
	}
	
	
}
