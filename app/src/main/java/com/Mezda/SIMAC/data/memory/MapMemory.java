package com.Mezda.SIMAC.data.memory;

import com.Mezda.SIMAC.data.dao.Map;

import java.util.List;

public class MapMemory  implements MemoryRepository<Map>{

    private List<Map> mapList;
    private Map map;

    public MapMemory(List<Map> mapList, Map map) {
        this.mapList = mapList;
        this.map = map;
    }

    @Override
    public List<Map> getMemoryItem() {
        return mapList;
    }

    @Override
    public void setMemoryItem(Map item) {
        mapList.add(item);
    }

    @Override
    public Map getSelectedItem() {
        return map;
    }

    @Override
    public void setSelectedItem(Map item) {
        this.map = item;
    }
}
