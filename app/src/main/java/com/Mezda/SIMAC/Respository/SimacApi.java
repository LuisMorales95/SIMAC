package com.Mezda.SIMAC.Respository;

import com.Mezda.SIMAC.Respository.apiModels.startupValidation;

import io.reactivex.Observable;
import okhttp3.RequestBody;
import retrofit2.http.Body;
import retrofit2.http.POST;

public interface SimacApi {

    @POST("startup.php")
    Observable<startupValidation> getStartUp(@Body RequestBody object);
}
