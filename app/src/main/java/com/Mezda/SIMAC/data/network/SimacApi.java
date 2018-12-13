package com.Mezda.SIMAC.data.network;

import com.Mezda.SIMAC.data.dao.startupValidation;

import io.reactivex.Observable;
import okhttp3.RequestBody;
import retrofit2.http.Body;
import retrofit2.http.POST;

public interface SimacApi {

    @POST("startup.php")
    Observable<startupValidation> getStartUp(@Body RequestBody object);
}
