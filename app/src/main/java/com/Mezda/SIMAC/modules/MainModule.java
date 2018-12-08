package com.Mezda.SIMAC.modules;

import com.Mezda.SIMAC.Interfaces.Activity_MainContract;
import com.Mezda.SIMAC.mvp_models.MainModel;
import com.Mezda.SIMAC.mvp_presenters.MainPresenter;

import dagger.Module;
import dagger.Provides;

@Module
public class MainModule {



    @Provides
    public Activity_MainContract.Model provideMainModel(){
        return new MainModel();
    }

    @Provides
    public Activity_MainContract.Presenter provideMainPresenter(Activity_MainContract.Model model){
       return new MainPresenter(model);
    }

}
