package com.Mezda.SIMAC.mvp_view.Activitys;

import android.os.Bundle;
import android.support.v7.app.ActionBar;
import android.support.v7.app.AppCompatActivity;
import android.widget.ImageView;
import android.widget.TextView;

import com.Mezda.SIMAC.R;
import com.Mezda.SIMAC.Methods.HTMLSimplifier;
import com.Mezda.SIMAC.Objects.NoticiaCiudadana;
import com.bumptech.glide.Glide;

public class Activity_NoticiaMunicipal extends AppCompatActivity {

    public static NoticiaCiudadana noticiaCiudadana;
    ImageView NoticiaMun_Imagen;
    TextView NoticiaMun_Titulo;
    TextView NoticiaMun_Descripcion;
    public static int position;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_noticiamunicipal);
        getSupportActionBar().setTitle("Noticia");
        ActionBar actionBar = getSupportActionBar();
        actionBar.hide();
        NoticiaMun_Imagen = (ImageView) findViewById(R.id.NoticiaMun_Imagen);
        NoticiaMun_Titulo = (TextView) findViewById(R.id.NoticiaMun_Titulo);
        NoticiaMun_Descripcion = (TextView) findViewById(R.id.NoticiaMun_Descripcion);
        Glide.with(this).load(noticiaCiudadana.getNoticiaimagen()).into(NoticiaMun_Imagen);
        NoticiaMun_Titulo.setText(noticiaCiudadana.getTitulo());
        NoticiaMun_Descripcion.setText(HTMLSimplifier.eliminadorHTML(noticiaCiudadana.getDescripcion()));
    }
}
