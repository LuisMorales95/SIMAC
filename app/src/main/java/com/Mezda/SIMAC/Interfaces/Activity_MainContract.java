package com.Mezda.SIMAC.Interfaces;

import com.Mezda.SIMAC.Respository.apiModels.startupValidation;

import retrofit2.Call;
import rx.Observable;

public interface Activity_MainContract {
    interface View{
        void hideNavigationItem();
        void setActionBarTitle(String barTitle);
        void selectItem(int position);
        void clearNavagationDrawer();
        void onStartUpResult(int opcion);
        void showMessage(String Msg);
    }
    interface Presenter{
        void setView(View view);
        void startup();
    }
    interface Model{
       Call<startupValidation> getUserValidation();
    }
}
