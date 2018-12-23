package com.Mezda.SIMAC.ui.fragments.localNewsFeed;

import android.content.Context;

import com.Mezda.SIMAC.data.dao.Article;
import com.Mezda.SIMAC.ui.base.BasePresenter;

import java.util.HashMap;
import java.util.List;

import io.reactivex.Observable;

public class LocalNewsContract {
    interface View{

        Context getContexts();
        void showToast(String message);
        void addItem(Article article);
        void clearAdapter();
    }
    interface Presenter extends BasePresenter<LocalNewsContract.View> {

        void fetchData();
        void setItemClicked(Article article);

    }
    interface Model{

        Observable<List<Article>> localFeed(String counter, String idUser);
        void saveItemClicked(Article article);
    }
}
