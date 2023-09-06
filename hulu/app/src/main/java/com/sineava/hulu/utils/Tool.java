package com.sineava.hulu.utils;

import com.sineava.hulu.models.Movie;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Tool {
    public static List<Movie> getMovies(int type, int page) {
        List list = new ArrayList();
        try {
            String link;
            link = "https://www.kjbaa.com/search.php?page=" + page + "&searchtype=5&order=hit&tid=" + (type + 1);
            Document document = Jsoup.connect(link).get();
            Elements els = document.select(".myui-vodlist .myui-vodlist__box");
            for (Element el : els) {
                Movie movie = new Movie();
                Element aEl = el.selectFirst(".myui-vodlist__thumb");
                Element imgEl = el.selectFirst("img");
                Integer id = new Integer(aEl.attr("href").split("[?|.]")[1]);
                String title = aEl.attr("title");
                String imgUrl = imgEl.attr("data-original");
                String total = el.selectFirst(".text-right").text();
                String img = "";
                movie.setTotal(0);
                if (!total.isEmpty() && total.indexOf("1080") == -1) {
                    String regEx="[^0-9]";
                    Pattern p = Pattern.compile(regEx);
                    Matcher m = p.matcher(total);
                    String real = m.replaceAll("").trim();
                    if (!real.isEmpty()) {
                        movie.setTotal(Integer.valueOf(real));
                    }
                }
                if (!imgUrl.isEmpty()) {
                    img = "https://www.kanjuda.com" + imgUrl;
                }
                movie.setId(id);
                movie.setImg(img);
                movie.setTitle(title);
                list.add(movie);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
