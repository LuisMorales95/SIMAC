package com.example.josel.apptest.Objects;

public class NoticiaCiudadana {
    String id;
    String titulo, descripcion, fecha, ubicacion;
    String noticiaimagen, userimagen, nombreusuario;
    String Longitud, Latitud;
    String like, comment, id_usuario;

    public NoticiaCiudadana() {

    }

    public NoticiaCiudadana(String id, String titulo, String descripcion, String fecha, String ubicacion, String noticiaimagen, String userimagen, String nombreusuario, String longitud, String latitud, String like, String comment, String id_usuario) {
        this.id = id;
        this.titulo = titulo;
        this.descripcion = descripcion;
        this.fecha = fecha;
        this.ubicacion = ubicacion;
        this.noticiaimagen = noticiaimagen;
        this.userimagen = userimagen;
        this.nombreusuario = nombreusuario;
        Longitud = longitud;
        Latitud = latitud;
        this.like = like;
        this.comment = comment;
        this.id_usuario = id_usuario;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public String getUbicacion() {
        return ubicacion;
    }

    public void setUbicacion(String ubicacion) {
        this.ubicacion = ubicacion;
    }

    public String getNoticiaimagen() {
        return noticiaimagen;
    }

    public void setNoticiaimagen(String noticiaimagen) {
        this.noticiaimagen = noticiaimagen;
    }

    public String getUserimagen() {
        return userimagen;
    }

    public void setUserimagen(String userimagen) {
        this.userimagen = userimagen;
    }

    public String getNombreusuario() {
        return nombreusuario;
    }

    public void setNombreusuario(String nombreusuario) {
        this.nombreusuario = nombreusuario;
    }

    public String getLongitud() {
        return Longitud;
    }

    public void setLongitud(String longitud) {
        Longitud = longitud;
    }

    public String getLatitud() {
        return Latitud;
    }

    public void setLatitud(String latitud) {
        Latitud = latitud;
    }

    public String getLike() {
        return like;
    }

    public void setLike(String like) {
        this.like = like;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public String getId_usuario() {
        return id_usuario;
    }

    public void setId_usuario(String id_usuario) {
        this.id_usuario = id_usuario;
    }
}
