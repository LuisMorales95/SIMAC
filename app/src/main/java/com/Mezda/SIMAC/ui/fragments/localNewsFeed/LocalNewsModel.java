package com.Mezda.SIMAC.ui.fragments.localNewsFeed;

import com.Mezda.SIMAC.data.dao.Article;
import com.Mezda.SIMAC.data.memory.MemoryRepository;
import com.Mezda.SIMAC.data.network.SimacApi;

import org.json.JSONObject;

import java.util.HashMap;
import java.util.List;

import io.reactivex.Observable;
import okhttp3.RequestBody;

public class LocalNewsModel implements LocalNewsContract.Model {

    private String PAGE="page";
    private String IDUSER="idUser";
    private SimacApi simacApi;
    private MemoryRepository<Article> articleMemory;

    public LocalNewsModel(SimacApi simacApi,MemoryRepository<Article> articleMemory) {
        this.simacApi = simacApi;
        this.articleMemory = articleMemory;
    }

    @Override
    public Observable<List<Article>> localFeed(String counter, String idUser) {
        HashMap<String,String> stringHashMap = new HashMap<>();
        stringHashMap.put(PAGE,counter);
        stringHashMap.put(IDUSER,idUser);

        RequestBody onjRequestBody = RequestBody.create(okhttp3.MediaType.parse("application/json; charset=utf-8")
                ,(new JSONObject(stringHashMap)).toString());

        return simacApi.getLocalFeed(onjRequestBody);
    }

    @Override
    public void saveItemClicked(Article article) {
        articleMemory.setSelectedItem(article);
    }
}
