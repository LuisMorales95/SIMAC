package com.Mezda.SIMAC.Fragments;

import android.annotation.SuppressLint;
import android.app.FragmentManager;
import android.app.LoaderManager;
import android.content.AsyncTaskLoader;
import android.content.Context;
import android.net.Uri;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.telecom.Call;
import android.text.InputFilter;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.TextView;

import com.Mezda.SIMAC.BuildConfig;
import com.Mezda.SIMAC.Methods.Factura;
import com.Mezda.SIMAC.Objects.Recibo;
import com.Mezda.SIMAC.R;
import butterknife.BindView;
import butterknife.ButterKnife;

import static com.Mezda.SIMAC.Methods.StaticData.MetodoDePagos;
import static com.Mezda.SIMAC.Methods.StaticData.UsoCFDIs;

public class Fragment_Facturar_Datos extends Fragment {
    
    private static final String ARG_PARAM1 = "param1";
    private static final String ARG_PARAM2 = "param2";
    
    
    // TODO: Rename and change types of parameters
    private String mParam1;
    private String mParam2;
    static Recibo recibo;
    @BindView(R.id.DF_RazonSocial) EditText DF_RazonSocial;
    @BindView(R.id.DF_RFC) EditText DF_RFC;
    @BindView(R.id.DF_Direccion) EditText DF_Direccion;
    @BindView(R.id.DF_Correo) EditText DF_Correo;
    @BindView(R.id.DF_ActualizarRegistro) Button DF_ActualizarRegistro;
    @BindView(R.id.CFDI_Folio) TextView CFDI_Folio;
    @BindView(R.id.CFDI_TipoDePago)Spinner CFDI_TipoDePago;
    @BindView(R.id.CFDI_UsoCFDI) Spinner CFDI_UsoCFDI;
    @BindView(R.id.CFDI_Concepto) EditText CFDI_Concepto;
    @BindView(R.id.CFDI_Rezagos) EditText CFDI_Rezagos;
    @BindView(R.id.CFDI_Recargos) EditText CFDI_Recargos;
    @BindView(R.id.CFDI_Corriente) EditText CFDI_Corriente;
    @BindView(R.id.CFDI_Adicional) EditText CFDI_Adicional;
    @BindView(R.id.CFDI_Multas) EditText CFDI_Multas;
    @BindView(R.id.CFDI_Gastos) EditText CFDI_Gastos;
    @BindView(R.id.CFDI_Dec20Art118) EditText CFDI_Dec20Art118;
    @BindView(R.id.CFDI_Otros) EditText CFDI_Otros;
    @BindView(R.id.CFDI_Total) EditText CFDI_Total;
    @BindView(R.id.CFDI_TotalEscrito) TextView CFDI_TotalEscrito;
    @BindView(R.id.CFDI_GenerarFactura) Button CFDI_GenerarFactura;
    private OnFragmentInteractionListener mListener;
    public Fragment_Facturar_Datos() {
    }
    public static Fragment_Facturar_Datos newInstance(String param1, String param2) {
        Fragment_Facturar_Datos fragment = new Fragment_Facturar_Datos();
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
        View view = inflater.inflate(R.layout.fragment_facturar_datos, container, false);
        ButterKnife.bind(this,view);
        if (BuildConfig.DEBUG){
            DF_RFC.setText("XAXX010101000");
            DF_RazonSocial.setText("VENTA AL PUBLICO EN GENERAL");
            DF_Direccion.setText("CIUDAD PEMEX 103 COLONIA CUATRO CAMINOS");
            DF_Correo.setText("Joseluismoralesp95@gmail.com");
        }else{
            DF_RazonSocial.setText(recibo.getContribuyente());
            DF_RFC.setText(recibo.getRfc().replace("-",""));
        }
        DF_RazonSocial.setFilters(new InputFilter[]{ new InputFilter.AllCaps()});
        DF_RFC.setFilters(new InputFilter[]{ new InputFilter.AllCaps()});
        
        
        CFDI_Folio.setText("FOLIO: "+recibo.getFolio());
        CFDI_TipoDePago.setAdapter(new ArrayAdapter(getActivity(), R.layout.simple_spinner_item, MetodoDePagos()));
        CFDI_UsoCFDI.setAdapter(new ArrayAdapter(getActivity(), R.layout.simple_spinner_item, UsoCFDIs()));
        CFDI_Concepto.setText(recibo.getConcepto1()+" "+recibo.getConcepto2()+" "+recibo.getConcepto3()+" "+recibo.getConcepto4());
        CFDI_Rezagos.setText("$"+recibo.getRezagos());
        CFDI_Recargos.setText("$"+recibo.getRecargos());
        CFDI_Corriente.setText("$"+recibo.getCorriente());
        CFDI_Adicional.setText("$"+recibo.getAdicional());
        CFDI_Multas.setText("$"+recibo.getMultas());
        CFDI_Gastos.setText("$"+recibo.getGastos());
        CFDI_Dec20Art118.setText("$"+recibo.getDescuento20());
        CFDI_Total.setText("$"+recibo.getTotal());
        CFDI_TotalEscrito.setText("$"+recibo.getImporteletra());
        CFDI_GenerarFactura.setOnClickListener(
                new Factura(
                        getContext(),
                        "SysConroe2015",
                        recibo,
                        DF_RFC,
                        DF_RazonSocial,
                        DF_Correo,
                        CFDI_TipoDePago,
                        CFDI_UsoCFDI
                        ,DF_Direccion));
        return view;
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
