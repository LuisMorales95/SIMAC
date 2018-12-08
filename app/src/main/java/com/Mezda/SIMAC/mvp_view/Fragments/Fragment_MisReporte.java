package com.Mezda.SIMAC.mvp_view.Fragments;

import android.content.Context;
import android.content.DialogInterface;
import android.graphics.Color;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.support.v7.app.AlertDialog;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import com.Mezda.SIMAC.Objects.Reportes;
import com.Mezda.SIMAC.R;
import com.android.volley.Request;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.JsonArrayRequest;
import com.Mezda.SIMAC.Methods.HTTPPARAMS;
import com.Mezda.SIMAC.Methods.VolleySingleton;

import com.Mezda.SIMAC.UserData;
import com.bumptech.glide.Glide;

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
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import butterknife.BindView;
import butterknife.ButterKnife;

import static com.Mezda.SIMAC.Methods.SharedPreference.GETSharedPreferences;


/**
 * A simple {@link Fragment} subclass.
 * Activities that contain this fragment must implement the
 * {@link Fragment_MisReporte.OnFragmentInteractionListener} interface
 * to handle interaction events.
 * Use the {@link Fragment_MisReporte#newInstance} factory method to
 * create an instance of this fragment.
 */
public class Fragment_MisReporte extends Fragment {
	// TODO: Rename parameter arguments, choose names that match
	// the fragment initialization parameters, e.g. ARG_ITEM_NUMBER
	private static final String ARG_PARAM1 = "param1";
	private static final String ARG_PARAM2 = "param2";
	
	
	// TODO: Rename and change types of parameters
	private String mParam1;
	private String mParam2;
	private List<Reportes> reportesList;
	private OnFragmentInteractionListener mListener;
	@BindView(R.id.RecyclerList) RecyclerView recyclerlist;
    RecyclerView.Adapter recyclerAdapter;
	RecyclerView.LayoutManager recyclerlayoutManager;
	
	
	public Fragment_MisReporte() {
	}
	
	public static Fragment_MisReporte newInstance(String param1, String param2) {
		Fragment_MisReporte fragment = new Fragment_MisReporte();
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
		final View view = inflater.inflate(R.layout.fragment_misreporte, container, false);
		ButterKnife.bind(this,view);
		return view;
	}
	
	
	@Override
	public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
		super.onViewCreated(view, savedInstanceState);
		new Mireportes(GETSharedPreferences("ID", "")).execute();
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
	
	public class Mireportes extends AsyncTask<Void, Boolean, Boolean> {
		String iduser;
		
		public Mireportes(String iduser) {
			this.iduser = iduser;
		}
		
		@Override
		protected void onPreExecute() {
			super.onPreExecute();
		}
		
