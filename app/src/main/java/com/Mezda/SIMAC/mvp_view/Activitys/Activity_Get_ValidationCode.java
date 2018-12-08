package com.Mezda.SIMAC.mvp_view.Activitys;

import android.app.ProgressDialog;
import android.content.DialogInterface;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import com.android.volley.AuthFailureError;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.Mezda.SIMAC.R;

import com.Mezda.SIMAC.UserData;
import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.FirebaseException;
import com.google.firebase.auth.AuthResult;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseAuthInvalidCredentialsException;
import com.google.firebase.auth.FirebaseUser;
import com.google.firebase.auth.PhoneAuthCredential;
import com.google.firebase.auth.PhoneAuthProvider;

import org.json.JSONArray;
import org.json.JSONException;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;

public class Activity_Get_ValidationCode extends AppCompatActivity {
    public static String Telefono = "";
    private TextView get_validation_code_validate;
    private EditText get_validation_code_code;
    private Button get_validation_code_send;
    private int btnType = 0;
    private PhoneAuthProvider.OnVerificationStateChangedCallbacks callbacks;
    private FirebaseAuth mAuth;
    private String mVerificationId;
    private PhoneAuthProvider.ForceResendingToken mResendToken;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_get_validationcode);
        ProgressDialog proBuilder = new ProgressDialog(Activity_Get_ValidationCode.this);
        get_validation_code_validate = (TextView) findViewById(R.id.get_validation_code_validate);
        get_validation_code_code = (EditText) findViewById(R.id.get_validation_code_code);
        get_validation_code_code.setEnabled(false);
        get_validation_code_send = (Button) findViewById(R.id.get_validation_code_send);
        mAuth = FirebaseAuth.getInstance();
        get_validation_code_send.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (btnType==0) {
                    proBuilder.setMessage("Enviado Codigo de Verificacion");
                    proBuilder.setCancelable(false);
                    proBuilder.show();
                    PhoneAuthProvider.getInstance().verifyPhoneNumber(
                            Telefono,
                            120,
                            TimeUnit.SECONDS,
                            Activity_Get_ValidationCode.this,
                            callbacks
                    );
                    get_validation_code_send.setEnabled(false);
                }else{
                    get_validation_code_send.setEnabled(false);
                    String verificacionCode = get_validation_code_code.getText().toString();
                    PhoneAuthCredential phoneAuthCredential =  PhoneAuthProvider.getCredential(mVerificationId,verificacionCode);
                    signInWithPhoneAuthCredential(phoneAuthCredential);
                }
            }
        });
        
        callbacks = new PhoneAuthProvider.OnVerificationStateChangedCallbacks() {
            @Override
            public void onVerificationCompleted(PhoneAuthCredential phoneAuthCredential) {
                get_validation_code_code.setText(phoneAuthCredential.getSmsCode().toString());
                signInWithPhoneAuthCredential(phoneAuthCredential);
            }
            @Override
            public void onVerificationFailed(FirebaseException e) {
                proBuilder.dismiss();
                new AlertDialog.Builder(Activity_Get_ValidationCode.this)
                        .setMessage(e.toString())
                        .setPositiveButton("Ok", new DialogInterface.OnClickListener() {
                            @Override
                            public void onClick(DialogInterface dialog, int which) {
                                dialog.dismiss();
                                finish();
                            }
                        }).show();
            }
            @Override
            public void onCodeSent(String s, PhoneAuthProvider.ForceResendingToken forceResendingToken) {
                super.onCodeSent(s, forceResendingToken);
                Toast.makeText(Activity_Get_ValidationCode.this, "Codigo Enviado", Toast.LENGTH_SHORT).show();
                mVerificationId = s;
                mResendToken = forceResendingToken;
                proBuilder.dismiss();
                btnType=1;
                get_validation_code_code.setEnabled(true);
                get_validation_code_validate.setText("Codigo Enviado");
                get_validation_code_send.setText("Verificar Codigo");
                get_validation_code_send.setEnabled(true);
            }
        };
    }
    
    private void signInWithPhoneAuthCredential(PhoneAuthCredential credential) {
        mAuth.signInWithCredential(credential)
                .addOnCompleteListener(this, new OnCompleteListener<AuthResult>() {
                    @Override
                    public void onComplete(@NonNull Task<AuthResult> task) {
                        if (task.isSuccessful()) {
                            // Sign in success, update UI with the signed-in user's information
                            Log.d("FireBase", "signInWithCredential:success");
                            FirebaseUser user = task.getResult().getUser();
                            if (get_validation_code_code.getText().length() == 6) {
                                final ProgressDialog progressDialog = new ProgressDialog(Activity_Get_ValidationCode.this);
                                progressDialog.setMessage("Activando Cuenta");
                                progressDialog.setCancelable(false);
                                progressDialog.show();
                                RequestQueue requestQueue = Volley.newRequestQueue(getApplicationContext());
                                String Url = UserData.SERVER_ADDRESS + "validateaccount.php";
                                StringRequest postrequest = new StringRequest(
                                        Request.Method.POST,
                                        Url,
                                        new Response.Listener<String>() {
                                            @Override
                                            public void onResponse(String response) {
                                                try {
                                                    JSONArray jsonArray = new JSONArray(response);
                                                    String exito = jsonArray.getJSONObject(0).getString("EXITO");
                                                    if (exito.equals("SI")) {
                                                        progressDialog.dismiss();
                                                        final android.app.AlertDialog.Builder builder =
                                                                new android.app.AlertDialog.Builder(Activity_Get_ValidationCode.this);
                                                        builder.setMessage("Cuenta Activada")
                                                                .setTitle("Aviso")
                                                                .setCancelable(false)
                                                                .setPositiveButton(android.R.string.ok, new DialogInterface.OnClickListener() {
                                                                    @Override
                                                                    public void onClick(DialogInterface dialogInterface, int i) {
                                                                        finish();
                                                                    }
                                                                }).show();
                                                        builder.create();
                                                    } else if (exito.equals("NO")) {
                                                        progressDialog.dismiss();
                                                        final android.app.AlertDialog.Builder builder =
                                                                new android.app.AlertDialog.Builder(Activity_Get_ValidationCode.this);
                                                        builder.setMessage("Codigo Invalido")
                                                                .setTitle("Aviso")
                                                                .setCancelable(false)
                                                                .setPositiveButton(android.R.string.ok, new DialogInterface.OnClickListener() {
                                                                    @Override
                                                                    public void onClick(DialogInterface dialogInterface, int i) {
                                                                        finish();
                                                                    }
                                                                }).show();
                                                        builder.create();
                                                    } else {
                                                        progressDialog.dismiss();
                                                        final android.app.AlertDialog.Builder builder =
                                                                new android.app.AlertDialog.Builder(Activity_Get_ValidationCode.this);
                                                        builder.setMessage("Error en Servidor")
                                                                .setTitle("Aviso")
                                                                .setCancelable(false)
                                                                .setPositiveButton(android.R.string.ok, new DialogInterface.OnClickListener() {
                                                                    @Override
                                                                    public void onClick(DialogInterface dialogInterface, int i) {
                                                                        finish();
                                                                    }
                                                                }).show();
                                                        builder.create();
                                                    }
                                                    
                                                } catch (JSONException e) {
                                                    e.printStackTrace();
                                                }
                                            }
                                        }, new Response.ErrorListener() {
                                    @Override
                                    public void onErrorResponse(VolleyError error) {
                                        progressDialog.dismiss();
                                        final android.app.AlertDialog.Builder builder =
                                                new android.app.AlertDialog.Builder(Activity_Get_ValidationCode.this);
                                        builder.setMessage(error.toString())
                                                .setTitle("Aviso")
                                                .setCancelable(false)
                                                .setPositiveButton(android.R.string.ok, new DialogInterface.OnClickListener() {
                                                    @Override
                                                    public void onClick(DialogInterface dialogInterface, int i) {
                                                        finish();
                                                    }
                                                }).show();
                                        builder.create();
                                    }
                                }) {
                                    @Override
                                    protected Map<String, String> getParams() throws AuthFailureError {
                                        Map<String, String> params = new HashMap<String, String>();
                                        params.put("telefono", UserData.Telefono);
                                        return params;
                                        
                                    }
                                };
                                requestQueue.add(postrequest);
                            } else {
                                final android.app.AlertDialog.Builder builder = new android.app.AlertDialog.Builder(Activity_Get_ValidationCode.this);
                                builder.setMessage("Codigo debe ser de 6 Caracteres")
                                        .setTitle("Aviso")
                                        .setCancelable(false)
                                        .setPositiveButton(android.R.string.ok, null).show();
                                builder.create();
                            }
                        } else {
                            // Sign in failed, display a message and update the UI
                            Log.w("FireBase", "signInWithCredential:failure", task.getException());
                            if (task.getException() instanceof FirebaseAuthInvalidCredentialsException) {
                                //TODO The verification code entered was invalid*****************************************
                            }
                        }
                    }
                });
    }
    
}
