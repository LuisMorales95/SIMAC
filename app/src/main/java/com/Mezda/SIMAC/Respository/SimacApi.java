package com.Mezda.SIMAC.Respository;

import com.Mezda.SIMAC.Respository.apiModels.ObjectIdToken;
import com.Mezda.SIMAC.Respository.apiModels.startupValidation;
import com.google.gson.JsonObject;


import org.json.JSONObject;

import java.util.Map;

import retrofit2.Call;
import retrofit2.http.Body;
import retrofit2.http.FieldMap;
import retrofit2.http.FormUrlEncoded;
import retrofit2.http.Headers;
import retrofit2.http.POST;

public interface SimacApi {
    @POST("startup.php")
    @FormUrlEncoded
    @Headers("Content-Type: application/json")
    Call<startupValidation> getStartUp(@Body ObjectIdToken object);
}
