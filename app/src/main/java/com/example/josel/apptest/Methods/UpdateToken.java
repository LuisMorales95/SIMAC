package com.example.josel.apptest.Methods;

import android.os.AsyncTask;

import com.example.josel.apptest.UserData;

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

import static com.example.josel.apptest.Methods.SharedPreference.GETSharedPreferences;


public class UpdateToken extends AsyncTask<Void, Boolean, Boolean> {
	String token;
	int STATUS = 0;
	
	public UpdateToken(String token) {
		this.token = token;
	}
	
	@Override
	protected void onPreExecute() {
		super.onPreExecute();
	}
	
	@Override
	protected Boolean doInBackground(Void... voids) {
		String id_usuario = GETSharedPreferences("ID", "");
		
		
		// ++ ARRAY DE PARAMETROS QUE VAS A MANDAR AL WEB SERVICE ++
		ArrayList<NameValuePair> datatosend = new ArrayList<>();
		datatosend.add(new BasicNameValuePair("id", id_usuario));
		datatosend.add(new BasicNameValuePair("token", token));
		
		// ++ CONECCION PARA MANDAR LOS PARAMETROS ++
		HttpParams httpRequestParams = HTTPPARAMS.GETHTTPREQUESTPARAMS();
		HttpClient client = new DefaultHttpClient(httpRequestParams);
		HttpPost post = new HttpPost(UserData.SERVER_ADDRESS + "notiftokeninsert.php");
		
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
			if (respuesta.equals("SI")) {
				STATUS = 1;
				httpEntity.consumeContent();
			}
			httpEntity.consumeContent();
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
			System.out.println("Token identificador se ha guardado");
		} else {
			System.out.println("error al intentar guardar");
		}
	}
}











