package com.Mezda.SIMAC.Fragments;

import android.app.DatePickerDialog;
import android.content.Context;
import android.net.Uri;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.text.InputFilter;
import android.text.Spanned;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.ImageButton;
import android.widget.ImageView;

import com.Mezda.SIMAC.R;
import com.bumptech.glide.Glide;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Locale;

import butterknife.BindView;
import butterknife.ButterKnife;


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
                            String format = "MM/dd/yy";
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
