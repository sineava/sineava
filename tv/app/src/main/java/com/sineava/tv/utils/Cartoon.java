package com.sineava.tv.utils;

import com.sineava.tv.Movie;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Cartoon {
    public List<Movie> ParseTheme() {
        List list = new ArrayList();
        Random r = new Random();
        try {
            int j,k;
            int n = 1;
            for (j = 1; j < 3; j++) {
                for (k = 1; k < 10; k++) {
                    String link;
//                    if (j == 1) {
//                        n = r.nextInt(1380);
//                    }
//                    if (j == 2) {
//                        n = r.nextInt(644);
//                    }
//                    if (j == 3) {
//                        n = r.nextInt(60);
//                    }
//                    if (j == 4) {
//                        n = r.nextInt(205);
//                    }
                    link = "https://www.kjbaa.com/search.php?page="+ n +"&searchtype=5&order=hit&tid=" + j;
//                    link = "https://www.kanjuda.com/cat/?"+ j +"-"+ n +".html";
//                    if (k == 1) {

//                        link = "https://www.kanjuda.com/cat/?"+ j +".html";
//                    } else {
//                        link = "https://www.kanjuda.com/cat/?"+ j +"-"+ n +".html";
//                    }
                    Document document = Jsoup.connect(link).get();
                    Elements els = document.select(".myui-vodlist .myui-vodlist__box");
                    for (Element el : els) {
                        Element aEl = el.selectFirst(".myui-vodlist__thumb");
                        Element imgEl = el.selectFirst("img");
                        Integer id = new Integer(aEl.attr("href").split("[?|.]")[1]);
                        String description = el.selectFirst("p").text();
                        String title = aEl.attr("title");
                        String imgUrl = imgEl.attr("data-original");
                        String total = el.selectFirst(".text-right").text();
                        String num = "";
                        if (!total.isEmpty() && total.indexOf("1080") == -1) {
                            String regEx="[^0-9]";
                            Pattern p = Pattern.compile(regEx);
                            Matcher m = p.matcher(total);
                            String real = m.replaceAll("").trim();
                            if (!real.isEmpty()) {
                                num = real;
                            }
                        }
                        if (!imgUrl.isEmpty()) {
                            String img = "https://www.kanjuda.com" + imgUrl;
                            list.add(buildMovieInfo(id, title, num, description,
                                    "",
                                    img, img, j)
                            );
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    private static Movie buildMovieInfo(
            Integer id,
            String title,
            String description,
            String studio,
            String videoUrl,
            String cardImageUrl,
            String backgroundImageUrl,
            Integer type) {
        Movie movie = new Movie();
        movie.setId(id);
        movie.setTitle(title);
        movie.setDescription(description);
        movie.setStudio(studio);
        movie.setCardImageUrl(cardImageUrl);
        movie.setBackgroundImageUrl(backgroundImageUrl);
        movie.setVideoUrl(videoUrl);
        movie.setType(type);
        return movie;
    }
}
