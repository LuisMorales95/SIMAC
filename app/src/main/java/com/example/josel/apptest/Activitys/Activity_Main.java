package com.example.josel.apptest.Activitys;


import android.annotation.SuppressLint;
import android.app.Activity;
import android.app.ProgressDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.PorterDuff;
import android.graphics.PorterDuffXfermode;
import android.graphics.Rect;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Bundle;
import android.os.Handler;
import android.os.StrictMode;
import android.support.design.widget.NavigationView;
import android.support.design.widget.Snackbar;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.view.GravityCompat;
import android.support.v4.widget.DrawerLayout;
import android.support.v7.app.ActionBarDrawerToggle;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import com.android.volley.toolbox.ImageLoader;
import com.android.volley.toolbox.NetworkImageView;
import com.example.josel.apptest.Fragments.Fragment_AdministrarUsuarios;
import com.example.josel.apptest.Fragments.Fragment_Alcalde;
import com.example.josel.apptest.Fragments.Fragment_AlertC;
import com.example.josel.apptest.Fragments.Fragment_AtencionC;
import com.example.josel.apptest.Fragments.Fragment_Emergencia;
import com.example.josel.apptest.Fragments.Fragment_Empty;
import com.example.josel.apptest.Fragments.Fragment_FacturaE;
import com.example.josel.apptest.Fragments.Fragment_Login;
import com.example.josel.apptest.Fragments.Fragment_MisReporte;
import com.example.josel.apptest.Fragments.Fragment_Noticias;
import com.example.josel.apptest.Fragments.Fragment_Predial;
import com.example.josel.apptest.Fragments.Fragment_Reportar;
import com.example.josel.apptest.Fragments.Fragment_Reporte;
import com.example.josel.apptest.Fragments.Fragment_Turista;
import com.example.josel.apptest.Methods.HTTPPARAMS;
import com.example.josel.apptest.Methods.UpdateToken;
import com.example.josel.apptest.Methods.VolleySingleton;
import com.example.josel.apptest.R;
import com.example.josel.apptest.UserData;

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

import java.io.BufferedInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.util.ArrayList;

import cn.pedant.SweetAlert.SweetAlertDialog;

import static com.example.josel.apptest.Methods.SharedPreference.GETSharedPreferences;
import static com.example.josel.apptest.Methods.SharedPreference.SETSharedPreferences;
import static com.example.josel.apptest.Methods.VolleySingleton.SuperContext;


