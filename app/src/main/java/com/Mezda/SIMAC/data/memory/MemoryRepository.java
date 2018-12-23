package com.Mezda.SIMAC.data.memory;

import com.Mezda.SIMAC.data.dao.Article;

import java.util.ArrayList;
import java.util.List;

public interface MemoryRepository<T> {
    List<T> getMemoryItem();
    void setMemoryItem(T item);
    T getSelectedItem();
    void setSelectedItem(T item);
}
