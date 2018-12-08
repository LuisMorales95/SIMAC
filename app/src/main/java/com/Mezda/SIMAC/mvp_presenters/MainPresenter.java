package com.Mezda.SIMAC.mvp_presenters;

import android.content.SharedPreferences;

import com.Mezda.SIMAC.Interfaces.Activity_MainContract;
import com.Mezda.SIMAC.Respository.apiModels.startupValidation;

import javax.inject.Inject;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class MainPresenter implements Activity_MainContract.Presenter{

    @Inject
    public SharedPreferences preferences;

    private Activity_MainContract.Model model;
    private Activity_MainContract.View view;

    public MainPresenter(Activity_MainContract.Model model) {
        this.model = model;
    }

    @Override
    public void setView(Activity_MainContract.View view) {
        this.view = view;
    }

    @Override
    public void startup() {

    }
}
