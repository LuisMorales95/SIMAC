package com.Mezda.SIMAC.ui.activities.detailArticle;

import android.content.Context;
import android.util.Log;

import com.Mezda.SIMAC.data.dao.Article;
import com.Mezda.SIMAC.data.dao.Map;
import com.google.android.gms.maps.CameraUpdate;
import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.MarkerOptions;

public class DetailArticlePresenter implements DetailArticleContract.Presenter{

    private DetailArticleContract.View view;
    private DetailArticleContract.Model model;
    private String TAG = "DetailArticlePresenter";
    Article article;

    public DetailArticlePresenter(DetailArticleContract.Model model) {
        this.model = model;
    }

    @Override
    public void showArticle() {
        article = model.selectedArticle();
        view.setHeadline(article.getHeadline());
        view.setUserName(article.getUserName());
        view.setImage(article.getImage());
        view.setContent(article.getContent());
    }

    @Override
    public void createMapMarker() {
        Map map = new Map(
                article.getHeadline(),
                article.getContent(),
                new LatLng(Double.valueOf(article.getLatitude()),
                        Double.valueOf(article.getLongitud())),
                false);
        model.setSelectedMap(map);
    }

    @Override
    public void attach(DetailArticleContract.View view) {
        this.view = view;
    }

    @Override
    public void onDetach() {
        view=null;
    }
}
