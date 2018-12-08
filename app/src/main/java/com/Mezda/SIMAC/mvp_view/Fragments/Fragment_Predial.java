package com.Mezda.SIMAC.mvp_view.Fragments;

import android.content.Context;
import android.net.Uri;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;
import android.widget.ImageButton;
import android.widget.TextView;

import com.Mezda.SIMAC.R;



/**
 * A simple {@link Fragment} subclass.
 * Activities that contain this fragment must implement the
 * {@link Fragment_Predial.OnFragmentInteractionListener} interface
 * to handle interaction events.
 * Use the {@link Fragment_Predial#newInstance} factory method to
 * create an instance of this fragment.
 */
public class Fragment_Predial extends Fragment {
	// TODO: Rename parameter arguments, choose names that match
	// the fragment initialization parameters, e.g. ARG_ITEM_NUMBER
	private static final String ARG_PARAM1 = "param1";
	private static final String ARG_PARAM2 = "param2";
	
	// TODO: Rename and change types of parameters
	private String mParam1;
	private String mParam2;
	
	private OnFragmentInteractionListener mListener;
	
	public Fragment_Predial() {
		// Required empty public constructor
	}
	
	/**
	 * Use this factory method to create a new instance of
	 * this fragment using the provided parameters.
	 *
	 * @param param1 Parameter 1.
	 * @param param2 Parameter 2.
	 * @return A new instance of fragment Fragment_Predial.
	 */
	// TODO: Rename and change types and number of parameters
	public static Fragment_Predial newInstance(String param1, String param2) {
		Fragment_Predial fragment = new Fragment_Predial();
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
		return inflater.inflate(R.layout.fragment_predial, container, false);
	}
	
	@Override
	public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
		EditText etxtpredialbuscar = (EditText) getView().findViewById(R.id.etxtpredialbuscar);
		etxtpredialbuscar.setHint("Cuenta Catastral");
		ImageButton predialbuscar = (ImageButton) getView().findViewById(R.id.predialbuscar);
		TextView txtpredialtit2 = (TextView) getView().findViewById(R.id.txtpredialtit2);
		txtpredialtit2.setText("Datos del Predio");
		TextView txtpredialNom = (TextView) getView().findViewById(R.id.txtpredialNom);
		txtpredialNom.setText("Nombre del propietario:");
		TextView txtpredialpersona = (TextView) getView().findViewById(R.id.txtpredialpersona);
		txtpredialpersona.setText("Eje: AnnaSophia RobbAnne Hathaway");
		TextView txtpredialubica = (TextView) getView().findViewById(R.id.txtpredialubica);
		txtpredialubica.setText("Ubicacion del Predio:");
		TextView txtpredialubicacion = (TextView) getView().findViewById(R.id.txtpredialubicacion);
		txtpredialubicacion.setText("Eje: Lerdo 1, Benito Juárez, 96360 Nanchital, Ver.");
		TextView txtpredialAdeudo = (TextView) getView().findViewById(R.id.txtpredialAdeudo);
		txtpredialAdeudo.setText("Adeudos");
		TextView txtpredialcantidad = (TextView) getView().findViewById(R.id.txtpredialcantidad);
		txtpredialcantidad.setText("Eje: $2,504.95");
		
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