		@Override
		protected Boolean doInBackground(Void... voids) {
			ArrayList<NameValuePair> datatosend = new ArrayList<>();
			datatosend.add(new BasicNameValuePair("id_ciudadano", iduser));
			
			HttpParams httpRequestParams = HTTPPARAMS.GETHTTPREQUESTPARAMS();
			HttpClient client = new DefaultHttpClient(httpRequestParams);
			HttpPost post = new HttpPost(UserData.SERVER_ADDRESS + "JSONSelectMisReportes.php");
			// ++ RESPONSE FROM SERVER ++
			HttpResponse httpResponse = null;
			String responsedecoded = "";
			
			try {
				post.setEntity(new UrlEncodedFormEntity(datatosend));
				httpResponse = client.execute(post);
				HttpEntity httpEntity = httpResponse.getEntity();
				responsedecoded = EntityUtils.toString(httpEntity, "UTF-8");
				JSONArray jsonArray = new JSONArray(responsedecoded);
				reportesList = new ArrayList<Reportes>();
				
				for (int i = 0; i < jsonArray.length(); i++) {
					Reportes reportes = new Reportes();
					reportes.setFolio(jsonArray.getJSONObject(i).getString("id"));
					reportes.setReportevalidez(jsonArray.getJSONObject(i).getString("vigencia"));
					reportes.setFechasolicitud(jsonArray.getJSONObject(i).getString("fechahora"));
					reportes.setReporteimagen(jsonArray.getJSONObject(i).getString("Img_Solicitud"));
					reportes.setReporteproblema(jsonArray.getJSONObject(i).getString("problema"));
					reportes.setReferencia1(jsonArray.getJSONObject(i).getString("referencia1"));
					reportes.setReferencia2(jsonArray.getJSONObject(i).getString("referencia2"));
					reportes.setEstado(jsonArray.getJSONObject(i).getString("Estado"));
					reportesList.add(reportes);
				}
				if (jsonArray.length() > 0) {
					return true;
				} else {
					return false;
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			return false;
			
		}
		
		@Override
		protected void onPostExecute(final Boolean result) {
			if (result) {
                recyclerlist.setHasFixedSize(true);
                recyclerlayoutManager = new LinearLayoutManager(getContext());
                recyclerlist.setLayoutManager(recyclerlayoutManager);
                recyclerAdapter = new RecyclerViewAdapter(reportesList);
                recyclerlist.setAdapter(recyclerAdapter);
			} else {
				Toast.makeText(getContext(), "Imposible obtener informacion en este momento", Toast.LENGTH_LONG).show();
			}
		}
	}
	
	
	class RecyclerViewAdapter extends RecyclerView.Adapter<RecyclerViewAdapter.mViewHolder>  {
        
        List<Reportes> reportesList;
        
        
		
		
		public  class mViewHolder extends RecyclerView.ViewHolder {
			@BindView(R.id.MiReporte_Estado) TextView estado;
			@BindView(R.id.MiReporte_Folio) TextView miReporte_Folio;
			@BindView(R.id.MiReporte_fechahora) TextView mireporte_fechahora;
			@BindView(R.id.MiReporte_Descripcion) TextView problematica;
			@BindView(R.id.MiReporte_1referencia) TextView PReferencia;
			@BindView(R.id.MiReporte_2referencia) TextView SReferencia;
			@BindView(R.id.MiReporte_Imagen) ImageView evidencia;
			public mViewHolder(View itemView) {
				super(itemView);
				ButterKnife.bind(this,itemView);
				itemView.setOnClickListener(new MyOnClickListener());
			}
		}
  
		public RecyclerViewAdapter(List<Reportes> reportesList) {
            this.reportesList = reportesList;
        }
		
        @NonNull
		@Override
		public mViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
			View itemview = LayoutInflater.from(parent.getContext()).inflate(R.layout.mis_solicitudes,parent,false);
			mViewHolder vh = new mViewHolder(itemview);
			return vh;
		}
		
		@Override
		public void onBindViewHolder(@NonNull RecyclerViewAdapter.mViewHolder holder, int position) {
			Reportes reportes = reportesList.get(position);
			
			holder.estado.setText(reportes.getEstado());
			if (reportes.getEstado().equals("")) {
				holder.estado.setText("Solicitud: " + "Enviada");
				holder.estado.setTextColor(getResources().getColor(R.color.TextInPrimary));
				holder.estado.setBackgroundColor(getResources().getColor(R.color.colorPrimary));
			} else {
				holder.estado.setText("Solicitud: " + reportes.getEstado());
				holder.estado.setTextColor(getResources().getColor(R.color.TextInPrimary));
				holder.estado.setBackgroundColor(getResources().getColor(R.color.Facebook_blue));
			}
			holder.miReporte_Folio.setText("Folio: " + reportes.getFolio());
			holder.mireporte_fechahora.setText(reportes.getFechasolicitud());
			Glide.with(holder.itemView).load(UserData.SERVER_ADDRESS + reportes.getReporteimagen()).into(holder.evidencia);
			holder.problematica.setText("Problematica: \n  " + reportes.getReporteproblema());
			if (reportes.getReferencia1().isEmpty()) {
				holder.PReferencia.setText("Sin Referencia");
			} else {
				holder.PReferencia.setText(reportes.getReferencia1());
			}
			if (reportes.getReferencia2().isEmpty()) {
				holder.SReferencia.setText("Sin Referencia");
			} else {
				holder.SReferencia.setText(reportes.getReferencia2());
			}
		}
		
        @Override
        public int getItemCount() {
            return reportesList.size();
        }
    }
	class MyOnClickListener implements View.OnClickListener {
		@Override
		public void onClick(View v) {
			int position = recyclerlist.getChildLayoutPosition(v);
			if (!reportesList.get(position).getEstado().isEmpty()) {
				HashMap<String, String> map = new HashMap<>();
				map.put("idSolicitud", reportesList.get(position).getFolio());
				JSONObject object = new JSONObject(map);
				VolleySingleton.getInstance().addToRequestQueue(
						new JsonArrayRequest(
								Request.Method.POST,
								UserData.SERVER_ADDRESS + "JSONSelectSolicitudMovil.php",
								object,
								new Response.Listener<JSONArray>() {
									@Override
									public void onResponse(JSONArray response) {
										try {
											LayoutInflater factory = LayoutInflater.from(getActivity());
											final View view = factory.inflate(R.layout.request_details, null);
											((TextView) view.findViewById(R.id.request_estado))
													.setText("Estado\n"+response.getJSONObject(0).getString("Estado"));
											((TextView) view.findViewById(R.id.request_descripcion))
													.setText("Descripcion\n"+response.getJSONObject(0).getString("Descripcion"));
											((TextView) view.findViewById(R.id.request_servicio))
													.setText("Servicio\n"+response.getJSONObject(0).getString("Servicio"));
											((TextView) view.findViewById(R.id.request_dependencia))
													.setText("Dependencia\n"+response.getJSONObject(0).getString("Dependencia"));
											((TextView) view.findViewById(R.id.request_fecha))
													.setText("Fecha\n"+response.getJSONObject(0).getString("FechaAvance"));
											TextView title = new TextView(getActivity());
											title.setText("Informe de Progreso");
											title.setBackgroundColor(getResources().getInteger(R.color.com_facebook_blue));
											title.setPadding(10, 10, 10, 10);
											title.setGravity(Gravity.CENTER);
											title.setTextColor(Color.WHITE);
											title.setTextSize(20);
											new AlertDialog
													.Builder(getActivity())
													.setCustomTitle(title)
													.setView(view)
													.setPositiveButton("Ok", new DialogInterface.OnClickListener() {
                                                @Override
                                                public void onClick(DialogInterface dialog, int which) {
                                                    dialog.dismiss();
                                                }
                                            }).show();
										} catch (JSONException e) {
											e.printStackTrace();
										}
									}
								},
								new Response.ErrorListener() {
									@Override
									public void onErrorResponse(VolleyError error) {
										Toast.makeText(v.getContext(), error.toString(), Toast.LENGTH_SHORT).show();
										
									}
								}
						) {
							@Override
							public Map<String, String> getHeaders() {
								Map<String, String> headers = new HashMap<String, String>();
								headers.put("Content-Type", "application/json; charset=utf-8");
								headers.put("Accept", "application/json");
								return headers;
							}
						}
				);
				
			}
			
		}
	}
}
