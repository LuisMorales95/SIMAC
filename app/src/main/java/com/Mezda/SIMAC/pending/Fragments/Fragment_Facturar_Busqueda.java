package com.Mezda.SIMAC.pending.Fragments;

import android.app.DatePickerDialog;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v7.app.AlertDialog;
import android.text.InputFilter;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.ImageButton;
import android.widget.ImageView;

import com.Mezda.SIMAC.pending.Activities.PDFViewer;
import com.Mezda.SIMAC.BuildConfig;
import com.Mezda.SIMAC.utils.FileChooser;
import com.Mezda.SIMAC.data.dao.Recibo;
import com.Mezda.SIMAC.R;
import com.Mezda.SIMAC.UserData;
import com.android.volley.DefaultRetryPolicy;
import com.android.volley.Request;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.JsonArrayRequest;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import butterknife.BindView;
import butterknife.ButterKnife;

import static com.Mezda.SIMAC.utils.GenericDialogs.ProgressDialog;
import static com.Mezda.SIMAC.utils.VolleySingleton.getInstance;


public class Fragment_Facturar_Busqueda extends Fragment {
    private static final String ARG_PARAM1 = "param1";
    private static final String ARG_PARAM2 = "param2";
    private String mParam1;
    private String mParam2;
    
    @BindView(R.id.Factura_Folio)
    EditText Factura_Folio;
    @BindView(R.id.Factura_Fecha)
    EditText Factura_Fecha;
    @BindView(R.id.Factura_Calendario)
    ImageButton Factura_Calendario;
    @BindView(R.id.Factura_Facturar)
    Button Factura_Facturar;
    @BindView(R.id.file_cabinet)
    ImageView file_cabinet;
    
    private OnFragmentInteractionListener mListener;
    public Fragment_Facturar_Busqueda() { }
    
