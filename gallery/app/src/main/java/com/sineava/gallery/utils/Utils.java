package com.sineava.gallery.utils;

public class Utils {
    public String getUrl(String type, String keyword, Integer page) {
        String url = "";
        if (type.equals("dm") || type.equals("av")) {
            if (keyword.length() == 0) {
                url = "https://bad.news/"+ type + "/page-" + page;
            } else {
                url = "https://bad.news/" + type + "/search/q-"+ keyword +"/type-title/page-" + page;
            }
        }
        if (type.equals("classic")) {
            if (keyword.length() == 0) {
                url = "https://tubepornclassic.com/top-country/" + page + "/";
            } else {
                url = "https://tubepornclassic.com/search/" + page + "/?s=" + keyword + "&sort=latest-updates&date=all&type=all&duration=all";
            }
        }
        return url;
    }
}
