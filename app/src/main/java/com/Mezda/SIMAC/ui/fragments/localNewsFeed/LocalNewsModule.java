package com.Mezda.SIMAC.ui.fragments.localNewsFeed;

import com.Mezda.SIMAC.data.dao.Article;
import com.Mezda.SIMAC.data.memory.MemoryRepository;
import com.Mezda.SIMAC.data.network.SimacApi;
import com.Mezda.SIMAC.data.prefs.UserPreferences;
import com.Mezda.SIMAC.ui.base.PerFragment;

import dagger.Module;
import dagger.Provides;

@Module
public class LocalNewsModule {

    @Provides @PerFragment
    public LocalNewsContract.Presenter providesLocalNewsPresenter(LocalNewsContract.Model model, UserPreferences userPreferences){
        return new LocalNewsPresenter(model,userPreferences);
    }

    @Provides @PerFragment
    public LocalNewsContract.Model providesLocalNewsModel(SimacApi simacApi, MemoryRepository<Article> articleMemory){
        return new LocalNewsModel(simacApi,articleMemory);
    }

}
