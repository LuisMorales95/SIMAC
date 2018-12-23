package com.Mezda.SIMAC.data.dao;

import com.google.android.gms.maps.CameraUpdate;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.MarkerOptions;

public class Map {

    private String markerTitle;
    private String snippet;
    private LatLng latLng;
    private Boolean draggable;

    public Map() {
    }

    public Map(String markerTitle, String snippet, LatLng latLng, Boolean draggable) {
        this.markerTitle = markerTitle;
        this.snippet = snippet;
        this.latLng = latLng;
        this.draggable = draggable;
    }

    public String getMarkerTitle() {
        return markerTitle;
    }

    public void setMarkerTitle(String markerTitle) {
        this.markerTitle = markerTitle;
    }

    public String getSnippet() {
        return snippet;
    }

    public void setSnippet(String snippet) {
        this.snippet = snippet;
    }

    public LatLng getLatLng() {
        return latLng;
    }

    public void setLatLng(LatLng latLng) {
        this.latLng = latLng;
    }

    public Boolean getDraggable() {
        return draggable;
    }

    public void setDraggable(Boolean draggable) {
        this.draggable = draggable;
    }
}
