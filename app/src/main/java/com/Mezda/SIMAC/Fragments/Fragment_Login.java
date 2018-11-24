package com.Mezda.SIMAC.Fragments;

import android.Manifest;
import android.annotation.SuppressLint;
import android.app.AlertDialog;
import android.app.ProgressDialog;
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
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.Toast;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.Mezda.SIMAC.Activitys.Activity_Get_PhoneNum;
import com.Mezda.SIMAC.Activitys.Activity_Get_ValidationCode;
import com.Mezda.SIMAC.Activitys.Activity_Main;
import com.Mezda.SIMAC.Activitys.Activity_Registrar;
import com.Mezda.SIMAC.Methods.HTTPPARAMS;
import com.Mezda.SIMAC.Methods.UpdateToken;
import com.Mezda.SIMAC.Methods.VolleySingleton;

import com.Mezda.SIMAC.UserData;
import com.bumptech.glide.Glide;
import com.facebook.CallbackManager;
import com.facebook.FacebookCallback;
import com.facebook.FacebookException;
import com.facebook.GraphRequest;
import com.facebook.GraphResponse;
import com.facebook.login.LoginResult;
import com.facebook.login.widget.LoginButton;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;
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
import org.json.JSONException;
import org.json.JSONObject;
import com.Mezda.SIMAC.R;

import java.security.Permission;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

import butterknife.BindView;
import butterknife.ButterKnife;

import static android.app.Activity.RESULT_OK;
import static com.Mezda.SIMAC.Methods.SharedPreference.GETSharedPreferences;
import static com.Mezda.SIMAC.Methods.SharedPreference.SETSharedPreferences;
import static com.facebook.FacebookSdk.getApplicationContext;


/**
 * A simple {@link Fragment} subclass.
 * Activities that contain this fragment must implement the
 * {@link Fragment_Login.OnFragmentInteractionListener} interface
 * to handle interaction events.
 * Use the {@link Fragment_Login#newInstance} factory method to
 * create an instance of this fragment.
 */
public class Fragment_Login extends Fragment {
    private static final String ARG_PARAM1 = "param1";
    private static final String ARG_PARAM2 = "param2";
    private final int PHONERQUESTPERCODE = 1002;
    Fragment_AtencionC fragmentAtencionC = new Fragment_AtencionC();
    
    @BindView(R.id.LoginBackground)
    ImageView loginbackground;
    @BindView(R.id.validarportelefono)
    Button validarportelefono;
    @BindView(R.id.facebookLogin)
    LoginButton loginButton;
    
