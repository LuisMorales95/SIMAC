package com.Mezda.SIMAC.ui.activities.main;

import com.Mezda.SIMAC.data.network.SimacApi;
import com.Mezda.SIMAC.data.dao.Credentials;
import com.Mezda.SIMAC.data.dao.UserInfo;

import org.json.JSONObject;

import java.util.HashMap;

import io.reactivex.Observable;
import okhttp3.RequestBody;

public class MainModel implements MainContract.Model {

    private final String ID = "ID";
    private final String TOKEN = "Token";
    private SimacApi simacApi;

    public MainModel(SimacApi simacApi) {
        this.simacApi = simacApi;
    }

    @Override
    public Observable<UserInfo> getUserValidation(Credentials credentials) {
        HashMap<String,String> params = new HashMap<>();
        params.put(ID,credentials.getId());
        params.put(TOKEN,credentials.getToken());

        RequestBody body = RequestBody.create(okhttp3.MediaType.parse("application/json; charset=utf-8")
                ,(new JSONObject(params)).toString());

        return simacApi.getStartUp(body);
    }
}
