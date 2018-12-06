package com.Mezda.SIMAC.Fragments;

import android.Manifest;
import android.annotation.SuppressLint;
import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.ClipData;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.drawable.BitmapDrawable;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Build;
import android.os.Bundle;
import android.os.Environment;
import android.os.StrictMode;
import android.provider.MediaStore;
import android.support.annotation.Nullable;
import android.support.v4.app.ActivityCompat;
import android.support.v4.app.Fragment;
import android.support.v4.content.ContextCompat;
import android.support.v4.content.FileProvider;
import android.util.Base64;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.EditText;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

import com.Mezda.SIMAC.Activitys.Activity_Maps;
import com.Mezda.SIMAC.Methods.HTTPPARAMS;
import com.Mezda.SIMAC.R;

import com.Mezda.SIMAC.UserData;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.MapView;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.params.HttpParams;
import org.apache.http.protocol.BasicHttpContext;
import org.apache.http.protocol.HttpContext;
import org.apache.http.util.EntityUtils;
import org.json.JSONArray;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Objects;

import static android.app.Activity.RESULT_OK;
import static com.Mezda.SIMAC.Methods.SharedPreference.GETSharedPreferences;


/**
 * A simple {@link Fragment} subclass.
 * Activities that contain this fragment must implement the
 * {@link Fragment_Reportar.OnFragmentInteractionListener} interface
 * to handle interaction events.
 * Use the {@link Fragment_Reportar#newInstance} factory method to
 * create an instance of this fragment.
 */
public class Fragment_Reportar extends Fragment {
	
	private static final String ARG_PARAM1 = "param1";
	private static final String ARG_PARAM2 = "param2";
	
	private static final int REQUEST_CAMARA_WRITE_PER = 2398;
	public static TextView Reporte_Longitud, Reporte_Latitud, Reporte_direccionMaps;
	String mCurrentPhotoPath;
	File image;
	OutputStream outputStream = null;
	TextView Reporte_Nombre, Reporte_Correo, Reporte_Direccion, Reporte_Fecha;
	EditText Reporte_Descripcion, Reporte_DireccionA, Reporte_PReferencia, Reporte_SReferencia;
	ImageView Reporte_Evidencia, Reporte_TomarFoto, Reporte_Galeria, Reporte_GoogleMaps;
	ImageButton Reporte_Enviar;
	Spinner Reporte_SColonia;
	Intent cameraIntent;
	Uri imageUri;
	ArrayAdapter<CharSequence> langAdapter;
	String[] GetColonias, GetColoniasId;
	String date;
	Integer REQUEST_LOCATION = 2431;
	MapView mapView;
	GoogleMap map;
	private String mParam1;
	private String mParam2;
	private OnFragmentInteractionListener mListener;
	
	public Fragment_Reportar() {
		// Required empty public constructor
	}
	
	public static Fragment_Reportar newInstance(String param1, String param2) {
		Fragment_Reportar fragment = new Fragment_Reportar();
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
		View v = inflater.inflate(R.layout.fragment_reportar, container, false);
		
		return v;
	}
	
	@Override
	public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
		super.onViewCreated(view, savedInstanceState);
		iniciate();
		Reporte_Nombre.setText(GETSharedPreferences("Nombre", ""));
		Reporte_Correo.setText(GETSharedPreferences("Correo", ""));
		Date c = Calendar.getInstance().getTime();
		SimpleDateFormat df = new SimpleDateFormat("dd-MMM-yyyy");
		date = df.format(c);
		Reporte_Fecha.setText(date);
		
