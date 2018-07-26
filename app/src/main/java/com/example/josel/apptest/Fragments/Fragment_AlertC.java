package com.example.josel.apptest.Fragments;

import android.Manifest;
import android.annotation.SuppressLint;
import android.app.AlertDialog;
import android.content.ClipData;
import android.content.ContentValues;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.pm.PackageManager;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Matrix;
import android.graphics.Paint;
import android.graphics.PorterDuff;
import android.graphics.PorterDuffXfermode;
import android.graphics.Rect;
import android.graphics.drawable.BitmapDrawable;
import android.location.Address;
import android.location.Geocoder;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Build;
import android.os.Bundle;
import android.os.Environment;
import android.os.StrictMode;
import android.provider.MediaStore;
import android.support.annotation.Nullable;
import android.support.design.widget.Snackbar;
import android.support.v4.app.ActivityCompat;
import android.support.v4.app.Fragment;
import android.support.v4.content.ContextCompat;
import android.support.v4.content.FileProvider;
import android.util.Base64;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import com.android.volley.toolbox.ImageLoader;
import com.example.josel.apptest.Activitys.Activity_Maps;
import com.example.josel.apptest.Activitys.Activity_Main;
import com.example.josel.apptest.Methods.AppController;
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
import java.util.Locale;
import java.util.NoSuchElementException;
import java.util.Objects;

import cn.pedant.SweetAlert.SweetAlertDialog;

import static android.app.Activity.RESULT_OK;
import static android.content.Context.LOCATION_SERVICE;


/**
 * A simple {@link Fragment} subclass.
 * Activities that contain this fragment must implement the
 * {@link Fragment_AlertC.OnFragmentInteractionListener} interface
 * to handle interaction events.
 */
public class Fragment_AlertC extends Fragment {
    static final int REQUEST_LOCATION = 1;
    private static final int REQUEST_CAMARA_WRITE_PER = 2399;
    // The minimum distance to change Updates in meters
    private static final long MIN_DISTANCE_CHANGE_FOR_UPDATES = 1; // 10 meters
    // The minimum time between updates in milliseconds
    private static final long MIN_TIME_BW_UPDATES = 1; // 1 minute
    public static TextView alertatxtubicacion, alert_longitud, alert_latitud;
    final long MIN_CAMBIO_DISTANCIA_PARA_UPDATES = 10;
    final long MIN_TIEMPO_ENTRE_UPDATES = 1000 * 60 * 1;
    public boolean isGPSEnabled = false;
    ContentValues cv;
    Uri imageUri;
    String Contrasena = null;
    ImageView imagen_camara;
    LocationManager locationManager;
    Location location;
    String mCurrentPhotoPath;
    File image;
    OutputStream outputStream = null;
    boolean isNetworkEnabled = false;
    boolean canGetLocation = false;
    SweetAlertDialog pdialogerror, pdialogExito, pdialogmastarde, pDialogloading;
    EditText edittxtdes, txttitalerta;
    ImageButton btnubicar, alertcamara, alertgallery;
    ImageButton btnenviaraviso;
    ImageLoader imageLoader = AppController.getInstance().getImageLoader();
    double latitude, longitude;
    SharedPreferences preferences;
    String id_preferencia;
    String date;
    String categoria = "1";
    Intent cameraIntent;
    LocationListener locationListener = new LocationListener() {
        @Override
        public void onLocationChanged(Location location) {
            String Locations = String.valueOf(location.getLatitude());
            Log.w("Location", Locations);
            latitude = location.getLatitude();
            longitude = location.getLongitude();
        }

        @Override
        public void onStatusChanged(String s, int i, Bundle bundle) {

        }

        @Override
        public void onProviderEnabled(String s) {

        }

        @Override
        public void onProviderDisabled(String s) {

        }
    };
    private OnFragmentInteractionListener mListener;

