package com.example.josel.apptest.Fragments;

import android.Manifest;
import android.annotation.SuppressLint;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.pm.PackageManager;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.v4.app.ActivityCompat;
import android.support.v4.app.Fragment;
import android.support.v4.content.ContextCompat;
import android.telephony.TelephonyManager;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;

import com.example.josel.apptest.Activitys.Activity_Registrar;
import com.example.josel.apptest.Methods.HTTPPARAMS;
import com.example.josel.apptest.Activitys.Activity_Main;
import com.example.josel.apptest.R;
import com.example.josel.apptest.Methods.UpdateToken;
import com.example.josel.apptest.UserData;
import com.example.josel.apptest.Activitys.Activity_Get_PhoneNum;
import com.example.josel.apptest.Activitys.Activity_Get_ValidationCode;
import com.google.firebase.iid.FirebaseInstanceId;

import org.apache.http.HttpEntity;
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

import static android.app.Activity.RESULT_OK;


/**
 * A simple {@link Fragment} subclass.
 * Activities that contain this fragment must implement the
 * {@link Fragment_Login.OnFragmentInteractionListener} interface
 * to handle interaction events.
 * Use the {@link Fragment_Login#newInstance} factory method to
 * create an instance of this fragment.
 */
public class Fragment_Login extends Fragment {

    //  TODO: View elements on the fragment
    private Button validarportelefono;
    private final int PHONERQUESTPERCODE = 1002;
    

    // TODO: Variables for the code
    private SharedPreferences preferences;

    // TODO: Animations


    // TODO: Instances
    Fragment_AtencionC fragmentAtencionC = new Fragment_AtencionC();

    // TODO: Dialogs


    // TODO: Rename parameter arguments, choose names that match
    // the fragment initialization parameters, e.g. ARG_ITEM_NUMBER
    private static final String ARG_PARAM1 = "param1";
    private static final String ARG_PARAM2 = "param2";

    // TODO: Rename and change types of parameters
    private String mParam1;
    private String mParam2;

    private OnFragmentInteractionListener mListener;




    public Fragment_Login() {
        // Required empty public constructor
    }

    /**
     * Use this factory method to create a new instance of
     * this fragment using the provided parameters.
     *
     * @param param1 Parameter 1.
     * @param param2 Parameter 2.
     * @return A new instance of fragment Fragment_Login.
     */
    // TODO: Rename and change types and number of parameters
    public static Fragment_Login newInstance(String param1, String param2) {
        Fragment_Login fragment = new Fragment_Login();
        Bundle args = new Bundle();
        args.putString(ARG_PARAM1, param1);
        args.putString(ARG_PARAM2, param2);
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (getArguments() != null) {
            mParam1 = getArguments().getString(ARG_PARAM1);
            mParam2 = getArguments().getString(ARG_PARAM2);
        }
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_login, container, false);
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        validarportelefono = view.findViewById(R.id.validarportelefono);
        preferences = getActivity().getSharedPreferences(UserData.Credential,Context.MODE_PRIVATE);

