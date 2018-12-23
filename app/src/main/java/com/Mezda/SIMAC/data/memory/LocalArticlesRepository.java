package com.Mezda.SIMAC.data.memory;

import com.Mezda.SIMAC.data.dao.Article;

import java.util.List;

public class LocalArticlesRepository implements MemoryRepository<Article> {

    private List<Article> articleList;
    private Article article;

    public LocalArticlesRepository(Article article, List<Article> articleList) {
        this.article = article;
        this.articleList = articleList;
    }

    @Override
    public List<Article> getMemoryItem() {
        return articleList;
    }

    @Override
    public void setMemoryItem(Article item) {
        articleList.add(item);
    }

    @Override
    public Article getSelectedItem() {
        return article;
    }

    @Override
    public void setSelectedItem(Article item) {
        this.article=item;
    }
}
