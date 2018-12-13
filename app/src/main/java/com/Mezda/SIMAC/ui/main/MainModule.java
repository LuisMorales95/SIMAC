package com.Mezda.SIMAC.ui.main;

import dagger.Binds;
import dagger.Module;
import dagger.android.ContributesAndroidInjector;

@Module
public abstract class MainModule {

    @ContributesAndroidInjector
    public abstract Activity_Main ContributesAndroidInjector();

    @Binds
    public abstract Activity_MainContract.Presenter provideMainPresenter(MainPresenter presenter);

    @Binds
    public abstract Activity_MainContract.Model provideMainModel(MainModel model);

}
