package com.Mezda.SIMAC.Interfaces;

import com.Mezda.SIMAC.Respository.apiModels.Credentials;
import com.Mezda.SIMAC.Respository.apiModels.startupValidation;

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
    interface Presenter extends BasePresenter<Activity_MainContract.View> {
        void startup();
    }

    interface Model{
       Observable<startupValidation> getUserValidation(Credentials credentials);
    }
}
