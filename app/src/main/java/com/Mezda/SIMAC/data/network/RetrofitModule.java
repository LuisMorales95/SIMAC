package com.Mezda.SIMAC.data.network;

import com.Mezda.SIMAC.data.dao.Article;

import javax.inject.Singleton;

import dagger.Module;
import dagger.Provides;
import okhttp3.OkHttpClient;
import okhttp3.logging.HttpLoggingInterceptor;
import retrofit2.Retrofit;
import retrofit2.adapter.rxjava2.RxJava2CallAdapterFactory;
import retrofit2.converter.gson.GsonConverterFactory;

@Module
public class RetrofitModule {
    private final String mBaseUrl="http://192.168.1.68/SIMACApi/";



    @Provides @Singleton
    GsonConverterFactory providesGsonConverterFactory(){
        return GsonConverterFactory.create();
    }

    @Provides @Singleton
    RxJava2CallAdapterFactory providesRxJava2CallAdapterFactory(){
        return RxJava2CallAdapterFactory.create();
    }

    @Provides
    @Singleton
    public OkHttpClient provideClient(){
        HttpLoggingInterceptor interceptor = new HttpLoggingInterceptor();
        interceptor.setLevel(HttpLoggingInterceptor.Level.BODY);
        return new OkHttpClient.Builder().addInterceptor(interceptor).build();
    }

    @Provides
    @Singleton
    public Retrofit provideRetrofit(OkHttpClient client, GsonConverterFactory gsonConverterFactory,
                                    RxJava2CallAdapterFactory rxJava2CallAdapterFactory){
        return new Retrofit.Builder()
                .baseUrl(mBaseUrl)
                .client(client)
                .addConverterFactory(gsonConverterFactory)
                .addCallAdapterFactory(rxJava2CallAdapterFactory)
                .build();
    }

    @Provides
    @Singleton
    public SimacApi provideSimacApi(Retrofit retrofit){
        return retrofit.create(SimacApi.class);
    }

    @Provides @Singleton
    public Article providesArticle(){
        return new Article();
    }
}
