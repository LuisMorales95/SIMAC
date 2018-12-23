package com.Mezda.SIMAC.data.dao;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

public class UserInfo {

    @SerializedName("id") @Expose
    private String id;

    @SerializedName("Nombre") @Expose
    private String nombre;

    @SerializedName("ApellidoP") @Expose
    private String apellidoP;

    @SerializedName("CorreoE") @Expose
    private String correoE;

    @SerializedName("Telefono") @Expose
    private String telefono;

    @SerializedName("Token") @Expose
    private String token;

    @SerializedName("ImgURL") @Expose
    private String imgURL;

    @SerializedName("fk_id_rol") @Expose
    private String fkIdRol;

    @SerializedName("Verificacion_Usuario") @Expose
    private String verificacionUsuario;

    @SerializedName("message") @Expose
    private String message;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellidoP() {
        return apellidoP;
    }

    public void setApellidoP(String apellidoP) {
        this.apellidoP = apellidoP;
    }

    public String getCorreoE() {
        return correoE;
    }

    public void setCorreoE(String correoE) {
        this.correoE = correoE;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public String getImgURL() {
        return imgURL;
    }

    public void setImgURL(String imgURL) {
        this.imgURL = imgURL;
    }

    public String getFkIdRol() {
        return fkIdRol;
    }

    public void setFkIdRol(String fkIdRol) {
        this.fkIdRol = fkIdRol;
    }

    public String getVerificacionUsuario() {
        return verificacionUsuario;
    }

    public void setVerificacionUsuario(String verificacionUsuario) {
        this.verificacionUsuario = verificacionUsuario;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
