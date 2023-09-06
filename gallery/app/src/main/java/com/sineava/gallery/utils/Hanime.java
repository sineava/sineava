package com.sineava.gallery.utils;

import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.util.Log;
import android.view.View;
import android.webkit.WebResourceRequest;
import android.webkit.WebResourceResponse;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.GridLayout;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;

import androidx.cardview.widget.CardView;

import com.bumptech.glide.Glide;
import com.bumptech.glide.load.resource.drawable.DrawableTransitionOptions;
import com.google.android.exoplayer2.ExoPlayer;
import com.google.android.exoplayer2.MediaItem;
import com.google.android.exoplayer2.ui.StyledPlayerView;
import com.google.android.exoplayer2.util.MimeTypes;
import com.sineava.gallery.R;
import com.sineava.gallery.VideoActivity;
import com.sineava.gallery.model.Params;

import org.json.JSONObject;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import okhttp3.MultipartBody;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

public class Hanime {
    ExoPlayer player;
    StyledPlayerView playerView;
    GridLayout layout;

    public Hanime() {}
    public Hanime(ExoPlayer player, StyledPlayerView playerView, GridLayout layout) {
        this.player = player;
        this.playerView = playerView;
        this.layout = layout;
    }
    public void loadHanime(GridLayout layout, String url, ScrollView scrollView, Integer flag) {
        Context context = layout.getContext();
        try {
            Document document = Jsoup.connect(url).get();
            Elements els = document.select(".afterglow.post-thumb");
            LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(500, 760);
            params.rightMargin = 30;
            params.bottomMargin = 16;
            for (Element el: els) {
                Element img = el.select("img").first();
                String videoUrl = el.absUrl("href");
                String imgUrl = img.attr("data-echo");
                String title = img.attr("alt");
                CardView cardView = new CardView(context);
                cardView.setLayoutParams(params);
                ImageView imgView = new ImageView(context);
                imgView.setScaleType(ImageView.ScaleType.CENTER_CROP);
                TextView textView = new TextView(context);
                textView.setText(title);
                textView.setTextColor(0xFFFFFFFF);
                cardView.addView(imgView);
                cardView.addView(textView);
                cardView.setTag(videoUrl.split("/id-")[1]);
                cardView.setOnClickListener(view -> {
                    Params par = playVideo(view.getTag().toString(), "dm");
                    if (flag.equals(1)) {
                        Intent intent = new Intent(context, VideoActivity.class);
                        intent.putExtra("url", par.getUrl());
                        intent.putExtra("id", par.getId());
                        intent.putExtra("type", "dm");
                        context.startActivity(intent);
                    } else {
                        play(player, par.getUrl(), "dm");
                        layout.removeAllViews();
                        layout.setVisibility(View.INVISIBLE);
                    }
                });
                layout.addView(cardView);
                Glide.with(context).load(imgUrl).transition(DrawableTransitionOptions.withCrossFade()).into(imgView);
            }
            scrollView.post(() -> scrollView.smoothScrollTo(0, 0));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void LoadTrandition(GridLayout layout, WebView webView, String link) {
        webView.setWebViewClient(new WebViewClient() {
            @Override
            public WebResourceResponse shouldInterceptRequest(WebView view, WebResourceRequest request) {
                String url = request.getUrl().toString();
                Log.d("DDDDDD", url);
                if (url.endsWith(".mp4.m3u8")) {
                    Intent intent = new Intent(layout.getContext(), VideoActivity.class);
                    intent.putExtra("url", url);
                    intent.putExtra("id", "/id-1");
                    intent.putExtra("type", "av");
                    layout.getContext().startActivity(intent);
                }
                return super.shouldInterceptRequest(view, request);
            }
        });
        WebSettings webSettings = webView.getSettings();
        webSettings.setJavaScriptEnabled(true);
        webSettings.setDomStorageEnabled(true);
        webSettings.setUserAgentString("Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.134 Safari/537.36");
        webView.loadUrl(link);
    }

    public void loadAv(GridLayout layout, String url, ScrollView scrollView, Integer flag) {
        Context context = layout.getContext();
        try {
            Document document = Jsoup.connect(url).get();
            Elements els;
            if (flag == 0) {
                els = document.select(".post.post-medium");
            } else {
                els = document.select(".entry");
            }
            LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(500, 760);
            params.rightMargin = 30;
            params.bottomMargin = 16;
            for (Element el: els) {
                Element img;
                Element titleEl;
                String imgUrl;
                String videoUrl;
                String title;
                if (flag == 0) {
                    img = el.selectFirst(".img-responsive");
                    titleEl = el.selectFirst(".infor a");
                    imgUrl = img.attr("src");
                } else {
                    img = el.selectFirst("img");
                    titleEl = el.selectFirst("a.title");
                    String echo = img.attr("data-echo");
                    String src = img.attr("src");
                    imgUrl = echo.length() > 0 ? echo : src;
                }
                videoUrl = titleEl.absUrl("href");
                title = titleEl.text();
                CardView cardView = new CardView(context);
                cardView.setLayoutParams(params);
                ImageView imgView = new ImageView(context);
                imgView.setScaleType(ImageView.ScaleType.CENTER_CROP);
                TextView textView = new TextView(context);
                textView.setText(title);
                textView.setTextColor(0xFFFFFFFF);
                cardView.addView(imgView);
                cardView.addView(textView);
                cardView.setTag(videoUrl.split("/")[4]);
                cardView.setOnClickListener(view -> {
                    Params par = playVideo(view.getTag().toString(), "av");
                    if (flag == 1) {
                        Intent intent = new Intent(context, VideoActivity.class);
                        intent.putExtra("url", par.getUrl());
                        intent.putExtra("id", par.getId());
                        intent.putExtra("type", "av");
                        context.startActivity(intent);
                    } else {
                        play(player, par.getUrl(), "av");
                        layout.removeAllViews();
                        layout.setVisibility(View.INVISIBLE);
                    }
                });
                layout.addView(cardView);
                Glide.with(context).load(imgUrl).transition(DrawableTransitionOptions.withCrossFade()).into(imgView);
            }
            scrollView.post(() -> scrollView.smoothScrollTo(0, 0));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private Params playVideo(String id, String type) {
        try {
            // 请求视频数据
            OkHttpClient client = new OkHttpClient().newBuilder().build();
            RequestBody body = new MultipartBody.Builder().setType(MultipartBody.FORM)
                    .addFormDataPart("token","03AKH6MRGzis06thjaEIoqkOM9uPiJ5EbvAyTsfMrlG5f_DheP4z0eFikzTpNOpp3ItXnchObX7PHzkYm2mc_cbWIVZvw6BaH26_UG1a1BHmhhM34ZKKZzLbvrd1-Dup_WS0NqOpRPrYB5xxFkkUzlZMgMv4UqKyA-0x1wD1OLLsMBeItPUrfWk4Bgbe3I2yW1TvKuImZkbiOMiwQchUBdNSTJpLxctdb-gF_M_OIABESUbReuvFc_zEcr6pfTpGXUX2xIr9kDkhj36hk6If5sfec5Amiu-9lYrNH176SiU1OA4mxTFV4T4RVNMA4cdezz-KUiYFua9qWA3A-ej5Mpa1K6DopEceIIszkR585ZU8LfA8g_EudAYDa8lvWD8xUH7533OjGdcp1T0qEJt3cFW1mGC5RQbx1MfMLmZreB3HU0LnhhagoIXkD1QcI2dgleJQQflWVqbPsF_H6ZXH_1eat_2sgGI2BSHbfoPC2frL0Eyei9l0Kkf63gqzGRGv-mGTe3KQ7zViJj_311gA4Mr9-E9ps8W5Oqyumc8NDH0iZMDuWKe2WdQHReoE3kJlqpip42NRNv5vT1xxpQWx3lhSoU5fmj-lBemDiTndM1aVpbmbNfDnMG0j1DmQVeAS3mEAxBq01LYnGi5uxjoX1FZ2lTKcri7V0eN7ntHg8P-AxvSF4cPb-N3B4lgHw-vYF19e4wMA2wf5zqE3V-VOSc5HApZeiSQ5TofUvGjLIN6pcQM-I9ENhopmEBCfwJo-ANJcPuYkb1klHZW1ZNp_QzzIKrl7kOXtrywLjDnrnnWrl5CWcoUUbHNJIUjO0oT0SdZsAxfY7kiQbgL4MgEN6lRW-x5aiJe03G6MVVcEJ9RwzvrvDCKS76w52PfV65Ag2iWZcG1Z5J9nKN2Y335Cc80XArnUbtId6sP9XVXt5se3PODonSFdDiGu3MZ-jrli-0eOCND8NilfFlr1EpDkHyT6EOsIHDF-1xuFNv0_dCZj14Z8pWtX8Cw0sRLvo5fJ0ffifWRsIe2k465KqLJ04Cl6XH-_mrfjYXBWcBOWglqPzZyi3fUg_sJvrlxlDJizqQVw9Rd3RwtM2x8mfkY1vH82eHTt4rGoELK5m0ykbTPEuoj1GQ9f_OU9DAQEPz5PNxfNaNodeWq3Ou05tOvzBGwVrJbwvZYwdDNO3dzzzbODhtg5Oar5eIjsVi6lDB_U3V79Q5P9TQFpRDOCmwDToFQxlfkrEF3jeQ1n-4Rt3Lj2Um19-FaJ3VZA6GD3D0-ekN4cbNimvy6BYJ71pBIrdfZbcVWu1wSaC-lOhMLZNJ9ralccwciA67BppoAhLJGliP-v1SZQJlicX0j0H4q8I19iujrGPil1WWPOuFGxysxVOvaazo3gmn2aVw7u77NAFxGY0O3r-Y6Fyf4Ovu-NsBSxF-rWKnJMg5UA5k2AV1Jnh_3_xjikffUdodWtAafsKHWatlxIK802bom5PBxSZCNuvoncDhWFulFwAYR45AqKNbVboHy1eMNOuJ19ogsw_VC_z5U6Cox3H6NkGVI9oMm68nwjqYUy1FhAj3oqqTv_C3mBfg_CWpqsRDmg_bi06yHEgyiRQI9jO4no_pWUUgiGbJK5ySySclWK8JZpHkBPBNZ3wE4EqCjwk")
                    .addFormDataPart("id",id)
                    .addFormDataPart("type",type)
                    .build();
            Request request = new Request.Builder()
                    .url("https://bad.news/ajax.php?code=recaptcha")
                    .method("POST", body)
                    .addHeader("Cookie", "PHPSESSID=7jiojb3c75b1m3md27bclavum9")
                    .build();
            Response response = client.newCall(request).execute();
            JSONObject obj = new JSONObject(response.body().string());
            String url = obj.get("video").toString();
            Params params = new Params(url, id);
            return params;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public void play(ExoPlayer player, String url, String type) {
        MediaItem mediaItem;
        if (type.equals("av")) {
            mediaItem = new MediaItem.Builder().setUri(url).setMimeType(MimeTypes.APPLICATION_M3U8).build();
        } else {
            mediaItem = MediaItem.fromUri(Uri.parse("https://ip182522468.ahcdn.com/key=Mi22+qmGXu5CBah1By-utA,s=,end=1682333079,limit=3/state=ZEUMuQ4v/referer=none,.tubepornclassic.com,.gstatic.com/reftag=76056370/media=hls/1/121/1/50828941.m3u8"));
        }
        player.setMediaItem(mediaItem);
        player.prepare();
        player.play();
    }
}
