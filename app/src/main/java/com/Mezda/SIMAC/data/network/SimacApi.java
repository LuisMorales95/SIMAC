package com.Mezda.SIMAC.data.network;

import com.Mezda.SIMAC.data.dao.Article;
import com.Mezda.SIMAC.data.dao.UserInfo;

import java.util.List;

import javax.annotation.PostConstruct;

import io.reactivex.Observable;
import okhttp3.RequestBody;
import retrofit2.http.Body;
import retrofit2.http.POST;

public interface SimacApi {

    @POST("startup.php")
    Observable<UserInfo> getStartUp(@Body RequestBody object);

    @POST("JSONLocalNewsFeed.php")
    Observable<List<Article>> getLocalFeed(@Body RequestBody objRequestBody);
}
