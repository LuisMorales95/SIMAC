package com.Mezda.SIMAC.Objects;

public class LosUsuarios {
    String id_usuario,nombre,apellidop,numeroext,direccion,idcolonia,sexo,correoe,telefono,fechanac,fk_id_rol,imgurl;

    public LosUsuarios(){

    }

    public LosUsuarios(String id_usuario, String nombre, String apellidop, String numeroext, String direccion, String idcolonia, String sexo, String correoe, String telefono, String fechanac, String fk_id_rol, String imgurl) {
        this.id_usuario = id_usuario;
        this.nombre = nombre;
        this.apellidop = apellidop;
        this.numeroext = numeroext;
        this.direccion = direccion;
        this.idcolonia = idcolonia;
        this.sexo = sexo;
        this.correoe = correoe;
        this.telefono = telefono;
        this.fechanac = fechanac;
        this.fk_id_rol = fk_id_rol;
        this.imgurl = imgurl;
    }

    public String getId_usuario() {
        return id_usuario;
    }

    public void setId_usuario(String id_usuario) {
        this.id_usuario = id_usuario;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellidop() {
        return apellidop;
    }

    public void setApellidop(String apellidop) {
        this.apellidop = apellidop;
    }

    public String getNumeroext() {
        return numeroext;
    }

    public void setNumeroext(String numeroext) {
        this.numeroext = numeroext;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getIdcolonia() {
        return idcolonia;
    }

    public void setIdcolonia(String idcolonia) {
        this.idcolonia = idcolonia;
    }

    public String getSexo() {
        return sexo;
    }

    public void setSexo(String sexo) {
        this.sexo = sexo;
    }

    public String getCorreoe() {
        return correoe;
    }

    public void setCorreoe(String correoe) {
        this.correoe = correoe;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getFechanac() {
        return fechanac;
    }

    public void setFechanac(String fechanac) {
        this.fechanac = fechanac;
    }

    public String getFk_id_rol() {
        return fk_id_rol;
    }

    public void setFk_id_rol(String fk_id_rol) {
        this.fk_id_rol = fk_id_rol;
    }

    public String getImgurl() {
        return imgurl;
    }

    public void setImgurl(String imgurl) {
        this.imgurl = imgurl;
    }
}
