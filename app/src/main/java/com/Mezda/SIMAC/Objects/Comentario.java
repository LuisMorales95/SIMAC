package com.Mezda.SIMAC.Objects;

public class Comentario {
    String id_comentario,ImageUrl,Name,comment,fecha,Id_usuario;

    public Comentario( ) {

    }

    public Comentario(String id_comentario, String imageUrl, String name, String comment, String fecha, String id_usuario) {
        this.id_comentario = id_comentario;
        ImageUrl = imageUrl;
        Name = name;
        this.comment = comment;
        this.fecha = fecha;
        Id_usuario = id_usuario;
    }

    public String getId_comentario() {
        return id_comentario;
    }

    public void setId_comentario(String id_comentario) {
        this.id_comentario = id_comentario;
    }

    public String getImageUrl() {
        return ImageUrl;
    }

    public void setImageUrl(String imageUrl) {
        ImageUrl = imageUrl;
    }

    public String getName() {
        return Name;
    }

    public void setName(String name) {
        Name = name;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public String getId_usuario() {
        return Id_usuario;
    }

    public void setId_usuario(String id_usuario) {
        Id_usuario = id_usuario;
    }
}
