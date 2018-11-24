package com.Mezda.SIMAC;

import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.media.RingtoneManager;
import android.net.Uri;
import android.os.Vibrator;
import android.support.v4.app.NotificationCompat;
import android.support.v4.content.ContextCompat;

import com.Mezda.SIMAC.Activitys.Activity_Main;
import com.Mezda.SIMAC.R;

import com.google.firebase.messaging.FirebaseMessagingService;
import com.google.firebase.messaging.RemoteMessage;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.regex.Pattern;

public class MyFirebaseMessagingService extends FirebaseMessagingService {
	String type = "";
	
	
	@Override
	public void onMessageReceived(RemoteMessage remoteMessage) {
		
		if (remoteMessage.getData().toString().length() > 0) {
			sendNotification(remoteMessage.getData().toString());
		}
		
	}
	private void sendNotification(String messageBody) {
		Bitmap bitmappic = BitmapFactory.decodeResource(this.getResources(), R.drawable.icon_notification);
		String message = "";
		String title = "";
		
		try {
			JSONObject jsonObject = new JSONObject(messageBody);
			message = jsonObject.getString("body");
			title = jsonObject.getString("title");
		} catch (JSONException e) {
			e.printStackTrace();
		}
		String tituloultimo = "";
		String[] parts = title.split(Pattern.quote("~"));
		for (int i = 0; i < parts.length; i++) {
			tituloultimo += parts[i] + " ";
		}
		String messageultimo = "";
		String direccion = "";
		String[] partsmensaje = message.split(Pattern.quote("~"));
		for (int i = 0; i < partsmensaje.length; i++) {
			if (i == partsmensaje.length - 1) {
				direccion = partsmensaje[i];
			} else {
				messageultimo += partsmensaje[i] + " ";
			}
		}
		Intent intent = new Intent(this, Activity_Main.class);
		intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
		
		PendingIntent pendingIntent = PendingIntent.getActivity(this, 0, intent, PendingIntent.FLAG_ONE_SHOT);
		
		Uri soundUri = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_NOTIFICATION);
		
		NotificationCompat.Builder notificationBuilder = new NotificationCompat.Builder(this);
		
		notificationBuilder.setSmallIcon(R.drawable.logosim);
		notificationBuilder.setLargeIcon(bitmappic);
		notificationBuilder.setColor(ContextCompat.getColor(this, R.color.colorPrimaryDark));
		
		notificationBuilder.setContentTitle(tituloultimo);
		notificationBuilder.setContentText(messageultimo);
		
		notificationBuilder.setSound(soundUri);
		notificationBuilder.setAutoCancel(true);
		notificationBuilder.setContentIntent(pendingIntent);
		
		Vibrator v = (Vibrator) this.getSystemService(Context.VIBRATOR_SERVICE);
		v.vibrate(1000);
		
		
		NotificationManager notificationManager = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
		
		notificationManager.notify(1, notificationBuilder.build());
	}
	
}