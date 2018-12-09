package com.Mezda.SIMAC.mvp_models;

import com.Mezda.SIMAC.Interfaces.Activity_MainContract;
import com.Mezda.SIMAC.Respository.SimacApi;
import com.Mezda.SIMAC.Respository.apiModels.Credentials;
import com.Mezda.SIMAC.Respository.apiModels.startupValidation;

import org.json.JSONObject;

import java.util.HashMap;
import javax.inject.Inject;

import io.reactivex.Observable;
import okhttp3.RequestBody;

public class MainModel implements Activity_MainContract.Model {

    private final String ID = "ID";
    private final String TOKEN = "Token";
    private SimacApi simacApi;

    @Inject
    public MainModel(SimacApi simacApi) {
        this.simacApi = simacApi;
    }
    @Override
    public Observable<startupValidation> getUserValidation(Credentials credentials) {
        HashMap<String,String> params = new HashMap<>();
        params.put(ID,credentials.getId());
        params.put(TOKEN,credentials.getToken());

        RequestBody body = RequestBody.create(okhttp3.MediaType.parse("application/json; charset=utf-8")
                ,(new JSONObject(params)).toString());

        return simacApi.getStartUp(body);
    }
}
