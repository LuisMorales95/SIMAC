package com.Mezda.SIMAC.ui.activities.detailArticle;

import com.Mezda.SIMAC.data.dao.Article;
import com.Mezda.SIMAC.data.dao.Map;
import com.Mezda.SIMAC.data.memory.MemoryRepository;

public class DetailArticleModel implements DetailArticleContract.Model {

    private MemoryRepository<Article> memoryRepository;
    private MemoryRepository<Map> mapMemoryRepository;

    public DetailArticleModel(MemoryRepository<Article> memoryRepository,MemoryRepository<Map> mapMemoryRepository) {
        this.memoryRepository = memoryRepository;
        this.mapMemoryRepository = mapMemoryRepository;
    }

    @Override
    public void setSelectedMap(Map map) {
        mapMemoryRepository.setSelectedItem(map);
    }

    @Override
    public Article selectedArticle() {
        return memoryRepository.getSelectedItem();
    }
}
