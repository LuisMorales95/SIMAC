package com.Mezda.SIMAC.ui.fragments.localNewsFeed;

import com.Mezda.SIMAC.ui.base.PerFragment;

import dagger.Subcomponent;
import dagger.android.AndroidInjector;

@PerFragment
@Subcomponent(modules = LocalNewsModule.class)
public interface LocalNewsSubcomponent extends AndroidInjector<LocalNewsFragment> {
    @Subcomponent.Builder
    abstract class Builder extends AndroidInjector.Builder<LocalNewsFragment>{

    }
}
