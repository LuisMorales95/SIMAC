package com.example.josel.apptest.Methods;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.drawable.Drawable;
import android.os.AsyncTask;
import android.util.Log;
import android.widget.ImageView;

import com.example.josel.apptest.R;

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

import java.io.InputStream;
import java.lang.ref.WeakReference;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

public class ImageDownloaderTask extends AsyncTask<String, Void, Bitmap> {


    private final WeakReference<ImageView> imageViewReference;


    public ImageDownloaderTask(ImageView imageView) {
        imageViewReference = new WeakReference<ImageView>(imageView);
    }


    @Override
    protected Bitmap doInBackground(String... params) {
        return downloadBitmap(params[0]);
    }

    @Override
    protected void onPostExecute(Bitmap bitmap) {

        if (isCancelled()) {
            bitmap = null;
        }
        if (imageViewReference != null) {
            ImageView imageView = imageViewReference.get();
            if (imageView != null) {
                if (bitmap != null) {
                    imageView.setImageBitmap(bitmap);
                } else {
                    Drawable placeholder = imageView.getContext().getResources().getDrawable(R.drawable.wait);
                    imageView.setImageDrawable(placeholder);
                }
            }
        }
    }


    public boolean validarusuario(String user, String pass){
        HttpClient httpc = new DefaultHttpClient();
        HttpContext localc = new BasicHttpContext();
        HttpPost httppost = new HttpPost("http://clothinglinestore.esy.es/consultarUsuario.php");
        HttpResponse response = null;
        String res = null;
        try {

            List<NameValuePair> params = new ArrayList<NameValuePair>();
            params.add(new BasicNameValuePair("usu", user));
            params.add(new BasicNameValuePair("contra", pass));
            httppost.setEntity(new UrlEncodedFormEntity(params));

            response = httpc.execute(httppost, localc);
            HttpEntity entity = response.getEntity();
            res = EntityUtils.toString(entity, "UTF-8");

            JSONArray jsonArray = new JSONArray(res);
            /**
            String Contrasena = jsonArray.getJSONObject(0).getString("Contrasenna");
            id = jsonArray.getJSONObject(0).getString("id_usuario");
            Nombre = jsonArray.getJSONObject(0).getString("Nombre");
            App = jsonArray.getJSONObject(0).getString("Ap_paterno");
            Apm = jsonArray.getJSONObject(0).getString("Ap_materno");
            if(Contrasena.equals(pass)){
                Almacen_de_datos.id=id;
                Almacen_de_datos.nom=Nombre;
                Almacen_de_datos.app=App;
                Almacen_de_datos.apm=Apm;
                return true;
            }**/
        }catch (Exception e){
        }
        return false;
    }



    private Bitmap downloadBitmap(String url) {
        HttpURLConnection urlConnection = null;
        try {
            URL uri = new URL(url);
            urlConnection = (HttpURLConnection) uri.openConnection();
            int statusCode = urlConnection.getResponseCode();
            if (statusCode != 200) {
                return null;
            }
            InputStream inputStream = urlConnection.getInputStream();
            if (inputStream != null) {
                Bitmap bitmap = BitmapFactory.decodeStream(inputStream);
                return bitmap;
            }
        } catch (Exception e) {
            urlConnection.disconnect();
            Log.w("ImageDownloader", "Error downloading image from " + url);
        } finally {
            if (urlConnection != null) {
                urlConnection.disconnect();
            }
        }
        return null;
    }



}
