package com.Mezda.SIMAC.pending.Activitys;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.ActionBar;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.ImageButton;
import android.widget.TextView;

import com.android.volley.toolbox.ImageLoader;
import com.android.volley.toolbox.NetworkImageView;
import com.Mezda.SIMAC.pending.Fragments.Fragment_AtencionC;
import com.Mezda.SIMAC.utils.VolleySingleton;
import com.Mezda.SIMAC.R;

import com.Mezda.SIMAC.UserData;

public class Activity_NoticiaIndividual extends AppCompatActivity {
	public static int opcion;
	ImageLoader imageLoader = VolleySingleton.getInstance().getImageLoader();
	NetworkImageView oneescudo, oneimgprin;
	TextView onedesc, oneperson, onetitle;
	ImageButton noticiaone_maps;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_noticiaindividual);
		ActionBar actionBar = getSupportActionBar();
		actionBar.hide();
		oneescudo = (NetworkImageView) findViewById(R.id.oneescudo);
		oneimgprin = (NetworkImageView) findViewById(R.id.oneimgprin);
		noticiaone_maps = (ImageButton) findViewById(R.id.noticiaone_maps);
		onedesc = (TextView) findViewById(R.id.onedesc);
		oneperson = (TextView) findViewById(R.id.oneperson);
		onetitle = (TextView) findViewById(R.id.onetitle);
//        oneaddr= (TextView) findViewById(R.id.oneaddr);
		
		imageLoader = VolleySingleton.getInstance().getImageLoader();
		if (opcion == 1) {
			op1();
		}
	}
	
	private void op1() {
		
		getSupportActionBar().setTitle("Atención Ciudadana");
		oneescudo.setImageUrl(UserData.SERVER_ADDRESS + Fragment_AtencionC.NoticiaCiudadana_lista.get(Fragment_AtencionC.posilista).getUserimagen(), imageLoader);
		oneimgprin.setImageUrl(UserData.SERVER_ADDRESS + Fragment_AtencionC.NoticiaCiudadana_lista.get(Fragment_AtencionC.posilista).getNoticiaimagen(), imageLoader);
		noticiaone_maps.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				Activity_Maps.opcion = 1;
				startActivity(new Intent(Activity_NoticiaIndividual.this, Activity_Maps.class));
			}
		});

//       PhotoViewAttacher pAttacher;
//       pAttacher = new PhotoViewAttacher(oneimgprin);
//       pAttacher.update();
		
		
		onedesc.setText(Fragment_AtencionC.NoticiaCiudadana_lista.get(Fragment_AtencionC.posilista).getDescripcion());
		onedesc.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				if (onedesc.getAlpha() >= 0.8f) {
					onedesc.setAlpha(0.5f);
				} else {
					onedesc.setAlpha(1.0f);
				}
			}
		});
		oneperson.setText(Fragment_AtencionC.NoticiaCiudadana_lista.get(Fragment_AtencionC.posilista).getNombreusuario());
		onetitle.setText(Fragment_AtencionC.NoticiaCiudadana_lista.get(Fragment_AtencionC.posilista).getTitulo());
//        oneaddr.setText(Fragment_AtencionC.NoticiaCiudadana_lista.get(Fragment_AtencionC.posilista).getUbicacion());
	}
  /*  // create an action bar button
    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.googlemap, menu);
        return super.onCreateOptionsMenu(menu);
    }
    // handle button activities
    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        int id = item.getItemId();
        if (id == R.id.locate) {
            Activity_Maps.opcion=1;
            startActivity(new Intent(Activity_NoticiaIndividual.this,Activity_Maps.class));
        }
        return super.onOptionsItemSelected(item);
    }*/
}
