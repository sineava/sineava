package com.sineava.hulu;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.graphics.Color;
import android.graphics.drawable.Drawable;
import android.os.Bundle;
import android.util.TypedValue;
import android.view.KeyEvent;
import android.view.View;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.webkit.WebChromeClient;
import android.webkit.WebResourceRequest;
import android.webkit.WebResourceResponse;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.Button;
import android.widget.GridLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.Nullable;
import androidx.constraintlayout.widget.ConstraintLayout;
import androidx.core.content.ContextCompat;
import androidx.fragment.app.FragmentActivity;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.sineava.hulu.models.Movie;

import org.json.JSONArray;
import org.json.JSONObject;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.net.URL;

public class DetailActivity extends FragmentActivity {
    RelativeLayout layout;
    GridLayout gridLayout;
    Movie currentMovie;
    Context context;
    TextView titleView;
    TextView descView;
    TextView totalView;
    Button play;
    int current = -1;
    int total = 0;
    int comp = 0;
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.detail);
        layout = findViewById(R.id.detail);
        gridLayout = findViewById(R.id.grid);
        play = findViewById(R.id.play);
        titleView = findViewById(R.id.title);
        descView = findViewById(R.id.desc);
        totalView = findViewById(R.id.total);
        context = getApplicationContext();

        Intent intent = getIntent();
        Movie movie = (Movie) intent.getSerializableExtra("movie");
        total = movie.getTotal();
        currentMovie = movie;

        play.setOnClickListener(view -> {
            play(0);
        });

        if (total > 0) initSeries();
        changeCover();
    }

    public void initSeries() {
        int i;
        for (i = 0; i < total;i++) {
            Button btn = new Button(context);
            btn.setText("第" + (i + 1) + "集");
            btn.setWidth(240);
            btn.setHeight(80);
            int finalI = i;
            btn.setOnClickListener(view -> {
                current = finalI;
                play(finalI);
            });
            gridLayout.addView(btn);
        }
    }

    private void changeCover() {
        String title = currentMovie.getTitle();
        titleView.setText(title);
        totalView.setText("总集数：" + currentMovie.getTotal());
        if (!title.isEmpty()) {
            RequestQueue queue = Volley.newRequestQueue(this);
            String url = "https://api.themoviedb.org/3/search/movie?api_key=ff95cb56b0e46787ba2603975fe7b441&language=zh-CN&page=1&query=" + title;

            StringRequest stringRequest = new StringRequest(Request.Method.GET, url,
                    response -> {
                        try {
                            JSONObject obj = new JSONObject(response);
                            JSONArray jsonArray = obj.getJSONArray("results");
                            if (jsonArray.length() != 0) {
                                JSONObject ob = (JSONObject) jsonArray.get(0);
                                String img = ob.getString("backdrop_path");
                                String desc = ob.getString("overview");
                                descView.setText(desc);
                                if (!img.isEmpty()) {
                                    Drawable drawable = Drawable.createFromStream(new URL("https://image.tmdb.org/t/p/original" + img).openStream(), "cover.jpg");
                                    layout.setBackground(drawable);
                                }
                            } else {
                                layout.setBackground(ContextCompat.getDrawable(context, R.drawable.cover));
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    },
                    error -> {
                        System.out.println(error);
                    }
            );
            queue.add(stringRequest);
        }
    }

    public void play(int num) {
        WebView webView = new WebView(DetailActivity.this);
        WebSettings webSettings = webView.getSettings();
        webSettings.setJavaScriptEnabled(true);
        webSettings.setDomStorageEnabled(true);
        webView.setWebChromeClient(new WebChromeClient());
        String url = "https://www.kanjuda.com/video/?" + currentMovie.getId() +"-0-"+ num +".html";
        webView.loadUrl(url);
        Intent intent = new Intent(DetailActivity.this, PlayActivity.class);
        webView.setWebViewClient(new WebViewClient() {
            @Override
            public WebResourceResponse shouldInterceptRequest(WebView view, WebResourceRequest request) {
                String url = request.getUrl().toString();
                if (url.endsWith("m3u8")) {
                    intent.putExtra("id", String.valueOf(currentMovie.getId()));
                    intent.putExtra("url", url);
                    intent.putExtra("current", String.valueOf(num));
                    startActivityForResult(intent, 1);
                    return new WebResourceResponse("text/html", "UTF-8", null);
                }
                return null;
            }
        });
    }

    public void animate(Animation buttonAnimation, String type) {
        if (type.equals("play")) {
            play.startAnimation(buttonAnimation);
        } else {
            Button btn = (Button) gridLayout.getChildAt(current - 1);
            btn.startAnimation(buttonAnimation);
        }
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (resultCode == 1) {
            current += 1;
            play(current);
        }
    }
}
