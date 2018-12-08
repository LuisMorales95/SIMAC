package com.Mezda.SIMAC.mvp_view.Fragments;

import android.app.Activity;
import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AbsListView;
import android.widget.AdapterView;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;

import com.android.volley.toolbox.ImageLoader;
import com.Mezda.SIMAC.mvp_view.Activitys.Activity_Main;
import com.Mezda.SIMAC.Methods.HTTPPARAMS;
import com.Mezda.SIMAC.Methods.VolleySingleton;
import com.Mezda.SIMAC.Methods.HTMLSimplifier;
import com.Mezda.SIMAC.mvp_view.Activitys.Activity_NoticiaMunicipal;
import com.Mezda.SIMAC.Objects.NoticiaCiudadana;
import com.Mezda.SIMAC.R;
import com.bumptech.glide.Glide;


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

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import static com.Mezda.SIMAC.UserData.SERVER_ADDRESS;


/**
 * A simple {@link Fragment} subclass.
 * Activities that contain this fragment must implement the
 * {@link Fragment_Noticias.OnFragmentInteractionListener} interface
 * to handle interaction events.
 * Use the {@link Fragment_Noticias#newInstance} factory method to
 * create an instance of this fragment.
 */
public class Fragment_Noticias extends Fragment {

    private static final String TAG = Activity_Main.class.getSimpleName();
    private static final String url = SERVER_ADDRESS+"JSONSelectNoticia.php";
    private static ProgressDialog pDialog;
    public List<NoticiaCiudadana> NoticiaCiudadana_lista = new ArrayList<NoticiaCiudadana>();
    ListView listnoticias;
    private CustomListAdapter adapter;

    private static final String ARG_PARAM1 = "param1";
    private static final String ARG_PARAM2 = "param2";
    String formatteddate;
    public static int posilista;
    public static int page1=2;


    public boolean isLoading = false;
    public View ftView;
    public Handler mHandler;

    public static List<NoticiaCiudadana> items;

    int numero =0;

    private String mParam1;
    private String mParam2;

    private OnFragmentInteractionListener mListener;

