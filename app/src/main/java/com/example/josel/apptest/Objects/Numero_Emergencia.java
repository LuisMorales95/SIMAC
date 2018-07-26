package com.example.josel.apptest.Objects;

public class Numero_Emergencia {
    String id_emergencia, nombreEmergencia, telefono, extencion, img_emergencia;

    public Numero_Emergencia() {
    }

    public Numero_Emergencia(String id_emergencia, String nombreEmergencia, String telefono, String extencion, String img_emergencia) {
        this.id_emergencia = id_emergencia;
        this.nombreEmergencia = nombreEmergencia;
        this.telefono = telefono;
        this.extencion = extencion;
        this.img_emergencia = img_emergencia;
    }

    public String getId_emergencia() {
        return id_emergencia;
    }

    public void setId_emergencia(String id_emergencia) {
        this.id_emergencia = id_emergencia;
    }

    public String getNombreEmergencia() {
        return nombreEmergencia;
    }

    public void setNombreEmergencia(String nombreEmergencia) {
        this.nombreEmergencia = nombreEmergencia;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getExtencion() {
        return extencion;
    }

    public void setExtencion(String extencion) {
        this.extencion = extencion;
    }

    public String getImg_emergencia() {
        return img_emergencia;
    }

    public void setImg_emergencia(String img_emergencia) {
        this.img_emergencia = img_emergencia;
    }
}