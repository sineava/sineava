package com.sineava.gallery.model;

public class Params {
    private String url;
    private String id;
    public Params (String url, String id) {
        this.url = url;
        this.id = id;
    }
    public String getId() {
        return id;
    }
    public void setName(String id) {
        this.id = id;
    }
    public String getUrl() {
        return url;
    }
    public void setAge(String url) {
        this.url = url;
    }
}
