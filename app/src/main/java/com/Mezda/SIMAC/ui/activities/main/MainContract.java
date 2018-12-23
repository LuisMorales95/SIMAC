package com.Mezda.SIMAC.ui.activities.main;

import android.content.Context;

import com.Mezda.SIMAC.ui.base.BasePresenter;
import com.Mezda.SIMAC.data.dao.Credentials;
import com.Mezda.SIMAC.data.dao.UserInfo;

import io.reactivex.Observable;


public interface MainContract {
    interface View {
        void setActionBarTitle(String barTitle);
        void selectItem(int position);
        void setProfilPic(String url);
        void setUserName(String userName);
        void setUserEmail(String userEmail);
        void itemAuthorization(int authorization);
        void sessionStatusItem(boolean status);
        void showToast(String msg);
        void defaultSetup();
        Context getContext();
    }
    interface Presenter extends BasePresenter<View> {
        void startup();
        void viewConfig();
        void menuitems();
        String getToken();
        String getAutorization();
        void logOut();
    }

    interface Model{
       Observable<UserInfo> getUserValidation(Credentials credentials);
    }
}