		TomarFotoonclick();
		MapOpen();
		new Spinnerfill(getView()).execute();
//        int item =spinner.getSelectedItemPosition();
		Send_Information();
		
	}
	
	private void iniciate() {
		Reporte_Nombre = getActivity().findViewById(R.id.Reporte_Nombre);
		Reporte_Correo = getActivity().findViewById(R.id.Reporte_Correo);
		Reporte_Direccion = getActivity().findViewById(R.id.Reporte_Direccion);
		Reporte_Fecha = getActivity().findViewById(R.id.Reporte_Fecha);
		
		Reporte_Descripcion = getActivity().findViewById(R.id.Reporte_Descripcion);
		Reporte_DireccionA = getActivity().findViewById(R.id.Reporte_DireccionA);
		Reporte_SColonia = (Spinner) getActivity().findViewById(R.id.Reporte_SColonia);
		Reporte_PReferencia = getActivity().findViewById(R.id.Reporte_PReferencia);
		Reporte_SReferencia = getActivity().findViewById(R.id.Reporte_SReferencia);
		
		Reporte_Evidencia = (ImageView) getActivity().findViewById(R.id.Reporte_Evidencia);
		Reporte_TomarFoto = getActivity().findViewById(R.id.Reporte_TomarFoto);
		Reporte_Galeria = getActivity().findViewById(R.id.Reporte_Galeria);
		
		Reporte_direccionMaps = getActivity().findViewById(R.id.Reporte_direccionMaps);
		Reporte_Latitud = getActivity().findViewById(R.id.Reporte_Latitud);
		Reporte_Longitud = getActivity().findViewById(R.id.Reporte_Longitud);
		Reporte_GoogleMaps = getActivity().findViewById(R.id.Reporte_GoogleMaps);
		
		Reporte_Enviar = getActivity().findViewById(R.id.Reporte_Enviar);
	}
	
	private void TomarFotoonclick() {

        /*Reporte_TomarFoto.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                StrictMode.VmPolicy.Builder builder = new StrictMode.VmPolicy.Builder();
                StrictMode.setVmPolicy(builder.build());
                if (getcamara()){
                    String timeStamp = new SimpleDateFormat("yyyyMMdd_HHmmss").format(new Date());
                    File file = new File(getExternalStoragePublicDirectory(Environment.DIRECTORY_PICTURES), "/photo_" + timeStamp + ".png");
                    imageUri = Uri.fromFile(file);

                    cameraIntent = new Intent(android.provider.MediaStore.ACTION_IMAGE_CAPTURE);
                    cameraIntent.putExtra(MediaStore.EXTRA_SCREEN_ORIENTATION, ActivityInfo.SCREEN_ORIENTATION_LANDSCAPE);
                    cameraIntent.putExtra(MediaStore.EXTRA_OUTPUT, imageUri);
                    startActivityForResult(cameraIntent, 2356);
                }else{
                    Snackbar.make(getView(),"Porfavor vuelva a intentarlo",Snackbar.LENGTH_SHORT).show();
                }
            }
        });*/
		Reporte_TomarFoto.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				StrictMode.VmPolicy.Builder builder = new StrictMode.VmPolicy.Builder();
				StrictMode.setVmPolicy(builder.build());
				if (Reporte_Evidencia.getDrawable() == null) {
					getcamara();
				} else {
					final android.app.AlertDialog.Builder alerBuilder1 = new android.app.AlertDialog.Builder(getContext());
					alerBuilder1.setMessage("Desea recapturar la imagen?")
							.setTitle("Aviso")
							.setCancelable(false)
							.setPositiveButton(android.R.string.ok, new DialogInterface.OnClickListener() {
								@Override
								public void onClick(DialogInterface dialog, int which) {
									Toast.makeText(getContext(), "Obteniendo Camara", Toast.LENGTH_SHORT).show();
									getcamara();
								}
							})
							.setNegativeButton(android.R.string.cancel, null).show();
					alerBuilder1.create();
				}
			}
		});
		Reporte_Galeria.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View view) {
				agarrarnuevaimage();
			}
		});
		
	}
	
	private void MapOpen() {
		Reporte_GoogleMaps.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View view) {
				permisoubicacion();
			}
		});
	}
	
	private void Send_Information() {
		Reporte_Enviar.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View view) {
				
				if (Reporte_Descripcion.getText().toString().isEmpty() ||
						Reporte_DireccionA.getText().toString().isEmpty() || Reporte_Evidencia.getDrawable() == null || Reporte_Longitud.getText().toString().isEmpty()) {
					
					final AlertDialog.Builder builder = new AlertDialog.Builder(getActivity());
					builder.setMessage("Se Requiere minimo una: \n\n- Descripción \n- Dirección \n- Evidencia \n- Ubicación")
							.setTitle("Estado")
							.setCancelable(false)
							.setPositiveButton(android.R.string.ok, null);
					AlertDialog dialog = builder.create();
					dialog.show();
					
				} else {
					
					Bitmap image = ((BitmapDrawable) Reporte_Evidencia.getDrawable()).getBitmap();
					int item = Reporte_SColonia.getSelectedItemPosition();
					new SendAplication(
							image,
							GETSharedPreferences("ID", ""),
							GetColoniasId[item],
							Reporte_Descripcion.getText().toString(),
							Reporte_DireccionA.getText().toString(),
							Reporte_PReferencia.getText().toString(),
							Reporte_SReferencia.getText().toString(),
							date,
							image.toString(),
							Reporte_Longitud.getText().toString(),
							Reporte_Latitud.getText().toString()
					).execute();
					
				}
				
				
			}
		});
	}
	
	
	private void agarrarnuevaimage() {
		StrictMode.VmPolicy.Builder builder = new StrictMode.VmPolicy.Builder();
		StrictMode.setVmPolicy(builder.build());
		Intent getIntent = new Intent(Intent.ACTION_GET_CONTENT);
		getIntent.setType("image/*");
		Intent pickIntent = new Intent(Intent.ACTION_PICK, android.provider.MediaStore.Images.Media.EXTERNAL_CONTENT_URI);
		pickIntent.setType("image/*");
		Intent chooserIntent = Intent.createChooser(getIntent, "Select Image");
		chooserIntent.putExtra(Intent.EXTRA_INITIAL_INTENTS, new Intent[]{pickIntent});
		startActivityForResult(Intent.createChooser(chooserIntent, "Nueva Foto de Perfil"), 1315);
	}
	
	
	@Override
	public void onActivityResult(int requestCode, int resultCode, Intent data) {
		super.onActivityResult(requestCode, resultCode, data);
		if (requestCode == REQUEST_CAMARA_WRITE_PER && resultCode == RESULT_OK) {
//            Bundle extras = data.getExtras();
//            Bitmap imageBitmap = (Bitmap) extras.get("data");
//            Main_Evidencia.setImageBitmap(imageBitmap);
			setPic();
		}
		if (requestCode == 0 && resultCode == RESULT_OK) {
			dispatchTakePictureIntent();
		}
		if (requestCode == 2356 && resultCode == RESULT_OK) {
			try {
				Bitmap thumbnail = MediaStore.Images.Media.getBitmap(getActivity().getContentResolver(), imageUri);
				Reporte_Evidencia.setImageBitmap(thumbnail);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		if (requestCode == 1315 && resultCode == RESULT_OK) {
			if (data == null) {
				return;
			}
			try {
				InputStream inputStream = getContext().getContentResolver().openInputStream(data.getData());
				Bitmap maped = BitmapFactory.decodeStream(new BufferedInputStream(inputStream));
                /*Bitmap dstBmp;
                if (maped.getWidth() >= maped.getHeight()){
                    dstBmp = Bitmap.createBitmap(maped,maped.getWidth()/2-maped.getHeight()/2,0,maped.getHeight(),maped.getHeight());
                }else{
                    dstBmp = Bitmap.createBitmap(maped,0,maped.getHeight()/2-maped.getWidth()/2,maped.getWidth(),maped.getWidth());
                }*/
//                imagen_camara.setImageBitmap(getCroppedBitmap(dstBmp));
				Reporte_Evidencia.setImageBitmap(maped);
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			}
		}
		if (requestCode == REQUEST_LOCATION && requestCode == RESULT_OK) {
			permisoubicacion();
		}
		
	}
	
	
	private void permisoubicacion() {
		if (ContextCompat.checkSelfPermission(getActivity(), Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED
				&&
				ContextCompat.checkSelfPermission(getActivity(), Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
			ActivityCompat.requestPermissions(getActivity(), new String[]{Manifest.permission.ACCESS_FINE_LOCATION, Manifest.permission.ACCESS_COARSE_LOCATION}, REQUEST_LOCATION);
		} else {
			Activity_Maps.opcion = 2;
			startActivity(new Intent(getActivity(), Activity_Maps.class));
		}
	}
	
	public void fill() {
		langAdapter = new ArrayAdapter<CharSequence>(getActivity(), R.layout.spinner_text, GetColonias);
		langAdapter.setDropDownViewResource(R.layout.simple_spinner_dropdown);
		Reporte_SColonia.setAdapter(langAdapter);
	}
	
	/*boolean getcamara(){
		if (ContextCompat.checkSelfPermission(getActivity(), android.Manifest.permission.CAMERA) != PackageManager.PERMISSION_GRANTED){
			ActivityCompat.requestPermissions(getActivity(),new String[]{
					android.Manifest.permission.CAMERA,
					android.Manifest.permission.WRITE_EXTERNAL_STORAGE,
					Manifest.permission.READ_EXTERNAL_STORAGE
			},0);
			return false;
		}else  {
			return true;
		}
	}
*/
	private void getcamara() {
		if (ContextCompat.checkSelfPermission(getActivity(), Manifest.permission.CAMERA) != PackageManager.PERMISSION_GRANTED) {
			ActivityCompat.requestPermissions(getActivity(), new String[]{
					Manifest.permission.CAMERA,
					Manifest.permission.WRITE_EXTERNAL_STORAGE,
					Manifest.permission.READ_EXTERNAL_STORAGE
			}, REQUEST_CAMARA_WRITE_PER);
		} else {
			dispatchTakePictureIntent();
		}
	}
	
	private void dispatchTakePictureIntent() {
		Intent takePictureIntent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
		
		if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
			if (takePictureIntent.resolveActivity(Objects.requireNonNull(getActivity()).getPackageManager()) != null) {
				File photoFile = null;
				try {
					photoFile = createImageFile();
				} catch (IOException e) {
					e.printStackTrace();
				}
				if (photoFile != null) {
					Uri photoURI = FileProvider.getUriForFile(getContext(), getResources().getString(R.string.ruta_interna) , photoFile);
					takePictureIntent.putExtra(MediaStore.EXTRA_OUTPUT, photoURI);
					if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN) {
						takePictureIntent.setClipData(ClipData.newRawUri("", photoURI));
					}
					takePictureIntent.addFlags(Intent.FLAG_GRANT_WRITE_URI_PERMISSION | Intent.FLAG_GRANT_READ_URI_PERMISSION);
					
					startActivityForResult(takePictureIntent, REQUEST_CAMARA_WRITE_PER);
				}
			}
		}
	}
	
	private File createImageFile() throws IOException {
		@SuppressLint("SimpleDateFormat") String timestamp = new SimpleDateFormat("yyyyMMdd_HHmmss").format(new Date());
		String imageFileName = "Prep2018_" + timestamp + "_";
		File storageDir = null;
		if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.KITKAT) {
			storageDir = (Objects.requireNonNull(getActivity())).getExternalFilesDir(Environment.DIRECTORY_PICTURES);
		}
		
		image = File.createTempFile(imageFileName, ".jpg", storageDir);
		mCurrentPhotoPath = image.getAbsolutePath();
		return image;
	}
	
	private void setPic() {
		//TODO: Get the dimensions of the view;
		int targetWidth = 550;
//                Main_Evidencia.getWidth();
		int targetHeight = 550;
//                Main_Evidencia.getHeight();
		//TODO: Get the dimensions of the bitmap
		BitmapFactory.Options bmOptions = new BitmapFactory.Options();
		bmOptions.inJustDecodeBounds = true;
		BitmapFactory.decodeFile(mCurrentPhotoPath, bmOptions);
		int photoWidth = bmOptions.outWidth;
		int photoheight = bmOptions.outHeight;
		
		//TODO: Determine how much to scale down the image
		int scaleFactor = Math.min(photoWidth / targetWidth, photoheight / targetHeight);
		
		//TODO: Decode the image file into a Bitmap sized to fill the view
		bmOptions.inJustDecodeBounds = false;
		bmOptions.inSampleSize = scaleFactor;
		bmOptions.inPurgeable = true;
		
		try {
			int m_compress = 50;
			Bitmap bitmap = BitmapFactory.decodeFile(mCurrentPhotoPath, bmOptions);
			outputStream = new FileOutputStream(image);
			bitmap.compress(Bitmap.CompressFormat.JPEG, m_compress, outputStream);
			Reporte_Evidencia.setImageBitmap(bitmap);
			outputStream.flush();
			outputStream.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
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
	
	private class Spinnerfill extends AsyncTask<Void, Boolean, Boolean> {
		int STATUS = 0;
		private View ROOTVIEW;
		
		public Spinnerfill(View ROOTVIEW) {
			this.ROOTVIEW = ROOTVIEW;
		}
		
		@Override
		protected Boolean doInBackground(Void... voids) {
			// ++ ARRAY DE PARAMETROS QUE VAS A MANDAR AL WEB SERVICE ++
			ArrayList<NameValuePair> datatosend = new ArrayList<>();
			
			// ++ CONECCION PARA MANDAR LOS PARAMETROS ++
			HttpParams httpRequestParams = HTTPPARAMS.GETHTTPREQUESTPARAMS();
			HttpClient client = new DefaultHttpClient(httpRequestParams);
			HttpPost post = new HttpPost(UserData.SERVER_ADDRESS + "JSONSelectColonia.php");
			
			// ++ RESPONSE FROM SERVER ++
			HttpResponse httpResponse = null;
			String responsedecoded = "";
			
			try {
				post.setEntity(new UrlEncodedFormEntity(datatosend));
				httpResponse = client.execute(post);
				HttpEntity httpEntity = httpResponse.getEntity();
				responsedecoded = EntityUtils.toString(httpEntity, "UTF-8");
				JSONArray jsonArray = new JSONArray(responsedecoded);
				GetColonias = new String[jsonArray.length()];
				GetColoniasId = new String[jsonArray.length()];
				for (int i = 0; i < jsonArray.length(); i++) {
					GetColoniasId[i] = jsonArray.getJSONObject(i).getString("Id");
					GetColonias[i] = jsonArray.getJSONObject(i).getString("Colonia");
				}
				STATUS = 1;
			} catch (Exception e) {
				e.printStackTrace();
			}
			if (STATUS == 1) {
				return true;
			} else {
				return false;
			}
		}
		
		@Override
		protected void onPostExecute(final Boolean result) {
			if (result) {
				Reporte_SColonia.setClickable(true);
				fill();
				//Snackbar.make(ROOTVIEW,"Exito",Snackbar.LENGTH_LONG).show();
				//startActivity(new Intent(Activity_Registrar.this,Activity_Main.class));
				//finish();
			} else {
				//Snackbar.make(ROOTVIEW,"Usuario/Contraseña Incorrecto",Snackbar.LENGTH_LONG).show();
				
			}
		}
	}
	
	private class SendAplication extends AsyncTask<Void, Boolean, Boolean> {
		String falla;
		Bitmap image;
		String id_user, id_colony, problem, address, firstreference, secondreference, dated_time, image_url;
		String longitud, latitud;
		ProgressDialog progressDialog;
		
		public SendAplication(Bitmap image, String id_user, String id_colony, String problem, String address, String firstreference, String secondreference, String dated_time, String image_url, String longitud, String latitud) {
			this.image = image;
			this.id_user = id_user;
			this.id_colony = id_colony;
			this.problem = problem;
			this.address = address;
			this.firstreference = firstreference;
			this.secondreference = secondreference;
			this.dated_time = dated_time;
			this.image_url = image_url;
			this.longitud = longitud;
			this.latitud = latitud;
		}
		
		@Override
		protected void onPreExecute() {
			super.onPreExecute();
			progressDialog = new ProgressDialog(getActivity());
			progressDialog.setMessage("Subiendo Informacion...");
			progressDialog.setCancelable(false);
			progressDialog.show();
		}
		
		@Override
		protected Boolean doInBackground(Void... voids) {
			ByteArrayOutputStream os = new ByteArrayOutputStream();
			image.compress(Bitmap.CompressFormat.JPEG, 100, os);
			String encodedimage = Base64.encodeToString(os.toByteArray(), Base64.DEFAULT);
			
			HttpClient httpc = new DefaultHttpClient();
			HttpContext localc = new BasicHttpContext();
			HttpPost httppost = new HttpPost(UserData.SERVER_ADDRESS + "JSONInsertSolicitud.php");
			HttpResponse response = null;
			String res = null;
			
			try {
				
				List<NameValuePair> params = new ArrayList<NameValuePair>();
				params.add(new BasicNameValuePair("fk_id_ciudadano", id_user));
				params.add(new BasicNameValuePair("fk_id_colonia", id_colony));
				params.add(new BasicNameValuePair("problema", problem));
				params.add(new BasicNameValuePair("direccion", address));
				params.add(new BasicNameValuePair("referencia1", firstreference));
				params.add(new BasicNameValuePair("referencia2", secondreference));
				params.add(new BasicNameValuePair("fecha", dated_time));
				params.add(new BasicNameValuePair("urlimagen", image_url));
				params.add(new BasicNameValuePair("image", encodedimage));
				params.add(new BasicNameValuePair("longitud", longitud));
				params.add(new BasicNameValuePair("latitud", latitud));
				
				httppost.setEntity(new UrlEncodedFormEntity(params));
				
				response = httpc.execute(httppost, localc);
				HttpEntity entity = response.getEntity();
				res = EntityUtils.toString(entity, "UTF-8");
				
				JSONArray jsonArray = new JSONArray(res);
				String Contrasena = jsonArray.getJSONObject(0).getString("EXITO");
				if (Contrasena.equals("SI")) {
					return true;
				} else {
					falla = Contrasena;
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			return false;
		}
		
		@Override
		protected void onPostExecute(Boolean aBoolean) {
			super.onPostExecute(aBoolean);
			if (aBoolean) {
				progressDialog.dismiss();
				//success!
				final AlertDialog.Builder builder = new AlertDialog.Builder(getActivity());
				builder.setMessage("Solicitud Realizado Exitosamente")
						.setTitle("Estado")
						.setCancelable(false)
						.setPositiveButton(android.R.string.ok, new DialogInterface.OnClickListener() {
							@Override
							public void onClick(DialogInterface dialogInterface, int i) {
								getActivity().getSupportFragmentManager().beginTransaction().replace(R.id.ReportarContent, new Fragment_MisReporte()).addToBackStack(null).commit();
							}
						});
				AlertDialog dialog = builder.create();
				dialog.show();
			} else {
				progressDialog.dismiss();
				//success!
				final AlertDialog.Builder builder = new AlertDialog.Builder(getActivity());
				builder.setMessage("Solicitud Fallida Intente Mas Tarde")
						.setTitle("Estado")
						.setCancelable(false)
						.setPositiveButton(android.R.string.ok, null);
				AlertDialog dialog = builder.create();
				dialog.show();
			}
		}
	}
}
