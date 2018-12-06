package com.Mezda.SIMAC.Methods;

import android.app.ProgressDialog;
import android.content.Context;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentActivity;
import android.support.v4.app.FragmentManager;
import android.util.Base64;
import android.util.Log;
import android.view.View;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.Toast;

import com.Mezda.SIMAC.Fragments.Fragment_Facturar_Busqueda;
import com.Mezda.SIMAC.Fragments.Fragment_Facturar_Datos;
import com.Mezda.SIMAC.Objects.Recibo;
import com.Mezda.SIMAC.R;
import com.Mezda.SIMAC.UserData;
import com.android.volley.AuthFailureError;
import com.android.volley.DefaultRetryPolicy;
import com.android.volley.Request;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.JsonObjectRequest;
import com.google.gson.Gson;

import org.apache.commons.io.FileUtils;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import static com.Mezda.SIMAC.Methods.StaticData.MetodoDePagos;
import static com.Mezda.SIMAC.Methods.StaticData.UsoCFDIs;
import static com.Mezda.SIMAC.Methods.VolleySingleton.*;

public class Factura implements View.OnClickListener {
    private Context context;
    private String password;
    private Recibo recibo;
    private String content;
    private String archivobase64;
    private EditText rfc,nombre,correo,direccion;
    private Spinner usoCDFI, formaPago;
    private ProgressDialog progressDialog;
    private Gson gson;
    public Factura(Context context, String password, Recibo recibo, EditText rfc, EditText nombre, EditText correo, Spinner formaPago, Spinner usoCDFI, EditText Direccion) {
        this.context = context;
        this.password = password;
        this.recibo = recibo;
        this.rfc=rfc;
        this.nombre=nombre;
        this.correo=correo;
        this.direccion=Direccion;
        this.usoCDFI=usoCDFI;
        this.formaPago=formaPago;
        this.gson = new Gson();
    }
    