    public Fragment_Noticias() {
        // Required empty public constructor
    }
    public static Fragment_Noticias newInstance(String param1, String param2) {
        Fragment_Noticias fragment = new Fragment_Noticias();
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
        ((Activity_Main) getActivity()).setActionBarTitle("Noticias Municipales");
        ((Activity_Main) getActivity()).selectItem(R.id.noticias);
        return inflater.inflate(R.layout.fragment_noticias, container, false);
    }
    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {

        listnoticias = (ListView) getView().findViewById(R.id.listnoticias);


        adapter = new CustomListAdapter(getActivity(),NoticiaCiudadana_lista);
        listnoticias.setAdapter(adapter);


        pDialog = new ProgressDialog(getActivity());
        // Showing progress dialog before making http request
        pDialog.setMessage("Cargando Noticias...");
        pDialog.setCancelable(false);
        pDialog.show();

        LayoutInflater li = (LayoutInflater)getActivity().getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        ftView = li.inflate(R.layout.footer_view, null);

        /*
        new jalar_noticias(view.getRootView(), String.valueOf(numero),url,NoticiaCiudadana_lista).execute();
        */
        new jalar_noticias2(view.getRootView(), String.valueOf(numero),url,NoticiaCiudadana_lista).execute();

        listnoticias.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                startActivity(new Intent(getActivity(),Activity_NoticiaMunicipal.class));
                Activity_NoticiaMunicipal.noticiaCiudadana=NoticiaCiudadana_lista.get(position);
            }
        });

        listnoticias.setOnScrollListener(new AbsListView.OnScrollListener() {
            @Override
            public void onScrollStateChanged(AbsListView absListView, int i) {

            }

            @Override
            public void onScroll(AbsListView View, int firstvisibleitem, int visibleitemcount, int totalitemcount) {
                if (View.getLastVisiblePosition()== totalitemcount-1 && isLoading == false){
                    mHandler = new MyHandler();
                    isLoading = true;
                    /*still need to edit this here*/
                    Thread thread = new ThreadGetMoreData();
                    thread.start();
                }
            }
        });


        Date c = Calendar.getInstance().getTime();
        SimpleDateFormat dateformat = new SimpleDateFormat("dd-mm-yyyy");
        formatteddate = dateformat.format(c);
        super.onViewCreated(view, savedInstanceState);
    }

    
    public static class jalar_noticias2 extends AsyncTask<Void,Boolean,Boolean> {

        String id;
        View rootview;
        String numero;
        String url;
        List<NoticiaCiudadana> NoticiaCiudadana_lista;

        public jalar_noticias2(View rootview, String numero, String url, List<NoticiaCiudadana> noticiaCiudadana) {
            this.rootview = rootview;
            this.numero = numero;
            this.url = url;
            NoticiaCiudadana_lista = noticiaCiudadana;
        }

        @Override
        protected Boolean doInBackground(Void... voids) {
            // ++ ARRAY DE PARAMETROS QUE VAS A MANDAR AL WEB SERVICE ++
            ArrayList<NameValuePair> datatosend = new ArrayList<>();

            // ++ CONECCION PARA MANDAR LOS PARAMETROS ++
            HttpParams httpRequestParams = HTTPPARAMS.GETHTTPREQUESTPARAMS();
            HttpClient client = new DefaultHttpClient(httpRequestParams);
            HttpPost post = new HttpPost(SERVER_ADDRESS+"wpnoticias.php");

            // ++ RESPONSE FROM SERVER ++
            HttpResponse httpResponse = null;
            String responsedecoded = "";

            try {
                post.setEntity(new UrlEncodedFormEntity(datatosend));
                httpResponse = client.execute(post);
                HttpEntity httpEntity = httpResponse.getEntity();
                responsedecoded = EntityUtils.toString(httpEntity,"UTF-8");
                JSONArray jsonArray = new JSONArray(responsedecoded);
                for (int i = 0; i<jsonArray.length();i++){
                    NoticiaCiudadana NoticiaCiudadana = new NoticiaCiudadana();
                    NoticiaCiudadana.setTitulo(jsonArray.getJSONObject(i).getString("Titulo"));
                    NoticiaCiudadana.setDescripcion(jsonArray.getJSONObject(i).getString("Contenido"));
                    NoticiaCiudadana.setFecha(jsonArray.getJSONObject(i).getString("FechaPub"));
                    if (jsonArray.getJSONObject(i).getString("Foto").equals("")){
                        NoticiaCiudadana.setNoticiaimagen("http://www.conexiatravel.com.ar/images/default.jpg");
                    }else{
                        NoticiaCiudadana.setNoticiaimagen(jsonArray.getJSONObject(i).getString("Foto"));
                    }
                    NoticiaCiudadana_lista.add(NoticiaCiudadana);
                }
                httpEntity.consumeContent();
                if (jsonArray.length()>=0){
                    return true;
                }else{
                    return false;
                }

            }catch (Exception e){
                e.printStackTrace();
            }
            return false;
        }
        @Override
        protected void onPostExecute(final Boolean result) {
            if (result){
                hidePDialog();
            }else{
                hidePDialog();
                final AlertDialog.Builder builder = new AlertDialog.Builder(rootview.getContext());
                builder.setMessage("Solicitud Fallida Intente Mas Tarde")
                        .setTitle("Estado")
                        .setCancelable(false)
                        .setPositiveButton(android.R.string.ok, null);
                AlertDialog dialog = builder.create();
                dialog.show();
            }
        }
    }













    public class MyHandler extends Handler {
        @Override
        public void handleMessage(Message msg) {
            switch (msg.what) {
                case 0:
                    //Add loading view during search processing
                   // listnoticias.addFooterView(ftView);
                    break;
                case 1:
                    //Update data adapter and UI
                      adapter.addListItemToAdapter((ArrayList<NoticiaCiudadana>)msg.obj);
                    //Remove loading view after update listview
                    //listnoticias.removeFooterView(ftView);
                    isLoading=false;
                    break;
                default:
                    break;
            }
        }
    }
    private ArrayList<NoticiaCiudadana> getMoreData() {
        ArrayList<NoticiaCiudadana>lst = new ArrayList<>();
        return lst;
    }
    public class ThreadGetMoreData extends Thread {
        @Override
        public void run() {
            //Add footer view after get data
            mHandler.sendEmptyMessage(0);
            //Search more data
            ArrayList<NoticiaCiudadana> lstResult = getMoreData();
            //Delay time to show loading footer when debug, remove it when release
            /*try {
                Thread.sleep(3000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }*/
            //Send the result to Handle
            Message msg = mHandler.obtainMessage(1, lstResult);
            mHandler.sendMessage(msg);

        }
    }




















    private static void hidePDialog() {
        if (pDialog != null) {
            pDialog.dismiss();
            pDialog = null;
        }
    }





    public class CustomListAdapter extends BaseAdapter {
        private Activity activity;
        private LayoutInflater inflater;
        private List<NoticiaCiudadana> NoticiaCiudadana;
        ImageLoader imageLoader = VolleySingleton.getInstance().getImageLoader();

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
        public View getView(int position, View convertView, ViewGroup parent) {

            if (inflater == null)
                inflater = (LayoutInflater) activity
                        .getSystemService(Context.LAYOUT_INFLATER_SERVICE);
            if (convertView == null)
                convertView = inflater.inflate(R.layout.customnoticiasmunicipales, null);
    
            ImageView municipio_imagen = (ImageView) convertView.findViewById(R.id.municipio_imagen);
            TextView municipio_titulo = (TextView) convertView.findViewById(R.id.municipio_titulo);
            TextView municipio_descripcion = (TextView) convertView.findViewById(R.id.municipio_descripcion);
            TextView municipio_fecha = (TextView) convertView.findViewById(R.id.municipio_fecha);
    
            NoticiaCiudadana m = NoticiaCiudadana.get(position);
            
            Glide.with(convertView).load(m.getNoticiaimagen()).into(municipio_imagen);

            municipio_titulo.setText(m.getTitulo());
            municipio_descripcion.setText(HTMLSimplifier.eliminadorHTML(m.getDescripcion()));
            municipio_fecha.setText(m.getFecha());
            
            return convertView;
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
}
