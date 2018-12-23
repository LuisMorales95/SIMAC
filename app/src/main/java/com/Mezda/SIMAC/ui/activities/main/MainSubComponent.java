package com.Mezda.SIMAC.ui.activities.main;

import com.Mezda.SIMAC.ui.base.PerActivity;

import dagger.Subcomponent;
import dagger.android.AndroidInjector;

@PerActivity
@Subcomponent(modules = MainModule.class)
public interface MainSubComponent extends AndroidInjector<Activity_Main> {
    @Subcomponent.Builder
    abstract class Builder extends AndroidInjector.Builder<Activity_Main>{

    }
}
