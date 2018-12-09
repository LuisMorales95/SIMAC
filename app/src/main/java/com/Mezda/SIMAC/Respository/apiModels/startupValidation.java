package com.Mezda.SIMAC.Respository.apiModels;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

public class startupValidation {

    @SerializedName("id")
    @Expose
    private String id;
    @SerializedName("Nombre")
    @Expose
    private String nombre;
    @SerializedName("ApellidoP")
    @Expose
    private String apellidoP;
    @SerializedName("NumeroExt")
    @Expose
    private String numeroExt;
    @SerializedName("Direccion")
    @Expose
    private String direccion;
    @SerializedName("IdColonia")
    @Expose
    private String idColonia;
    @SerializedName("Sexo")
    @Expose
    private String sexo;
    @SerializedName("CorreoE")
    @Expose
    private String correoE;
    @SerializedName("Telefono")
    @Expose
    private String telefono;
    @SerializedName("fechaNac")
    @Expose
    private String fechaNac;
    @SerializedName("Contrasena")
    @Expose
    private String contrasena;
    @SerializedName("Token")
    @Expose
    private String token;
    @SerializedName("ImgURL")
    @Expose
    private String imgURL;
    @SerializedName("tokennotif")
    @Expose
    private String tokennotif;
    @SerializedName("fk_id_rol")
    @Expose
    private String fkIdRol;
    @SerializedName("Verificacion_Usuario")
    @Expose
    private String verificacionUsuario;

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

    public String getNumeroExt() {
        return numeroExt;
    }

    public void setNumeroExt(String numeroExt) {
        this.numeroExt = numeroExt;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getIdColonia() {
        return idColonia;
    }

    public void setIdColonia(String idColonia) {
        this.idColonia = idColonia;
    }

    public String getSexo() {
        return sexo;
    }

    public void setSexo(String sexo) {
        this.sexo = sexo;
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

    public String getFechaNac() {
        return fechaNac;
    }

    public void setFechaNac(String fechaNac) {
        this.fechaNac = fechaNac;
    }

    public String getContrasena() {
        return contrasena;
    }

    public void setContrasena(String contrasena) {
        this.contrasena = contrasena;
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

    public String getTokennotif() {
        return tokennotif;
    }

    public void setTokennotif(String tokennotif) {
        this.tokennotif = tokennotif;
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

}
