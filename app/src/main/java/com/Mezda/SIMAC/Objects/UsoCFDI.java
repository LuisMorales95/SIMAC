package com.Mezda.SIMAC.Objects;

public class UsoCFDI {
    String
            id,
            type,
            name;
    
    public UsoCFDI() {
    }
    
    public UsoCFDI(String id, String type, String name) {
        this.id = id;
        this.type = type;
        this.name = name;
    }
    
    public String getId() {
        return id;
    }
    
    public void setId(String id) {
        this.id = id;
    }
    
    public String getType() {
        return type;
    }
    
    public void setType(String type) {
        this.type = type;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    @Override
    public String toString() {
        return  name ;
    }
    
}
