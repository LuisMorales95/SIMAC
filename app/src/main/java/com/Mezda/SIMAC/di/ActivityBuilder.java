package com.Mezda.SIMAC.di;

import android.app.Activity;

import com.Mezda.SIMAC.ui.activities.Map.Activity_Maps;
import com.Mezda.SIMAC.ui.activities.Map.MapsSubComponent;
import com.Mezda.SIMAC.ui.activities.detailArticle.Activity_DetailArticle;
import com.Mezda.SIMAC.ui.activities.detailArticle.DetailArticleSubComponent;
import com.Mezda.SIMAC.ui.activities.main.Activity_Main;
import com.Mezda.SIMAC.ui.activities.main.MainSubComponent;

import dagger.Binds;
import dagger.Module;
import dagger.android.ActivityKey;
import dagger.android.AndroidInjector;
import dagger.multibindings.IntoMap;

@Module(subcomponents = {
        MainSubComponent.class,
        DetailArticleSubComponent.class,
        MapsSubComponent.class
})
public abstract class ActivityBuilder {

    @Binds
    @IntoMap
    @ActivityKey(Activity_Main.class)
    abstract AndroidInjector.Factory<? extends Activity>
    bindIntoMapActivityMainInjectorFactory(MainSubComponent.Builder builder);

    @Binds
    @IntoMap
    @ActivityKey(Activity_DetailArticle.class)
    abstract AndroidInjector.Factory<? extends Activity>
    bindIntoMapActivity_DetailArticleInjectorFactory(DetailArticleSubComponent.Builder builder);

    @Binds
    @IntoMap
    @ActivityKey(Activity_Maps.class)
    abstract AndroidInjector.Factory<? extends Activity>
    bindIntoMapActivityMapsFactory(MapsSubComponent.Builder builder);
}
