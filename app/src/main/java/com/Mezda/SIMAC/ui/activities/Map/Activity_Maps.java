package com.Mezda.SIMAC.ui.activities.Map;

import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.FragmentActivity;
import android.support.v7.app.AppCompatActivity;
import android.widget.Button;
import android.widget.TextView;


import com.Mezda.SIMAC.R;
import com.Mezda.SIMAC.ui.base.BaseActivity;
import com.google.android.gms.maps.CameraUpdate;
import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.OnMapReadyCallback;
import com.google.android.gms.maps.SupportMapFragment;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.Marker;
import com.google.android.gms.maps.model.MarkerOptions;

import javax.inject.Inject;

import butterknife.BindView;

public class Activity_Maps extends BaseActivity implements OnMapReadyCallback, MapsContract.View {

    @BindView(R.id.MapActivity_Done)
    Button MapActivity_Done;
    @BindView(R.id.MapActivity_Instructions)
    TextView MapActivity_Instructions;
    @Inject
    MapsContract.Presenter presenter;
    private GoogleMap mGoogleMap;

    @Override
    protected int getLayout() {
        return R.layout.activity_maps;
    }
    @Override
    public void onCreating(Bundle savedBundle, Intent intent) {
        SupportMapFragment supportMapFragment = (SupportMapFragment)
                getSupportFragmentManager().findFragmentById(R.id.map);
        supportMapFragment.getMapAsync(this);
        presenter.loadMarker();
    }

    @Override
    public void onMapReady(GoogleMap googleMap) {
        mGoogleMap = googleMap;
        mGoogleMap.addMarker(presenter.getMarkerOptions());
        mGoogleMap.moveCamera(presenter.getCameraUpdate());
    }

    @Override
    protected void onResuming() {

    }