        validarportelefono.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                premission();
            }
        });

    }
    private void premission(){
        if (ContextCompat.checkSelfPermission( getActivity() , android.Manifest.permission.READ_PHONE_STATE)
                != PackageManager.PERMISSION_GRANTED){
            ActivityCompat.requestPermissions(getActivity() , new String[]{
                    Manifest.permission.READ_PHONE_STATE
            },PHONERQUESTPERCODE);
        }else  {
            if (UserData.Telefono.equals("")){
                TelephonyManager mTelephonyManager;
                mTelephonyManager = (TelephonyManager) getActivity().getSystemService(Context.TELEPHONY_SERVICE);
                if (mTelephonyManager.getPhoneType() == TelephonyManager.PHONE_TYPE_NONE){
                    startActivityForResult(new Intent(getActivity(),Activity_Get_PhoneNum.class),024);
                }else{
                    UserData.Telefono = mTelephonyManager.getLine1Number();
                    if (UserData.Telefono.length()!=13){
                        startActivityForResult(new Intent(getActivity(),Activity_Get_PhoneNum.class),024);
                    }else{
                        new telephoneval(UserData.Telefono).execute();
                    }
                }
                
            }else{
                new telephoneval(UserData.Telefono).execute();
            }




/*
            RequestQueue requestQueue = Volley.newRequestQueue(getContext());
            String url_address = UserData.SERVER_ADDRESS+"JSONtelephoneval.php";
            StringRequest postRequest = new StringRequest(Request.Method.POST, url_address, new Response.Listener<String>() {
                @Override
                public void onResponse(String response) {
                    final ProgressDialog pDialog = new ProgressDialog(getContext());
                    // Showing progress dialog before making http request
                    pDialog.setMessage("Creando...");
                    pDialog.setCancelable(false);
                    pDialog.show();
                    try {
                        JSONArray jsonArray= new JSONArray(response);
                        String DataBase_Id = jsonArray.getJSONObject(0).getString("Id");
                        String DataBase_Token = jsonArray.getJSONObject(0).getString("Token");
                        String DataBase_email = jsonArray.getJSONObject(0).getString("CorreoE");
                        String DataBase_Name = jsonArray.getJSONObject(0).getString("Nombre")+" "+jsonArray.getJSONObject(0).getString("ApellidoP");
                        String DataBase_UserImageURL = jsonArray.getJSONObject(0).getString("ImgUrl");
                        String DataBase_Rol = jsonArray.getJSONObject(0).getString("fk_id_rol");
                        String Verificacion_Usuario = jsonArray.getJSONObject(0).getString("Verificacion_Usuario");

                        if (jsonArray.length()>0){
                            if (Verificacion_Usuario.equals("1")) {
                                pDialog.dismiss();
                                SharedPreferences.Editor editor = preferences.edit();
                                editor.putString("ID", DataBase_Id);
                                editor.putString("TOKEN", DataBase_Token);
                                editor.putString("IMGUSU", DataBase_UserImageURL);
                                editor.putString("Nombre", DataBase_Name);
                                editor.putString("Correo", DataBase_email);
                                editor.putString("Rol", DataBase_Rol);
                                editor.apply();
                                Activity_Main.header_name.setText(preferences.getString("Nombre",""));
                                Activity_Main.header_email.setText(preferences.getString("Correo",""));
                                Activity_Main.navigationView.getMenu().getItem(0).setChecked(true);
                                getActivity().invalidateOptionsMenu();
                                Activity_Main.ocultar_campos();
                                new UpdateToken(FirebaseInstanceId.getInstance().getToken(), preferences).execute();
                                getActivity().getSupportFragmentManager().beginTransaction().replace(R.id.flContent,fragmentAtencionC).addToBackStack(null).commit();
                            }else{
                                pDialog.dismiss();
                                final android.app.AlertDialog.Builder builder = new android.app.AlertDialog.Builder(getActivity());
                                builder.setMessage("Es necesario activar su cuenta!")
                                        .setTitle("Aviso")
                                        .setCancelable(false)
                                        .setPositiveButton(android.R.string.ok, null).show();
                                builder.create();
                            }
                        }else{
                            pDialog.dismiss();
                            final android.app.AlertDialog.Builder builder = new android.app.AlertDialog.Builder(getActivity());
                            builder.setMessage("Su numero no esta vinculado a una cuenta \n ¿Desea crear cuenta ahora?")
                                    .setTitle("Aviso")
                                    .setCancelable(false)
                                    .setPositiveButton(android.R.string.ok, new DialogInterface.OnClickListener() {
                                        @Override
                                        public void onClick(DialogInterface dialogInterface, int i) {
                                            startActivity(new Intent(getActivity(),Activity_Registrar.class));
                                        }
                                    })
                                    .setNegativeButton("No", null).show();
                            builder.create();
                        }
                    } catch (JSONException e) {
                        e.printStackTrace();
                    }

                }
            }, new Response.ErrorListener() {
                @Override
                public void onErrorResponse(VolleyError error) {

                    final android.app.AlertDialog.Builder builder = new android.app.AlertDialog.Builder(getActivity());
                    builder.setMessage("Error Masivo")
                            .setTitle("Aviso")
                            .setCancelable(false)
                            .setPositiveButton(android.R.string.ok, null).show();
                    builder.create();
                }
            }){
                @Override
                protected Map<String, String> getParams() throws AuthFailureError {
                    Map<String, String>  params = new HashMap<String, String>();
                    params.put("telefono",UserData.Telefono);
                    return params;
                }
            };
            requestQueue.add(postRequest);
*/



        }
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode==024 && resultCode == RESULT_OK){
            premission();
        }
    }

    @SuppressLint("MissingPermission")
    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        if (requestCode==PHONERQUESTPERCODE){
            if (grantResults.length>0){
                premission();
            }else{
                final android.app.AlertDialog.Builder builder = new android.app.AlertDialog.Builder(getActivity());
                builder.setMessage("Es necesario obtener este permiso")
                        .setTitle("Estado")
                        .setCancelable(false)
                        .setPositiveButton(android.R.string.ok, null);
                android.app.AlertDialog dialog1 = builder.create();
                dialog1.show();
            }
        }
    }


    private class telephoneval extends AsyncTask<Void,Integer, Integer>{

        String telephone;
        private String DataBase_Token, DataBase_UserImageURL,DataBase_Id, DataBase_Name,DataBase_email, DataBase_Rol;
        private String Verificacion_Usuario;

        public telephoneval(String telephone) {
            this.telephone = telephone;
        }

        @Override
        protected void onPreExecute() {
            super.onPreExecute();
        }

        @Override
        protected Integer doInBackground(Void... voids) {

//              TODO: Array of parameters for the web service
            @SuppressWarnings("MismatchedQueryAndUpdateOfCollection")
            ArrayList<NameValuePair> nameValuePairs = new ArrayList<>();
            nameValuePairs.add(new BasicNameValuePair("telefono",telephone));

//              TODO: Connection to send "NameValuesPairs" to DataBase
            HttpParams httpParams = HTTPPARAMS.GETHTTPREQUESTPARAMS();
            HttpClient httpClient = new DefaultHttpClient(httpParams);
            HttpPost httpPost = new HttpPost(UserData.SERVER_ADDRESS+"JSONtelephoneval.php");

//              TODO: Response from server
            org.apache.http.HttpResponse httpResponse = null;
            String ResponseCode = "";
            try {
                httpPost.setEntity(new UrlEncodedFormEntity(nameValuePairs));
                httpResponse = httpClient.execute(httpPost);
                HttpEntity httpEntity = httpResponse.getEntity();
                ResponseCode = EntityUtils.toString(httpEntity,"UTF-8");

                JSONArray jsonArray = new JSONArray(ResponseCode);


                if (!ResponseCode.equals("[]")){
                    DataBase_Id = jsonArray.getJSONObject(0).getString("Id");
                    DataBase_Token = jsonArray.getJSONObject(0).getString("Token");
                    DataBase_email = jsonArray.getJSONObject(0).getString("CorreoE");
                    DataBase_Name = jsonArray.getJSONObject(0).getString("Nombre")+" "+jsonArray.getJSONObject(0).getString("ApellidoP");
                    DataBase_UserImageURL = jsonArray.getJSONObject(0).getString("ImgUrl");
                    DataBase_Rol = jsonArray.getJSONObject(0).getString("fk_id_rol");
                    Verificacion_Usuario = jsonArray.getJSONObject(0).getString("Verificacion_Usuario");
                    httpEntity.consumeContent();
                    if (Verificacion_Usuario.equals("1")) {
                        SharedPreferences.Editor editor = preferences.edit();
                        editor.putString("ID", DataBase_Id);
                        editor.putString("TOKEN", DataBase_Token);
                        editor.putString("IMGUSU", DataBase_UserImageURL);
                        editor.putString("Nombre", DataBase_Name);
                        editor.putString("Correo", DataBase_email);
                        editor.putString("Rol", DataBase_Rol);
                        editor.apply();
                        return 1;
                    }else{
                        return 3;
                    }
                }else{
                    return 4;
                }

            }catch (Exception e){
                e.printStackTrace();
            }
            return 2;

        }
        @Override
        protected void onPostExecute(Integer aBoolean) {
            super.onPostExecute(aBoolean);
            if (aBoolean==1){
                Activity_Main.header_name.setText(preferences.getString("Nombre",""));
                Activity_Main.header_email.setText(preferences.getString("Correo",""));
                Activity_Main.navigationView.getMenu().getItem(0).setChecked(true);
                getActivity().invalidateOptionsMenu();
                Activity_Main.ocultar_campos();
	            new UpdateToken(FirebaseInstanceId.getInstance().getToken()).execute();
                getActivity().getSupportFragmentManager().beginTransaction().replace(R.id.flContent,fragmentAtencionC).addToBackStack(null)                   .commit();
            }else if (aBoolean==2){
                final android.app.AlertDialog.Builder builder = new android.app.AlertDialog.Builder(getActivity());
                builder.setMessage("error server")
                        .setTitle("Aviso")
                        .setCancelable(false)
                        .setPositiveButton(android.R.string.ok, null)
                        .setNegativeButton("No", null).show();
                builder.create();
            }else if (aBoolean==3){
                final android.app.AlertDialog.Builder builder = new android.app.AlertDialog.Builder(getActivity());
                builder.setMessage("Es necesario activar su cuenta!")
                        .setTitle("Aviso")
                        .setCancelable(false)
                        .setPositiveButton(android.R.string.ok, new DialogInterface.OnClickListener() {
                            @Override
                            public void onClick(DialogInterface dialogInterface, int i) {
                            startActivity(new Intent(getActivity(),Activity_Get_ValidationCode.class));
                            }
                        }).show();
                builder.create();

            }else if (aBoolean==4){
                final android.app.AlertDialog.Builder builder = new android.app.AlertDialog.Builder(getActivity());
                builder.setMessage("Su numero no esta vinculado a una cuenta \n ¿Desea crear cuenta ahora?")
                        .setTitle("Aviso")
                        .setCancelable(false)
                        .setPositiveButton(android.R.string.ok, new DialogInterface.OnClickListener() {
                            @Override
                            public void onClick(DialogInterface dialogInterface, int i) {
                                startActivity(new Intent(getActivity(),Activity_Registrar.class));
                            }
                        })
                        .setNegativeButton("No", null).show();
                builder.create();
            }
        }
    }



















    // TODO: Rename method, update argument and hook method into UI event
    public void onButtonPressed(Uri uri) {
        if (mListener != null) {
            mListener.onFragmentInteraction(uri);
        }
    }

    @Override
    public void onAttach(Context context) {
        super.onAttach(context);
        if (context instanceof OnFragmentInteractionListener) {
            mListener = (OnFragmentInteractionListener) context;
        } else {
            throw new RuntimeException(context.toString()
                    + " must implement OnFragmentInteractionListener");
        }
    }

    @Override
    public void onDetach() {
        super.onDetach();
        mListener = null;
    }

    /**
     * This interface must be implemented by activities that contain this
     * fragment to allow an interaction in this fragment to be communicated
     * to the activity and potentially other fragments contained in that
     * activity.
     * <p>
     * See the Android Training lesson <a href=
     * "http://developer.android.com/training/basics/fragments/communicating.html"
     * >Communicating with Other Fragments</a> for more information.
     */
    public interface OnFragmentInteractionListener {
        // TODO: Update argument type and name
        void onFragmentInteraction(Uri uri);
    }
}
