package com.Mezda.SIMAC.mvp_view.Fragments;
import android.Manifest;
import android.annotation.SuppressLint;
import android.app.Activity;
import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.net.Uri;
import android.os.AsyncTask;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.design.widget.FloatingActionButton;
import android.support.v4.app.ActivityCompat;
import android.support.v4.app.Fragment;
import android.support.v4.content.ContextCompat;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.BaseAdapter;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import com.android.volley.toolbox.ImageLoader;
import com.android.volley.toolbox.NetworkImageView;
import com.Mezda.SIMAC.mvp_view.Activitys.Activity_Main;
import com.Mezda.SIMAC.mvp_view.Activitys.Activity_SubirNumEmergencia;
import com.Mezda.SIMAC.Methods.HTTPPARAMS;
import com.Mezda.SIMAC.Methods.VolleySingleton;
import com.Mezda.SIMAC.Objects.Numero_Emergencia;
import com.Mezda.SIMAC.R;

import com.Mezda.SIMAC.UserData;
import com.wdullaer.swipeactionadapter.SwipeActionAdapter;
import com.wdullaer.swipeactionadapter.SwipeDirection;

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

import static android.app.Activity.RESULT_OK;
import static com.Mezda.SIMAC.Methods.SharedPreference.GETSharedPreferences;

/**
 * A simple {@link Fragment} subclass.
 * Activities that contain this fragment must implement the
 * {@link Fragment_Emergencia.OnFragmentInteractionListener} interface
 * to handle interaction events.
 * Use the {@link Fragment_Emergencia#newInstance} factory method to
 * create an instance of this fragment.
 */
public class Fragment_Emergencia extends Fragment {
    private static final String TAG = Activity_Main.class.getSimpleName();
    private static final String ARG_PARAM1 = "param1";
    private static final String ARG_PARAM2 = "param2";

    // TODO: Rename and change types of parameters
    private String mParam1;
    private String mParam2;



    private static final String url = "http://192.168.1.70/SQLServerPhpWebServices/JSONSelectAllEmergencia.php";
    private ProgressDialog pDialog;
    private List<Numero_Emergencia> Numero_Emergencia_list;


    private ListView listView;
    private CustomListAdapter adapter;
    private FloatingActionButton EmergencyAdd;




    private OnFragmentInteractionListener mListener;

    public Fragment_Emergencia() {
        // Required empty public constructor
    }

    public static Fragment_Emergencia newInstance(String param1, String param2) {
        Fragment_Emergencia fragment = new Fragment_Emergencia();
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
        ((Activity_Main) getActivity()).setActionBarTitle("Numeros de Emergencia");
        ((Activity_Main) getActivity()).selectItem(R.id.NumEmergencia);
        return inflater.inflate(R.layout.fragment_emergencia, container, false);
    }

