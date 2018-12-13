package com.Mezda.SIMAC.ui.main;

import com.Mezda.SIMAC.data.network.SimacApi;
import com.Mezda.SIMAC.data.dao.Credentials;
import com.Mezda.SIMAC.data.dao.startupValidation;

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
