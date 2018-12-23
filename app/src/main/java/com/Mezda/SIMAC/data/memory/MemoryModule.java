package com.Mezda.SIMAC.data.memory;

import com.Mezda.SIMAC.data.dao.Article;
import com.Mezda.SIMAC.data.dao.Map;

import java.util.ArrayList;

import javax.inject.Singleton;

import dagger.Module;
import dagger.Provides;

@Module
public class MemoryModule {
    @Provides @Singleton
    MemoryRepository<Article> providesLocalArticleMemory(){
        return new LocalArticlesRepository(new Article(), new ArrayList<>());
    }
    @Provides @Singleton
    MemoryRepository<Map> providesMapMemory(){
        return new MapMemory(new ArrayList<>(),new Map());
    }
}
