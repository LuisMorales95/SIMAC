package com.Mezda.SIMAC.ui.activities.main;

import com.Mezda.SIMAC.data.network.SimacApi;
import com.Mezda.SIMAC.data.prefs.UserPreferences;
import com.Mezda.SIMAC.ui.base.PerActivity;

import dagger.Module;
import dagger.Provides;

@Module
public class MainModule {

    @Provides @PerActivity
    MainContract.Presenter providesMainPresenter(MainContract.Model model, UserPreferences userPreferences){
        return new MainPresenter(model,userPreferences);
    }

    @Provides @PerActivity
    MainContract.Model providesMainModel(SimacApi simacApi){
        return new MainModel(simacApi);
    }
}
