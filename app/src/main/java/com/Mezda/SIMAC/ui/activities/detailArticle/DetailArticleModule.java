package com.Mezda.SIMAC.ui.activities.detailArticle;

import com.Mezda.SIMAC.data.dao.Article;
import com.Mezda.SIMAC.data.dao.Map;
import com.Mezda.SIMAC.data.memory.MemoryRepository;
import com.Mezda.SIMAC.ui.base.PerActivity;

import dagger.Module;
import dagger.Provides;

@Module
public class DetailArticleModule {
    @Provides @PerActivity
    DetailArticleContract.Model providesDetailArticleModel(MemoryRepository<Article> articleMemory,
                                                           MemoryRepository<Map> mapMemoryRepository){
        return new DetailArticleModel(articleMemory,mapMemoryRepository);
    }
    @Provides @PerActivity
    DetailArticleContract.Presenter providesDetailArticlePresenter(DetailArticleContract.Model model){
       return new DetailArticlePresenter(model);
    }
}
