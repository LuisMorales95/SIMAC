package com.Mezda.SIMAC.data.prefs;

import android.content.SharedPreferences;

import com.Mezda.SIMAC.data.dao.UserInfo;

import static com.Mezda.SIMAC.utils.Constants.Base;
import static com.Mezda.SIMAC.utils.Constants.FacebookUrl;

public class UserPreferences {

    private String id="id";
    private String token = "token";
    private String profileImage= "image";
    private String name = "name";
    private String email  = "email";
    private String authorization = "authorization";
    private String phone = "phone";
    private String idFacebook = "idFacebook";
    private String verified = "verified";

    private SharedPreferences sharedPreferences;

    public UserPreferences(SharedPreferences sharedPreferences) {
        this.sharedPreferences = sharedPreferences;
    }

    public String getValue(String key){
        return sharedPreferences.getString(key,"");
    }
    public void setValue(String key,String value){
        sharedPreferences.edit().putString(key, value).apply();
    }

    public String getId() {
        return getValue(this.id);
    }

    public void setId(String id) {
        setValue(this.id,id);
    }

    public String getToken() {
        return getValue(this.token);
    }

    public void setToken(String token) {
        setValue(this.token,token);
    }

    public String getProfileImage() {
        return sharedPreferences.getString(this.profileImage,"http://192.168.1.68/SIMACApi/profilpic/icon.png");
    }

    public void setProfileImage(String profileImage) {
        setValue(this.profileImage,profileImage);
    }

    public String getName() {
        if (!getValue(this.name).isEmpty()){
            return getValue(this.name);
        }
        return sharedPreferences.getString(this.profileImage,"Default User");
    }

    public void setName(String name) {
        setValue(this.name,name);
    }

    public String getEmail() {
        if (!getValue(this.email).isEmpty()) {
            return getValue(this.email);
        }
        return sharedPreferences.getString(this.profileImage,"defaultUser@example.com");
    }

    public void setEmail(String email) {
        setValue(this.email,email);
    }

    public String getAuthorization() {
        return getValue(this.authorization);
    }

    public void setAuthorization(String authorization) {
        setValue(this.authorization,authorization);
    }

    public String getPhone() {
        return getValue(this.phone);
    }

    public void setPhone(String phone) {
        setValue(this.phone,phone);
    }

    public String getIdFacebook() {
        return getValue(this.idFacebook);
    }

    public void setIdFacebook(String idFacebook) {
        setValue(this.idFacebook, idFacebook);
    }

    public String getVerified() {
        return getValue(this.verified);
    }

    public void setVerified(String verified) {
        setValue(this.verified,verified);
    }

    public void EmptyPreferences(){
        SharedPreferences.Editor editor = sharedPreferences.edit();
        editor.remove(this.id);
        editor.remove(this.token);
        editor.remove(this.profileImage);
        editor.remove(this.name);
        editor.remove(this.email);
        editor.remove(this.authorization);
        editor.remove(this.phone);
        editor.remove(this.idFacebook);
        editor.remove(this.verified);
        editor.apply();
    }
    public void saveUserInfo(UserInfo userInfo){
        setValue(this.id,userInfo.getId());
        setValue(this.token,userInfo.getToken());
        if (!userInfo.getImgURL().isEmpty()){
            if (userInfo.getImgURL().contains("profilpic")){
                setValue(this.profileImage, Base +userInfo.getImgURL());
            }else{
                setValue(this.profileImage,FacebookUrl.replace("{facebookId}",getValue(this.getIdFacebook())));
            }
        }
        setValue(this.name, userInfo.getNombre()+" "+userInfo.getApellidoP());
        setValue(this.email,userInfo.getCorreoE());
        setValue(this.authorization,userInfo.getFkIdRol());
        setValue(this.phone, userInfo.getTelefono());
        setValue(this.verified, userInfo.getVerificacionUsuario());
    }
}
