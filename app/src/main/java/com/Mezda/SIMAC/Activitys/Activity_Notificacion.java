package com.Mezda.SIMAC.Activitys;

import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.PorterDuff;
import android.graphics.PorterDuffXfermode;
import android.graphics.Rect;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.util.DisplayMetrics;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.TextView;

import com.Mezda.SIMAC.R;

import com.Mezda.SIMAC.UserData;
import com.bumptech.glide.Glide;

public class Activity_Notificacion extends AppCompatActivity {
	
	private String title, mensaje, direccion;
	private TextView notificacion_title;
	private ImageView notificacion_image;
	private TextView notificacion_message;
	private ImageButton notificacion_close;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_notificacion);
		DisplayMetrics displayMetrics = new DisplayMetrics();
		
		
		notificacion_title = (TextView) findViewById(R.id.notificacion_title);
		notificacion_image = (ImageView) findViewById(R.id.notificacion_image);
		notificacion_message = (TextView) findViewById(R.id.notificacion_message);
		notificacion_close = (ImageButton) findViewById(R.id.notificacion_close);
		
		notificacion_close.setOnClickListener(view -> finish());
		
		Bundle bundle = getIntent().getExtras();
		if (bundle != null) {
			title = bundle.getString("title");
			mensaje = bundle.getString("mensaje");
			direccion = bundle.getString("dir");
		}
		
		notificacion_title.setText(title);
		
		getWindowManager().getDefaultDisplay().getMetrics(displayMetrics);
		int width = displayMetrics.widthPixels;
		width = (width / 100) * 60;
		notificacion_image.getLayoutParams().height = width;
		notificacion_image.getLayoutParams().width = width;
		Glide.with(getApplicationContext()).load(UserData.SERVER_ADDRESS + "imagen/" + direccion + ".jpg").into(notificacion_image);
		/*Picasso.get()
				.load(UserData.SERVER_ADDRESS + "imagen/" + direccion + ".jpg")
				.into(notificacion_image, new Callback() {
					@Override
					public void onSuccess() {
						Bitmap maped = ((BitmapDrawable) notificacion_image.getDrawable()).getBitmap();
						Bitmap dstBmp;
						if (maped.getWidth() >= maped.getHeight()) {
							dstBmp = Bitmap.createBitmap(
									maped,
									maped.getWidth() / 2 - maped.getHeight() / 2,
									0,
									maped.getHeight(),
									maped.getHeight()
							);
						} else {
							dstBmp = Bitmap.createBitmap(
									maped,
									0,
									maped.getHeight() / 2 - maped.getWidth() / 2,
									maped.getWidth(),
									maped.getWidth()
							);
						}
						notificacion_image.setImageBitmap(getCroppedBitmap(dstBmp));
					}
					
					@Override
					public void onError(Exception e) {
					
					}
				});*/
		notificacion_message.setText(mensaje);
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
		canvas.drawCircle(bitmap.getWidth() / 2, bitmap.getHeight() / 2,
				bitmap.getWidth() / 2, paint);
		paint.setXfermode(new PorterDuffXfermode(PorterDuff.Mode.SRC_IN));
		canvas.drawBitmap(bitmap, rect, rect, paint);
		return output;
	}
	
}
