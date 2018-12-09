package com.Mezda.SIMAC.modules;

import com.Mezda.SIMAC.Interfaces.Activity_MainContract;
import com.Mezda.SIMAC.mvp_models.MainModel;
import com.Mezda.SIMAC.mvp_presenters.MainPresenter;
import com.Mezda.SIMAC.mvp_view.Activitys.Activity_Main;

import dagger.Binds;
import dagger.Module;
import dagger.Provides;
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
