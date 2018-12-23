package com.Mezda.SIMAC.data.dao;

import android.os.Parcel;
import android.os.Parcelable;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

public class Article implements Parcelable {

    @SerializedName("id_alerta")
    @Expose
    private String id;
    @SerializedName("id")
    @Expose
    private String userId;
    @SerializedName("titulo")
    @Expose
    private String headline;
    @SerializedName("descripcion")
    @Expose
    private String content;
    @SerializedName("fecha")
    @Expose
    private String date;
    @SerializedName("ubicacion")
    @Expose
    private String place;
    @SerializedName("alertaimg")
    @Expose
    private String image;
    @SerializedName("longitud")
    @Expose
    private String longitude;
    @SerializedName("latitud")
    @Expose
    private String latitude;
    @SerializedName("nombre")
    @Expose
    private String userName;
    @SerializedName("ImgURL")
    @Expose
    private String userImage;
    @SerializedName("like")
    @Expose
    private String like;
    @SerializedName("comment")
    @Expose
    private String comment;
    public Article() {

    }

    public Article(String id, String headline, String content, String date, String place, String image, String userImage, String userName, String longitude, String latitude, String like, String comment, String userId) {
        this.id = id;
        this.headline = headline;
        this.content = content;
        this.date = date;
        this.place = place;
        this.image = image;
        this.userImage = userImage;
        this.userName = userName;
        this.longitude = longitude;
        this.latitude = latitude;
        this.like = like;
        this.comment = comment;
        this.userId = userId;
    }

    protected Article(Parcel in) {
        id = in.readString();
        userId = in.readString();
        headline = in.readString();
        content = in.readString();
        date = in.readString();
        place = in.readString();
        image = in.readString();
        longitude = in.readString();
        latitude = in.readString();
        userName = in.readString();
        userImage = in.readString();
        like = in.readString();
        comment = in.readString();
    }

    public static final Creator<Article> CREATOR = new Creator<Article>() {
        @Override
        public Article createFromParcel(Parcel in) {
            return new Article(in);
        }

        @Override
        public Article[] newArray(int size) {
            return new Article[size];
        }
    };

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getHeadline() {
        return headline;
    }

    public void setHeadline(String headline) {
        this.headline = headline;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getPlace() {
        return place;
    }

    public void setPlace(String place) {
        this.place = place;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getUserImage() {
        return userImage;
    }

    public void setUserImage(String userImage) {
        this.userImage = userImage;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getLongitud() {
        return longitude;
    }

    public void setLongitud(String longitud) {
        this.longitude = longitud;
    }

    public String getLatitude() {
        return latitude;
    }

    public void setLatitude(String latitude) {
        this.latitude = latitude;
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

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    @Override
    public String toString() {
        return "Article{" +
                "id='" + id + '\'' +
                ", userId='" + userId + '\'' +
                ", headline='" + headline + '\'' +
                ", content='" + content + '\'' +
                ", date='" + date + '\'' +
                ", place='" + place + '\'' +
                ", image='" + image + '\'' +
                ", longitude='" + longitude + '\'' +
                ", latitude='" + latitude + '\'' +
                ", userName='" + userName + '\'' +
                ", userImage='" + userImage + '\'' +
                ", like='" + like + '\'' +
                ", comment='" + comment + '\'' +
                '}';
    }

    @Override
    public int describeContents() {
        return 0;
    }

    @Override
    public void writeToParcel(Parcel dest, int flags) {
        dest.writeString(this.id);
        dest.writeString(this.userId);
        dest.writeString(this.headline);
        dest.writeString(this.content);
        dest.writeString(this.date);
        dest.writeString(this.place);
        dest.writeString(this.image);
        dest.writeString(this.longitude);
        dest.writeString(this.latitude);
        dest.writeString(this.userName);
        dest.writeString(this.userImage);
        dest.writeString(this.like);
        dest.writeString(this.comment);
    }
}
