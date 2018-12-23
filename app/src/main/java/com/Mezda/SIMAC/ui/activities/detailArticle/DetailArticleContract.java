package com.Mezda.SIMAC.ui.activities.detailArticle;

import android.content.Context;

import com.Mezda.SIMAC.data.dao.Article;
import com.Mezda.SIMAC.data.dao.Map;
import com.Mezda.SIMAC.ui.base.BasePresenter;
import com.google.android.gms.maps.model.LatLng;

import io.reactivex.Observable;

public interface DetailArticleContract {

 interface View{
  void setHeadline(String headline);
  void setUserName (String userName);
  void setImage (String url);
  void setContent(String content);
 }
 interface Presenter extends BasePresenter<DetailArticleContract.View> {
  void showArticle();
  void createMapMarker();
 }
 interface Model{
     void setSelectedMap(Map map);
     Article selectedArticle();
 }

}
