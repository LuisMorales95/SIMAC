package com.Mezda.SIMAC.Fragments;

import android.content.Context;
import android.net.Uri;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.design.widget.Snackbar;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.TextView;

import com.Mezda.SIMAC.Activitys.Activity_Main;
import com.Mezda.SIMAC.R;
import com.bumptech.glide.Glide;


import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import butterknife.BindView;
import butterknife.ButterKnife;


/**
 * A simple {@link Fragment} subclass.
 * Activities that contain this fragment must implement the
 * {@link Fragment_FacturaE.OnFragmentInteractionListener} interface
 * to handle interaction events.
 * Use the {@link Fragment_FacturaE#newInstance} factory method to
 * create an instance of this fragment.
 */
public class Fragment_FacturaE extends Fragment implements Fragment_Facturar_Busqueda.OnFragmentInteractionListener{
	private static final String ARG_PARAM1 = "param1";
	private static final String ARG_PARAM2 = "param2";
	private String mParam1;
	private String mParam2;
	private OnFragmentInteractionListener mListener;
	
	@BindView(R.id.backgroundtransfer)
	ImageView backgroundtransfer;
	
	public Fragment_FacturaE() { }
	public static Fragment_FacturaE newInstance(String param1, String param2) {
		Fragment_FacturaE fragment = new Fragment_FacturaE();
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
		final View view = inflater.inflate(R.layout.fragment_facturae, container, false);
		ButterKnife.bind(this,view);
		return view;
	}
	
	@Override
	public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
		super.onViewCreated(view, savedInstanceState);
        Glide.with(getActivity()).load(R.drawable.fondofacturacion).into(backgroundtransfer);
		Fragment_Facturar_Busqueda fragment = new Fragment_Facturar_Busqueda();
		getActivity().getSupportFragmentManager().beginTransaction().replace(R.id.content_Factura, fragment).commit();
		((Activity_Main) getActivity()).setActionBarTitle("Facturación");
		((Activity_Main) getActivity()).selectItem(R.id.FacturaElectronica);
		
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
	
	@Override
	public void onFragmentInteraction(Uri uri) {
	
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
