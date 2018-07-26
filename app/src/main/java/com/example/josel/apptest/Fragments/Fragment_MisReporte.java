package com.example.josel.apptest.Fragments;

import android.app.Activity;
import android.content.Context;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import com.android.volley.toolbox.ImageLoader;
import com.android.volley.toolbox.NetworkImageView;
import com.example.josel.apptest.Activitys.Activity_Main;
import com.example.josel.apptest.Methods.AppController;
import com.example.josel.apptest.Methods.HTTPPARAMS;
import com.example.josel.apptest.R;
import com.example.josel.apptest.UserData;
import com.example.josel.apptest.Objects.LosUsuarios;

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


/**
 * A simple {@link Fragment} subclass.
 * Activities that contain this fragment must implement the
 * {@link Fragment_MisReporte.OnFragmentInteractionListener} interface
 * to handle interaction events.
 * Use the {@link Fragment_MisReporte#newInstance} factory method to
 * create an instance of this fragment.
 */
public class Fragment_MisReporte extends Fragment {
    // TODO: Rename parameter arguments, choose names that match
    // the fragment initialization parameters, e.g. ARG_ITEM_NUMBER
    private static final String ARG_PARAM1 = "param1";
    private static final String ARG_PARAM2 = "param2";
    // TODO: Rename and change types of parameters
    private String mParam1;
    private String mParam2;





    private ListView lista;
    private String [] reportevalidez,reporteimagen,reporteproblema,folio,referencia1,referencia2,fechasolicitud;
    public static CustomListAdapter adapter;










    private OnFragmentInteractionListener mListener;
    public Fragment_MisReporte() { }
    public static Fragment_MisReporte newInstance(String param1, String param2) {
        Fragment_MisReporte fragment = new Fragment_MisReporte();
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
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_misreporte, container, false);
    }












    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        inicializar();
        new Mireportes(Activity_Main.preferences.getString("ID","")).execute();
    }
    private void inicializar(){
        lista = getActivity().findViewById(R.id.MisReporteslista);

    }

    public class Mireportes extends AsyncTask<Void,Boolean,Boolean> {
        String iduser;

        public Mireportes(String iduser) {
            this.iduser = iduser;
        }

        @Override
        protected void onPreExecute() {
            super.onPreExecute();
        }
        @Override
        protected Boolean doInBackground(Void... voids) {
            ArrayList<NameValuePair> datatosend = new ArrayList<>();
            datatosend.add(new BasicNameValuePair("id_ciudadano",iduser));

            HttpParams httpRequestParams = HTTPPARAMS.GETHTTPREQUESTPARAMS();
            HttpClient client = new DefaultHttpClient(httpRequestParams);
            HttpPost post = new HttpPost(UserData.SERVER_ADDRESS+"JSONSelectReportesMios.php");
            // ++ RESPONSE FROM SERVER ++
            HttpResponse httpResponse = null;
            String responsedecoded = "";

            try {
                post.setEntity(new UrlEncodedFormEntity(datatosend));
                httpResponse = client.execute(post);
                HttpEntity httpEntity = httpResponse.getEntity();
                responsedecoded = EntityUtils.toString(httpEntity,"UTF-8");
                JSONArray jsonArray = new JSONArray(responsedecoded);
                folio = new String[jsonArray.length()];
                reportevalidez = new String[jsonArray.length()];
                fechasolicitud = new String[jsonArray.length()];
                reporteimagen = new String[jsonArray.length()];
                reporteproblema = new String[jsonArray.length()];
                referencia1 = new String[jsonArray.length()];
                referencia2 = new String[jsonArray.length()];

                for (int i = 0;i<jsonArray.length();i++){
                    folio[i] = jsonArray.getJSONObject(i).getString("id");
                    reportevalidez[i] = jsonArray.getJSONObject(i).getString("vigencia");
                    fechasolicitud[i] = jsonArray.getJSONObject(i).getString("fechahora");
                    reporteimagen[i] = jsonArray.getJSONObject(i).getString("Img_Solicitud");
                    reporteproblema[i] = jsonArray.getJSONObject(i).getString("problema");
                    referencia1[i] = jsonArray.getJSONObject(i).getString("referencia1");
                    referencia2[i] = jsonArray.getJSONObject(i).getString("referencia2");
                }
                if (jsonArray.length()>0){
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
                adapter = new CustomListAdapter(getActivity(),reportevalidez,reporteimagen,reporteproblema,folio);
                lista.setAdapter(adapter);
            }else{
                Toast.makeText(getContext(),"Imposible obtener informacion en este momento",Toast.LENGTH_LONG).show();
            }
        }
    }

    private class CustomListAdapter extends BaseAdapter {

        private LayoutInflater inflater;
        private Activity activity;
        private String [] vigencia,imagen,problema,folio;
        private List<LosUsuarios> Users;
        ImageLoader imageLoader = AppController.getInstance().getImageLoader();

        public CustomListAdapter(Activity activity, String[] vigencia, String[] imagen, String[] problema, String[] folio) {
            this.activity = activity;
            this.vigencia = vigencia;
            this.imagen = imagen;
            this.problema = problema;
            this.folio = folio;
        }

        @Override
        public int getCount() {
            return vigencia.length;
        }

        @Override
        public Object getItem(int i) {
            return vigencia[i];
        }

        @Override
        public long getItemId(int i) {
            return i;
        }

        @Override
        public View getView(int i, View view, ViewGroup viewGroup) {
            if (inflater == null) inflater = (LayoutInflater) activity.getSystemService(Context.LAYOUT_INFLATER_SERVICE);

            if (view == null) view = inflater.inflate(R.layout.mis_solicitudes, null);

            if (imageLoader == null) imageLoader = AppController.getInstance().getImageLoader();

            TextView Estado = view.findViewById(R.id.MiReporte_Estado);
            NetworkImageView evidencia = view.findViewById(R.id.MiReporte_Imagen);
            TextView MiReporte_Folio = view.findViewById(R.id.MiReporte_Folio);
            TextView mireporte_fechahora = view.findViewById(R.id.MiReporte_fechahora);
            TextView problematica = view.findViewById(R.id.MiReporte_Descripcion);
            TextView PReferencia = view.findViewById(R.id.MiReporte_1referencia);
            TextView SReferencia = view.findViewById(R.id.MiReporte_2referencia);

            if (vigencia[i].equals("1")){
                Estado.setText("Solicitud: "+"Activa");
                Estado.setTextColor(getResources().getColor(R.color.TextInPrimary));
                Estado.setBackgroundColor(getResources().getColor(R.color.colorPrimary));
            }else{
                Estado.setText("Solicitud: "+"Inactiva");
                Estado.setTextColor(getResources().getColor(R.color.TextInPrimaryLight));
                Estado.setBackgroundColor(getResources().getColor(R.color.shadow));
            }
            MiReporte_Folio.setText("Folio: "+folio[i]);
            mireporte_fechahora.setText(fechasolicitud[i]);
            evidencia.setImageUrl(UserData.SERVER_ADDRESS+imagen[i], imageLoader);
            problematica.setText("Problematica: \n  "+problema[i]);
            if (referencia1[i].isEmpty()){
                PReferencia.setText("Sin Referencia");
            }else{
                PReferencia.setText(referencia1[i]);
            }
            if (referencia2[i].isEmpty()){
                SReferencia.setText("Sin Referencia");
            }else{
                SReferencia.setText(referencia2[i]);
            }

            return view;
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
