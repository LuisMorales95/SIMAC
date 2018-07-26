package com.example.josel.apptest.Activitys;

import android.support.v7.app.ActionBar;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.TextView;

import com.android.volley.toolbox.ImageLoader;
import com.android.volley.toolbox.NetworkImageView;
import com.example.josel.apptest.Methods.AppController;
import com.example.josel.apptest.Methods.HTMLSimplifier;
import com.example.josel.apptest.Objects.NoticiaCiudadana;
import com.example.josel.apptest.R;

import java.util.ArrayList;
import java.util.List;

public class Activity_NoticiaMunicipal extends AppCompatActivity {

    public static List<NoticiaCiudadana> NoticiaMunicipal = new ArrayList<NoticiaCiudadana>();
    NetworkImageView NoticiaMun_Imagen;
    TextView NoticiaMun_Titulo;
    TextView NoticiaMun_Descripcion;
    public static int position;
    ImageLoader imageLoader = AppController.getInstance().getImageLoader();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_noticiamunicipal);
        getSupportActionBar().setTitle("Noticia");
        ActionBar actionBar = getSupportActionBar();
        actionBar.hide();
        NoticiaMun_Imagen = (NetworkImageView) findViewById(R.id.NoticiaMun_Imagen);
        NoticiaMun_Titulo = (TextView) findViewById(R.id.NoticiaMun_Titulo);
        NoticiaMun_Descripcion = (TextView) findViewById(R.id.NoticiaMun_Descripcion);
        if (imageLoader == null) imageLoader = AppController.getInstance().getImageLoader();
        NoticiaMun_Imagen.setImageUrl(NoticiaMunicipal.get(position).getNoticiaimagen(),imageLoader);
        NoticiaMun_Titulo.setText(NoticiaMunicipal.get(position).getTitulo());
        NoticiaMun_Descripcion.setText(HTMLSimplifier.eliminadorHTML(NoticiaMunicipal.get(position).getDescripcion()));
    }
}
