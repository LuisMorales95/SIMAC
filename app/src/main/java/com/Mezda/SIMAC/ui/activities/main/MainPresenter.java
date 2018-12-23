package com.Mezda.SIMAC.ui.activities.main;

import android.util.Log;

import com.Mezda.SIMAC.data.dao.Credentials;
import com.Mezda.SIMAC.data.prefs.UserPreferences;
import com.Mezda.SIMAC.di.SimacApplication;
import com.Mezda.SIMAC.utils.Utils;
import com.google.firebase.auth.FirebaseAuth;

import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.disposables.CompositeDisposable;
import io.reactivex.schedulers.Schedulers;

import static com.Mezda.SIMAC.utils.Constants.Authorized;
import static com.Mezda.SIMAC.utils.Constants.Logged;
import static com.Mezda.SIMAC.utils.Constants.Unauthorized;
import static com.Mezda.SIMAC.utils.Constants.Unlogged;

public class MainPresenter implements MainContract.Presenter{
    private MainContract.Model model;
    private MainContract.View view;
    private UserPreferences userPreferences;
    private FirebaseAuth firebaseAuth;
    private CompositeDisposable disposable  = new CompositeDisposable();
    private final String TAG = "MainPresenter";

    public MainPresenter(MainContract.Model model,UserPreferences userPreferences) {
        this.model = model;
        this.userPreferences = userPreferences;
    }

    @Override
    public void attach(MainContract.View view) {
        this.view = view;
        firebaseAuth = FirebaseAuth.getInstance();
    }

    @Override
    public void onDetach() {
            disposable.clear();
    }

    @Override
    public void startup() {
        if (view!=null){
//            Credentials credentials = new Credentials("1076", "3492cbcdbf3fdb502e8932d218d71401");
            Credentials credentials = new Credentials(userPreferences.getId(), userPreferences.getToken());
            if (credentials.isEmpty()){
                viewConfig();
                view.showToast("Default User");
            }else{
                if (Utils.isConnected(view.getContext())){
                    disposable.add(model.getUserValidation(credentials).subscribeOn(Schedulers.io())
                            .observeOn(AndroidSchedulers.mainThread())
                            .subscribe(obj->{
                                        if (obj.getMessage().isEmpty()){
                                            userPreferences.saveUserInfo(obj);
                                            view.showToast("User InfoSaved");
                                            viewConfig();
                                        } else{
                                            logOut();
                                        }
                                    },throwable ->{
                                        Log.i(TAG,"something was wrong: "+throwable.getMessage());
                                        viewConfig();
                                        view.showToast(throwable.getMessage());
                                    }
                            ));
                }else{
                    viewConfig();
                    view.showToast("Internet not available");
                }

            }
        }
    }

    @Override
    public void menuitems() {
        if (userPreferences.getAuthorization().equals("1")||userPreferences.getAuthorization().equals("")) {
            view.itemAuthorization(Unauthorized);
        }else{
            view.itemAuthorization(Authorized);
        }
        if (userPreferences.getToken().isEmpty()){
            view.sessionStatusItem(Unlogged);
        }else{
            view.sessionStatusItem(Logged);
        }
    }

    @Override
    public String getToken() {
        return userPreferences.getToken();
    }

    @Override
    public String getAutorization() {
        return userPreferences.getAuthorization();
    }

    @Override
    public void viewConfig() {
        view.defaultSetup();
        view.setProfilPic(userPreferences.getProfileImage());
        view.setUserName(userPreferences.getName());
        view.setUserEmail(userPreferences.getEmail());
    }

    @Override
    public void logOut() {
        userPreferences.EmptyPreferences();
        firebaseAuth.signOut();
        SimacApplication.disconnectFromFacebook();
        viewConfig();
    }
}
