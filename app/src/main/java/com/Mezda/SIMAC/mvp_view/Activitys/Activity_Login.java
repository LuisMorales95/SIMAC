package com.Mezda.SIMAC.mvp_view.Activitys;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.AsyncTask;
import android.os.Build;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.EditText;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.ProgressBar;
import android.widget.TextView;

import com.Mezda.SIMAC.Methods.HTTPPARAMS;
import com.Mezda.SIMAC.R;

import com.Mezda.SIMAC.UserData;
import com.Mezda.SIMAC.Methods.UpdateToken;
import com.google.firebase.iid.FirebaseInstanceId;

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


public class Activity_Login extends AppCompatActivity {

    static ImageButton logexe;
    View view4,view5;
    EditText Edittuser,Editcontra;
    TextView textView2,textView3;
    ImageView imageView6,imageView7;
    ProgressBar progress;
    static Animation myAnim;
    SharedPreferences preferences;

    private int currentApiVersion;
    @SuppressLint("StaticFieldLeak")
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);


        currentApiVersion = android.os.Build.VERSION.SDK_INT;
        final int flags =
                  View.SYSTEM_UI_FLAG_LAYOUT_STABLE
                | View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION
                | View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN
                | View.SYSTEM_UI_FLAG_HIDE_NAVIGATION
                | View.SYSTEM_UI_FLAG_FULLSCREEN
                | View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY;
        if(currentApiVersion >= Build.VERSION_CODES.KITKAT) {
            getWindow().getDecorView().setSystemUiVisibility(flags);
            final View decorView = getWindow().getDecorView();
            decorView
                    .setOnSystemUiVisibilityChangeListener(new View.OnSystemUiVisibilityChangeListener() {
                        @Override
                        public void onSystemUiVisibilityChange(int visibility) {
                            if((visibility & View.SYSTEM_UI_FLAG_FULLSCREEN) == 0) {
                                decorView.setSystemUiVisibility(flags);
                            }
                        }
                    });
        }
        getSupportActionBar().hide();


        progress = (ProgressBar) findViewById(R.id.progresssym);
        view4 = (View) findViewById(R.id.view4);
        view5 = (View) findViewById(R.id.view5);
        textView2 = (TextView) findViewById(R.id.textView2);
        textView3 = (TextView) findViewById(R.id.crearcuenta);
        imageView6 = (ImageView) findViewById(R.id.imageView6);
        imageView7 = (ImageView) findViewById(R.id.imageView7);
        Edittuser = (EditText) findViewById(R.id.Edittuser);
        Editcontra = (EditText) findViewById(R.id.Editcontra);
        logexe = (ImageButton) findViewById(R.id.log);

        progress.setVisibility(View.VISIBLE);
        view4.setVisibility(View.INVISIBLE);
        view5.setVisibility(View.INVISIBLE);
        textView2.setVisibility(View.INVISIBLE);
        textView3.setVisibility(View.INVISIBLE);
        imageView6.setVisibility(View.INVISIBLE);
        imageView7.setVisibility(View.INVISIBLE);
        Edittuser.setVisibility(View.INVISIBLE);
        Editcontra.setVisibility(View.INVISIBLE);
        logexe.setVisibility(View.INVISIBLE);

        preferences = getSharedPreferences("Credenciales",MODE_PRIVATE);
        final String TOKEN_PREFERENCIAS = preferences.getString("TOKEN","");
                if (TOKEN_PREFERENCIAS ==""){
                    progress.setVisibility(View.INVISIBLE);
                    view4.setVisibility(View.VISIBLE);
                    view5.setVisibility(View.VISIBLE);
                    textView2.setVisibility(View.VISIBLE);
                    textView3.setVisibility(View.VISIBLE);
                    imageView6.setVisibility(View.VISIBLE);
                    imageView7.setVisibility(View.VISIBLE);
                    Edittuser.setVisibility(View.VISIBLE);
                    Editcontra.setVisibility(View.VISIBLE);
                    logexe.setVisibility(View.VISIBLE);
                    myAnim = AnimationUtils.loadAnimation(Activity_Login.this, R.anim.milkshake);
                    Edittuser.setHint("Correo");
                    Edittuser.setText("Luis@developer.com");
                    Editcontra.setHint("Contraseña");
                    Editcontra.setText("google");
                    String refreshedToken = FirebaseInstanceId.getInstance().getToken();
                    System.out.println(refreshedToken);
                    
                    logexe.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View view) {
                            new validate_por_campos(Activity_Login.this,Edittuser.getText().toString(),Editcontra.getText().toString(),findViewById(android.R.id.content),preferences).execute();
                        }
                    });
                    
                    textView3.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View view) {
                            startActivity(new Intent(Activity_Login.this,Activity_Registrar.class));
                        }
                    });
                    
                }else{
                    
                    new validate_por_TOKEN(findViewById(android.R.id.content),preferences).execute();
                
                }



    }


    public static class validate_por_campos extends AsyncTask<Void,Boolean,Boolean> {
        String Correo,Contraseña;
        String Basecontra="";
        String Token,IMAGENUSU,id, nombre, correoe;
        int STATUS = 0;
        private View ROOTVIEW;
        SharedPreferences PREFERENCIAS;
        Activity activity;
        public validate_por_campos (Activity activity, String correo,String contraseña,View ROOTVIEW,SharedPreferences PREFERENCIAS){
            this.activity=activity;
            this.Correo= correo;
            this.Contraseña= contraseña;
            this.ROOTVIEW = ROOTVIEW;
            this.PREFERENCIAS = PREFERENCIAS;
        }
        @Override
        protected Boolean doInBackground(Void... voids) {
            SharedPreferences.Editor editor = PREFERENCIAS.edit();
            // ++ ARRAY DE PARAMETROS QUE VAS A MANDAR AL WEB SERVICE ++
            ArrayList<NameValuePair> datatosend = new ArrayList<>();
            datatosend.add(new BasicNameValuePair("Correo",Correo));

            // ++ CONECCION PARA MANDAR LOS PARAMETROS ++
            HttpParams httpRequestParams = HTTPPARAMS.GETHTTPREQUESTPARAMS();
            HttpClient client = new DefaultHttpClient(httpRequestParams);
            HttpPost post = new HttpPost(UserData.SERVER_ADDRESS+"JSONLogin.php");

            // ++ RESPONSE FROM SERVER ++
            HttpResponse httpResponse = null;
            String responsedecoded = "";

            try {
                post.setEntity(new UrlEncodedFormEntity(datatosend));
                httpResponse = client.execute(post);
                HttpEntity httpEntity = httpResponse.getEntity();
                responsedecoded = EntityUtils.toString(httpEntity,"UTF-8");
                JSONArray jsonArray = new JSONArray(responsedecoded);
                id = jsonArray.getJSONObject(0).getString("id");
                Token = jsonArray.getJSONObject(0).getString("Token");
                Basecontra = jsonArray.getJSONObject(0).getString("Contraseña");
                IMAGENUSU = jsonArray.getJSONObject(0).getString("ImgUrl");
                nombre = jsonArray.getJSONObject(0).getString("Nombre");
                correoe = jsonArray.getJSONObject(0).getString("CorreoE");
                if (Contraseña.equals(Basecontra)){
                    STATUS=1;
                    editor.putString("ID",id);
                    editor.putString("TOKEN",Token);
                    editor.putString("IMGUSU",IMAGENUSU);
                    editor.putString("Nombre",nombre);
                    editor.putString("Correo",correoe);
                    editor.commit();
                    httpEntity.consumeContent();
                }
                httpEntity.consumeContent();
            }catch (Exception e){
                e.printStackTrace();
            }
            if (STATUS==1){
                return true;
            }else{
                return false;
            }
        }
        @Override
        protected void onPostExecute(final Boolean result) {
                    if (result){
                        //Snackbar.make(ROOTVIEW,"Exito",Snackbar.LENGTH_LONG).show();
	                    new UpdateToken(FirebaseInstanceId.getInstance().getToken()).execute();
                        Intent this_intent = new Intent(activity,Activity_Main.class);
                        activity.startActivity(this_intent);
                        activity.finish();
                    }else{
                        //Snackbar.make(ROOTVIEW,"Usuario/Contraseña Incorrecto",Snackbar.LENGTH_LONG).show();
                        logexe.setAnimation(myAnim);
                    }
                }
    }

    private class validate_por_TOKEN extends AsyncTask<Void,Boolean,Boolean> {

        String token;
        int STATUS = 0;
        private View ROOTVIEW;
        SharedPreferences TOKEN;

        public validate_por_TOKEN (View ROOTVIEW,SharedPreferences TOKEN){
            this.ROOTVIEW = ROOTVIEW;
            this.TOKEN = TOKEN;
        }

        @Override
        protected void onPreExecute() {
            super.onPreExecute();
        }

        @Override
        protected Boolean doInBackground(Void... voids) {
            String Token = TOKEN.getString("TOKEN","");


            // ++ ARRAY DE PARAMETROS QUE VAS A MANDAR AL WEB SERVICE ++
            ArrayList<NameValuePair> datatosend = new ArrayList<>();
            datatosend.add(new BasicNameValuePair("Token",Token));

            // ++ CONECCION PARA MANDAR LOS PARAMETROS ++
            HttpParams httpRequestParams = HTTPPARAMS.GETHTTPREQUESTPARAMS();
            HttpClient client = new DefaultHttpClient(httpRequestParams);
            HttpPost post = new HttpPost(UserData.SERVER_ADDRESS+"tokenverify.php");

            // ++ RESPONSE FROM SERVER ++
            HttpResponse httpResponse = null;
            String responsedecoded = "";

            try {
                post.setEntity(new UrlEncodedFormEntity(datatosend));
                httpResponse = client.execute(post);
                HttpEntity httpEntity = httpResponse.getEntity();
                responsedecoded = EntityUtils.toString(httpEntity,"UTF-8");
                JSONArray jsonArray = new JSONArray(responsedecoded);
                token = jsonArray.getJSONObject(0).getString("Token");
                if (token.equals(Token)){
                    STATUS=1;
                    httpEntity.consumeContent();
                }
                httpEntity.consumeContent();
            }catch (Exception e){
                e.printStackTrace();
            }
            if (STATUS==1){
                return true;
            }else{
                return false;

            }
        }
        @Override
        protected void onPostExecute(final Boolean result) {
            if (result){
                        Intent open = new Intent(Activity_Login.this,Activity_Main.class);
	            new UpdateToken(FirebaseInstanceId.getInstance().getToken()).execute();
                        startActivity(open);
                        finish();
                        progress.setVisibility(View.INVISIBLE);
            }else{
                //Snackbar.make(ROOTVIEW,"Sesion iniciada en otro equipo",Snackbar.LENGTH_LONG).show();

                SharedPreferences.Editor editor = TOKEN.edit();
                editor.putString("TOKEN","");
                editor.putString("IMGUSU","");
                editor.putString("ID","");
                editor.putString("Nombre","");
                editor.putString("Correo","");
                editor.commit();
                finish();
                startActivity(new Intent(Activity_Login.this,Activity_Login.class));

            }
        }
    }

    @Override
    public void onWindowFocusChanged(boolean hasFocus) {
        super.onWindowFocusChanged(hasFocus);
        if(currentApiVersion >= Build.VERSION_CODES.KITKAT && hasFocus)
        {
            getWindow().getDecorView().setSystemUiVisibility(
                    View.SYSTEM_UI_FLAG_LAYOUT_STABLE
                            | View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION
                            | View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN
                            | View.SYSTEM_UI_FLAG_HIDE_NAVIGATION
                            | View.SYSTEM_UI_FLAG_FULLSCREEN
                            | View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY);
        }
    }
}
