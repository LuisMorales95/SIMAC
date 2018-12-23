package com.Mezda.SIMAC.ui.activities.Map;

import com.Mezda.SIMAC.data.dao.Map;
import com.Mezda.SIMAC.data.memory.MemoryRepository;
import com.Mezda.SIMAC.ui.base.PerActivity;

import dagger.Module;
import dagger.Provides;

@Module
public class MapsModule {
    @Provides @PerActivity
    MapsContract.Presenter providesMapsContractPresenter(MapsContract.Model model){
        return new MapsPresenter(model);
    }
    @Provides @PerActivity
    MapsContract.Model providesMapsContractModel(MemoryRepository<Map> memoryRepository){
        return new MapModel(memoryRepository);
    }
}
