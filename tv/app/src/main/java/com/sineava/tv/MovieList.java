package com.sineava.tv;

import com.sineava.tv.utils.Cartoon;

import java.util.ArrayList;
import java.util.List;

public final class MovieList {
    public static final String MOVIE_CATEGORY[] = {
            "电影",
            "电视剧",
            "综艺",
            "动漫"
    };

    private static List<Movie> list;

    public static List<Movie> getList() {
        if (list == null) {
            list = setupMovies();
        }
        return list;
    }

    public static List<Movie> setupMovies() {
        Cartoon cartoon = new Cartoon();
//        1: 電影
        return cartoon.ParseTheme();
//        return new ArrayList<>();
    }
}