package com.Mezda.SIMAC.di;

import com.Mezda.SIMAC.data.network.RetrofitModule;
import com.Mezda.SIMAC.ui.main.MainModule;

import javax.inject.Singleton;

import dagger.Component;
import dagger.android.AndroidInjector;

@Singleton
@Component(modules = {AppModule.class, MainModule.class,RetrofitModule.class})
public interface ApplicationComponent extends AndroidInjector<AppApplication> {

}
