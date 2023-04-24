package com.sineava.gallery.utils;

import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.view.View;
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

    public Hanime() {

    }
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
                    Params par = playVideo(view.getTag().toString());
                    if (flag == 1) {
                        Intent intent = new Intent(context, VideoActivity.class);
                        intent.putExtra("url", par.getUrl());
                        intent.putExtra("id", par.getId());
                        context.startActivity(intent);
                    } else {
                        play(player, par.getUrl());
                        scrollView.setVisibility(View.INVISIBLE);
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

    private Params playVideo(String id) {
        try {
            // 请求视频数据
            OkHttpClient client = new OkHttpClient().newBuilder().build();
            RequestBody body = new MultipartBody.Builder().setType(MultipartBody.FORM)
                    .addFormDataPart("token","03AKH6MRGzis06thjaEIoqkOM9uPiJ5EbvAyTsfMrlG5f_DheP4z0eFikzTpNOpp3ItXnchObX7PHzkYm2mc_cbWIVZvw6BaH26_UG1a1BHmhhM34ZKKZzLbvrd1-Dup_WS0NqOpRPrYB5xxFkkUzlZMgMv4UqKyA-0x1wD1OLLsMBeItPUrfWk4Bgbe3I2yW1TvKuImZkbiOMiwQchUBdNSTJpLxctdb-gF_M_OIABESUbReuvFc_zEcr6pfTpGXUX2xIr9kDkhj36hk6If5sfec5Amiu-9lYrNH176SiU1OA4mxTFV4T4RVNMA4cdezz-KUiYFua9qWA3A-ej5Mpa1K6DopEceIIszkR585ZU8LfA8g_EudAYDa8lvWD8xUH7533OjGdcp1T0qEJt3cFW1mGC5RQbx1MfMLmZreB3HU0LnhhagoIXkD1QcI2dgleJQQflWVqbPsF_H6ZXH_1eat_2sgGI2BSHbfoPC2frL0Eyei9l0Kkf63gqzGRGv-mGTe3KQ7zViJj_311gA4Mr9-E9ps8W5Oqyumc8NDH0iZMDuWKe2WdQHReoE3kJlqpip42NRNv5vT1xxpQWx3lhSoU5fmj-lBemDiTndM1aVpbmbNfDnMG0j1DmQVeAS3mEAxBq01LYnGi5uxjoX1FZ2lTKcri7V0eN7ntHg8P-AxvSF4cPb-N3B4lgHw-vYF19e4wMA2wf5zqE3V-VOSc5HApZeiSQ5TofUvGjLIN6pcQM-I9ENhopmEBCfwJo-ANJcPuYkb1klHZW1ZNp_QzzIKrl7kOXtrywLjDnrnnWrl5CWcoUUbHNJIUjO0oT0SdZsAxfY7kiQbgL4MgEN6lRW-x5aiJe03G6MVVcEJ9RwzvrvDCKS76w52PfV65Ag2iWZcG1Z5J9nKN2Y335Cc80XArnUbtId6sP9XVXt5se3PODonSFdDiGu3MZ-jrli-0eOCND8NilfFlr1EpDkHyT6EOsIHDF-1xuFNv0_dCZj14Z8pWtX8Cw0sRLvo5fJ0ffifWRsIe2k465KqLJ04Cl6XH-_mrfjYXBWcBOWglqPzZyi3fUg_sJvrlxlDJizqQVw9Rd3RwtM2x8mfkY1vH82eHTt4rGoELK5m0ykbTPEuoj1GQ9f_OU9DAQEPz5PNxfNaNodeWq3Ou05tOvzBGwVrJbwvZYwdDNO3dzzzbODhtg5Oar5eIjsVi6lDB_U3V79Q5P9TQFpRDOCmwDToFQxlfkrEF3jeQ1n-4Rt3Lj2Um19-FaJ3VZA6GD3D0-ekN4cbNimvy6BYJ71pBIrdfZbcVWu1wSaC-lOhMLZNJ9ralccwciA67BppoAhLJGliP-v1SZQJlicX0j0H4q8I19iujrGPil1WWPOuFGxysxVOvaazo3gmn2aVw7u77NAFxGY0O3r-Y6Fyf4Ovu-NsBSxF-rWKnJMg5UA5k2AV1Jnh_3_xjikffUdodWtAafsKHWatlxIK802bom5PBxSZCNuvoncDhWFulFwAYR45AqKNbVboHy1eMNOuJ19ogsw_VC_z5U6Cox3H6NkGVI9oMm68nwjqYUy1FhAj3oqqTv_C3mBfg_CWpqsRDmg_bi06yHEgyiRQI9jO4no_pWUUgiGbJK5ySySclWK8JZpHkBPBNZ3wE4EqCjwk")
                    .addFormDataPart("id",id)
                    .addFormDataPart("type","dm")
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

    public void play(ExoPlayer player, String url) {
        MediaItem mediaItem = MediaItem.fromUri(Uri.parse(url));
        player.setMediaItem(mediaItem);
        player.prepare();
        player.play();
    }
}
