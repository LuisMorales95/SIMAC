package com.Mezda.SIMAC.root;

import com.Mezda.SIMAC.Respository.RetrofitModule;
import com.Mezda.SIMAC.modules.MainModule;
import com.Mezda.SIMAC.mvp_view.Activitys.Activity_Main;

import javax.inject.Singleton;

import dagger.Component;
import dagger.android.AndroidInjector;

@Singleton
@Component(modules = {AppModule.class, MainModule.class,RetrofitModule.class})
public interface ApplicationComponent extends AndroidInjector<AppApplication> {

}