    @SuppressLint("ClickableViewAccessibility")
    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);

        Numero_Emergencia_list = new ArrayList<Numero_Emergencia>();
        listView = (ListView) getView().findViewById(R.id.listemergencia);
        EmergencyAdd = (FloatingActionButton) getView().findViewById(R.id.EmergencyAdd);
        EmergencyAdd.setVisibility(View.INVISIBLE);
        EmergencyAdd.setClickable(false);
        pDialog = new ProgressDialog(getActivity());
        // Showing progress dialog before making http request
        pDialog.setMessage("Loading...");
        pDialog.show();


        new getEmergencyNumber(Numero_Emergencia_list).execute();
	
	    if (GETSharedPreferences("Rol", "").equals("3")) {
            EmergencyAdd.setVisibility(View.VISIBLE);
            EmergencyAdd.setClickable(true);
            EmergencyAdd.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    startActivityForResult(new Intent(getActivity(), Activity_SubirNumEmergencia.class),001);
                }
            });

            listView.setOnItemLongClickListener(new AdapterView.OnItemLongClickListener() {
                @Override
                public boolean onItemLongClick(AdapterView<?> adapterView, View view, final int i, long l) {
                    DialogInterface.OnClickListener dialogClickListener = new DialogInterface.OnClickListener() {
                        @Override
                        public void onClick(DialogInterface dialog, int which) {
                            switch (which){
                                case DialogInterface.BUTTON_POSITIVE:
                                    new borrarContacto(Numero_Emergencia_list.get(i).getId_emergencia()).execute();
                                    break;

                                case DialogInterface.BUTTON_NEGATIVE:
                                    //No button clicked
                                    break;
                            }
                        }
                    };

                    AlertDialog.Builder builder = new AlertDialog.Builder(getContext());
                    builder.setTitle("Advertencia").setIcon(R.drawable.ic_menu_alerta);
                    builder.setMessage("Desea borrar Contacto?").setPositiveButton("Si", dialogClickListener)
                            .setNegativeButton("No", dialogClickListener).show();


                    return false;
                }
            });
        }


    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode==001 && resultCode==RESULT_OK){
            getActivity().getSupportFragmentManager().beginTransaction().replace(R.id.flContent,new Fragment_Emergencia()).addToBackStack(null).commit();
        }
    }

    public class getEmergencyNumber extends AsyncTask<Void,Boolean,Boolean> {
        List<Numero_Emergencia> llenar;

        public getEmergencyNumber(List<Numero_Emergencia> llenar) {
            this.llenar = llenar;
        }

        @Override
        protected void onPreExecute() {
            super.onPreExecute();
        }
        @Override
        protected Boolean doInBackground(Void... voids) {
            ArrayList<NameValuePair> datatosend = new ArrayList<>();
//            datatosend.add(new BasicNameValuePair("id_ciudadano",iduser));
            HttpParams httpRequestParams = HTTPPARAMS.GETHTTPREQUESTPARAMS();
            HttpClient client = new DefaultHttpClient(httpRequestParams);
            HttpPost post = new HttpPost(UserData.SERVER_ADDRESS+"JSONSelectEmergencia.php");
            // ++ RESPONSE FROM SERVER ++
            HttpResponse httpResponse = null;
            String responsedecoded = "";

            try {
                post.setEntity(new UrlEncodedFormEntity(datatosend));
                httpResponse = client.execute(post);
                HttpEntity httpEntity = httpResponse.getEntity();
                responsedecoded = EntityUtils.toString(httpEntity,"UTF-8");
                JSONArray jsonArray = new JSONArray(responsedecoded);
                for (int i = 0;i<jsonArray.length();i++){
                    Numero_Emergencia m = new Numero_Emergencia();
                    m.setId_emergencia(jsonArray.getJSONObject(i).getString("id_emergencia"));
                    m.setTelefono(jsonArray.getJSONObject(i).getString("telefono"));
                    m.setExtencion(jsonArray.getJSONObject(i).getString("extencion"));
                    m.setImg_emergencia(jsonArray.getJSONObject(i).getString("img_emergencia"));
                    m.setNombreEmergencia(jsonArray.getJSONObject(i).getString("Nombre_emergencia"));
                    llenar.add(m);
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
            hidePDialog();
            if (result){
                adapter = new CustomListAdapter(getActivity(),Numero_Emergencia_list);
                SwipeActionAdapter mSwipeActionAdapter = new SwipeActionAdapter(adapter);
                mSwipeActionAdapter.setListView(listView);
                mSwipeActionAdapter.addBackground(SwipeDirection.DIRECTION_NORMAL_RIGHT,R.layout.row_bg_right);
                listView.setAdapter(mSwipeActionAdapter);
                mSwipeActionAdapter.setSwipeActionListener(new SwipeActionAdapter.SwipeActionListener() {
                    @Override
                    public boolean hasActions(int position, SwipeDirection direction) {
                        if (direction.isRight())return true;
                        return false;
                    }

                    @Override
                    public boolean shouldDismiss(int position, SwipeDirection direction) {
                        return false;
                    }

                    @Override
                    public void onSwipe(int[] positionList, SwipeDirection[] directionList){
                        for(int i=0;i<positionList.length;i++) {
                            AlertDialog.Builder builder;
                            SwipeDirection direction = directionList[i];
                            int position = positionList[i];

                            final int REQUEST_PHONE_CALL = 1;
                            Intent intent = new Intent(Intent.ACTION_CALL, Uri.parse("tel:" + llenar.get(position).getTelefono()));
                            switch (direction) {
                                case DIRECTION_FAR_RIGHT:
                                    if (ContextCompat.checkSelfPermission(
                                            getActivity(), Manifest.permission.CALL_PHONE) != PackageManager.PERMISSION_GRANTED) {
                                        ActivityCompat.requestPermissions(getActivity(), new String[]{Manifest.permission.CALL_PHONE},REQUEST_PHONE_CALL);
                                    } else {
                                        startActivity(intent);
                                    }
//                                    builder = new AlertDialog.Builder(getContext());
//                                    builder.setTitle("Test Dialog").setMessage("You swiped right"+String.valueOf(position)).create().show();
                                    break;
                                case DIRECTION_NORMAL_RIGHT:
                                    if (ContextCompat.checkSelfPermission(
                                            getActivity(), Manifest.permission.CALL_PHONE) != PackageManager.PERMISSION_GRANTED) {
                                        ActivityCompat.requestPermissions(getActivity(), new String[]{Manifest.permission.CALL_PHONE},REQUEST_PHONE_CALL);
                                    } else {
                                        startActivity(intent);
                                    }
//                                    builder = new AlertDialog.Builder(getContext());
//                                    builder.setTitle("Test Dialog").setMessage("You swiped right"+String.valueOf(position)).create().show();
                                    break;
                            }

                            mSwipeActionAdapter.notifyDataSetChanged();
                        }
                    }

                });
            }else{
                Toast.makeText(getContext(),"Informacion no Disponible",Toast.LENGTH_LONG).show();
            }
        }
    }

    private void hidePDialog() {
        if (pDialog != null) {
            pDialog.dismiss();
            pDialog = null;
        }
    }

    public class CustomListAdapter extends BaseAdapter {
        private Activity activity;
        private LayoutInflater inflater;
        private List<Numero_Emergencia> NumeroEmergencia;
	    ImageLoader imageLoader = VolleySingleton.getInstance().getImageLoader();

        public CustomListAdapter(Activity activity, List<Numero_Emergencia> NumeroEmergencia) {
            this.activity = activity;
            this.NumeroEmergencia = NumeroEmergencia;
        }

        @Override
        public int getCount() {
            return NumeroEmergencia.size();
        }

        @Override
        public Object getItem(int location) {
            return NumeroEmergencia.get(location);
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
                convertView = inflater.inflate(R.layout.itememergencia, null);
	
	        if (imageLoader == null) imageLoader = VolleySingleton.getInstance().getImageLoader();
            NetworkImageView thumbNail = (NetworkImageView) convertView.findViewById(R.id.emerthumbnail);
            TextView title = (TextView) convertView.findViewById(R.id.emertitle);
            TextView numero = (TextView) convertView.findViewById(R.id.emernumber);
            TextView emerexte= (TextView) convertView.findViewById(R.id.emerexte);
            View select = (View) convertView.findViewById(R.id.select);



            // getting movie data for the row
            final Numero_Emergencia m = NumeroEmergencia.get(position);

            // thumbnail image
            thumbNail.setImageUrl(UserData.SERVER_ADDRESS+m.getImg_emergencia(), imageLoader);

            // title
            title.setText(m.getNombreEmergencia());

            // NUMERO
            numero.setText(String.valueOf(m.getTelefono()));
            if (String.valueOf(m.getExtencion()).equals("")){
                emerexte.setVisibility(View.INVISIBLE);
            }else{
                emerexte.setVisibility(View.VISIBLE);
            }
            emerexte.setText("Ext: "+String.valueOf(m.getExtencion()));

           /* call.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    final int REQUEST_PHONE_CALL = 1;
                    Intent intent = new Intent(Intent.ACTION_CALL, Uri.parse("tel:" + m.getTelefono()));

                        if (ContextCompat.checkSelfPermission(
                                getActivity(), Manifest.permission.CALL_PHONE) != PackageManager.PERMISSION_GRANTED) {
                            ActivityCompat.requestPermissions(getActivity(), new String[]{Manifest.permission.CALL_PHONE},REQUEST_PHONE_CALL);
                        } else {
                            startActivity(intent);
                        }


                }
            });*/
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


    private class borrarContacto extends AsyncTask<Void,Boolean,Boolean>{
        ProgressDialog progressDialog;
        String id_emer;

        public borrarContacto(String id_emer) {
            this.id_emer = id_emer;
        }

        @Override
        protected void onPreExecute() {
            super.onPreExecute();
            progressDialog = new ProgressDialog(getActivity());
            progressDialog.setMessage("Subiendo Informacion...");
            progressDialog.setCancelable(false);
            progressDialog.show();
        }
        @Override
        protected Boolean doInBackground(Void... voids) {
            // ++ ARRAY DE PARAMETROS QUE VAS A MANDAR AL WEB SERVICE ++
            ArrayList<NameValuePair> datatosend = new ArrayList<>();
            datatosend.add(new BasicNameValuePair("emer", id_emer));
            // ++ CONECCION PARA MANDAR LOS PARAMETROS ++
            HttpParams httpRequestParams = HTTPPARAMS.GETHTTPREQUESTPARAMS();
            HttpClient client = new DefaultHttpClient(httpRequestParams);
            HttpPost post = new HttpPost(UserData.SERVER_ADDRESS+"JSONDeleteContacto.php");

            // ++ RESPONSE FROM SERVER ++
            HttpResponse httpResponse = null;
            String responsedecoded = "";

            try {
                post.setEntity(new UrlEncodedFormEntity(datatosend));
                httpResponse = client.execute(post);
                HttpEntity httpEntity = httpResponse.getEntity();
                responsedecoded = EntityUtils.toString(httpEntity,"UTF-8");
                JSONArray jsonArray = new JSONArray(responsedecoded);
                String Respuesta = jsonArray.getJSONObject(0).getString("EXITO");
                if (Respuesta.equals("SI")){
                    return true;
                }
            }catch (Exception e){
                e.printStackTrace();
            }
                return false;

        }

        @Override
        protected void onPostExecute(Boolean aBoolean) {
            super.onPostExecute(aBoolean);
            progressDialog.dismiss();
            if (aBoolean){
                getActivity().getSupportFragmentManager().beginTransaction().replace(R.id.flContent,new Fragment_Emergencia()).addToBackStack(null).commit();
            }else{
                final AlertDialog.Builder builder = new AlertDialog.Builder(getActivity());
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