    private SharedPreferences preferences;
    private FirebaseAuth auth;
    private String nombre;
    private String apellido;
    private String id;
    private String email;
    private String mParam1;
    private String mParam2;
    private CallbackManager callbackManager;
    private ProgressDialog progressDialog;
    private OnFragmentInteractionListener mListener;
    
    
    public Fragment_Login() {
        // Required empty public constructor
    }
    
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
        View view = inflater.inflate(R.layout.fragment_login, container, false);
        ((Activity_Main) getActivity()).setActionBarTitle("Inicia Sesión");
        ((Activity_Main) getActivity()).clearMainDrawer();
        ButterKnife.bind(this,view);
        Glide.with(this).load(R.drawable.fondologinapp).into(loginbackground);
        return view;
    }
    
    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        callbackManager = CallbackManager.Factory.create();
        preferences = getActivity().getSharedPreferences(UserData.Credential, Context.MODE_PRIVATE);
        auth = FirebaseAuth.getInstance();
        
        validarportelefono.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                premission();
            }
        });
        
        loginButton.setFragment(this);
        loginButton.setReadPermissions(Arrays.asList("email", "public_profile"));
        loginButton.registerCallback(callbackManager, new FacebookCallback<LoginResult>() {
            @Override
            public void onSuccess(LoginResult loginResult) {
                progressDialog = new ProgressDialog(getContext());
                progressDialog.setMessage("Obteniendo Informacion...");
                progressDialog.show();
                
                String accesstoken = loginResult.getAccessToken().toString();
                GraphRequest request = GraphRequest.newMeRequest(loginResult.getAccessToken(), new GraphRequest.GraphJSONObjectCallback() {
                    @Override
                    public void onCompleted(JSONObject object, GraphResponse response) {
                        progressDialog.dismiss();
                        Log.i("Response: ", response.toString());
//                       new AlertDialog.Builder(getActivity()).setMessage(object.toString()).show();
                        try {
                            id = object.getString("id");
                            nombre = object.getString("first_name");
                            apellido = object.getString("last_name");
                            email = object.getString("email");
                            UserExistes(email);
                        } catch (JSONException e) {
                            e.printStackTrace();
                        }
                        
                    }
                });
                Bundle parameters = new Bundle();
                parameters.putString("fields", "id,name,email,first_name,middle_name,last_name,picture");
                request.setParameters(parameters);
                request.executeAsync();
            }
            
            @Override
            public void onCancel() {
                Toast.makeText(getContext(), "Canceled", Toast.LENGTH_SHORT).show();
            }
            
            @Override
            public void onError(FacebookException error) {
                Toast.makeText(getContext(), "Error: " + error.toString(), Toast.LENGTH_SHORT).show();
            }
        });
        
    }
    
    private void premission() {
        if (ContextCompat.checkSelfPermission(getActivity(), android.Manifest.permission.READ_PHONE_STATE)
                != PackageManager.PERMISSION_GRANTED) {
            ActivityCompat.requestPermissions(getActivity(), new String[]{
                    Manifest.permission.READ_PHONE_STATE
            }, PHONERQUESTPERCODE);
        } else {
            if (UserData.Telefono.equals("")) {
                TelephonyManager mTelephonyManager;
                mTelephonyManager = (TelephonyManager) getActivity().getSystemService(Context.TELEPHONY_SERVICE);
                if (mTelephonyManager.getPhoneType() == TelephonyManager.PHONE_TYPE_NONE) {
                    /*new AlertDialog.Builder(getActivity())
                            .setMessage("Dispositivo Invalido")
                            .setCancelable(false)
                            .setPositiveButton("Ok", new DialogInterface.OnClickListener() {
                                @Override
                                public void onClick(DialogInterface dialog, int which) {
                                    dialog.dismiss();
                                }
                            }).show();*/
                    startActivityForResult(new Intent(getActivity(),Activity_Get_PhoneNum.class),024);
                } else {
                    UserData.Telefono = mTelephonyManager.getLine1Number();
                    if (UserData.Telefono.length() != 13) {
                        startActivityForResult(new Intent(getActivity(), Activity_Get_PhoneNum.class), 024);
                    } else {
                        new telephoneval(UserData.Telefono).execute();
                    }
                }
            } else {
                new telephoneval(UserData.Telefono).execute();
            }
            
            
        }
    }
    
    private void UserExistes(String email) {
        RequestQueue queue = Volley.newRequestQueue(getApplicationContext());
        String url = UserData.SERVER_ADDRESS + "JSONExistsFacebook.php";
        StringRequest postRequest = new StringRequest(Request.Method.POST, url, response -> {
            String resultado = "";
            try {
                
                JSONArray jsonArray = new JSONArray(response);
                resultado = jsonArray.getJSONObject(0).getString("EXITO");
                if (resultado.equals("SI")) {
                    LoginIntoAccount();
                } else if (resultado.equals("NO")) {
                    UserInsert(nombre, apellido, email);
                } else {
                    new AlertDialog.Builder(getActivity())
                            .setMessage("Sin Respuesta")
                            .setPositiveButton("Ok", (dialog, which) -> {
                                VolleySingleton.disconnectFromFacebook();
                                dialog.dismiss();
                            }).show();
                }
                
            } catch (JSONException e) {
                e.printStackTrace();
            }
        }, error -> {
            new AlertDialog.Builder(getActivity()).setMessage("Error en el servidor intente mas tarde!")
                    .setPositiveButton("Ok", (dialog, which) ->{
    
                        VolleySingleton.disconnectFromFacebook();
                        dialog.dismiss();
                            }).show();
            Log.d("Error.Response", error.toString());
        }
        ) {
            @Override
            protected Map<String, String> getParams() {
                Map<String, String> params = new HashMap<String, String>();
                params.put("email", email);
                return params;
            }
        };
        queue.add(postRequest);
    }
    
    private void LoginIntoAccount() {
        RequestQueue queue = Volley.newRequestQueue(getApplicationContext());
        String url = UserData.SERVER_ADDRESS + "JSONLoginInFacebook.php";
        StringRequest postRequest = new StringRequest(Request.Method.POST, url, response -> {
            String resultado = "";
            try {
                
                JSONArray jsonArray = new JSONArray(response);
                if (!response.equals("[]")) {
                    String DataBase_Id = jsonArray.getJSONObject(0).getString("Id");
                    String DataBase_Token = jsonArray.getJSONObject(0).getString("Token");
                    String DataBase_email = jsonArray.getJSONObject(0).getString("CorreoE");
                    String DataBase_IMGURL = jsonArray.getJSONObject(0).getString("ImgUrl");
                    String DataBase_Name = jsonArray.getJSONObject(0).getString("Nombre") + " " + jsonArray.getJSONObject(0).getString("ApellidoP");
                    String DataBase_Rol = jsonArray.getJSONObject(0).getString("fk_id_rol");
                    SETSharedPreferences("FacebookID",id);
                    SETSharedPreferences("ID", DataBase_Id);
                    SETSharedPreferences("TOKEN", DataBase_Token);
                    SETSharedPreferences("IMGUSU", DataBase_IMGURL);
                    SETSharedPreferences("Nombre", DataBase_Name);
                    SETSharedPreferences("Correo", DataBase_email);
                    SETSharedPreferences("Rol", DataBase_Rol);
                    Activity_Main.header_name.setText(GETSharedPreferences("Nombre", ""));
                    Activity_Main.header_email.setText(GETSharedPreferences("Correo", ""));
                    Activity_Main.navigationView.getMenu().getItem(0).setChecked(true);
                    getActivity().invalidateOptionsMenu();
                    Activity_Main.ocultar_campos();
                    new UpdateToken(FirebaseInstanceId.getInstance().getToken()).execute();
                    getActivity().getSupportFragmentManager().beginTransaction().
                            replace(R.id.flContent, fragmentAtencionC).addToBackStack(null).commit();
                    
                } else {
                    new AlertDialog.Builder(getActivity())
                            .setMessage("No se ha podido recuperar la informacion")
                            .setPositiveButton("Ok", new DialogInterface.OnClickListener() {
                                @Override
                                public void onClick(DialogInterface dialog, int which) {
                                    VolleySingleton.disconnectFromFacebook();
                                    dialog.dismiss();
                                }
                            }).show();
                }
                
            } catch (JSONException e) {
                e.printStackTrace();
            }
        }, error -> {
            new AlertDialog.Builder(getActivity()).setMessage("Error en el servidor intente mas tarde!")
                    .setPositiveButton("Ok", (dialog, which) -> {
    
                        VolleySingleton.disconnectFromFacebook();
                        dialog.dismiss();
                    }).show();
            Log.d("Error.Response", error.toString());
        }
        ) {
            @Override
            protected Map<String, String> getParams() {
                Map<String, String> params = new HashMap<String, String>();
                params.put("email", email);
                return params;
            }
        };
        queue.add(postRequest);
    }
    
    
    private void UserInsert(String nombre, String apellido, String Correo) {
        RequestQueue queue = Volley.newRequestQueue(getApplicationContext());
        String url = UserData.SERVER_ADDRESS + "JSONInsertUserFacebook.php";
        StringRequest postRequest = new StringRequest(Request.Method.POST, url,
                new Response.Listener<String>() {
                    @Override
                    public void onResponse(String response) {
                        String resultado = "";
                        try {
                            JSONArray jsonArray = new JSONArray(response);
                            resultado = jsonArray.getJSONObject(0).getString("EXITO");
                            
                            if (resultado.equals("SI")) {
                                new AlertDialog.Builder(getActivity())
                                        .setMessage("Su cuenta fue creada exitosamente").setCancelable(false)
                                        .setPositiveButton("Ok", new DialogInterface.OnClickListener() {
                                            @Override
                                            public void onClick(DialogInterface dialog, int which) {
                                                LoginIntoAccount();
                                            }
                                        }).show();
                            } else if (resultado.equals("NOVALIDO")) {
                                new AlertDialog.Builder(getActivity())
                                        .setMessage("Ya se encuentra registrado").setCancelable(false)
                                        .setPositiveButton("Ok", new DialogInterface.OnClickListener() {
                                            @Override
                                            public void onClick(DialogInterface dialog, int which) {
                                                LoginIntoAccount();
                                            }
                                        })
                                        .setNegativeButton("Cancelar", new DialogInterface.OnClickListener() {
                                            @Override
                                            public void onClick(DialogInterface dialog, int which) {
                                                VolleySingleton.disconnectFromFacebook();
                                                dialog.dismiss();
                                            }
                                        })
                                        .show();
                            } else {
                                new AlertDialog.Builder(getActivity())
                                        .setMessage("Solicutud no ha podido ser realizada").setCancelable(false)
                                        .setPositiveButton("Ok", new DialogInterface.OnClickListener() {
                                            @Override
                                            public void onClick(DialogInterface dialog, int which) {
                                                VolleySingleton.disconnectFromFacebook();
                                                dialog.dismiss();
                                            }
                                        }).show();
                            }
                        } catch (JSONException e) {
                            e.printStackTrace();
                        }
                    }
                },
                new Response.ErrorListener() {
                    @Override
                    public void onErrorResponse(VolleyError error) {
                        new AlertDialog.Builder(getActivity()).setMessage("Error en el servidor intente mas tarde!")
                                .setPositiveButton("Ok", (dialog, which) -> {
    
                                    VolleySingleton.disconnectFromFacebook();
                                    dialog.dismiss();
                                }).show();
                        Log.d("Error.Response", error.toString());
                    }
                }
        ) {
            @Override
            protected Map<String, String> getParams() {
                Map<String, String> params = new HashMap<String, String>();
                params.put("nombre", nombre);
                params.put("ApellidoM", apellido);
                params.put("telefono", "null");
                params.put("direccion", "null");
                params.put("numext", "null");
                params.put("colonia", "null");
                params.put("correo", Correo);
                return params;
            }
        };
        queue.add(postRequest);
    }
    
    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        callbackManager.onActivityResult(requestCode, resultCode, data);
        if (requestCode == 024 && resultCode == RESULT_OK) {
            premission();
        }
        super.onActivityResult(requestCode, resultCode, data);
    }
    
    @SuppressLint("MissingPermission")
    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        if (requestCode == PHONERQUESTPERCODE) {
            if (grantResults[0]== PackageManager.PERMISSION_GRANTED) {
                premission();
            } else {
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
    
    @Override
    public void onStart() {
        super.onStart();
        FirebaseUser currentUser = auth.getCurrentUser();
        if (currentUser == null) {
            Log.e("Auth", "No user");
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
    
    public interface OnFragmentInteractionListener {
        // TODO: Update argument type and name
        void onFragmentInteraction(Uri uri);
    }
    
    private class telephoneval extends AsyncTask<Void, Integer, Integer> {
        
        String telephone;
        private String DataBase_Token, DataBase_UserImageURL, DataBase_Id, DataBase_Name, DataBase_email, DataBase_Rol;
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
            nameValuePairs.add(new BasicNameValuePair("telefono", telephone));
            
            //              TODO: Connection to send "NameValuesPairs" to DataBase
            HttpParams httpParams = HTTPPARAMS.GETHTTPREQUESTPARAMS();
            HttpClient httpClient = new DefaultHttpClient(httpParams);
            HttpPost httpPost = new HttpPost(UserData.SERVER_ADDRESS + "JSONtelephoneval.php");
            
            //              TODO: Response from server
            org.apache.http.HttpResponse httpResponse = null;
            String ResponseCode = "";
            try {
                httpPost.setEntity(new UrlEncodedFormEntity(nameValuePairs));
                httpResponse = httpClient.execute(httpPost);
                HttpEntity httpEntity = httpResponse.getEntity();
                ResponseCode = EntityUtils.toString(httpEntity, "UTF-8");
                
                JSONArray jsonArray = new JSONArray(ResponseCode);
                
                
                if (!ResponseCode.equals("[]")) {
                    DataBase_Id = jsonArray.getJSONObject(0).getString("Id");
                    DataBase_Token = jsonArray.getJSONObject(0).getString("Token");
                    DataBase_email = jsonArray.getJSONObject(0).getString("CorreoE");
                    DataBase_Name = jsonArray.getJSONObject(0).getString("Nombre") + " " + jsonArray.getJSONObject(0).getString("ApellidoP");
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
                    } else {
                        return 3;
                    }
                } else {
                    return 4;
                }
                
            } catch (Exception e) {
                e.printStackTrace();
            }
            return 2;
            
        }
        
        @Override
        protected void onPostExecute(Integer aBoolean) {
            super.onPostExecute(aBoolean);
            if (aBoolean == 1) {
                Activity_Main.header_name.setText(preferences.getString("Nombre", ""));
                Activity_Main.header_email.setText(preferences.getString("Correo", ""));
                Activity_Main.navigationView.getMenu().getItem(0).setChecked(true);
                getActivity().invalidateOptionsMenu();
                Activity_Main.ocultar_campos();
                new UpdateToken(FirebaseInstanceId.getInstance().getToken()).execute();
                getActivity().getSupportFragmentManager().beginTransaction().replace(R.id.flContent, fragmentAtencionC).addToBackStack(null).commit();
            } else if (aBoolean == 2) {
                final android.app.AlertDialog.Builder builder = new android.app.AlertDialog.Builder(getActivity());
                builder.setMessage("error server")
                        .setTitle("Aviso")
                        .setCancelable(false)
                        .setPositiveButton(android.R.string.ok, null)
                        .setNegativeButton("No", null).show();
                builder.create();
            } else if (aBoolean == 3) {
                
                final android.app.AlertDialog.Builder builder = new android.app.AlertDialog.Builder(getActivity());
                builder.setMessage("Es necesario activar su cuenta!")
                        .setTitle("Aviso")
                        .setCancelable(false)
                        .setPositiveButton(android.R.string.ok, new DialogInterface.OnClickListener() {
                            @Override
                            public void onClick(DialogInterface dialogInterface, int i) {
                                Activity_Get_ValidationCode.Telefono = UserData.Telefono;
                                startActivity(new Intent(getActivity(), Activity_Get_ValidationCode.class));
                            }
                        }).show();
                builder.create();
                
                
            } else if (aBoolean == 4) {
                final android.app.AlertDialog.Builder builder = new android.app.AlertDialog.Builder(getActivity());
                builder.setMessage("Su numero no esta vinculado a una cuenta \n ¿Desea crear cuenta ahora?")
                        .setTitle("Aviso")
                        .setCancelable(false)
                        .setPositiveButton(android.R.string.ok, new DialogInterface.OnClickListener() {
                            @Override
                            public void onClick(DialogInterface dialogInterface, int i) {
                                startActivity(new Intent(getActivity(), Activity_Registrar.class));
                            }
                        })
                        .setNegativeButton("No", null).show();
                builder.create();
            }
        }
    }
}