    public Fragment_AlertC() {
        // Required empty public constructor
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_alertc, container, false);
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {


        pDialogloading = new SweetAlertDialog(getActivity(), SweetAlertDialog.PROGRESS_TYPE);
        pDialogloading.getProgressHelper().setBarColor(Color.parseColor("#A5DC86"));
        pDialogloading.setTitleText("Subiendo Informacion...");
        pDialogloading.setCancelable(false);

        pdialogerror = new SweetAlertDialog(getActivity(), SweetAlertDialog.ERROR_TYPE);
        pdialogExito = new SweetAlertDialog(getActivity(), SweetAlertDialog.SUCCESS_TYPE);
        pdialogmastarde = new SweetAlertDialog(getActivity(), SweetAlertDialog.NORMAL_TYPE);

        Date c = Calendar.getInstance().getTime();
        SimpleDateFormat df = new SimpleDateFormat("dd-MMM-yyyy");
        date = df.format(c);


        locationManager = (LocationManager) getView().getContext().getSystemService(LOCATION_SERVICE);


        //++++++++++++++++++++++++ CAMPOS
        txttitalerta = (EditText) getView().findViewById(R.id.txttitalerta);
        edittxtdes = (EditText) getView().findViewById(R.id.listdisc);
        alertatxtubicacion = (TextView) getView().findViewById(R.id.alertatxtubicacion);
        alert_longitud = (TextView) getView().findViewById(R.id.alert_longitud);
        alert_latitud = (TextView) getView().findViewById(R.id.alert_latitud);
        //++++++++++++++++++++++++ IMAGENES

        imagen_camara = (ImageView) getView().findViewById(R.id.imgfoto);
        //++++++++++++++++++++++++ BOTTONES IMAGENES
        btnubicar = (ImageButton) view.findViewById(R.id.btnubicar);
        alertcamara = (ImageButton) view.findViewById(R.id.alertcamara);
        alertgallery = (ImageButton) view.findViewById(R.id.alertgallery);
        //++++++++++++++++++++++++ BOTTON MANDAR+++++++
        btnenviaraviso = (ImageButton) getView().findViewById(R.id.btnenviaraviso);

        // ESCUDO
        imageLoader = AppController.getInstance().getImageLoader();

        //new GetImagesURL(imgescudoalerta).execute(UserData.Escudo);

        preferences = getActivity().getSharedPreferences("Credenciales", Context.MODE_PRIVATE);
        id_preferencia = preferences.getString("ID", "");

        alertcamara.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                StrictMode.VmPolicy.Builder builder = new StrictMode.VmPolicy.Builder();
                StrictMode.setVmPolicy(builder.build());
                /*if (getcamara()){
                    String timeStamp = new SimpleDateFormat("yyyyMMdd_HHmmss").format(new Date());
                    File file = new File(getExternalStoragePublicDirectory(Environment.DIRECTORY_PICTURES), "/photo_" + timeStamp + ".png");
                    imageUri = Uri.fromFile(file);

                    cameraIntent = new Intent(android.provider.MediaStore.ACTION_IMAGE_CAPTURE);
                    cameraIntent.putExtra(MediaStore.EXTRA_SCREEN_ORIENTATION, ActivityInfo.SCREEN_ORIENTATION_LANDSCAPE);
                    cameraIntent.putExtra(MediaStore.EXTRA_OUTPUT, imageUri);
                    startActivityForResult(cameraIntent, 0);
                }else{
                    Snackbar.make(getView(),"Porfavor vuelva a intentarlo",Snackbar.LENGTH_SHORT).show();
                }*/
                if (imagen_camara.getDrawable() == null) {
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
        alertgallery.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                agarrarnuevaimage();
            }
        });
        btnubicar.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                permisoubicacion();
            }
        });
        btnenviaraviso.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(final View view) {
                pDialogloading.show();
                if (imagen_camara.getDrawable() != null && !alertatxtubicacion.getText().toString().equals("") &&
                        !txttitalerta.getText().toString().equals("") && !edittxtdes.getText().toString().equals("")) {

                    Bitmap image = ((BitmapDrawable) imagen_camara.getDrawable()).getBitmap();
                    new send_news(image, image.toString(), txttitalerta.getText().toString(), edittxtdes.getText().toString(),
                            date, alertatxtubicacion.getText().toString(), categoria, id_preferencia,
                            alert_longitud.getText().toString(), alert_latitud.getText().toString()).execute();

                } else {

                    String falta = "Elementos faltantes: \n";
                    if (txttitalerta.getText().toString().equals("")) {
                        falta += "- Titulo \n";
                    }
                    if (edittxtdes.getText().toString().equals("")) {
                        falta += "- Descripción \n";
                    }
                    if (alertatxtubicacion.getText().toString() == "") {
                        falta += "- Ubicación \n";
                    }
                    if (imagen_camara.getDrawable() == null) {
                        falta += "- Imagen \n";
                    }
                    pDialogloading.dismiss();
                    pdialogerror.setTitleText("Error").setContentText(falta);
                    pdialogerror.setCancelable(false);
                    pdialogerror.show();
                    Button ok = (Button) pdialogerror.findViewById(cn.pedant.SweetAlert.R.id.confirm_button);
                    if (ok != null) {
                        Log.e("Messeage from pdialog", "showErrorMsg: Button view Found yep");
                        ok.setBackgroundColor(getResources().getColor(R.color.colorPrimaryDark));
                        ok.setTextColor(getResources().getColor(R.color.TextInPrimary));
                        ok.setText("Entendido");
                    } else {
                        Log.e("Messeage from pdialog", "showErrorMsg: Button view Null :( ");
                    }
                    ok.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View view) {
                            pdialogerror.dismiss();
                        }
                    });

                }
            }


        });
        super.onViewCreated(view, savedInstanceState);
    }

    private void permisoubicacion() {
        if (ContextCompat.checkSelfPermission(getActivity(), Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED
                &&
                ContextCompat.checkSelfPermission(getActivity(), Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
            ActivityCompat.requestPermissions(getActivity(), new String[]{Manifest.permission.ACCESS_FINE_LOCATION, Manifest.permission.ACCESS_COARSE_LOCATION}, REQUEST_LOCATION);
        } else {
            Activity_Maps.opcion = 5;
            startActivityForResult(new Intent(getActivity(), Activity_Maps.class), 1292);
        }
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
        startActivityForResult(Intent.createChooser(chooserIntent, "Nueva Foto de Perfil"), 1310);
    }

    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++                            ONACTIVITYRESULT
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        if (requestCode == REQUEST_CAMARA_WRITE_PER && resultCode == RESULT_OK) {
//            Bundle extras = data.getExtras();
//            Bitmap imageBitmap = (Bitmap) extras.get("data");
//            Main_Evidencia.setImageBitmap(imageBitmap);
            setPic();
        }
        if (requestCode == 0 && resultCode == RESULT_OK) {
            dispatchTakePictureIntent();
        }
        /*if (requestCode == 0 && resultCode == RESULT_OK) {
             try {
                Bitmap thumbnail = MediaStore.Images.Media.getBitmap(getActivity().getContentResolver() , imageUri);
                imagen_camara.setImageBitmap(thumbnail);
             } catch (Exception e) {
             e.printStackTrace();
             }
//
//            Bitmap bitmap = (Bitmap) data.getExtras().get("data");
//            scaleImage(imagen_camara,bitmap);
        }*/
        if (requestCode == 1310 && resultCode == RESULT_OK) {
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
                imagen_camara.setImageBitmap(maped);
            } catch (FileNotFoundException e) {
                e.printStackTrace();
            }
            if (requestCode == REQUEST_LOCATION && resultCode == RESULT_OK) {
                permisoubicacion();
            }
        }
        if (requestCode == 1292 && resultCode == RESULT_OK) {
            if (alert_latitud.getText().toString().isEmpty() || alert_longitud.getText().toString().isEmpty()) {
                Snackbar.make(getActivity().getCurrentFocus(), "Es necesario que coloque el Marcador en algun punto", Snackbar.LENGTH_LONG).show();
            } else {
                alertatxtubicacion.setText(getCompleteAddressString(Double.valueOf(alert_latitud.getText().toString()), Double.valueOf(alert_longitud.getText().toString())));
            }
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
        canvas.drawCircle(bitmap.getWidth() / 2, bitmap.getHeight() / 2,
                bitmap.getWidth() / 2, paint);
        paint.setXfermode(new PorterDuffXfermode(PorterDuff.Mode.SRC_IN));
        canvas.drawBitmap(bitmap, rect, rect, paint);
        //Bitmap _bmp = Bitmap.createScaledBitmap(output, 60, 60, false);
        //return _bmp;
        return output;
    }

    public boolean send_image_to_server(Bitmap image, String name, String titulo, String descripcion, String fecha, String direccion, String idcategoria, String idusuario) {

        ByteArrayOutputStream os = new ByteArrayOutputStream();
        image.compress(Bitmap.CompressFormat.JPEG, 100, os);
        String encodedimage = Base64.encodeToString(os.toByteArray(), Base64.DEFAULT);

        HttpClient httpc = new DefaultHttpClient();
        HttpContext localc = new BasicHttpContext();
        HttpPost httppost = new HttpPost(UserData.SERVER_ADDRESS + "JSONInsertNoticia.php");
        HttpResponse response = null;
        String res = null;
        try {

            List<NameValuePair> params = new ArrayList<NameValuePair>();
            params.add(new BasicNameValuePair("titulo", titulo));
            params.add(new BasicNameValuePair("descripcion", descripcion));
            params.add(new BasicNameValuePair("fecha", fecha));
            params.add(new BasicNameValuePair("direccion", direccion));
            params.add(new BasicNameValuePair("idcategoria", idcategoria));
            params.add(new BasicNameValuePair("idusuario", idusuario));
            params.add(new BasicNameValuePair("image", encodedimage));
            params.add(new BasicNameValuePair("name", name));
            httppost.setEntity(new UrlEncodedFormEntity(params));

            response = httpc.execute(httppost, localc);
            HttpEntity entity = response.getEntity();
            res = EntityUtils.toString(entity, "UTF-8");

            JSONArray jsonArray = new JSONArray(res);
            Contrasena = jsonArray.getJSONObject(0).getString("EXITO");
            if (Contrasena.equals("SI")) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
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

    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++                              CAMARA PERMISSION
    /*boolean getcamara(){
        if (ContextCompat.checkSelfPermission(getActivity(),Manifest.permission.CAMERA) != PackageManager.PERMISSION_GRANTED){
            ActivityCompat.requestPermissions(getActivity(),new String[]{
                    Manifest.permission.CAMERA,
                    Manifest.permission.WRITE_EXTERNAL_STORAGE,
                    Manifest.permission.READ_EXTERNAL_STORAGE
            },0);
            return false;
        }else  {
            return true;
        }
    }*/
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
                    Uri photoURI = FileProvider.getUriForFile(getContext(), "com.example.josel.apptest.android.fileprovider", photoFile);
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
            imagen_camara.setImageBitmap(bitmap);
            outputStream.flush();
            outputStream.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++                              LOCATION PERMISSION
    boolean getLocation() {
        if (ContextCompat.checkSelfPermission(getActivity(), Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED
                &&
                ContextCompat.checkSelfPermission(getActivity(), Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
            ActivityCompat.requestPermissions(getActivity(), new String[]{Manifest.permission.ACCESS_FINE_LOCATION, Manifest.permission.ACCESS_COARSE_LOCATION}, REQUEST_LOCATION);
        } else {

//    TODO: CODIGO INICIAL DE LOCALIZACION
       /* if (!LocationManager.GPS_PROVIDER.isEmpty()){
            locationManager.requestLocationUpdates(
                    LocationManager.GPS_PROVIDER,
                    MIN_TIEMPO_ENTRE_UPDATES,
                    MIN_CAMBIO_DISTANCIA_PARA_UPDATES,
                    locationListener
                    *//*, Looper.getMainLooper()*//*
            );
            if (locationManager != null){
                location = locationManager.getLastKnownLocation(LocationManager.GPS_PROVIDER);
                if (location!=null){
                    latitude = location.getLatitude();
                    longitude = location.getLongitude();
                    return true;
                }
            }
        }
        Location location = locationManager.getLastKnownLocation(LocationManager.NETWORK_PROVIDER);
        if (location != null){
            latitude = location.getLatitude();
            longitude = location.getLongitude();
            return true;
        }*/
//    TODO: CODIGO INICIAL DE LOCALIZACION

            try {
                locationManager = (LocationManager) getContext()
                        .getSystemService(Context.LOCATION_SERVICE);

                // getting GPS status
                isGPSEnabled = locationManager
                        .isProviderEnabled(LocationManager.GPS_PROVIDER);

                Log.v("isGPSEnabled", "=" + isGPSEnabled);

                // getting network status
                isNetworkEnabled = locationManager
                        .isProviderEnabled(LocationManager.NETWORK_PROVIDER);

                Log.v("isNetworkEnabled", "=" + isNetworkEnabled);

                if (isGPSEnabled == false && isNetworkEnabled == false) {
                    // no network provider is enabled
                    final AlertDialog.Builder builder = new AlertDialog.Builder(getActivity());
                    builder.setMessage("Solicitud Fallida Intente Mas Tarde")
                            .setTitle("Estado")
                            .setCancelable(false)
                            .setPositiveButton(android.R.string.ok, null);
                    AlertDialog dialog = builder.create();
                    dialog.show();
                } else {
                    this.canGetLocation = true;
                    if (isNetworkEnabled) {
                        location = null;
                        locationManager.requestLocationUpdates(
                                LocationManager.NETWORK_PROVIDER,
                                MIN_TIME_BW_UPDATES,
                                MIN_DISTANCE_CHANGE_FOR_UPDATES, this.locationListener
                        );
                        Log.d("Network", "Network");
                        if (locationManager != null) {
                            location = locationManager
                                    .getLastKnownLocation(LocationManager.NETWORK_PROVIDER);
                            if (location != null) {
                                latitude = location.getLatitude();
                                longitude = location.getLongitude();
                                return true;

                            }
                        }
                    }
                    // if GPS Enabled get lat/long using GPS Services
                    if (isGPSEnabled) {
                        location = null;
                        if (location == null) {
                            locationManager.requestLocationUpdates(
                                    LocationManager.GPS_PROVIDER,
                                    MIN_TIME_BW_UPDATES,
                                    MIN_DISTANCE_CHANGE_FOR_UPDATES, this.locationListener);

                            Log.d("GPS Enabled", "GPS Enabled");
                            if (locationManager != null) {
                                location = locationManager
                                        .getLastKnownLocation(LocationManager.GPS_PROVIDER);
                                if (location != null) {
                                    latitude = location.getLatitude();
                                    longitude = location.getLongitude();
                                    return true;
                                }
                            }
                        }
                    }
                }

            } catch (Exception e) {
                e.printStackTrace();
            }

        }
        return false;
    }

    private String getCompleteAddressString(double LATITUDE, double LONGITUDE) {
        String strAdd = "";
        Geocoder geocoder = new Geocoder(this.getView().getContext(), Locale.getDefault());
        try {
            List<Address> addresses = geocoder.getFromLocation(LATITUDE, LONGITUDE, 1);
            if (addresses != null) {
                Address returnedAddress = addresses.get(0);
                StringBuilder strReturnedAddress = new StringBuilder("");

                for (int i = 0; i <= returnedAddress.getMaxAddressLineIndex(); i++) {
                    strReturnedAddress.append(returnedAddress.getAddressLine(i)).append("");
                }
                strAdd = strReturnedAddress.toString();
                Log.w("Current loction", strReturnedAddress.toString());
            } else {
                Log.w("Current loction", "No Address returned!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            Log.w("Current loction", "Canont get Address!");
        }
        return strAdd;
    }

    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++                        SCALEIMAGE PIC TAKEN
    private void scaleImage(ImageView view, Bitmap bitmap) throws NoSuchElementException {
        int containerh = view.getHeight();
        int containerw = view.getWidth();
        int width = bitmap.getWidth();
        int height = bitmap.getHeight();

        int bounding = dpToPx(500);

        // Determine how much to scale: the dimension requiring less scaling is
        // closer to the its side. This way the image always stays inside your
        // bounding box AND either x/y axis touches it.
        float xScale = ((float) bounding) / width;
        float yScale = ((float) bounding) / height;
        float scale = (xScale <= yScale) ? xScale : yScale;

        // Create a matrix for the scaling and add the scaling data
        Matrix matrix = new Matrix();
        matrix.postScale(scale, scale);

        // Create a new bitmap and convert it to a format understood by the ImageView
        Bitmap scaledBitmap = Bitmap.createBitmap(bitmap, 0, 0, width, height, matrix, true);
        width = scaledBitmap.getWidth(); // re-use
        height = scaledBitmap.getHeight(); // re-use
        BitmapDrawable result = new BitmapDrawable(scaledBitmap);
        // Apply the scaled bitmap
        view.setImageDrawable(result);

        // Now change ImageView's dimensions to match the scaled image
        //  LinearLayout.LayoutParams params = (LinearLayout.LayoutParams) view.getLayoutParams();
        //  params.width = width;
        //params.height = height;
        //view.setLayoutParams(params);
    }
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++                              LOCATION ADDRESS

    private int dpToPx(int dp) {
        float density = getView().getResources().getDisplayMetrics().density;
        return Math.round((float) dp * density);
    }

    public interface OnFragmentInteractionListener {
        // TODO: Update argument type and name
        void onFragmentInteraction(Uri uri);
    }

    private class send_news extends AsyncTask<Void, Boolean, Boolean> {
        Bitmap image;
        String name;
        String title;
        String description;
        String date;
        String Address;
        String idcategory;
        String iduser;
        String lat, longi;
        JSONArray jsonArray;

        public send_news(Bitmap image, String name, String title, String description, String date, String address, String idcategory, String iduser, String longitud, String latitude) {
            this.image = image;
            this.name = name;
            this.title = title;
            this.description = description;
            this.date = date;
            Address = address;
            this.idcategory = idcategory;
            this.iduser = iduser;
            this.longi = longitud;
            this.lat = latitude;
        }

        @Override
        protected Boolean doInBackground(Void... voids) {
            ByteArrayOutputStream os = new ByteArrayOutputStream();
            image.compress(Bitmap.CompressFormat.JPEG, 100, os);
            String encodedimage = Base64.encodeToString(os.toByteArray(), Base64.DEFAULT);

            HttpClient httpc = new DefaultHttpClient();
            HttpContext localc = new BasicHttpContext();
            HttpPost httppost = new HttpPost(UserData.SERVER_ADDRESS + "JSONInsertNoticia.php");
            HttpResponse response = null;
            String res = null;

            try {

                List<NameValuePair> params = new ArrayList<NameValuePair>();
                params.add(new BasicNameValuePair("titulo", title));
                params.add(new BasicNameValuePair("descripcion", description));
                params.add(new BasicNameValuePair("fecha", date));
                params.add(new BasicNameValuePair("direccion", Address));
                params.add(new BasicNameValuePair("idcategoria", idcategory));
                params.add(new BasicNameValuePair("idusuario", iduser));
                params.add(new BasicNameValuePair("image", encodedimage));
                params.add(new BasicNameValuePair("name", name));
                params.add(new BasicNameValuePair("long", longi));
                params.add(new BasicNameValuePair("lat", lat));
                httppost.setEntity(new UrlEncodedFormEntity(params));

                response = httpc.execute(httppost, localc);
                HttpEntity entity = response.getEntity();
                res = EntityUtils.toString(entity, "UTF-8");

                jsonArray = new JSONArray(res);
                Contrasena = jsonArray.getJSONObject(0).getString("EXITO");
                if (Contrasena.equals("SI")) {
                    return true;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            return false;
        }

        @Override
        protected void onPostExecute(Boolean b) {
            if (b == true) {
                int change = 0;
                pDialogloading.dismiss();
                pdialogExito.setTitleText("Exito").setContentText("Solicitud Exitosa :" + " \n" + "Publicación enviada" + " \n");
                pdialogExito.setCancelable(false);
                pdialogExito.show();
                Button ok = (Button) pdialogExito.findViewById(cn.pedant.SweetAlert.R.id.confirm_button);
                if (ok != null) {
                    Log.e("Messeage from pdialog", "showErrorMsg: Button view Found yep");
                    ok.setBackgroundColor(getResources().getColor(R.color.colorPrimaryDark));
                    ok.setTextColor(getResources().getColor(R.color.TextInPrimary));
                    ok.setText("Listo");
                } else {
                    Log.e("Messeage from pdialog", "showErrorMsg: Button view Null :( ");
                }
                ok.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        if (categoria.equals("1")) {
                            Activity_Main.navigationView.getMenu().getItem(0).setChecked(true);
                            Fragment_AtencionC myFragment = new Fragment_AtencionC();
                            getActivity().getSupportFragmentManager().beginTransaction().replace(R.id.flContent, myFragment).addToBackStack(null).commit();
                            pdialogExito.dismiss();
                        }
                    }
                });

            } else if (b == false) {
                pdialogerror.setTitleText("Error").setContentText("Conexion no se realizon \n" + " con exito");
                pdialogerror.setCancelable(false);
                pdialogerror.show();
                Button ok = (Button) pdialogerror.findViewById(cn.pedant.SweetAlert.R.id.confirm_button);
                if (ok != null) {
                    Log.e("Messeage from pdialog", "showErrorMsg: Button view Found yep");
                    ok.setBackgroundColor(getResources().getColor(R.color.colorPrimaryDark));
                    ok.setTextColor(getResources().getColor(R.color.TextInPrimary));
                    ok.setText("Entendido");
                } else {
                    Log.e("Messeage from pdialog", "showErrorMsg: Button view Null :( ");
                }
                ok.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        pdialogerror.dismiss();
                        pDialogloading.dismiss();
                    }
                });
            }
            super.onPostExecute(b);
        }

    }


}
