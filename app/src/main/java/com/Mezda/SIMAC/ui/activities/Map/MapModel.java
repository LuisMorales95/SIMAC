package com.Mezda.SIMAC.ui.activities.Map;

import com.Mezda.SIMAC.data.dao.Map;
import com.Mezda.SIMAC.data.memory.MemoryRepository;

public class MapModel implements MapsContract.Model{

    MemoryRepository<Map> mapMemoryRepository;

    public MapModel(MemoryRepository<Map> mapMemoryRepository) {
        this.mapMemoryRepository = mapMemoryRepository;
    }

    @Override
    public Map getMap() {
        return mapMemoryRepository.getSelectedItem();
    }
}
