package com.Mezda.SIMAC.ui.fragments.localNewsFeed;

import android.content.Context;
import android.util.Log;

import com.Mezda.SIMAC.data.dao.Article;
import com.Mezda.SIMAC.data.prefs.UserPreferences;
import com.Mezda.SIMAC.utils.Utils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.disposables.CompositeDisposable;
import io.reactivex.schedulers.Schedulers;

public class LocalNewsPresenter implements LocalNewsContract.Presenter{
    private String TAG = "LocalNewsPresenter";
    private LocalNewsContract.View view;
    private LocalNewsContract.Model model;
    private UserPreferences userPreferences;
    private CompositeDisposable compositeDisposable = new CompositeDisposable();
    private int counter = 1;

    public LocalNewsPresenter(LocalNewsContract.Model model, UserPreferences userPreferences) {
        this.model = model;
        this.userPreferences = userPreferences;
    }

    @Override
    public void attach(LocalNewsContract.View view) {
        this.view = view;
    }

    @Override
    public void fetchData() {
        compositeDisposable.add(
                model.localFeed(String.valueOf(counter),userPreferences.getId()).
                        subscribeOn(Schedulers.io()).
                        observeOn(AndroidSchedulers.mainThread()).
                        subscribe(
                                articles -> {
                                    if (!articles.isEmpty()){
                                        for (Article articleitem: articles) {
                                            view.addItem(articleitem);
                                        }
                                        counter+=5;
                                    }else{
                                        view.showToast("No more data");
                                    }
                                    },
                                throwable -> {
                                    view.showToast(throwable.getMessage());
                                    Log.e(TAG,throwable.getMessage());
                                }
                                ));
    }

    @Override
    public void setItemClicked(Article article) {
        model.saveItemClicked(article);
    }

    @Override
    public void onDetach() {
        compositeDisposable.clear();
    }
}
