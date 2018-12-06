package com.Mezda.SIMAC.Fragments;

import android.content.Context;
import android.net.Uri;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.Mezda.SIMAC.Activitys.Activity_Main;
import com.Mezda.SIMAC.R;




/**
 * A simple {@link Fragment} subclass.
 * Activities that contain this fragment must implement the
 * {@link Fragment_Reporte.OnFragmentInteractionListener} interface
 * to handle interaction events.
 * Use the {@link Fragment_Reporte#newInstance} factory method to
 * create an instance of this fragment.
 */
public class Fragment_Reporte extends Fragment {
	// TODO: Rename parameter arguments, choose names that match
	private static final String ARG_PARAM1 = "param1";
	private static final String ARG_PARAM2 = "param2";
	
	// TODO: Rename and change types of parameters
	private String mParam1;
	private String mParam2;
	
	private OnFragmentInteractionListener mListener;
	
	public Fragment_Reporte() {
	}
	
	/**
	 * Use this factory method to create a new instance of
	 * this fragment using the provided parameters.
	 *
	 * @param param1 Parameter 1.
	 * @param param2 Parameter 2.
	 * @return A new instance of fragment Fragment_Reporte.
	 */
	// TODO: Rename and change types and number of parameters
	public static Fragment_Reporte newInstance(String param1, String param2) {
		Fragment_Reporte fragment = new Fragment_Reporte();
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
		((Activity_Main) getActivity()).setActionBarTitle("Reportes");
		((Activity_Main) getActivity()).selectItem(R.id.Danos_tu_reporte);
		return inflater.inflate(R.layout.fragment_reporte, container, false);
	}
	
	@Override
	public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
		super.onViewCreated(view, savedInstanceState);
		
		getActivity().getSupportFragmentManager().beginTransaction().replace(R.id.ReportarContent, new Fragment_MisReporte()).addToBackStack(null).commit();
		
		TextView Reportar = view.findViewById(R.id.Reportar);
		TextView MisReportes = view.findViewById(R.id.MisReportes);
		Reportar.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View view) {
				getActivity().getSupportFragmentManager().beginTransaction().replace(R.id.ReportarContent, new Fragment_Reportar()).addToBackStack(null).commit();
			}
		});
		MisReportes.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View view) {
				getActivity().getSupportFragmentManager().beginTransaction().replace(R.id.ReportarContent, new Fragment_MisReporte()).addToBackStack(null).commit();
			}
		});
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
