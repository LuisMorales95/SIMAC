package com.example.josel.apptest.Fragments;

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
import android.widget.TextView;

import com.example.josel.apptest.R;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;


/**
 * A simple {@link Fragment} subclass.
 * Activities that contain this fragment must implement the
 * {@link Fragment_FacturaE.OnFragmentInteractionListener} interface
 * to handle interaction events.
 * Use the {@link Fragment_FacturaE#newInstance} factory method to
 * create an instance of this fragment.
 */
public class Fragment_FacturaE extends Fragment {
	// TODO: Rename parameter arguments, choose names that match
	// the fragment initialization parameters, e.g. ARG_ITEM_NUMBER
	private static final String ARG_PARAM1 = "param1";
	private static final String ARG_PARAM2 = "param2";
	
	// TODO: Rename and change types of parameters
	private String mParam1;
	private String mParam2;
	
	private OnFragmentInteractionListener mListener;
	
	public Fragment_FacturaE() {
		// Required empty public constructor
	}
	
	/**
	 * Use this factory method to create a new instance of
	 * this fragment using the provided parameters.
	 *
	 * @param param1 Parameter 1.
	 * @param param2 Parameter 2.
	 * @return A new instance of fragment Fragment_FacturaE.
	 */
	// TODO: Rename and change types and number of parameters
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
		// Inflate the layout for this fragment
		return inflater.inflate(R.layout.fragment_facturae, container, false);
		
	}
	
	@Override
	public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
		Date c = Calendar.getInstance().getTime();
		Snackbar.make(getView(), "" + c.toString(), Snackbar.LENGTH_LONG).show();
		SimpleDateFormat dateformat = new SimpleDateFormat("dd-mm-yyyy");
		String formatteddate = dateformat.format(c);
		
		EditText edittfolio = (EditText) getView().findViewById(R.id.editTfolio);
		edittfolio.setHint("Eje: 87694736");
		EditText edittfecha = (EditText) getView().findViewById(R.id.editTfecha);
		edittfecha.setHint("dd/mm/aaaa");
		edittfecha.setText(formatteddate);
		
		TextView textvfe = (TextView) getView().findViewById(R.id.factitle);
		textvfe.setText("Datos de Factura");
		
		EditText edittrfc = (EditText) getView().findViewById(R.id.editTrfc);
		edittrfc.setHint("Eje: MOP920695MYB");
		final EditText edittnombre = (EditText) getView().findViewById(R.id.editTnombre);
		edittnombre.setHint("Eje: Alejandro Ramos Barcelos");
		EditText edittcorreo = (EditText) getView().findViewById(R.id.editTcorreo);
		edittcorreo.setHint("Ejemplo: AlejandroRB@correo.com");
		
		Button btnenviar = (Button) getView().findViewById(R.id.btnenviarfac);
		btnenviar.setText("Facturar");
		btnenviar.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View view) {
				Snackbar.make(getView(), "Enviado" + edittnombre.getText().toString(), Snackbar.LENGTH_LONG).show();
			}
		});
		
		super.onViewCreated(view, savedInstanceState);
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
