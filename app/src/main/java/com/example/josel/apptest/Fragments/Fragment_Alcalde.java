package com.example.josel.apptest.Fragments;

import android.content.Context;
import android.content.res.Resources;
import android.net.Uri;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.ScrollView;
import android.widget.TextView;

import com.example.josel.apptest.Methods.GetImagesURL;
import com.example.josel.apptest.R;
import com.example.josel.apptest.UserData;


/**
 * A simple {@link Fragment} subclass.
 * Activities that contain this fragment must implement the
 * {@link Fragment_Alcalde.OnFragmentInteractionListener} interface
 * to handle interaction events.
 * Use the {@link Fragment_Alcalde#newInstance} factory method to
 * create an instance of this fragment.
 */
public class Fragment_Alcalde extends Fragment {
	// TODO: Rename parameter arguments, choose names that match
	// the fragment initialization parameters, e.g. ARG_ITEM_NUMBER
	private static final String ARG_PARAM1 = "param1";
	private static final String ARG_PARAM2 = "param2";
	
	// TODO: Rename and change types of parameters
	private String mParam1;
	private String mParam2;
	
	private OnFragmentInteractionListener mListener;
	
	public Fragment_Alcalde() {
		// Required empty public constructor
	}
	
	/**
	 * Use this factory method to create a new instance of
	 * this fragment using the provided parameters.
	 *
	 * @param param1 Parameter 1.
	 * @param param2 Parameter 2.
	 * @return A new instance of fragment Fragment_Alcalde.
	 */
	// TODO: Rename and change types and number of parameters
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
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
	                         Bundle savedInstanceState) {
		// Inflate the layout for this fragment
		return inflater.inflate(R.layout.fragment_alcalde, container, false);
	}
	
	@Override
	public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
		
		
		ImageView imgbackpro = (ImageView) view.findViewById(R.id.imgalcaldebackground);
		imgbackpro.getLayoutParams().width = getScreenWidth();
		imgbackpro.getLayoutParams().height = ((getScreenHeight() / 100) * 30);
		
		ImageView imgalcaldepic = (ImageView) view.findViewById(R.id.profilpic);
		imgalcaldepic.setY((getScreenHeight() / 100) * 15);
		imgalcaldepic.getLayoutParams().width = ((getScreenWidth() / 100) * 40);
		imgalcaldepic.getLayoutParams().height = ((getScreenWidth() / 100) * 40);
		
		TextView txtvnomalcalde = (TextView) view.findViewById(R.id.txtvnomalcalde);
		txtvnomalcalde.setText(UserData.Name);
		txtvnomalcalde.setY((getScreenHeight() / 100) * 15);
		
		ScrollView scrollView = (ScrollView) view.findViewById(R.id.scroll);
		scrollView.getLayoutParams().height = ((getScreenWidth() / 100) * 70);
		
		TextView txtvalcaldedesc = (TextView) view.findViewById(R.id.txtvalcaldedesc);
		txtvalcaldedesc.setText(UserData.descripalcalde);
		
		
		new GetImagesURL(imgalcaldepic).execute(UserData.Alcaldepic);
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
