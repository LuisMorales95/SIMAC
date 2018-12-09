package com.Mezda.SIMAC.root;

import android.app.Application;
import android.content.Context;
import android.support.multidex.MultiDex;

import com.Mezda.SIMAC.Respository.RetrofitModule;
import com.Mezda.SIMAC.modules.MainModule;
import com.crashlytics.android.Crashlytics;
import com.facebook.AccessToken;
import com.facebook.FacebookSdk;
import com.facebook.GraphRequest;
import com.facebook.GraphResponse;
import com.facebook.HttpMethod;
import com.facebook.appevents.AppEventsLogger;
import com.facebook.login.LoginManager;

import io.fabric.sdk.android.Fabric;

public class AppApplication extends android.app.Application {

    ApplicationComponent applicationComponent;

    @Override
    protected void attachBaseContext(Context base) {
        super.attachBaseContext(base);
        MultiDex.install(this);

    }

    @Override
    public void onCreate() {
        super.onCreate();
        applicationComponent = DaggerApplicationComponent.builder()
                .appModule(new AppModule(this))
                .mainModule(new MainModule())
                .retrofitModule(new RetrofitModule())
                .build();

        Fabric.with(this, new Crashlytics());
        FacebookSdk.sdkInitialize(getApplicationContext());
        AppEventsLogger.activateApp(this);
    }

    public ApplicationComponent provideComponent(){
        return applicationComponent;
    }


    public static void disconnectFromFacebook() {
        if (AccessToken.getCurrentAccessToken() == null) {
            return; // already logged out
        }
        new GraphRequest(AccessToken.getCurrentAccessToken(), "/me/permissions/", null, HttpMethod.DELETE, new GraphRequest
                .Callback() {
            @Override
            public void onCompleted(GraphResponse graphResponse) {
                LoginManager.getInstance().logOut();
            }
        }).executeAsync();
    }
}
