package com.Mezda.SIMAC.ui.fragments.GenerateAlert;

import com.Mezda.SIMAC.ui.base.PerFragment;

import dagger.Subcomponent;
import dagger.android.AndroidInjector;

@PerFragment
@Subcomponent(modules = AlertModule.class)
public interface AlertSubComponent extends AndroidInjector<Fragment_GenerateAlert> {
    @Subcomponent.Builder
    abstract class Builder extends AndroidInjector.Builder<Fragment_GenerateAlert>{}
}
