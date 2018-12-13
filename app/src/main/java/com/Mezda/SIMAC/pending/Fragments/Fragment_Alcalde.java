package com.Mezda.SIMAC.pending.Fragments;

import android.content.Context;
import android.content.res.Resources;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.Mezda.SIMAC.ui.main.Activity_Main;
import com.Mezda.SIMAC.R;
import com.Mezda.SIMAC.UserData;
import com.bumptech.glide.Glide;

import static android.text.Layout.JUSTIFICATION_MODE_INTER_WORD;


/**
 * A simple {@link Fragment} subclass.
 * Activities that contain this fragment must implement the
 * {@link Fragment_Alcalde.OnFragmentInteractionListener} interface
 * to handle interaction events.
 * Use the {@link Fragment_Alcalde#newInstance} factory method to
 * create an instance of this fragment.
 */
public class Fragment_Alcalde extends Fragment {
	private static final String ARG_PARAM1 = "param1";
	private static final String ARG_PARAM2 = "param2";
	private String mParam1;
	private String mParam2;
	private int pics[]={
			R.drawable.alcalde1,
			R.drawable.alcalde2,
			R.drawable.alcalde3,
			R.drawable.alcalde4,
			R.drawable.alcalde6,
			R.drawable.alcalde7,
			R.drawable.alcalde8};
	private OnFragmentInteractionListener mListener;
	
	private Handler myHandler;
	private Runnable myRunnable;
	
	public Fragment_Alcalde() {
	}
	
	public static Fragment_Alcalde newInstance(String param1, String param2) {
		Fragment_Alcalde fragment = new Fragment_Alcalde();
		Bundle args = new Bundle();
		args.putString(ARG_PARAM1, param1);
		args.putString(ARG_PARAM2, param2);
		fragment.setArguments(args);
		return fragment;
	}
	
	public static int getScreenHeight() {
		return Resources.getSystem().getDisplayMetrics().heightPixels;
	}
	
	public static int getScreenWidth() {
		return Resources.getSystem().getDisplayMetrics().widthPixels;
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
		((Activity_Main) getActivity()).setActionBarTitle("Alcalde");
		((Activity_Main) getActivity()).selectItem(R.id.CoAlcalde);
		return inflater.inflate(R.layout.fragment_alcalde, container, false);
	}
	
	@Override
	public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
	
		Glide.with(getActivity()).load(R.drawable.banersimac).into((ImageView)view.findViewById(R.id.imgalcaldebackground));
		ImageView imgalcaldepic = (ImageView) view.findViewById(R.id.profilpic);
		TextView txtvnomalcalde = (TextView) view.findViewById(R.id.txtvnomalcalde);
		txtvnomalcalde.setText(UserData.Name);
		
		((TextView) view.findViewById(R.id.DatosP)).setText(UserData.Datos_Personales);
		((TextView) view.findViewById(R.id.DatosPT)).setText(UserData.Datos_Personales_text);
		if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
			((TextView) view.findViewById(R.id.DatosPT)).setJustificationMode(JUSTIFICATION_MODE_INTER_WORD);
		}
		
		((TextView) view.findViewById(R.id.CargosP)).setText(UserData.Cargos_Politicos);
		((TextView) view.findViewById(R.id.CargosPT)).setText(UserData.Cargos_Politicos_text);
		if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
			((TextView) view.findViewById(R.id.CargosPT)).setJustificationMode(JUSTIFICATION_MODE_INTER_WORD);
		}
		((TextView) view.findViewById(R.id.TrabajosA)).setText(UserData.Trabajos_administrativos);
		((TextView) view.findViewById(R.id.TrabajosAT)).setText(UserData.Trabajos_administrativos_text);
		if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
			((TextView) view.findViewById(R.id.TrabajosAT)).setJustificationMode(JUSTIFICATION_MODE_INTER_WORD);
		}
		
		
		myHandler = new Handler(Looper.getMainLooper());
		myRunnable = new Runnable() {
			int updateInterval = 3000;
			int ini = 0;
			@Override
			public void run() {
				if (getActivity()!=null) {
					Glide.with(getActivity()).load(pics[ini]).into(imgalcaldepic);
					imgalcaldepic.postDelayed(this, updateInterval);
					if (ini == pics.length - 1) { ini = 0; } else { ini++; }
				}
			}
		};
		myHandler.post(myRunnable);
		
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
	
	public interface OnFragmentInteractionListener {
		// TODO: Update argument type and name
		void onFragmentInteraction(Uri uri);
	}
	
	@Override
	public void onDestroy() {
		myHandler.removeCallbacks(myRunnable);
		super.onDestroy();
	}
}
