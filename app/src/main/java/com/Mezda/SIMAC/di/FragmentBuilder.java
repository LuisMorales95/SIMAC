package com.Mezda.SIMAC.di;

import android.support.v4.app.Fragment;

import dagger.Binds;
import dagger.Module;
import dagger.android.AndroidInjector;
import dagger.android.support.FragmentKey;
import dagger.multibindings.IntoMap;

import com.Mezda.SIMAC.ui.fragments.localNewsFeed.LocalNewsFragment;
import com.Mezda.SIMAC.ui.fragments.localNewsFeed.LocalNewsSubcomponent;
@Module(subcomponents = LocalNewsSubcomponent.class)
public abstract class FragmentBuilder {

    @Binds
    @IntoMap
    @FragmentKey(LocalNewsFragment.class)
    abstract AndroidInjector.Factory<? extends Fragment>
    bindIntoMaplocalNewsFragment(LocalNewsSubcomponent.Builder builder);

}
