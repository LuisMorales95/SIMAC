package com.Mezda.SIMAC.ui.main;

import com.Mezda.SIMAC.ui.base.BasePresenter;
import com.Mezda.SIMAC.data.dao.Credentials;
import com.Mezda.SIMAC.data.dao.startupValidation;

import io.reactivex.Observable;


public interface Activity_MainContract {
    interface View{
        void hideNavigationItem();
        void setActionBarTitle(String barTitle);
        void selectItem(int position);
        void clearNavagationDrawer();
        void onStartUpResult(int opcion);
        void showMessage(String Msg);
    }
    interface Presenter extends BasePresenter<View> {
        void startup();
    }

    interface Model{
       Observable<startupValidation> getUserValidation(Credentials credentials);
    }
}
