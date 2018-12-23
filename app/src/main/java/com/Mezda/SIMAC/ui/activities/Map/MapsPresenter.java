package com.Mezda.SIMAC.ui.activities.Map;

import com.Mezda.SIMAC.data.dao.Map;
import com.google.android.gms.maps.CameraUpdate;
import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.MarkerOptions;

public class MapsPresenter implements MapsContract.Presenter{

    private MapsContract.View view;
    private MapsContract.Model model;
    private Map map;

    public MapsPresenter(MapsContract.Model model) {
        this.model = model;
    }

    @Override
    public void loadMarker() {
        map = model.getMap();
    }

    @Override
    public MarkerOptions getMarkerOptions() {
        return new MarkerOptions()
                .position(map.getLatLng())
                .title(map.getMarkerTitle());
    }

    @Override
    public CameraUpdate getCameraUpdate() {
        return CameraUpdateFactory.newLatLngZoom(map.getLatLng(), 13);
    }

    @Override
    public void attach(MapsContract.View view) {
        this.view = view;
    }

    @Override
    public void onDetach() {
        this.view=null;
    }
}
