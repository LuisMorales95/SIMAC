package com.Mezda.SIMAC.mvp_models;

import com.Mezda.SIMAC.Interfaces.Activity_MainContract;
import com.Mezda.SIMAC.Respository.SimacApi;
import com.Mezda.SIMAC.Respository.apiModels.startupValidation;

import javax.inject.Inject;

import retrofit2.Call;

public class MainModel implements Activity_MainContract.Model {


    @Inject
    SimacApi simacApi;

    @Override
    public Call<startupValidation> getUserValidation() {
        return simacApi.getStartUp("1","d9912d72a83c4fda79fe096667927b1e");
    }
}