    @Override
    protected void onDestroying() {

    }



}

	/*private static final String TAG = "Activity_Maps";
	public static int opcion;
	final Marker marker_final = null;
	Intent intent = new Intent();
	LatLng position = new LatLng(18.142577, -94.1437243);
	private GoogleMap mMap;
	private TextView MapActivity_Inst;
	private Button MapActivity_Done;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_maps);
		// Obtain the SupportMapFragment and get notified when the map is ready to be used.
		MapActivity_Inst = (TextView) findViewById(R.id.MapActivity_Inst);
		MapActivity_Done = (Button) findViewById(R.id.MapActivity_Done);
		SupportMapFragment mapFragment = (SupportMapFragment) getSupportFragmentManager().findFragmentById(R.id.map);
		mapFragment.getMapAsync(this);
		
	}*/
	
	/*
	@Override
	public void onMapReady(GoogleMap googleMap) {
		MapActivity_Done.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				switch (opcion) {
					case 5:
						intent.putExtra("id", "value");
						setResult(RESULT_OK, intent);
						finish();
						break;
					case 2:
						
						intent.putExtra("id", "value");
						setResult(RESULT_OK, intent);
						finish();
						break;
				}
			}
		});
		MapActivity_Inst.setText("Mantengan presionado el marcador y arrastre a la ubicacion requerida");
		mMap = googleMap;
		try {
			
			// Customise the styling of the base map using a JSON object defined
			// in a raw resource file.
			boolean success = googleMap.setMapStyle(
					MapStyleOptions.loadRawResourceStyle(
							this, R.raw.style_json));
			
			if (!success) {
				Log.e(TAG, "Style parsing failed.");
			}
		} catch (Resources.NotFoundException e) {
			Log.e(TAG, "Can't find style. Error: ", e);
		}
		if (opcion == 2) {
			if (ActivityCompat.checkSelfPermission(this, android.Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(this, android.Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
				return;
			}
			mMap.setMyLocationEnabled(true);
			mMap.moveCamera(CameraUpdateFactory.newLatLngZoom(position, 13));
			CameraUpdate zoom = CameraUpdateFactory.zoomTo(15);
			mMap.animateCamera(zoom);
			mMap.addMarker(new MarkerOptions()
					.title("Reportar Ubicación")
					.snippet("¿Es esta la ubicación?")
					.position(position))
					.setDraggable(true);
			// map.setInfoWindowAdapter(new PopupAdapter(getLayoutInflater()));
			mMap.setOnInfoWindowClickListener(new GoogleMap.OnInfoWindowClickListener() {
				@Override
				public void onInfoWindowClick(Marker marker) {
					Toast.makeText(getBaseContext(), marker.getTitle(), Toast.LENGTH_LONG).show();
				}
			});
			mMap.setOnMarkerDragListener(new GoogleMap.OnMarkerDragListener() {
				@Override
				public void onMarkerDragStart(Marker marker) {
					LatLng position0 = marker.getPosition();
					Log.d(getClass().getSimpleName(), String.format("Drag from %f:%f",
							position0.latitude,
							position0.longitude));
				}
				
				@Override
				public void onMarkerDrag(Marker marker) {
					LatLng position0 = marker.getPosition();
					Log.d(getClass().getSimpleName(),
							String.format("Dragging to %f:%f", position0.latitude,
									position0.longitude));
				}
				
				@Override
				public void onMarkerDragEnd(Marker marker) {
					position = marker.getPosition();
					Log.d(getClass().getSimpleName(), String.format("Dragged to %f:%f", position.latitude, position.longitude));
					Fragment_Reportar.Reporte_direccionMaps.setText(getCompleteAddressString(position.latitude, position.longitude));
					Fragment_Reportar.Reporte_Longitud.setText(String.valueOf(position.longitude));
					Fragment_Reportar.Reporte_Latitud.setText(String.valueOf(position.latitude));
				}
			});
		} else if (opcion == 5) {
			if (ActivityCompat.checkSelfPermission(this, android.Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(this, android.Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
				return;
			}
			mMap.setMyLocationEnabled(true);
			mMap.moveCamera(CameraUpdateFactory.newLatLngZoom(position, 13));
			CameraUpdate zoom = CameraUpdateFactory.zoomTo(15);
			mMap.animateCamera(zoom);
			mMap.addMarker(new MarkerOptions()
					.title("Reportar Ubicación")
					.snippet("¿Es esta la ubicación?")
					.position(position))
					.setDraggable(true);
			// map.setInfoWindowAdapter(new PopupAdapter(getLayoutInflater()));
			mMap.setOnInfoWindowClickListener(new GoogleMap.OnInfoWindowClickListener() {
				@Override
				public void onInfoWindowClick(Marker marker) {
					Toast.makeText(getBaseContext(), marker.getTitle(), Toast.LENGTH_LONG).show();
				}
			});
			mMap.setOnMarkerDragListener(new GoogleMap.OnMarkerDragListener() {
				@Override
				public void onMarkerDragStart(Marker marker) {
					LatLng position0 = marker.getPosition();
					Log.d(getClass().getSimpleName(), String.format("Drag from %f:%f",
							position0.latitude,
							position0.longitude));
				}
				
				@Override
				public void onMarkerDrag(Marker marker) {
					LatLng position0 = marker.getPosition();
					Log.d(getClass().getSimpleName(),
							String.format("Dragging to %f:%f", position0.latitude,
									position0.longitude));
				}
				
				@Override
				public void onMarkerDragEnd(Marker marker) {
					position = marker.getPosition();
					Log.d(getClass().getSimpleName(), String.format("Dragged to %f:%f", position.latitude, position.longitude));
					Fragment_GenerateAlert.alert_longitud.setText(String.valueOf(position.longitude));
					Fragment_GenerateAlert.alert_latitud.setText(String.valueOf(position.latitude));
				}
			});
			
		} else {
			MapActivity_Done.setOnClickListener(new View.OnClickListener() {
				@Override
				public void onClick(View v) {
					finish();
				}
			});
			MapActivity_Inst.setVisibility(View.INVISIBLE);
			MapActivity_Inst.setHeight(0);
			// Add a marker in Sydney and move the camera
			LatLng Place_LngLat = new LatLng(Double.valueOf(LocalNewsFragment.mArticleList.get(LocalNewsFragment.posilista).getLatitude()), Double.valueOf(LocalNewsFragment.mArticleList.get(LocalNewsFragment.posilista).getLongitud()));
			mMap.addMarker(new MarkerOptions().position(Place_LngLat).title(LocalNewsFragment.mArticleList.get(LocalNewsFragment.posilista).getHeadline()));
			CameraPosition cameraPosition = new CameraPosition.Builder().target(Place_LngLat).zoom(15).bearing(0).tilt(30).build();
			mMap.animateCamera(CameraUpdateFactory.newCameraPosition(cameraPosition));
//        mMap.moveCamera(CameraUpdateFactory.newLatLng(Place_LngLat));
		
		}
	}
	
	
	private String getCompleteAddressString(double LATITUDE, double LONGITUDE) {
		String strAdd = "";
		Geocoder geocoder = new Geocoder(Activity_Maps.this, Locale.getDefault());
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
	*/
	/*@Override
	public void onBackPressed() {
	}
}
*/
