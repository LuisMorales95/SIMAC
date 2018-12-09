package com.Mezda.SIMAC.root;

import android.content.Context;
import android.content.SharedPreferences;

import javax.inject.Singleton;

import dagger.Module;
import dagger.Provides;

@Module
public class AppModule {

    @Provides
    @Singleton
    public Context provideContext(){
        return AppApplication.provideContext();
    }

    @Provides
    @Singleton
    public SharedPreferences provideSharedPreference(Context app){
        return app.getSharedPreferences("General_Prefs",Context.MODE_PRIVATE);
    }

}
