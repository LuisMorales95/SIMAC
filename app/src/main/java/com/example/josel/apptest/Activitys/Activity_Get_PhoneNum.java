package com.example.josel.apptest.Activitys;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;

import com.example.josel.apptest.R;
import com.example.josel.apptest.UserData;


public class Activity_Get_PhoneNum extends AppCompatActivity {
	
	Button get_phone_number_validar;
	EditText get_phone_number_telefono;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_get_phonenum);
		get_phone_number_validar = (Button) findViewById(R.id.get_phone_number_validar);
		get_phone_number_telefono = (EditText) findViewById(R.id.get_phone_number_telefono);
		
		get_phone_number_validar.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View view) {
				if (get_phone_number_telefono.getText().length() == 10) {
					UserData.Telefono = "+52" + get_phone_number_telefono.getText().toString();
					Intent intent = new Intent();
					setResult(RESULT_OK, intent);
					finish();
				} else {
					final android.app.AlertDialog.Builder builder = new android.app.AlertDialog.Builder(Activity_Get_PhoneNum.this);
					builder.setMessage("Numero debe ser a 10 digitos!")
							.setTitle("Aviso")
							.setCancelable(false)
							.setPositiveButton(android.R.string.ok, null).show();
					builder.create();
				}
			}
		});
	}
}
