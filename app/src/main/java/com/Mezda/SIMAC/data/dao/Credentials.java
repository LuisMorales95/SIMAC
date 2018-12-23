package com.Mezda.SIMAC.data.dao;

public class Credentials {
    String id;
    String Token;

    public Credentials(String id, String token) {
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

    public boolean isEmpty(){
        return (this.id.isEmpty()&&this.Token.isEmpty());
    }
}
