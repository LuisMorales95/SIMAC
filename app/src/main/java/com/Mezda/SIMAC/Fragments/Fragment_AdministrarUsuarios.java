package com.Mezda.SIMAC.Fragments;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Build;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.design.widget.Snackbar;
import android.support.v4.app.Fragment;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.BaseAdapter;
import android.widget.ListView;
import android.widget.TextView;

import com.Mezda.SIMAC.Activitys.Activity_Main;
import com.android.volley.toolbox.ImageLoader;
import com.android.volley.toolbox.NetworkImageView;
import com.Mezda.SIMAC.Activitys.Activity_Privilegios;
import com.Mezda.SIMAC.Methods.HTTPPARAMS;
import com.Mezda.SIMAC.Methods.VolleySingleton;
import com.Mezda.SIMAC.Objects.LosUsuarios;
import com.Mezda.SIMAC.R;

import com.Mezda.SIMAC.UserData;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.params.HttpParams;
import org.apache.http.util.EntityUtils;
import org.json.JSONArray;

import java.util.ArrayList;
import java.util.List;

import static android.app.Activity.RESULT_OK;


/**
 * A simple {@link Fragment} subclass.
 * Activities that contain this fragment must implement the
 * {@link Fragment_AdministrarUsuarios.OnFragmentInteractionListener} interface
 * to handle interaction events.
 * Use the {@link Fragment_AdministrarUsuarios#newInstance} factory method to
 * create an instance of this fragment.
 */
public class Fragment_AdministrarUsuarios extends Fragment {
	// TODO: Rename parameter arguments, choose names that match
	private static final String ARG_PARAM1 = "param1";
	private static final String ARG_PARAM2 = "param2";
	// TODO: Variables
	public static TextView AdminCUser;
	public static TextView AdminCWorker;
	public static TextView AdminCAdmin;
	public static TextView AdminCSearch;
	public static List<LosUsuarios> lista_usuario;
	public static CustomListAdapter adapter;
	public static int usuarioSeleciondo = -1;
	ListView AdminCLista;
	// TODO: Rename and change types of parameters
	private String mParam1;
	private String mParam2;
	private OnFragmentInteractionListener mListener;
	private Object mActionMode;
	
	
	public Fragment_AdministrarUsuarios() {
		// Required empty public constructor
	}
	
	public static Fragment_AdministrarUsuarios newInstance(String param1, String param2) {
		Fragment_AdministrarUsuarios fragment = new Fragment_AdministrarUsuarios();
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
		((Activity_Main) getActivity()).setActionBarTitle("Administrar Usuarios");
		((Activity_Main) getActivity()).clearMainDrawer();
		return inflater.inflate(R.layout.fragment_administrar_usuarios, container, false);
	}
	
	@Override
	public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
		
