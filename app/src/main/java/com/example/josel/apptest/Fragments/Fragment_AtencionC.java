package com.example.josel.apptest.Fragments;

import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AbsListView;
import android.widget.AdapterView;
import android.widget.BaseAdapter;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import com.android.volley.toolbox.ImageLoader;
import com.android.volley.toolbox.NetworkImageView;
import com.bumptech.glide.Glide;
import com.example.josel.apptest.Activitys.Activity_Comments;
import com.example.josel.apptest.Activitys.Activity_Main;
import com.example.josel.apptest.Activitys.Activity_NoticiaIndividual;
import com.example.josel.apptest.Methods.HTTPPARAMS;
import com.example.josel.apptest.Methods.VolleySingleton;
import com.example.josel.apptest.Objects.NoticiaCiudadana;
import com.example.josel.apptest.R;
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
import java.util.List;
import java.util.Objects;

import cn.pedant.SweetAlert.SweetAlertDialog;

import static com.example.josel.apptest.Methods.SharedPreference.GETSharedPreferences;
import static com.example.josel.apptest.UserData.Facebook_Picture;


/**
 * A simple {@link Fragment} subclass.
 * Activities that contain this fragment must implement the
 * {@link Fragment_AtencionC.OnFragmentInteractionListener} interface
 * to handle interaction events.
 * Use the {@link Fragment_AtencionC#newInstance} factory method to
 * create an instance of this fragment.
 */
public class Fragment_AtencionC extends Fragment {
    
    
    public static final String TAG = Activity_Main.class.getSimpleName();
    // TODO: Rename parameter arguments, choose names that match
    // the fragment initialization parameters, e.g. ARG_ITEM_NUMBER
    private static final String ARG_PARAM1 = "param1";
    private static final String ARG_PARAM2 = "param2";
    public static ProgressDialog pDialog;
    static public List<NoticiaCiudadana> NoticiaCiudadana_lista;
    public static int posilista;
    public static List<NoticiaCiudadana> items;
    static SweetAlertDialog successDialog;
    public ListView listView;
    public CustomListAdapter adapter;
    public boolean isLoading = false;
    public View ftView;
    public Handler mHandler;
    int number = 0;
    int USUARIO_EXISTENTE = 0;
    int count = 0;
    private OnFragmentInteractionListener mListener;
    // TODO: Rename and change types of parameters
    private String mParam1;
    private String mParam2;
    
    
    public Fragment_AtencionC() {
        // Required empty public constructor
    }
    
    // TODO: Rename and change types and number of parameters
    public static Fragment_AtencionC newInstance(String param1, String param2) {
        Fragment_AtencionC fragment = new Fragment_AtencionC();
    
        Bundle args = new Bundle();
        args.putString(ARG_PARAM1, param1);
        args.putString(ARG_PARAM2, param2);
        fragment.setArguments(args);
        return fragment;
    }
    
