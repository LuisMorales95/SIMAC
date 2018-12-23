package com.Mezda.SIMAC.di;

import android.app.Activity;
import android.app.Application;
import android.content.Context;
import android.support.multidex.MultiDex;
import android.support.v4.app.Fragment;


import com.Mezda.SIMAC.BuildConfig;
import com.Mezda.SIMAC.data.memory.MemoryModule;
import com.Mezda.SIMAC.data.network.RetrofitModule;
import com.crashlytics.android.Crashlytics;
import com.crashlytics.android.core.CrashlyticsCore;
import com.facebook.AccessToken;
import com.facebook.FacebookSdk;
import com.facebook.GraphRequest;
import com.facebook.GraphResponse;
import com.facebook.HttpMethod;
import com.facebook.appevents.AppEventsLogger;
import com.facebook.login.LoginManager;

import javax.inject.Inject;

import dagger.android.AndroidInjector;
import dagger.android.DispatchingAndroidInjector;
import dagger.android.HasActivityInjector;
import dagger.android.support.HasSupportFragmentInjector;
import io.fabric.sdk.android.Fabric;

public class SimacApplication extends Application implements HasActivityInjector,HasSupportFragmentInjector {

    @Inject DispatchingAndroidInjector<Activity> activityDispatchingAndroidInjector;
    @Inject DispatchingAndroidInjector<Fragment> fragmentDispatchingAndroidInjector;

    private ApplicationComponent applicationComponent;
    private static Context context;

    @Override
    protected void attachBaseContext(Context base) {
        super.attachBaseContext(base);
        MultiDex.install(this);
    }

    @Override
    public void onCreate() {
        super.onCreate();
        applicationComponent = DaggerApplicationComponent.builder()
                .applicationModule(new ApplicationModule(this))
                .retrofitModule(new RetrofitModule())
                .memoryModule(new MemoryModule())
                .build();
        applicationComponent.inject(this);
        context = this;
        Crashlytics crashlytics = new Crashlytics.Builder().
                core(new CrashlyticsCore.Builder().disabled(BuildConfig.DEBUG).build()).build();
        Fabric.with(this, crashlytics);
        FacebookSdk.sdkInitialize(getApplicationContext());
        AppEventsLogger.activateApp(this);
    }


    public static void disconnectFromFacebook() {
        if (AccessToken.getCurrentAccessToken() == null) {
            return; // already logged out
        }
        new GraphRequest(AccessToken.getCurrentAccessToken(), "/me/permissions/", null,
                HttpMethod.DELETE,response -> LoginManager.getInstance().logOut()).executeAsync();
    }
    public static Context provideContexts(){
        return context;
    }


    @Override
    public AndroidInjector<Activity> activityInjector() {
        return activityDispatchingAndroidInjector;
    }

    @Override
    public AndroidInjector<Fragment> supportFragmentInjector() {
        return fragmentDispatchingAndroidInjector;
    }

}