		lista_usuario = new ArrayList<LosUsuarios>();
		AdminCUser = view.findViewById(R.id.AdminCUser);
		AdminCWorker = view.findViewById(R.id.AdminCWorker);
		AdminCAdmin = view.findViewById(R.id.AdminCAdmin);
		AdminCSearch = view.findViewById(R.id.AdminCSearch);
		AdminCLista = (ListView) view.findViewById(R.id.AdminCLista);
		new Usuarios(lista_usuario).execute();
		new ContarUsuarios().execute();
		AdminCLista.setOnItemLongClickListener(new AdapterView.OnItemLongClickListener() {
			@Override
			public boolean onItemLongClick(AdapterView<?> adapterView, View view, int position, long id) {
				if (!lista_usuario.get(position).getFk_id_rol().equals("3")) {
					usuarioSeleciondo = position;
					view.setSelected(true);
					startActivityForResult(new Intent(getActivity(), Activity_Privilegios.class), 1);
				} else {
					AlertDialog.Builder builder;
					if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
						builder = new AlertDialog.Builder(getContext(), android.R.style.ThemeOverlay_Material_Dialog_Alert);
					} else {
						builder = new AlertDialog.Builder(getContext());
					}
					builder.setTitle("Advertencia")
							.setMessage("Este usuario es un Administrador no puede sobreescribir sus privilegios")
							.setNegativeButton(android.R.string.no, new DialogInterface.OnClickListener() {
								public void onClick(DialogInterface dialog, int which) {
									// do nothing
								}
							})
							.setIcon(R.drawable.ic_menu_alerta)
							.show();
				}
				return true;
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
	
	@Override
	public void onActivityResult(int requestCode, int resultCode, Intent data) {
		super.onActivityResult(requestCode, resultCode, data);
		if (requestCode == 1) {
			if (resultCode == RESULT_OK) {
				getActivity().getSupportFragmentManager().beginTransaction().replace(R.id.flContent, new Fragment_AdministrarUsuarios()).addToBackStack(null).commit();
			}
		}
	}
	
	public interface OnFragmentInteractionListener {
		// TODO: Update argument type and name
		void onFragmentInteraction(Uri uri);
	}
	
	public class ContarUsuarios extends AsyncTask<Void, Boolean, Boolean> {
		String ciudadanos, trabajadores, administradores;
		
		@Override
		protected Boolean doInBackground(Void... voids) {
			ArrayList<NameValuePair> datatosend = new ArrayList<>();
			HttpParams httpRequestParams = HTTPPARAMS.GETHTTPREQUESTPARAMS();
			HttpClient client = new DefaultHttpClient(httpRequestParams);
			HttpPost post = new HttpPost(UserData.SERVER_ADDRESS + "ContarUsuarios.php");
			// ++ RESPONSE FROM SERVER ++
			HttpResponse httpResponse = null;
			String responsedecoded = "";
			
			try {
				post.setEntity(new UrlEncodedFormEntity(datatosend));
				httpResponse = client.execute(post);
				HttpEntity httpEntity = httpResponse.getEntity();
				responsedecoded = EntityUtils.toString(httpEntity, "UTF-8");
				JSONArray jsonArray = new JSONArray(responsedecoded);
				ciudadanos = jsonArray.getJSONObject(0).getString("C");
				trabajadores = jsonArray.getJSONObject(0).getString("T");
				administradores = jsonArray.getJSONObject(0).getString("A");
				return true;
			} catch (Exception e) {
				e.printStackTrace();
			}
			return false;
			
		}
		
		@Override
		protected void onPostExecute(final Boolean result) {
			if (result) {
				AdminCUser.setText(ciudadanos);
				AdminCWorker.setText(trabajadores);
				AdminCAdmin.setText(administradores);
			} else {
				
				AdminCUser.setText("0");
				AdminCWorker.setText("0");
				AdminCAdmin.setText("0");
				Snackbar.make(getView(), "No ha sido posible obtener su informacion", Snackbar.LENGTH_SHORT).show();
			}
			
		}
	}
	
	public class Usuarios extends AsyncTask<Void, Boolean, Boolean> {
		
		List<LosUsuarios> listausu;
		
		public Usuarios(List<LosUsuarios> listausu) {
			this.listausu = listausu;
		}
		
		@Override
		protected Boolean doInBackground(Void... voids) {
			ArrayList<NameValuePair> datatosend = new ArrayList<>();
			HttpParams httpRequestParams = HTTPPARAMS.GETHTTPREQUESTPARAMS();
			HttpClient client = new DefaultHttpClient(httpRequestParams);
			HttpPost post = new HttpPost(UserData.SERVER_ADDRESS + "JSONSelectAllCiudadanos.php");
			// ++ RESPONSE FROM SERVER ++
			HttpResponse httpResponse = null;
			String responsedecoded = "";
			
			try {
				post.setEntity(new UrlEncodedFormEntity(datatosend));
				httpResponse = client.execute(post);
				HttpEntity httpEntity = httpResponse.getEntity();
				responsedecoded = EntityUtils.toString(httpEntity, "UTF-8");
				JSONArray jsonArray = new JSONArray(responsedecoded);
				for (int i = 0; i < jsonArray.length(); i++) {
					LosUsuarios usuario = new LosUsuarios();
					usuario.setId_usuario(jsonArray.getJSONObject(i).getString("id"));
					usuario.setNombre(jsonArray.getJSONObject(i).getString("Nombre"));
					usuario.setApellidop(jsonArray.getJSONObject(i).getString("ApellidoP"));
					usuario.setNumeroext(jsonArray.getJSONObject(i).getString("NumeroExt"));
					usuario.setDireccion(jsonArray.getJSONObject(i).getString("Direccion"));
					usuario.setIdcolonia(jsonArray.getJSONObject(i).getString("IdColonia"));
					usuario.setSexo(jsonArray.getJSONObject(i).getString("Sexo"));
					usuario.setCorreoe(jsonArray.getJSONObject(i).getString("CorreoE"));
					usuario.setTelefono(jsonArray.getJSONObject(i).getString("Telefono"));
					usuario.setFechanac(jsonArray.getJSONObject(i).getString("fechaNac"));
					usuario.setFk_id_rol(jsonArray.getJSONObject(i).getString("fk_id_rol"));
					usuario.setImgurl(jsonArray.getJSONObject(i).getString("ImgURL"));
					listausu.add(usuario);
				}
				
				return true;
			} catch (Exception e) {
				e.printStackTrace();
			}
			return false;
			
		}
		
		@Override
		protected void onPostExecute(final Boolean result) {
			if (result) {
				adapter = new CustomListAdapter(getActivity(), lista_usuario);
				AdminCLista.setAdapter(adapter);
				AdminCLista.setTextFilterEnabled(true);
				AdminCSearch.addTextChangedListener(new TextWatcher() {
					@Override
					public void beforeTextChanged(CharSequence charSequence, int i, int i1, int i2) {
					
					}
					
					@Override
					public void onTextChanged(CharSequence charSequence, int i, int i1, int i2) {
						int textlength = charSequence.length();
						List<LosUsuarios> lista_temporal = new ArrayList<LosUsuarios>();
						for (LosUsuarios usuario : lista_usuario) {
							if (textlength <= usuario.getCorreoe().length()) {
								if (usuario.getCorreoe().toLowerCase().contains(charSequence.toString().toLowerCase())) {
									lista_temporal.add(usuario);
								}
							}
						}
						adapter = new CustomListAdapter(getActivity(), lista_temporal);
						AdminCLista.setAdapter(adapter);
					}
					
					@Override
					public void afterTextChanged(Editable editable) {
					
					}
				});
			} else {
				Snackbar.make(getView(), "No ha sido posible obtener su informacion", Snackbar.LENGTH_SHORT).show();
			}
			
		}
	}
	
	private class CustomListAdapter extends BaseAdapter {
		
		ImageLoader imageLoader = VolleySingleton.getInstance().getImageLoader();
		private LayoutInflater inflater;
		private Activity activity;
		private List<LosUsuarios> Users;
		
		public CustomListAdapter(Activity activity, List<LosUsuarios> users) {
			this.activity = activity;
			Users = users;
		}
		
		@Override
		public int getCount() {
			return Users.size();
		}
		
		@Override
		public Object getItem(int i) {
			return Users.get(i);
		}
		
		@Override
		public long getItemId(int i) {
			return i;
		}
		
		@Override
		public View getView(int i, View view, ViewGroup viewGroup) {
			if (inflater == null) inflater = (LayoutInflater) activity.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
			
			if (view == null) view = inflater.inflate(R.layout.itemusuario, null);
			
			if (imageLoader == null) imageLoader = VolleySingleton.getInstance().getImageLoader();
			
			NetworkImageView itemusuarioimg = view.findViewById(R.id.itemusuarioimg);
			TextView itemusuarioname = view.findViewById(R.id.itemusuarioname);
			TextView itemusuariocorreo = view.findViewById(R.id.itemusuariocorreo);
			TextView itemusuariotelefono = view.findViewById(R.id.itemusuariotelefono);
			TextView itemusuariorol = view.findViewById(R.id.itemusuariorol);
			
			LosUsuarios m = Users.get(i);
			
			itemusuarioimg.setImageUrl(UserData.SERVER_ADDRESS + m.getImgurl(), imageLoader);
			itemusuarioname.setText(m.getNombre() + " " + m.getApellidop());
			itemusuariocorreo.setText(m.getCorreoe());
			itemusuariotelefono.setText(m.getTelefono());
			
			if (m.getFk_id_rol().equals("1")) {
				itemusuariorol.setText("Ciudadano");
			}
			if (m.getFk_id_rol().equals("2")) {
				itemusuariorol.setText("Trabajador");
			}
			if (m.getFk_id_rol().equals("3")) {
				itemusuariorol.setText("Administrador");
			}
			
			
			return view;
		}
	}
}
