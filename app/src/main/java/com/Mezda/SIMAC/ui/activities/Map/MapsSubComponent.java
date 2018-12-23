package com.Mezda.SIMAC.ui.activities.Map;

import com.Mezda.SIMAC.ui.base.PerActivity;

import dagger.Subcomponent;
import dagger.android.AndroidInjection;
import dagger.android.AndroidInjector;

@PerActivity
@Subcomponent(modules = MapsModule.class)
public interface MapsSubComponent extends AndroidInjector<Activity_Maps> {
    @Subcomponent.Builder
    abstract class Builder extends AndroidInjector.Builder<Activity_Maps>{}
}
