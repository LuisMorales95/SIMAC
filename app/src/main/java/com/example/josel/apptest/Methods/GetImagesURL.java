package com.example.josel.apptest.Methods;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.AsyncTask;
import android.widget.ImageView;

import com.example.josel.apptest.R;

import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;

/**
 * Created by josel on 26/03/2018.
 */

public class GetImagesURL extends AsyncTask<String, Void,Bitmap> {
    ImageView imgView;
    Bitmap bitmap;
    public GetImagesURL(ImageView imgView) {
        this.imgView = imgView;
    }

    @Override
    protected Bitmap doInBackground(String... url) {
        String urldisplay = url[0];
        bitmap = null;
        try {
            InputStream src = new java.net.URL(urldisplay).openStream();
            bitmap = BitmapFactory.decodeStream(src);
        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

        return bitmap;
    }

    @Override
    protected void onPostExecute(Bitmap bitmap) {
        super.onPostExecute(bitmap);
        if (bitmap != null) {
            imgView.setImageBitmap(bitmap);
        } else {
            imgView.setImageResource(R.drawable.wait);
            //imageView.setImageDrawable(placeholder);
        }
        imgView.setImageBitmap(bitmap);
    }
}