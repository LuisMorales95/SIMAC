package com.Mezda.SIMAC.ui.activities.Map;

import com.Mezda.SIMAC.data.dao.Map;
import com.Mezda.SIMAC.ui.base.BasePresenter;
import com.google.android.gms.maps.CameraUpdate;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.MarkerOptions;

public interface MapsContract {
    interface View{
    }
    interface Presenter extends BasePresenter<MapsContract.View>{
        void loadMarker();
        MarkerOptions getMarkerOptions();
        CameraUpdate getCameraUpdate();
    }
    interface Model{
        Map getMap();
    }
}
