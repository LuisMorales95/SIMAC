package com.Mezda.SIMAC.ui.fragments.GenerateAlert;

import com.Mezda.SIMAC.ui.base.PerFragment;

import dagger.Module;
import dagger.Provides;

@Module
public class AlertModule {
    @Provides @PerFragment
    AlertContract.Presenter providesAlertPreseter(){
        return new AlertPresenter();
    }
    @Provides @PerFragment
    AlertContract.Model providesAlertModel(){
        return new AlertModel();
    }
}
