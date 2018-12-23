package com.Mezda.SIMAC.pending.Activities;

import android.content.Intent;
import android.net.Uri;
import android.support.v4.content.FileProvider;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

import com.Mezda.SIMAC.R;
import com.github.barteksc.pdfviewer.PDFView;

import java.io.File;

import butterknife.BindView;
import butterknife.ButterKnife;

public class PDFViewer extends AppCompatActivity {
    @BindView(R.id.pdfView)
    PDFView pdfView;
    public static File file;
    @BindView(R.id.PDF_Share)
    Button PDF_Share;
    
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_pdfviewer);
        ButterKnife.bind(this);
        pdfView.fromFile(file).load();
        PDF_Share.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Uri content = FileProvider.getUriForFile(getApplicationContext(),getResources().getString(R.string.ruta_interna),file);
                Intent sendIntent = new Intent(Intent.ACTION_SEND);
                sendIntent.setType(getString(R.string.AppPDF));
                sendIntent.putExtra(Intent.EXTRA_STREAM, content);
                sendIntent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
                startActivity(Intent.createChooser(sendIntent, getString(R.string.compartir)));
            }
        });
    }
    
}