    public static Fragment_Facturar_Busqueda newInstance(String param1, String param2) {
        Fragment_Facturar_Busqueda fragment = new Fragment_Facturar_Busqueda();
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
        final View view = inflater.inflate(R.layout.fragment_facturar_busqueda, container, false);
        ButterKnife.bind(this,view);
        
        Factura_Folio.setFilters(new InputFilter[]{ new InputFilter.AllCaps()});
        Factura_Calendario.setOnClickListener(new Calender());
        if (BuildConfig.DEBUG){
            Factura_Folio.setText("B350");
            Factura_Fecha.setText("12/01/2018");
        }
        Factura_Facturar.setOnClickListener(new Facturar(getActivity(),Factura_Folio,Factura_Fecha));
        file_cabinet.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
//                TODO: file chooser code
                FileChooser fileChooser = new FileChooser(getActivity());
                fileChooser.setFileListener(new FileChooser.FileSelectedListener() {
                    @Override
                    public void fileSelected(File file) {
                        /*TODO selected file*/
                        PDFViewer.file = file;
                        startActivity(new Intent(getActivity(), PDFViewer.class));
                    }
                });
                fileChooser.showDialog();
            }
        });
        return view;
    }
    
    private class Calender implements View.OnClickListener{
        Calendar calendar = Calendar.getInstance();
        @Override
        public void onClick(View v) {
            new DatePickerDialog(getActivity(),
                    new DatePickerDialog.OnDateSetListener() {
                        @Override
                        public void onDateSet(DatePicker view, int year, int month, int dayOfMonth) {
                            calendar.set(Calendar.YEAR,year);
                            calendar.set(Calendar.MONTH,month);
                            calendar.set(Calendar.DAY_OF_MONTH,dayOfMonth);
                            updateLabel();
                        }
                        private void updateLabel() {
                            String format = "dd/MM/yyyy";
                            SimpleDateFormat simpleDateFormat = new SimpleDateFormat(format, Locale.US);
                            Factura_Fecha.setText(simpleDateFormat.format(calendar.getTime()));
                        }
                    },
                    calendar.get(Calendar.YEAR),
                    calendar.get(Calendar.MONTH),
                    calendar.get(Calendar.DAY_OF_MONTH)
            ).show();
        }
    }
    
    public class Facturar implements View.OnClickListener{
    
        Context context;
        EditText folio;
        EditText fecha;
    
        public Facturar(Context context, EditText folio, EditText fecha) {
            this.context = context;
            this.folio = folio;
            this.fecha = fecha;
        }
    
        @Override
        public void onClick(View v) {
            ProgressDialog progressDialog = ProgressDialog(context,UserData.ProgressDialog_GETRECIBO);
            progressDialog.show();
            HashMap<String,String> HashMap = new HashMap<>();
            HashMap.put("FacturaFolio",folio.getText().toString());
            HashMap.put("FacturaFecha",fecha.getText().toString());
            JSONObject object = new JSONObject(HashMap);
            JsonArrayRequest request = new JsonArrayRequest(
                    Request.Method.POST,
                    UserData.Factura_JSONSelectRecibos,
                    object,
                    new Response.Listener<JSONArray>() {
                        @Override
                        public void onResponse(JSONArray response) {
                            System.out.println(response.toString());
                            progressDialog.dismiss();
                            if (response.toString().equals("[{\"\":\"not-found\"}]")){
                                new AlertDialog.Builder(context)
                                        .setMessage(R.string.Folio_notFound)
                                        .show();
                            }else if (response.toString().equals("[{\"\":\"Cashed\"}]")){
                                new AlertDialog.Builder(context)
                                        .setMessage(R.string.CDFI_cashed)
                                        .show();
                            }else{
                                try {
                                    Recibo recibo = new Recibo();
                                    recibo.setFolio(response.getJSONObject(0).getString("FOLIO"));
                                    recibo.setFecha(response.getJSONObject(0).getString("FECHA"));
                                    recibo.setAdicional(response.getJSONObject(0).getString("ADICIONAL"));
                                    recibo.setCorriente(response.getJSONObject(0).getString("CORRIENTE"));
                                    recibo.setGastos(response.getJSONObject(0).getString("GASTOS"));
                                    recibo.setMultas(response.getJSONObject(0).getString("MULTAS"));
                                    recibo.setRecargos(response.getJSONObject(0).getString("RECARGOS"));
                                    recibo.setRezagos(response.getJSONObject(0).getString("REZAGOS"));
                                    recibo.setTotal(response.getJSONObject(0).getString("TOTAL"));
                                    recibo.setDescuento20(response.getJSONObject(0).getString("DESCUENTO20"));
                                    recibo.setDescuento50(response.getJSONObject(0).getString("DESCUENTO50"));
                                    recibo.setConcepto1(response.getJSONObject(0).getString("CONCEPTO1"));
                                    recibo.setConcepto2(response.getJSONObject(0).getString("CONCEPTO2"));
                                    recibo.setConcepto3(response.getJSONObject(0).getString("CONCEPTO3"));
                                    recibo.setConcepto4(response.getJSONObject(0).getString("CONCEPTO4"));
                                    recibo.setContribuyente(response.getJSONObject(0).getString("CONTRIBUYENTE"));
                                    recibo.setCuentacatastral(response.getJSONObject(0).getString("CUENTACATASTRAL"));
                                    recibo.setCuentacontable(response.getJSONObject(0).getString("CUENTACONTABLE"));
                                    recibo.setImporteletra(response.getJSONObject(0).getString("IMPORTELETRA"));
                                    recibo.setEstatus(response.getJSONObject(0).getString("ESTATUS"));
                                    recibo.setRfc(response.getJSONObject(0).getString("RFC"));
                                    recibo.setTipo_predial_o_varios(response.getJSONObject(0).getString("TIPO_PAGO"));
                        
                                    Log.i("Informacion: ",response.toString());
                                    getActivity().getSupportFragmentManager().beginTransaction().replace(R.id.content_Factura, new Fragment_Facturar_Datos()).addToBackStack(this.getClass().getName()).commit();
                        
                        
                                    Fragment_Facturar_Datos.recibo=recibo;
                                } catch (JSONException e) {
                                    e.printStackTrace();
                                }
                            }
                        }
                    },
                    new Response.ErrorListener() {
                        @Override
                        public void onErrorResponse(VolleyError error) {
                            Log.e(getResources().getString(R.string.Tag_VolleyError),error.toString());
                            progressDialog.dismiss();
                            new AlertDialog.Builder(context).setMessage(error.toString()).show();
                        }
                    }){
                @Override
                public Map<String, String> getHeaders() {
                    Map<String, String> headers = new HashMap<String, String>();
                    headers.put("Content-Type", "application/json; charset=utf-8");
                    headers.put("Accept", "application/json");
                    return headers;
                }
            };
    
            request.setRetryPolicy(new DefaultRetryPolicy(10000,
                    DefaultRetryPolicy.DEFAULT_MAX_RETRIES,
                    DefaultRetryPolicy.DEFAULT_BACKOFF_MULT));
            getInstance().addToRequestQueue(request);
            
        }
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
        void onFragmentInteraction(Uri uri);
    }
}