    private static void hidePDialog() {
        if (pDialog != null) {
            pDialog.dismiss();
            pDialog = null;
        }
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
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle
            savedInstanceState) {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_atencionc, container, false);
    }
    
    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        
        
        if (!GETSharedPreferences("ID", "").isEmpty()) {
            USUARIO_EXISTENTE = 1;
        }
        NoticiaCiudadana_lista = new ArrayList<NoticiaCiudadana>();
        successDialog = new SweetAlertDialog(getActivity(), SweetAlertDialog.SUCCESS_TYPE);
        ImageLoader imageLoader = VolleySingleton.getInstance().getImageLoader();
        if (imageLoader == null) imageLoader = VolleySingleton.getInstance().getImageLoader();
        if (!GETSharedPreferences("FacebookID","").isEmpty()){
            Glide.with(getActivity()).load(Facebook_Picture.replace("{facebookId}",GETSharedPreferences("FacebookID",""))).into(Activity_Main.Userimage);
        }else{
            Glide.with(getActivity()).load(UserData.SERVER_ADDRESS + GETSharedPreferences("IMGUSU", "")).into(Activity_Main.Userimage);
        }
        
        listView = (ListView) getView().findViewById(R.id.lista_atencionc);
        adapter = new CustomListAdapter(getActivity(), NoticiaCiudadana_lista);
        listView.setAdapter(adapter);
        
        
        pDialog = new ProgressDialog(getActivity());
        // Showing progress dialog before making http request
        pDialog.setCancelable(false);
        pDialog.setMessage("Loading...");
        pDialog.show();
        LayoutInflater li = (LayoutInflater) getActivity().getSystemService(Context
                .LAYOUT_INFLATER_SERVICE);
        ftView = li.inflate(R.layout.footer_view, null);
        
        
        new jalar_noticias(view.getRootView(), String.valueOf(number), UserData.SERVER_ADDRESS +
                "JSONSelectNoticiasCiudadanos.php", NoticiaCiudadana_lista).execute();



       /* FloatingActionButton fab = getView().findViewById(R.id.fab);

        if (preferences.getString("ID","").isEmpty()){
            fab.setVisibility(View.VISIBLE);
            fab.setClickable(true);
            fab.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    Fragment_Login fragmentLogin = new Fragment_Login();
                    getActivity().getSupportFragmentManager().beginTransaction().replace(R.id
                    .flContent,fragmentLogin).addToBackStack(null).commit();
                }
            });
        }else{
            fab.setVisibility(View.INVISIBLE);
            fab.setClickable(false);

        }
*/
        
        
        //        listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
        //            @Override
        //            public void onItemClick(AdapterView<?> parent, View view, int position,
        // long id) {
        //
        //                posilista=position;
        //                Activity_NoticiaIndividual.opcion=1;
        //                startActivity(new Intent(getView().getContext(),
        // Activity_NoticiaIndividual.class));
        ////                Snackbar.make(getView(),"position: "+position,Snackbar.LENGTH_LONG)
        /// .show();
        //            }
        //        });
        
        listView.setOnItemLongClickListener(new AdapterView.OnItemLongClickListener() {
    
            @Override
            public boolean onItemLongClick(AdapterView<?> arg0, View arg1, final int pos, long id) {
                // TODO Auto-generated method stub
                final SweetAlertDialog sweetAlertDialog = new SweetAlertDialog(getActivity(),
                        SweetAlertDialog.WARNING_TYPE);
                sweetAlertDialog.setContentText("¿Desea borrar esta publicacion?");
                sweetAlertDialog.show();
                sweetAlertDialog.showCancelButton(true);
                Button cancel = sweetAlertDialog.findViewById(cn.pedant.SweetAlert.R.id
                        .cancel_button);
                if (cancel != null) {
                    Log.e("Messeage from pdialog", "showErrorMsg: Button view Found yep");
                    cancel.setBackgroundColor(getResources().getColor(R.color.colorPrimaryDark));
                    cancel.setTextColor(getResources().getColor(R.color.TextInPrimary));
                    cancel.setText("No, Gracias");
                }
                cancel.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        sweetAlertDialog.dismiss();
                    }
                });
                Button accept = sweetAlertDialog.findViewById(cn.pedant.SweetAlert.R.id
                        .confirm_button);
                if (accept != null) {
                    Log.e("Messeage from pdialog", "showErrorMsg: Button view Found yep");
                    accept.setBackgroundColor(getResources().getColor(R.color.colorPrimaryLight));
                    accept.setTextColor(getResources().getColor(R.color.TextInPrimaryLight));
                    accept.setText("Si, Hazlo");
                }
                accept.setOnClickListener(view -> {
                        sweetAlertDialog.dismiss();
                        new borrarNoticia(Integer.valueOf(NoticiaCiudadana_lista.get(pos).getId()), pos).execute();
                });
                //                Toast.makeText(getContext(), "long clicked, "+"pos: " + pos,
                // Toast.LENGTH_LONG).show();
                return true;
            }
        });
        listView.setOnScrollListener(new AbsListView.OnScrollListener() {
            @Override
            public void onScrollStateChanged(AbsListView absListView, int i) {
            }
    
            @Override
            public void onScroll(AbsListView View, int firstvisibleitem, int visibleitemcount,
                                 int totalitemcount) {
                if (View.getLastVisiblePosition() == totalitemcount - 1 && isLoading == false) {
                    mHandler = new MyHandler();
                    isLoading = true;
                    /*still need to edit this here*/
                    Thread thread = new ThreadGetMoreData();
                    thread.start();
                }
            }
        });
        
        
        super.onViewCreated(view, savedInstanceState);
    }
    
    private ArrayList<NoticiaCiudadana> getMoreData() {
        number = number + 5;
        ArrayList<NoticiaCiudadana> lst = new ArrayList<>();
        
        new jalar_noticias(getActivity().getCurrentFocus(), String.valueOf(number), UserData
                .SERVER_ADDRESS + "JSONSelectNoticiasCiudadanos.php", lst).execute();
        
        return lst;
    }
    
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
            throw new RuntimeException(context.toString() + " must implement " +
                    "OnFragmentInteractionListener");
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
    
    public static class jalar_noticias extends AsyncTask<Void, Boolean, Boolean> {
        
        String id, titulo, descripcion, fecha, ubicacion, noticiaimagen, nombre, apellidosm, imgurl;
        
        
        View rootview;
        String numero;
        String url;
        
        List<NoticiaCiudadana> NoticiaCiudadana_lista;
        
        public jalar_noticias(View rootview, String numero, String url, List<NoticiaCiudadana>
                noticiaCiudadana) {
            this.rootview = rootview;
            this.numero = numero;
            this.url = url;
            NoticiaCiudadana_lista = noticiaCiudadana;
        }
        
        @Override
        protected Boolean doInBackground(Void... voids) {
            if (!GETSharedPreferences("ID", "").isEmpty()) {
                ArrayList<NameValuePair> datatosend = new ArrayList<>();
                datatosend.add(new BasicNameValuePair("number", numero));
                datatosend.add(new BasicNameValuePair("id_usuario", GETSharedPreferences("ID",
                        "")));
                HttpParams httpRequestParams = HTTPPARAMS.GETHTTPREQUESTPARAMS();
                HttpClient client = new DefaultHttpClient(httpRequestParams);
                HttpPost post = new HttpPost(UserData.SERVER_ADDRESS +
                        "JSONSelectNoticiasCiudadanoscopia.php");
                // ++ RESPONSE FROM SERVER ++
                HttpResponse httpResponse = null;
                String responsedecoded = "";
                
                try {
                    post.setEntity(new UrlEncodedFormEntity(datatosend));
                    httpResponse = client.execute(post);
                    HttpEntity httpEntity = httpResponse.getEntity();
                    responsedecoded = EntityUtils.toString(httpEntity, "UTF-8");
                    JSONArray jsonArray = new JSONArray(responsedecoded);
                    if (jsonArray.length() <= 0) {
                        return true;
                    }
                    for (int i = 0; i < jsonArray.length(); i++) {
                        NoticiaCiudadana NoticiaCiudadana = new NoticiaCiudadana();
                        NoticiaCiudadana.setId(jsonArray.getJSONObject(i).getString("id_alerta"));
                        NoticiaCiudadana.setTitulo(jsonArray.getJSONObject(i).getString("titulo"));
                        NoticiaCiudadana.setDescripcion(jsonArray.getJSONObject(i).getString("descripcion"));
                        NoticiaCiudadana.setFecha(jsonArray.getJSONObject(i).getString("fecha"));
                        NoticiaCiudadana.setUbicacion(jsonArray.getJSONObject(i).getString("ubicacion"));
                        NoticiaCiudadana.setNoticiaimagen(jsonArray.getJSONObject(i).getString("alertaimg"));
                        NoticiaCiudadana.setNombreusuario(jsonArray.getJSONObject(i).getString("Nombre") + " " + jsonArray.getJSONObject(0).getString("ApellidoP"));
                        NoticiaCiudadana.setUserimagen(jsonArray.getJSONObject(i).getString("ImgURL"));
                        NoticiaCiudadana.setLongitud(jsonArray.getJSONObject(i).getString("longitud"));
                        NoticiaCiudadana.setLatitud(jsonArray.getJSONObject(i).getString("latitud"));
                        NoticiaCiudadana.setLike(jsonArray.getJSONObject(i).getString("like"));
                        NoticiaCiudadana.setComment(jsonArray.getJSONObject(i).getString("comment"));
                        NoticiaCiudadana.setId_usuario(jsonArray.getJSONObject(i).getString("id"));
                        NoticiaCiudadana_lista.add(NoticiaCiudadana);
                    }
                    httpEntity.consumeContent();
                    return true;
                } catch (Exception e) {
                    e.printStackTrace();
                }
                return false;
            } else {
                ArrayList<NameValuePair> datatosend = new ArrayList<>();
                datatosend.add(new BasicNameValuePair("number", numero));
                HttpParams httpRequestParams = HTTPPARAMS.GETHTTPREQUESTPARAMS();
                HttpClient client = new DefaultHttpClient(httpRequestParams);
                HttpPost post = new HttpPost(UserData.SERVER_ADDRESS +
                        "JSONSelectNoticiasCiudadanos.php");
                // ++ RESPONSE FROM SERVER ++
                HttpResponse httpResponse = null;
                String responsedecoded = "";
                
                try {
                    post.setEntity(new UrlEncodedFormEntity(datatosend));
                    httpResponse = client.execute(post);
                    HttpEntity httpEntity = httpResponse.getEntity();
                    responsedecoded = EntityUtils.toString(httpEntity, "UTF-8");
                    JSONArray jsonArray = new JSONArray(responsedecoded);
                    if (jsonArray.length() <= 0) {
                        return true;
                    }
                    for (int i = 0; i < jsonArray.length(); i++) {
                        NoticiaCiudadana NoticiaCiudadana = new NoticiaCiudadana();
                        NoticiaCiudadana.setId(jsonArray.getJSONObject(i).getString("id_alerta"));
                        NoticiaCiudadana.setTitulo(jsonArray.getJSONObject(i).getString("titulo"));
                        NoticiaCiudadana.setDescripcion(jsonArray.getJSONObject(i).getString
                                ("descripcion"));
                        NoticiaCiudadana.setFecha(jsonArray.getJSONObject(i).getString("fecha"));
                        NoticiaCiudadana.setUbicacion(jsonArray.getJSONObject(i).getString
                                ("ubicacion"));
                        NoticiaCiudadana.setNoticiaimagen(jsonArray.getJSONObject(i).getString
                                ("alertaimg"));
                        NoticiaCiudadana.setNombreusuario(jsonArray.getJSONObject(i).getString
                                ("Nombre") + " " + jsonArray.getJSONObject(0).getString
                                ("ApellidoP"));
                        NoticiaCiudadana.setUserimagen(jsonArray.getJSONObject(i).getString
                                ("ImgURL"));
                        NoticiaCiudadana.setLongitud(jsonArray.getJSONObject(i).getString
                                ("longitud"));
                        NoticiaCiudadana.setLatitud(jsonArray.getJSONObject(i).getString
                                ("latitud"));
                        NoticiaCiudadana.setLike("0");
                        NoticiaCiudadana.setComment("0");
                        NoticiaCiudadana.setId_usuario("0");
                        NoticiaCiudadana_lista.add(NoticiaCiudadana);
                    }
                    httpEntity.consumeContent();
                    return true;
                } catch (Exception e) {
                    e.printStackTrace();
                }
                return false;
            }
        }
        
        @Override
        protected void onPostExecute(final Boolean result) {
            if (result) {
                hidePDialog();
            } else {
                hidePDialog();
                /*TODO: Poner dialogo de que no se pudo obtener informacion*/
            }
        }
    }
    
    public static class Like_Management extends AsyncTask<Void, Integer, Integer> {
        View v;
        int iduser, idnews, opcion;
        int reaccion = 1;
        NoticiaCiudadana noticia;
        CustomListAdapter adapter;
        
        public Like_Management(View v, int iduser, int idnews, int opcion, NoticiaCiudadana
                noticia, CustomListAdapter adapter) {
            this.v = v;
            this.iduser = iduser;
            this.idnews = idnews;
            this.opcion = opcion;
            this.noticia = noticia;
            this.adapter = adapter;
        }
        
        @Override
        protected void onPreExecute() {
            super.onPreExecute();
        }
        
        @Override
        protected Integer doInBackground(Void... voids) {
            ArrayList<NameValuePair> datatosend = new ArrayList<>();
            datatosend.add(new BasicNameValuePair("id_usuario", String.valueOf(iduser)));
            datatosend.add(new BasicNameValuePair("id_noticia", String.valueOf(idnews)));
            datatosend.add(new BasicNameValuePair("id_reaccion", String.valueOf(reaccion)));
            datatosend.add(new BasicNameValuePair("opcion", String.valueOf(opcion))); //TODO: "0"
            // es para crear "1" borrar
            HttpParams httpRequestParams = HTTPPARAMS.GETHTTPREQUESTPARAMS();
            HttpClient client = new DefaultHttpClient(httpRequestParams);
            HttpPost post = new HttpPost(UserData.SERVER_ADDRESS + "likemanage.php");
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
                if (respuesta.equals("SI CREEO")) {
                    return 2;
                } else if (respuesta.equals("NO CREEO")) {
                    return 3;
                } else if (respuesta.equals("SI BORRO")) {
                    return 4;
                } else if (respuesta.equals("NO BORRO")) {
                    return 5;
                }
            } catch (Exception e) {
                e.printStackTrace();
                return 0;
            }
            return 1;
        }
        
        @Override
        protected void onPostExecute(Integer aInteger) {
            switch (aInteger) {
                case 0:
                    Toast.makeText(v.getContext(), "ERROR: 101 Actualize la ventana", Toast
                            .LENGTH_SHORT).show();
                    break;
                case 1:
                    Toast.makeText(v.getContext(), "Operación Fallida OF001", Toast.LENGTH_SHORT)
                            .show();
                    break;
                case 2:
                    noticia.setLike("1");
                    adapter.notifyDataSetChanged();
                    break;
                case 3:
                    Toast.makeText(v.getContext(), "Operación Fallida OF002", Toast.LENGTH_SHORT)
                            .show();
                    break;
                case 4:
                    noticia.setLike("0");
                    adapter.notifyDataSetChanged();
                    break;
                case 5:
                    Toast.makeText(v.getContext(), "Operación Fallida OF003", Toast.LENGTH_SHORT)
                            .show();
                    break;
            }
        }
    }
    
    public class borrarNoticia extends AsyncTask<Void, Boolean, Boolean> {
        int id;
        int position;
        
        public borrarNoticia(int id, int position) {
            this.id = id;
            this.position = position;
        }
        
        @Override
        protected Boolean doInBackground(Void... voids) {
            // ++ ARRAY DE PARAMETROS QUE VAS A MANDAR AL WEB SERVICE ++
            ArrayList<NameValuePair> datatosend = new ArrayList<>();
            datatosend.add(new BasicNameValuePair("id", String.valueOf(id)));
            
            // ++ CONECCION PARA MANDAR LOS PARAMETROS ++
            HttpParams httpRequestParams = HTTPPARAMS.GETHTTPREQUESTPARAMS();
            HttpClient client = new DefaultHttpClient(httpRequestParams);
            HttpPost post = new HttpPost(UserData.SERVER_ADDRESS + "JSONBorrarPublicacion.php");
            
            // ++ RESPONSE FROM SERVER ++
            HttpResponse httpResponse = null;
            String responsedecoded = "";
            
            try {
                post.setEntity(new UrlEncodedFormEntity(datatosend));
                httpResponse = client.execute(post);
                HttpEntity httpEntity = httpResponse.getEntity();
                responsedecoded = EntityUtils.toString(httpEntity, "UTF-8");
                JSONArray jsonArray = new JSONArray(responsedecoded);
                String answer = jsonArray.getJSONObject(0).getString("EXITO");
                httpEntity.consumeContent();
                if (answer.equals("SI")) {
                    return true;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            return false;
        }
        
        @Override
        protected void onPostExecute(Boolean aBoolean) {
            if (aBoolean) {
                successDialog.setContentText("¡Se ha borrado la Noticia!");
                successDialog.setCancelable(false);
                successDialog.show();
                
                Button cerrar = (Button) successDialog.findViewById(cn.pedant.SweetAlert.R.id
                        .confirm_button);
                if (cerrar != null) {
                    Log.e("Messeage from pdialog", "showErrorMsg: Button view Found yep");
                    cerrar.setBackgroundColor(getResources().getColor(R.color.colorPrimaryDark));
                    cerrar.setTextColor(getResources().getColor(R.color.TextInPrimary));
                    cerrar.setText(" Esta Bien ");
                }
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
                    Objects.requireNonNull(cerrar).setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View view) {
                            successDialog.dismiss();
                            NoticiaCiudadana_lista.remove(position);
                            adapter.notifyDataSetChanged();
                        }
                    });
                }
            } else {
            
            }
        }
    }
    
    public class MyHandler extends Handler {
        @Override
        public void handleMessage(Message msg) {
            switch (msg.what) {
                case 0:
                    //Add loading view during search processing
                    listView.addFooterView(ftView);
                    break;
                case 1:
                    //Update data adapter and UI
                    adapter.addListItemToAdapter((ArrayList<NoticiaCiudadana>) msg.obj);
                    //Remove loading view after update listview
                    listView.removeFooterView(ftView);
                    isLoading = false;
                    break;
                default:
                    break;
            }
        }
    }
    
    public class ThreadGetMoreData extends Thread {
        @Override
        public void run() {
            //Add footer view after get data
            mHandler.sendEmptyMessage(0);
            //Search more data
            ArrayList<NoticiaCiudadana> lstResult = getMoreData();
            //Delay time to show loading footer when debug, remove it when release
            try {
                Thread.sleep(5000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            //Send the result to Handle
            Message msg = mHandler.obtainMessage(1, lstResult);
            mHandler.sendMessage(msg);
    
        }
    }
    
    public class CustomListAdapter extends BaseAdapter {
        ImageLoader imageLoader = VolleySingleton.getInstance().getImageLoader();
        private Activity activity;
        private List<NoticiaCiudadana> NoticiaCiudadana;
        private LayoutInflater inflater;
        
        public CustomListAdapter(Activity activity, List<NoticiaCiudadana> NoticiaCiudadana) {
            this.activity = activity;
            this.NoticiaCiudadana = NoticiaCiudadana;
        }
        
        public void addListItemToAdapter(List<NoticiaCiudadana> list) {
            //Add list to current array list of data
            NoticiaCiudadana.addAll(list);
            //Notify UI
            this.notifyDataSetChanged();
        }
        
        @Override
        public int getCount() {
            return NoticiaCiudadana.size();
        }
        
        @Override
        public Object getItem(int location) {
            return NoticiaCiudadana.get(location);
        }
        
        @Override
        public long getItemId(int position) {
            return position;
        }
        
        @Override
        public View getView(final int position, View convertView, final ViewGroup parent) {
            
            if (inflater == null)
                inflater = (LayoutInflater) activity.getSystemService(Context
                        .LAYOUT_INFLATER_SERVICE);
            
            if (convertView == null)
                convertView = inflater.inflate(R.layout.customnoticias, null);
            
            if (imageLoader == null)
                imageLoader = VolleySingleton.getInstance().getImageLoader();
            
            
            NetworkImageView Imageuser = (NetworkImageView) convertView.findViewById(R.id
                    .noticiaescudo);
            NetworkImageView noticiaimg = (NetworkImageView) convertView.findViewById(R.id
                    .noticiaimg);
            TextView noticiatit = (TextView) convertView.findViewById(R.id.noticiatit);
            TextView noticiaubica = (TextView) convertView.findViewById(R.id.noticiaubicacion);
            TextView noticiades = (TextView) convertView.findViewById(R.id.noticiades);
            TextView noticiafecha = (TextView) convertView.findViewById(R.id.noticiafecha);
            TextView noticiausu = (TextView) convertView.findViewById(R.id.noticiausuario);
            ImageView image_user = convertView.findViewById(R.id.image_user);
            View clickAlert = (View) convertView.findViewById(R.id.clickAlert);
            final ImageView MeGusta = (ImageView) convertView.findViewById(R.id.MeGusta);
            TextView txt_megusta = (TextView) convertView.findViewById(R.id.txt_megusta);
            ImageView Comentar = (ImageView) convertView.findViewById(R.id.Comentar);
            TextView txt_comentar = (TextView) convertView.findViewById(R.id.txt_comentar);
            
            final NoticiaCiudadana m = NoticiaCiudadana.get(position);
            
            Imageuser.setImageUrl(UserData.SERVER_ADDRESS + m.getUserimagen(), imageLoader);
            noticiaimg.setImageUrl(UserData.SERVER_ADDRESS + m.getNoticiaimagen(), imageLoader);
            image_user.setImageResource(R.drawable.ic_menu_empty);
            noticiatit.setText(m.getTitulo());
            noticiaubica.setText(m.getUbicacion());
            noticiades.setText(m.getDescripcion());
            noticiafecha.setText(m.getFecha());
            noticiausu.setText(m.getNombreusuario());
            if (m.getLike().equals("1")) {
                MeGusta.setImageResource(R.drawable.ic_menu_like_blue);
                txt_megusta.setTextColor(getResources().getColor(R.color.colorAccent));
            } else {
                MeGusta.setImageResource(R.drawable.ic_menu_like_gray);
                txt_megusta.setTextColor(getResources().getColor(R.color.grey));
            }
            
            if (m.getComment().equals("1")) {
                Comentar.setImageResource(R.drawable.ic_menu_comment_gray);
                txt_comentar.setTextColor(getResources().getColor(R.color.grey));
                /*Comentar.setImageResource(R.drawable.ic_menu_comment_blue);
                txt_comentar.setTextColor(getResources().getColor(R.color.colorAccent));*/
            } else {
                Comentar.setImageResource(R.drawable.ic_menu_comment_gray);
                txt_comentar.setTextColor(getResources().getColor(R.color.grey));
            }
            
            MeGusta.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    if (GETSharedPreferences("ID", "").isEmpty()) {
                        Toast.makeText(getActivity(), "Necesita Iniciar sesión", Toast
                                .LENGTH_SHORT).show();
                    } else {
                        if (m.getLike().equals("1")) {
                            //                          TODO: AQUI SE BORRA
                            new Like_Management(Fragment_AtencionC.this.getView(), Integer
                                    .valueOf(GETSharedPreferences("ID", "")), Integer.valueOf(m
                                    .getId()), Integer.valueOf(m.getLike()), m, adapter).execute();
                            /*m.setLike("0");*/
                        } else {
                            //                          TODO: AQUI SE CREEA
                            new Like_Management(Fragment_AtencionC.this.getView(), Integer
                                    .valueOf(GETSharedPreferences("ID", "")), Integer.valueOf(m
                                    .getId()), Integer.valueOf(m.getLike()), m, adapter).execute();
                            /*m.setLike("1");*/
                        }
        
                    }
                }
            });
            Comentar.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    if (GETSharedPreferences("ID", "").isEmpty()) {
                        Toast.makeText(getActivity(), "Necesita Iniciar sesión", Toast
                                .LENGTH_SHORT).show();
                    } else {
                        Activity_Comments.commentposition = Integer.valueOf(m.getId());
                        startActivity(new Intent(getContext(), Activity_Comments.class));
                    }
                }
            });
            clickAlert.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    posilista = position;
                    Activity_NoticiaIndividual.opcion = 1;
                    startActivity(new Intent(Fragment_AtencionC.this.getView().getContext(),
                            Activity_NoticiaIndividual.class));
                    //                    Snackbar.make(Fragment_AtencionC.this.getView(),
                    // "position: "+position,Snackbar.LENGTH_LONG).show();
                }
            });
            if (m.getId_usuario().equals(GETSharedPreferences("ID", ""))) {
                image_user.setImageResource(R.drawable.ic_menu_accountsignup);
                clickAlert.setOnLongClickListener(new View.OnLongClickListener() {
                    @Override
                    public boolean onLongClick(View view) {
                        // TODO Auto-generated method stub
                        final SweetAlertDialog sweetAlertDialog = new SweetAlertDialog
                                (getActivity(), SweetAlertDialog.WARNING_TYPE);
                        sweetAlertDialog.setContentText("¿Desea borrar esta publicacion?");
                        sweetAlertDialog.show();
                        sweetAlertDialog.showCancelButton(true);
                        Button cancel = (Button) sweetAlertDialog.findViewById(cn.pedant
                                .SweetAlert.R.id.cancel_button);
                        if (cancel != null) {
                            Log.e("Messeage from pdialog", "showErrorMsg: Button view Found yep");
                            cancel.setBackgroundColor(getResources().getColor(R.color
                                    .colorPrimaryDark));
                            cancel.setTextColor(getResources().getColor(R.color.TextInPrimary));
                            cancel.setText("No, Gracias");
                        }
                        cancel.setOnClickListener(new View.OnClickListener() {
                            @Override
                            public void onClick(View view) {
                                sweetAlertDialog.dismiss();
                            }
                        });
                        Button accept = (Button) sweetAlertDialog.findViewById(cn.pedant
                                .SweetAlert.R.id.confirm_button);
                        if (accept != null) {
                            Log.e("Messeage from pdialog", "showErrorMsg: Button view Found yep");
                            accept.setBackgroundColor(getResources().getColor(R.color
                                    .colorPrimaryLight));
                            accept.setTextColor(getResources().getColor(R.color
                                    .TextInPrimaryLight));
                            accept.setText("Si, Hazlo");
                        }
                        accept.setOnClickListener(new View.OnClickListener() {
                            @Override
                            public void onClick(View view) {
                                sweetAlertDialog.dismiss();
                                new borrarNoticia(Integer.valueOf(m.getId()), position).execute();
                                
                            }
                        });
                        //                Toast.makeText(getContext(), "long clicked, "+"pos: " +
                        // pos, Toast.LENGTH_LONG).show();
                        return true;
                    }
                });
            }
            
            return convertView;
            
        }
        
    }
}
