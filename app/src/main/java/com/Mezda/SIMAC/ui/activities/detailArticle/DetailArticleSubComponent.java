package com.Mezda.SIMAC.ui.activities.detailArticle;

import android.app.Activity;

import com.Mezda.SIMAC.ui.base.PerActivity;

import dagger.Subcomponent;
import dagger.android.AndroidInjector;

@PerActivity
@Subcomponent(modules = DetailArticleModule.class)
public interface DetailArticleSubComponent extends AndroidInjector<Activity_DetailArticle> {
    @Subcomponent.Builder
    abstract class Builder extends AndroidInjector.Builder<Activity_DetailArticle>{}
}
