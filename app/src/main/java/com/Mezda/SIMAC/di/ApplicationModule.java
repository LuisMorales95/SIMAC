package com.Mezda.SIMAC.di;

import android.content.Context;
import android.content.SharedPreferences;

import com.Mezda.SIMAC.data.prefs.UserPreferences;

import javax.inject.Singleton;

import dagger.Module;
import dagger.Provides;

@Module
public class ApplicationModule {

    SimacApplication application;

    public ApplicationModule(SimacApplication application) {
        this.application = application;
    }

    @Provides
    @Singleton
    public Context provideContext(){
        return application;
    }

    @Provides
    @Singleton
    public SharedPreferences provideSharedPreference(Context app){
        return app.getSharedPreferences("UserPreferences",Context.MODE_PRIVATE);
    }

    @Provides
    @Singleton
    public UserPreferences provideUserPreferences(SharedPreferences preferences){
        return new UserPreferences(preferences);
    }

}