    @Override
    public void onClick(View v) {
        progressDialog = new ProgressDialog(context);
        progressDialog.setMessage("Generando CFDI...");
        progressDialog.show();
        content = ContentArchivo(
                recibo,rfc.getText().toString(),
                nombre.getText().toString(),
                correo.getText().toString(),
                MetodoDePagos().get(formaPago.getSelectedItemPosition()).getId(),
                UsoCFDIs().get(usoCDFI.getSelectedItemPosition()).getId(),
                direccion.getText().toString());
        
                Log.i("Info-File",FileCreator(recibo));
        archivobase64 = FileToBytes(FileCreator(recibo));
        recibo.setRfc(rfc.getText().toString());
        recibo.setmSocialReason(nombre.getText().toString());
        recibo.setmAddress(direccion.getText().toString());
        recibo.setmEmail(correo.getText().toString());
        recibo.setmAddress(direccion.getText().toString());
        recibo.setmPaymentMethod(MetodoDePagos().get(formaPago.getSelectedItemPosition()).getId());
        recibo.setmElectronicBilling(UsoCFDIs().get(usoCDFI.getSelectedItemPosition()).getId());
        String mGsonBill = gson.toJson(recibo);
        if (archivobase64!=null){
            Map<String,String> map = new HashMap<>();
            map.put("mBill",mGsonBill);
            map.put("Password",password);
            map.put("File64",archivobase64);
            map.put("file_name",recibo.getFolio());
            JSONObject object = new JSONObject(map);
            JsonObjectRequest request = new JsonObjectRequest(
                    Request.Method.POST,
                    UserData.Factura_RequestFactura,
                    object,
                    new Response.Listener<JSONObject>() {
                        @Override
                        public void onResponse(JSONObject response) {
                            progressDialog.dismiss();
    
                            try {
                                if (response.getString("MSJ").contains("Factura timbrada correctamente")){
                                    getFileFromBase64AndSaveInSDCard(response.getString("PDF64"),response.getString("NAMEFILE"),"pdf");
                                    getFileFromBase64AndSaveInSDCard(response.getString("XML64"),response.getString("NAMEFILE"),"xml");
                                    new AlertDialog.Builder(context)
                                            .setMessage(response.getString("MSJ"))
                                            .setCancelable(false)
                                            .setPositiveButton(R.string.dialog_ok, new DialogInterface.OnClickListener() {
                                                @Override
                                                public void onClick(DialogInterface dialog, int which) {
                                                    ((FragmentActivity)context).getSupportFragmentManager().
                                                            beginTransaction().replace(R.id.content_Factura,new Fragment_Facturar_Busqueda()).commit();
                                                }
                                            }).show();
                                }else{
                                    new AlertDialog.Builder(context)
                                            .setMessage(response.getString("MSJ"))
                                            .setCancelable(false)
                                            .setPositiveButton(R.string.dialog_ok, new DialogInterface.OnClickListener() {
                                                @Override
                                                public void onClick(DialogInterface dialog, int which) {
                                                    ((FragmentActivity)context).getSupportFragmentManager().
                                                            beginTransaction().replace(R.id.content_Factura,new Fragment_Facturar_Busqueda()).commit();
                                                }
                                            }).show();
                                }
                                
                            } catch (JSONException e) {
                                e.printStackTrace();
                            }
                        }
                    },
                    new Response.ErrorListener() {
                        @Override
                        public void onErrorResponse(VolleyError error) {
                            progressDialog.dismiss();
                            Log.e(context.getResources().getString(R.string.Tag_VolleyError),error.toString());
                            new AlertDialog.Builder(context).setMessage(error.toString()).show();
                
                        }
                    }
            ){
                @Override
                public Map<String, String> getHeaders() throws AuthFailureError {
                    Map<String, String> headers = new HashMap<String, String>();
                    headers.put("Content-Type", "application/json; charset=utf-8");
                    headers.put("Accept", "application/json");
                    return headers;
                }
            };
            request.setRetryPolicy(new DefaultRetryPolicy(10000,
                    DefaultRetryPolicy.DEFAULT_MAX_RETRIES,
                    DefaultRetryPolicy.DEFAULT_BACKOFF_MULT));
            getInstance().addToRequestQueue(request);
        }
        
    }
   
    
    public String FileToBytes(String filePath){
        File file = new File(filePath);
        byte[] b = new byte[(int) file.length()];
        FileInputStream fileInputStream = null;
        String base64String = "";
        try {
            fileInputStream = new FileInputStream(file);
            fileInputStream.read(b);
            byte[] byteFileArray = new byte[0];
            byteFileArray = FileUtils.readFileToByteArray(file);
            if (byteFileArray.length>0){
                base64String = android.util.Base64.encodeToString(byteFileArray, Base64.NO_WRAP);
            }
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        Log.d("Response",base64String);
        return base64String;
    }
    public String FileCreator(Recibo recibo){
        File gpxfile = null;
    
        try {
            String filename = "Facturas";
            File root = SuperContext().getExternalFilesDir(SuperContext().getResources().getString(R.string.carpetaFacturas));
            if (!root.exists()) root.mkdir();
            gpxfile = new File(root,recibo.getFolio().concat(".txt"));
            FileWriter writer = new FileWriter(gpxfile);
            writer.append(content);
            writer.flush();
            writer.close();
            Toast.makeText(context, "Archivo Creado", Toast.LENGTH_SHORT).show();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return gpxfile.getAbsolutePath();
    }
    String ContentArchivo(Recibo recibo,String RFC,String Nombre,String Correo,String FormaPago, String UsoCDFI,String Direccion){
        
        String day = recibo.getFecha().substring(0,2);
        String month = recibo.getFecha().substring(3,5);
        String year = recibo.getFecha().substring(6,10);
        String[] date_time = recibo.getFecha().replace(" ","T").split("T");
        /*+todo target 2018-10-05T11:07:24
         *  todo phone 12/01/2018T08:34:52*/
        return
            "[Datos Generales]\n" +
                    "Version|3.3\n" +
                    "Serie|AD\n" +
                    "Folio|"+recibo.getFolio()+"\n" +
                    "Fecha|"+year+"-"+month+"-"+day+"T"+date_time[1]+"\n"+
                    "FormaPago|"+FormaPago+"\n" +
                    "CondicionesDePago|PAGO EN UNA SOLA EXHIBICIÓN\n" +
                    "Subtotal|"+ String.valueOf(Double.valueOf(recibo.getCorriente())+Double.valueOf(recibo.getAdicional()))+"\n" +
                    "Descuento|"+String.valueOf(Double.valueOf(recibo.getDescuento20())+Double.valueOf(recibo.getDescuento50()))+"\n" +
                    "Moneda|MXN\n" +
                    "TipoCambio|1\n" +
                    "Total|"+recibo.getTotal()+"\n" +
                    "TipoDeComprobante|I\n"+
                    "MetodoPago|PUE\n" +
                    "numCtaPago|\n" +
                    "LugarExpedicion|96660\n" +
                    "\n" +
                    "[DATOS DEL EMISOR]\n" +
//                    "emRfc|AAA010101AAA\n" +MAD8812014V1
                    "emRfc|MAD8812014V1\n" +
                    "emNombre|MUNICIPIO DE AGUA DULCE VER\n" +
                    "emRegimenFiscal|603\n" +
                    "\n" +
                    "\n" +
                    "[DATOS DEL RECEPTOR]\n" +
                    "reRfc|"+RFC+"\n" +
                    "reNombre|"+Nombre+"\n" +
                    "reUsoCFDI|"+UsoCDFI+"\n" +
                    "reEmail|JOSELUISMORALESP95@GMAIL.COM,cfdi.aguadulce@gmail.com,"+Correo+"\n" +
                    "\n" +
                    "ClaveProdServ|93161700\n" +
                    "NoIdentificacion|1\n" +
                    "Cantidad|1\n" +
                    "ClaveUnidad|ACT\n" +
                    "Unidad|RECAUDACION\n" +
                    "Descripcion|"+recibo.getConcepto1()+" "+recibo.getConcepto2()+" "+recibo.getConcepto3()+" "+recibo.getConcepto4()+"\n" +
                    "ValorUnitario|"+recibo.getCorriente()+"\n" +
                    "Importe|"+recibo.getCorriente()+"\n" +
                    "conDescuento|"+String.valueOf(Double.valueOf(recibo.getDescuento20())+Double.valueOf(recibo.getDescuento50()))+"\n" +
                    "\n" +
                    "ClaveProdServ|93161700\n" +
                    "NoIdentificacion|2\n" +
                    "Cantidad|1\n" +
                    "ClaveUnidad|ACT\n" +
                    "Unidad|RECAUDACION\n" +
                    "Descripcion|ADICIONAL\n" +
                    "ValorUnitario|"+recibo.getAdicional()+"\n" +
                    "Importe|"+recibo.getAdicional()+"\n" +
                    "\n" +
                    "\n" +
                    "\n" +
                    "\n" +
                    "\n" +
                    "[EXTRAS]\n" +
                    "LeyendaEspecial1|"+Direccion+"\n" +
                    "LeyendaEspecial2|\n";
    }
    
    
    public static GetFilePathAndStatus getFileFromBase64AndSaveInSDCard(String base64, String filename,String extension){
        GetFilePathAndStatus getFilePathAndStatus = new GetFilePathAndStatus();
        try {
            
            File directory = SuperContext().getExternalFilesDir(SuperContext().getResources().getString(R.string.carpetaFacturados));
            if (!directory.exists()) {
                directory.mkdirs();
            }
            File[] files = directory.listFiles();
            String[] splits = filename.split("-");
            if(files.length>0){
                for (int i = 0; i < files.length; i++){
                    if (files[i].getName().contains(splits[1])&&files[i].getName().contains(extension)){
                        boolean deleted =  files[i].delete();
                    }
        
                }
            }
            
            
            byte[] pdfAsBytes = Base64.decode(base64, 0);
            FileOutputStream os;
            os = new FileOutputStream(getReportPath(filename,extension), false);
            os.write(pdfAsBytes);
            os.flush();
            os.close();
            getFilePathAndStatus.filStatus = true;
            getFilePathAndStatus.filePath = getReportPath(filename,extension);
            return getFilePathAndStatus;
        } catch (IOException e) {
            e.printStackTrace();
            getFilePathAndStatus.filStatus = false;
            getFilePathAndStatus.filePath = getReportPath(filename,extension);
            return getFilePathAndStatus;
        }
    }
    public static String getReportPath(String filename,String extension) {
        File file = SuperContext().getExternalFilesDir(SuperContext().getResources().getString(R.string.carpetaFacturados));
        if (!file.exists()) {
            file.mkdirs();
        }
        String uriSting = (file.getAbsolutePath() + "/" + filename + "."+extension);
        return uriSting;
        
    }
    public static class GetFilePathAndStatus{
        public boolean filStatus;
        public String filePath;
        
    }

}