public class Activity_Main extends AppCompatActivity implements NavigationView.OnNavigationItemSelectedListener, Fragment_FacturaE.OnFragmentInteractionListener, Fragment_AlertC.OnFragmentInteractionListener,
		Fragment_AtencionC.OnFragmentInteractionListener, Fragment_Alcalde.OnFragmentInteractionListener, Fragment_Noticias.OnFragmentInteractionListener, Fragment_Predial.OnFragmentInteractionListener,
		Fragment_Turista.OnFragmentInteractionListener, Fragment_Emergencia.OnFragmentInteractionListener, Fragment_Login.OnFragmentInteractionListener, Fragment_AdministrarUsuarios.OnFragmentInteractionListener,
		Fragment_Reporte.OnFragmentInteractionListener, Fragment_Reportar.OnFragmentInteractionListener, Fragment_MisReporte.OnFragmentInteractionListener,
		Fragment_Empty.OnFragmentInteractionListener {
	
	public static NetworkImageView Userimage;
	public static TextView header_name;
	public static TextView header_email;
	public static NavigationView navigationView;
	public static AsyncTask task;
	public static Activity main;
	FragmentManager fragmentManager = getSupportFragmentManager();
	private Bundle bundle;
	
	public static void ocultar_campos() {
		if (GETSharedPreferences("Rol", "").equals("1") || GETSharedPreferences("Rol", "").isEmpty()) {
			navigationView.getMenu().getItem(1).setVisible(false);
		} else {
			navigationView.getMenu().getItem(1).setVisible(true);
		}
		if (GETSharedPreferences("TOKEN", "").isEmpty()) {
			navigationView.getMenu().getItem(9).setVisible(false);
		} else {
			navigationView.getMenu().getItem(9).setVisible(true);
			
		}
	}
	
	@SuppressLint("StaticFieldLeak")
	@Override
	protected void onCreate(final Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		bundle = savedInstanceState;
		setContentView(R.layout.activity_main);
		main = this;
		new IniciarApp().execute();
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
		startActivityForResult(Intent.createChooser(chooserIntent, "Nueva Foto de Perfil"), 1304);
	}
	
	@Override
	protected void onActivityResult(int requestCode, int resultCode, Intent data) {
		super.onActivityResult(requestCode, resultCode, data);
		if (requestCode == 1304 && resultCode == RESULT_OK) {
			if (data == null) {
				return;
			}
			try {
				InputStream inputStream = getApplicationContext().getContentResolver().openInputStream(data.getData());
				Bitmap maped = BitmapFactory.decodeStream(new BufferedInputStream(inputStream));
				Bitmap dstBmp;
				if (maped.getWidth() >= maped.getHeight()) {
					dstBmp = Bitmap.createBitmap(maped, maped.getWidth() / 2 - maped.getHeight() / 2, 0, maped.getHeight(), maped.getHeight());
				} else {
					dstBmp = Bitmap.createBitmap(maped, 0, maped.getHeight() / 2 - maped.getWidth() / 2, maped.getWidth(), maped.getWidth());
				}
				Userimage.setImageBitmap(getCroppedBitmap(dstBmp));
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			}
			Toast.makeText(getBaseContext(), "obtuvo imagen", Toast.LENGTH_LONG).show();
		}
	}
	
	private Bitmap getCroppedBitmap(Bitmap bitmap) {
		Bitmap output = Bitmap.createBitmap(bitmap.getWidth(),
				bitmap.getHeight(), Bitmap.Config.ARGB_8888);
		Canvas canvas = new Canvas(output);
		
		final int color = 0xff424242;
		final Paint paint = new Paint();
		final Rect rect = new Rect(0, 0, bitmap.getWidth(), bitmap.getHeight());
		
		paint.setAntiAlias(true);
		canvas.drawARGB(0, 0, 0, 0);
		paint.setColor(color);
		// canvas.drawRoundRect(rectF, roundPx, roundPx, paint);
		canvas.drawCircle(bitmap.getWidth() / 2, bitmap.getHeight() / 2, bitmap.getWidth() / 2, paint);
		paint.setXfermode(new PorterDuffXfermode(PorterDuff.Mode.SRC_IN));
		canvas.drawBitmap(bitmap, rect, rect, paint);
		//Bitmap _bmp = Bitmap.createScaledBitmap(output, 60, 60, false);
		//return _bmp;
		return output;
	}
	
	@Override
	public void onBackPressed() {
		DrawerLayout drawer = (DrawerLayout) findViewById(R.id.drawer_layout);
		if (drawer.isDrawerOpen(GravityCompat.START)) {
			drawer.closeDrawer(GravityCompat.START);
		} else {
			new AlertDialog.Builder(this)
					.setIcon(android.R.drawable.ic_dialog_alert)
					.setTitle("Cerrando Aplicacion")
					.setMessage("Desea cerrar la aplicación?")
					.setPositiveButton("Si", new DialogInterface.OnClickListener() {
						@Override
						public void onClick(DialogInterface dialog, int which) {
							finish();
						}
						
					})
					.setNegativeButton("No", null)
					.show();
			//          super.onBackPressed();
		}
	}
	
	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		if (GETSharedPreferences("TOKEN", "").equals("")) {
			getMenuInflater().inflate(R.menu.iniciasesion, menu);
		} else if (GETSharedPreferences("Rol", "").equals("3")) {
			getMenuInflater().inflate(R.menu.main, menu);
		}
		
		return true;
	}
	
	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		int id = item.getItemId();
		
		if (id == R.id.Administar_Usuarios) {
//            TODO: agregar funciones
			getSupportActionBar().setTitle(item.getTitle());
			Fragment_AdministrarUsuarios fragmentAdministrarUsuarios = new Fragment_AdministrarUsuarios();
			this.getSupportFragmentManager().beginTransaction().replace(R.id.flContent, fragmentAdministrarUsuarios).addToBackStack(null).commit();
		} else if (id == R.id.Inicia_Sesión) {
			getSupportActionBar().setTitle(item.getTitle());
			Fragment_Login fragmentLogin = new Fragment_Login();
			this.getSupportFragmentManager().beginTransaction().replace(R.id.flContent, fragmentLogin).addToBackStack(null).commit();
		}
		
		return super.onOptionsItemSelected(item);
	}
	
	@SuppressWarnings("StatementWithEmptyBody")
	@Override
	public boolean onNavigationItemSelected(final MenuItem item) {
		final int id = item.getItemId();
		new Handler().postDelayed(new Runnable() {
			@Override
			public void run() {
				// Handle navigation view item clicks here.
				Fragment fragment = null;
				Class fragmenteclass = null;
				
				if (id == R.id.Alertas) {
					fragmenteclass = Fragment_AtencionC.class;
					getSupportActionBar().setTitle(item.getTitle());
					
				} else if (id == R.id.Alertar_Ciudadania) {
//                    fragmenteclass = Fragment_AlertC.class;
					if (!GETSharedPreferences("TOKEN", "").isEmpty()) {
						fragmenteclass = Fragment_AlertC.class;
						getSupportActionBar().setTitle(item.getTitle());
					} else {
						Snackbar.make(getCurrentFocus(), "Necesita Iniciar sesión", Snackbar.LENGTH_SHORT).show();
					}
				} else if (id == R.id.Danos_tu_reporte) {
					if (!GETSharedPreferences("TOKEN", "").isEmpty()) {
						fragmenteclass = Fragment_Reporte.class;
						
						getSupportActionBar().setTitle(item.getTitle());
					} else {
						Snackbar.make(getCurrentFocus(), "Necesita Iniciar sesión", Snackbar.LENGTH_SHORT).show();
					}
				} else if (id == R.id.FacturaElectronica) {
					fragmenteclass = Fragment_Empty.class;
					getSupportActionBar().setTitle(item.getTitle());
//                    fragmenteclass = Fragment_FacturaE.class;
				
				} else if (id == R.id.consulta_predial) {

//                    fragmenteclass = Fragment_Predial.class;
					fragmenteclass = Fragment_Empty.class;
					getSupportActionBar().setTitle(item.getTitle());
					
				} else if (id == R.id.noticias) {
					
					fragmenteclass = Fragment_Noticias.class;
					getSupportActionBar().setTitle(item.getTitle());
					
				} else if (id == R.id.Turismo) {
					
					fragmenteclass = Fragment_Turista.class;
					getSupportActionBar().setTitle(item.getTitle());
					
				} else if (id == R.id.CoAlcalde) {
					
					fragmenteclass = Fragment_Empty.class;
					getSupportActionBar().setTitle(item.getTitle());
//                    fragmenteclass = Fragment_Alcalde.class;
				
				} else if (id == R.id.NumEmergencia) {
					getSupportActionBar().setTitle(item.getTitle());
					fragmenteclass = Fragment_Emergencia.class;
					
				} else if (id == R.id.cerrar_Sesion) {
					final int[] option = {0};
//                    if (preferences.getString("TOKEN","").equals("")){
					DialogInterface.OnClickListener dialogClickListener = new DialogInterface.OnClickListener() {
						@Override
						public void onClick(DialogInterface dialog, int which) {
							switch (which) {
								case DialogInterface.BUTTON_POSITIVE:
									new UpdateToken("").execute();
									final android.app.AlertDialog.Builder builder = new android.app.AlertDialog.Builder(Activity_Main.this);
									builder.setMessage("¡Has cerrado tu sesion exitosamente! \n   Te esperamos pronto. ")
											.setTitle("Estado")
											.setCancelable(false)
											.setPositiveButton(android.R.string.ok, new DialogInterface.OnClickListener() {
												@Override
												public void onClick(DialogInterface dialogInterface, int i) {
                                                        /*SharedPreferences.Editor editor = preferences.edit();
                                                        editor.putString("TOKEN", "");
                                                        editor.putString("IMGUSU", "");
                                                        editor.putString("ID", "");
                                                        editor.putString("Nombre", "");
                                                        editor.putString("Correo", "");
                                                        editor.putString("Rol", "");
                                                        editor.apply();*/
													SETSharedPreferences("TOKEN", "");
													SETSharedPreferences("IMGUSU", "");
													SETSharedPreferences("ID", "");
													SETSharedPreferences("Nombre", "");
													SETSharedPreferences("Correo", "");
													SETSharedPreferences("Rol", "");
													
													invalidateOptionsMenu();
													ocultar_campos();
													ImageLoader imageLoader = VolleySingleton.getInstance().getImageLoader();
													if (imageLoader == null) imageLoader = VolleySingleton.getInstance().getImageLoader();
													Activity_Main.Userimage.setImageUrl(UserData.SERVER_ADDRESS + GETSharedPreferences("IMGUSU", ""),
															imageLoader);
													Activity_Main.header_name.setText(GETSharedPreferences("Nombre", ""));
													Activity_Main.header_email.setText(GETSharedPreferences("Correo", ""));
													option[0] = 1;
													Fragment_AtencionC fragmentAtencionC = new Fragment_AtencionC();
													Activity_Main.this.getSupportFragmentManager().beginTransaction().replace(R.id.flContent, fragmentAtencionC).addToBackStack(null).commit();
												}
											});
									android.app.AlertDialog dialog1 = builder.create();
									dialog1.show();
									break;
								
								case DialogInterface.BUTTON_NEGATIVE:
									//No button clicked
									break;
							}
						}
					};
					android.app.AlertDialog.Builder builder = new android.app.AlertDialog.Builder(Activity_Main.this);
					builder.setTitle("Advertencia").setIcon(R.drawable.ic_menu_alerta);
					builder.setMessage("Su cuenta sera cerrada, \n ¿Desea cerrarla?").setPositiveButton("Si", dialogClickListener)
							.setNegativeButton("No", dialogClickListener).show();
					
					if (option[0] == 1) {
						fragmenteclass = Fragment_AtencionC.class;
					}
				}
				if (fragmenteclass != null) {
					try {
						fragment = (Fragment) fragmenteclass.newInstance();
						
					} catch (Exception e) {
						e.printStackTrace();
					}
					fragmentManager.beginTransaction().replace(R.id.flContent, fragment).commit();
					
				}
				if (item.getItemId() != R.id.cerrar_Sesion) {
					item.setChecked(true);
					
				}
				
				
			}
		}, 450);
		DrawerLayout drawer = (DrawerLayout) findViewById(R.id.drawer_layout);
		drawer.closeDrawer(GravityCompat.START);
		return true;
	}
	
	@Override
	public void onFragmentInteraction(Uri uri) {
	}
	
	public class IniciarApp extends AsyncTask<Void, Integer, Integer> {
		
		ProgressDialog progressDialog = new ProgressDialog(Activity_Main.this);
		
		@Override
		protected void onPreExecute() {
			progressDialog.setMessage("Cargando informacion personal...");
			progressDialog.setCancelable(false);
			progressDialog.show();
		}
		
		@Override
		protected Integer doInBackground(Void... voids) {
			if (GETSharedPreferences("TOKEN", "").isEmpty() && GETSharedPreferences("ID", "").isEmpty()) {
				return 1;
			} else {
				ArrayList<NameValuePair> datatosend = new ArrayList<>();
				datatosend.add(new BasicNameValuePair("ID", GETSharedPreferences("ID", "")));
				datatosend.add(new BasicNameValuePair("Token", GETSharedPreferences("TOKEN", "")));
				
				// ++ CONECCION PARA MANDAR LOS PARAMETROS ++
				HttpParams httpRequestParams = HTTPPARAMS.GETHTTPREQUESTPARAMS();
				HttpClient client = new DefaultHttpClient(httpRequestParams);
				HttpPost post = new HttpPost(UserData.SERVER_ADDRESS + "ValidateUserOnStartUp.php");
				
				// ++ RESPONSE FROM SERVER ++
				HttpResponse httpResponse = null;
				String responsedecoded = "";
				
				try {
					post.setEntity(new UrlEncodedFormEntity(datatosend));
					httpResponse = client.execute(post);
					HttpEntity httpEntity = httpResponse.getEntity();
					responsedecoded = EntityUtils.toString(httpEntity, "UTF-8");
					
					JSONArray jsonArray = new JSONArray(responsedecoded);
					if (jsonArray.length() == 0) {
						return 2;
					} else if (jsonArray.length() > 0) {
						
						SETSharedPreferences("TOKEN", jsonArray.getJSONObject(0).getString("Token"));
						SETSharedPreferences("IMGUSU", jsonArray.getJSONObject(0).getString("ImgURL"));
						SETSharedPreferences("ID", jsonArray.getJSONObject(0).getString("id"));
						SETSharedPreferences("Nombre", jsonArray.getJSONObject(0).getString("Nombre") + " " + jsonArray.getJSONObject(0).getString("ApellidoP"));
						SETSharedPreferences("Correo", jsonArray.getJSONObject(0).getString("CorreoE"));
						SETSharedPreferences("Rol", jsonArray.getJSONObject(0).getString("fk_id_rol"));
						
						return 3;
					}
					Toast.makeText(SuperContext(), "", Toast.LENGTH_LONG).show();
					httpEntity.consumeContent();
				} catch (Exception e) {
					e.printStackTrace();
				}
				return 0;
				
			}
			
		}
		
		@Override
		protected void onPostExecute(Integer aBoolean) {
			if (aBoolean == 0) {
				progressDialog.dismiss();
				progressDialog.setMessage("Falla de Conexion, Reinicie");
				AlertDialog.Builder builder = new AlertDialog.Builder(Activity_Main.this);
				builder.setMessage("Falla de Conexion!")
						.setPositiveButton("Retry", new DialogInterface.OnClickListener() {
							@Override
							public void onClick(DialogInterface dialog, int which) {
								new IniciarApp().execute();
							}
						})
						.setNegativeButton("Cancelar", new DialogInterface.OnClickListener() {
							@Override
							public void onClick(DialogInterface dialog, int which) {
								finish();
							}
						});
				AlertDialog alertDialog = builder.create();
				alertDialog.show();
				
			} else if (aBoolean == 1) {
				
				progressDialog.setMessage("Ninguna sesion");
				Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
				setSupportActionBar(toolbar);
				toolbar.setBackgroundResource(R.drawable.gradient);
				
				if (bundle == null) {
					Fragment fragment = null;
					Class fragmenteclass = null;
					fragmenteclass = Fragment_AtencionC.class;
					try {
						fragment = (Fragment) fragmenteclass.newInstance();
					} catch (Exception e) {
						e.printStackTrace();
					}
					fragmentManager.beginTransaction().replace(R.id.flContent, fragment).commit();
					getSupportActionBar().setTitle("Alertas");
				}
				ImageLoader imageLoader = VolleySingleton.getInstance().getImageLoader();
				DrawerLayout drawer = (DrawerLayout) findViewById(R.id.drawer_layout);
				ActionBarDrawerToggle toggle = new ActionBarDrawerToggle(
						Activity_Main.this, drawer, toolbar, R.string.navigation_drawer_open, R.string.navigation_drawer_close);
				drawer.addDrawerListener(toggle);
				toggle.syncState();
				navigationView = (NavigationView) findViewById(R.id.nav_view);
				View headerView = navigationView.inflateHeaderView(R.layout.nav_header_main);
				if (imageLoader == null) imageLoader = VolleySingleton.getInstance().getImageLoader();
				Userimage = (NetworkImageView) headerView.findViewById(R.id.userimage);
				header_name = (TextView) headerView.findViewById(R.id.header_name);
				header_email = (TextView) headerView.findViewById(R.id.header_email);
				Userimage.setImageUrl(UserData.SERVER_ADDRESS + GETSharedPreferences("IMGUSU", ""), imageLoader);
				header_name.setText(GETSharedPreferences("Nombre", ""));
				header_email.setText(GETSharedPreferences("Correo", ""));
				navigationView.getMenu().getItem(0).setChecked(true);
				ocultar_campos();
				navigationView.setNavigationItemSelectedListener(Activity_Main.this);
				progressDialog.dismiss();
				
			} else if (aBoolean == 2) {
				
				progressDialog.dismiss();
				final SweetAlertDialog sweetAlertDialogLog = new SweetAlertDialog(SuperContext(), SweetAlertDialog.WARNING_TYPE);
				sweetAlertDialogLog.setTitle("Advertencia");
				sweetAlertDialogLog.setContentText("Sesión Iniciada en Otro Dispositivo \n Vuelva a Iniciar Sesión en este equipo");
				sweetAlertDialogLog.setCancelable(false);
				sweetAlertDialogLog.show();
				Button cerrar = (Button) sweetAlertDialogLog.findViewById(cn.pedant.SweetAlert.R.id.confirm_button);
				if (cerrar != null) {
					Log.e("Messeage from pdialog", "showErrorMsg: Button view Found yep");
					cerrar.setBackgroundColor(getResources().getColor(R.color.colorPrimaryDark));
					cerrar.setTextColor(getResources().getColor(R.color.TextInPrimary));
					cerrar.setText(" Esta Bien ");
				}
				cerrar.setOnClickListener(new View.OnClickListener() {
					@Override
					public void onClick(View view) {
						SETSharedPreferences("TOKEN", "");
						SETSharedPreferences("IMGUSU", "");
						SETSharedPreferences("ID", "");
						SETSharedPreferences("Nombre", "");
						SETSharedPreferences("Correo", "");
						SETSharedPreferences("Rol", "");
						sweetAlertDialogLog.dismiss();
						Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
						setSupportActionBar(toolbar);
						toolbar.setBackgroundResource(R.drawable.gradient);
						if (bundle == null) {
							Fragment fragment = null;
							Class fragmenteclass = null;
							fragmenteclass = Fragment_AtencionC.class;
							try {
								fragment = (Fragment) fragmenteclass.newInstance();
							} catch (Exception e) {
								e.printStackTrace();
							}
							fragmentManager.beginTransaction().replace(R.id.flContent, fragment).commit();
							getSupportActionBar().setTitle("Alertas");
						}
						ImageLoader imageLoader = VolleySingleton.getInstance().getImageLoader();
						DrawerLayout drawer = (DrawerLayout) findViewById(R.id.drawer_layout);
						ActionBarDrawerToggle toggle = new ActionBarDrawerToggle(
								Activity_Main.this, drawer, toolbar, R.string.navigation_drawer_open, R.string.navigation_drawer_close);
						drawer.addDrawerListener(toggle);
						toggle.syncState();
						navigationView = (NavigationView) findViewById(R.id.nav_view);
						View headerView = navigationView.inflateHeaderView(R.layout.nav_header_main);
						if (imageLoader == null) imageLoader = VolleySingleton.getInstance().getImageLoader();
						Userimage = (NetworkImageView) headerView.findViewById(R.id.userimage);
						header_name = (TextView) headerView.findViewById(R.id.header_name);
						header_email = (TextView) headerView.findViewById(R.id.header_email);
						Userimage.setImageUrl(UserData.SERVER_ADDRESS + GETSharedPreferences("IMGUSU", ""), imageLoader);
						header_name.setText(GETSharedPreferences("Nombre", ""));
						header_email.setText(GETSharedPreferences("Correo", ""));
						navigationView.getMenu().getItem(0).setChecked(true);
						ocultar_campos();
						navigationView.setNavigationItemSelectedListener(Activity_Main.this);
						
					}
				});
				
				
			} else if (aBoolean == 3) {
				
				progressDialog.setMessage("Sesion iniciada aqui");
				Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
				setSupportActionBar(toolbar);
				toolbar.setBackgroundResource(R.drawable.gradient);
				if (bundle == null) {
					Fragment fragment = null;
					Class fragmenteclass = null;
					fragmenteclass = Fragment_AtencionC.class;
					try {
						fragment = (Fragment) fragmenteclass.newInstance();
					} catch (Exception e) {
						e.printStackTrace();
					}
					fragmentManager.beginTransaction().replace(R.id.flContent, fragment).commit();
					getSupportActionBar().setTitle("Alertas");
				}
				ImageLoader imageLoader = VolleySingleton.getInstance().getImageLoader();
				DrawerLayout drawer = (DrawerLayout) findViewById(R.id.drawer_layout);
				ActionBarDrawerToggle toggle = new ActionBarDrawerToggle(
						Activity_Main.this, drawer, toolbar, R.string.navigation_drawer_open, R.string.navigation_drawer_close);
				drawer.addDrawerListener(toggle);
				toggle.syncState();
				navigationView = (NavigationView) findViewById(R.id.nav_view);
				View headerView = navigationView.inflateHeaderView(R.layout.nav_header_main);
				if (imageLoader == null) imageLoader = VolleySingleton.getInstance().getImageLoader();
				Userimage = (NetworkImageView) headerView.findViewById(R.id.userimage);
				header_name = (TextView) headerView.findViewById(R.id.header_name);
				header_email = (TextView) headerView.findViewById(R.id.header_email);
				Userimage.setImageUrl(UserData.SERVER_ADDRESS + GETSharedPreferences("IMGUSU", ""), imageLoader);
				header_name.setText(GETSharedPreferences("Nombre", ""));
				header_email.setText(GETSharedPreferences("Correo", ""));
				navigationView.getMenu().getItem(0).setChecked(true);
				ocultar_campos();
				navigationView.setNavigationItemSelectedListener(Activity_Main.this);
				progressDialog.dismiss();
				
			}
		}
	}
}