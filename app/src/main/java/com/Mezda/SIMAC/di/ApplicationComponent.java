package com.Mezda.SIMAC.di;

import com.Mezda.SIMAC.data.memory.MemoryModule;
import com.Mezda.SIMAC.data.network.RetrofitModule;

import javax.inject.Singleton;

import dagger.Component;
import dagger.android.AndroidInjectionModule;

@Singleton
@Component(modules = {
        AndroidInjectionModule.class,
        ApplicationModule.class,
        ActivityBuilder.class,
        FragmentBuilder.class,
        RetrofitModule.class,
        MemoryModule.class
})
public interface ApplicationComponent {
    void inject (SimacApplication application);
}
