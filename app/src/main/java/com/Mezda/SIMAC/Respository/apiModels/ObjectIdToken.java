package com.Mezda.SIMAC.Respository.apiModels;

public class ObjectIdToken {
    String id;
    String Token;

    public ObjectIdToken(String id, String token) {
        this.id = id;
        Token = token;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getToken() {
        return Token;
    }

    public void setToken(String token) {
        Token = token;
    }
}
