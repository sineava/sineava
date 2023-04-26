package com.sineava.hulu;

import android.animation.ObjectAnimator;
import android.animation.PropertyValuesHolder;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.graphics.Bitmap;
import android.graphics.Color;
import android.graphics.ColorFilter;
import android.graphics.drawable.ColorDrawable;
import android.graphics.drawable.Drawable;
import android.os.Bundle;
import android.os.StrictMode;
import android.util.Log;
import android.util.TypedValue;
import android.view.Gravity;
import android.view.KeyEvent;
import android.view.View;
import android.view.ViewGroup;
import android.view.animation.Animation;
import android.view.animation.OvershootInterpolator;
import android.view.animation.ScaleAnimation;
import android.webkit.WebResourceRequest;
import android.webkit.WebResourceResponse;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.AbsoluteLayout;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.Nullable;
import androidx.cardview.widget.CardView;
import androidx.constraintlayout.widget.ConstraintLayout;
import androidx.core.content.ContextCompat;
import androidx.fragment.app.FragmentActivity;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.bumptech.glide.Glide;
import com.bumptech.glide.load.MultiTransformation;
import com.bumptech.glide.load.resource.bitmap.CenterCrop;
import com.bumptech.glide.load.resource.bitmap.FitCenter;
import com.bumptech.glide.load.resource.drawable.DrawableTransitionOptions;
import com.bumptech.glide.request.RequestOptions;
import com.sineava.hulu.models.Movie;
import com.sineava.hulu.utils.Tool;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.net.URL;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class HomeActivity extends FragmentActivity {
    LinearLayout header;
    RelativeLayout bottomT;
    LinearLayout bottomB;
    ConstraintLayout constraint;
    TextView pageView;
    int page = 1;
    int current = 0;
    int bCurrent = -1;
    int size = 0;
    String focus = "header"; // 当前焦点
    List<List<Movie>> list = Arrays.asList(
            new ArrayList<>(),
            new ArrayList<>(),
            new ArrayList<>(),
            new ArrayList<>()
    ); // 电影列表
    Context context;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.home);

        if (android.os.Build.VERSION.SDK_INT > 9) {
            StrictMode.ThreadPolicy policy = new StrictMode.ThreadPolicy.Builder().permitAll().build();
            StrictMode.setThreadPolicy(policy);
        }

        context = getApplicationContext();
        constraint = findViewById(R.id.constraint);
        pageView = findViewById(R.id.page);
        header = findViewById(R.id.header);
        bottomT = findViewById(R.id.bottom_t);
        bottomB = findViewById(R.id.bottom_b);

        list.set(0, Tool.getMovies(0, page));
        list.set(1, Tool.getMovies(1, page));
        list.set(2, Tool.getMovies(2, page));
        list.set(3, Tool.getMovies(3, page));
        loadMovies();
    }

    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        final int code = event.getKeyCode();
        TextView prevTextView = (TextView) header.getChildAt(current);
        TextView textView;
        // 上: 19 下： 20 左: 21 右: 22 确定: 66 返回: 4 菜单: 82
        switch (code) {
            case 22:
                if (focus == "header") {
                    if (current < 3) {
                        headerChange(prevTextView, "right");
                        loadCurrent();
                    } else {
                        if (current == 3) { // star
                            Intent intent = new Intent(HomeActivity.this, StarActivity.class);
                            startActivity(intent);
                        }
                    }

                }
                if (focus == "bottom") {
                    if (bCurrent == size - 1) {
                        page += 1;
                        pageView.setText("第" + page + current + "页");
                        list.set(current, Tool.getMovies(current, page));
                        loadCurrent();
                    }
                    bottomChange("right");
                }
                break;
            case  21:
                if (focus == "header") {
                    if (current != 0) {
                        headerChange(prevTextView, "left");
                        loadCurrent();
                    }
                }
                if (focus == "bottom") {
                    if (bCurrent != 0) bottomChange("left");
                    if (page > 1) {
                        page -= 1;
                        pageView.setText("第" + page + current + "页");
                        list.set(current, Tool.getMovies(current, page));
                        loadCurrent();
                        bottomChange("right");
                    }
                }
                break;
            case 20:
                focus = "bottom";
                textView = (TextView) header.getChildAt(current);
                textView.setTextSize(TypedValue.COMPLEX_UNIT_SP, 16);
                bCurrent = -1;
                bottomChange("right");
                break;
            case 19:
                focus = "header";
                textView = (TextView) header.getChildAt(current);
                textView.setTextSize(TypedValue.COMPLEX_UNIT_SP, 26);
                bCurrent = -1;
                break;
            case 66:
                Movie movie = list.get(current).get(bCurrent == -1 ? 0 : bCurrent);
                WebView webView = new WebView(context);
                WebSettings webSettings = webView.getSettings();
                webSettings.setJavaScriptEnabled(true);
                webSettings.setDomStorageEnabled(true);
                webView.loadUrl("https://www.kanjuda.com/video/?" + movie.getId() +"-0-"+ 0 +".html");
                webView.setWebViewClient(new WebViewClient() {
                    @Override
                    public WebResourceResponse shouldInterceptRequest(WebView view, WebResourceRequest request) {
                        // 在這裡攔截請求，例如：
                        String url = request.getUrl().toString();
                        if (url.endsWith("m3u8")) {
//                            movies.add(movie);
                            Intent intent = new Intent(HomeActivity.this, PlayActivity.class);
                            intent.putExtra("url", url);
                            startActivity(intent);
                            InputStream stream = new ByteArrayInputStream("中断".getBytes());
                            return new WebResourceResponse("text/plain", "UTF-8", stream);
                        }
                        return null;
                    }
                });

        }
        return super.onKeyDown(keyCode, event);
    }

    void headerChange(TextView prevTextView, String type) {
        TextView currentTextView;
        if (type == "left") {
            current -= 1;
        } else {
            current += 1;
        }
        currentTextView = (TextView) header.getChildAt(current);
        currentTextView.setTextSize(TypedValue.COMPLEX_UNIT_SP, 26);
        prevTextView.setTextSize(TypedValue.COMPLEX_UNIT_SP, 16);
    }

    void bottomChange(String type) {
        if (bCurrent != -1) {
            CardView prevCard = (CardView) bottomB.getChildAt(bCurrent);
            ViewGroup.LayoutParams prevParams = prevCard.getLayoutParams();
            prevParams.width = 380;
            prevParams.height = 410;
            prevCard.setLayoutParams(prevParams);
        }
        int offset = (int)bottomT.getTranslationX();
        if (type == "left") {
            bCurrent -= 1;
//            changeCover();
            if (bCurrent > 2) {
                bottomT.setTranslationX(offset + 390);
            }
        } else {
            bCurrent += 1;
//            changeCover();
            if (bCurrent > 2 && bCurrent < size - 1) {
                bottomT.setTranslationX(offset - 390);
            }
        }
        CardView currentCard = (CardView) bottomB.getChildAt(bCurrent);
        ViewGroup.LayoutParams currentParams = currentCard.getLayoutParams();
        currentParams.width = 440;
        currentParams.height = 480;
        currentCard.setLayoutParams(currentParams);
    }

    private void changeCover() {
        Movie movie = list.get(current).get(bCurrent);
        String title = movie.getTitle();
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
                                if (!img.isEmpty()) {
                                    Drawable drawable = Drawable.createFromStream(new URL("https://image.tmdb.org/t/p/original" + img).openStream(), "cover.jpg");
                                    constraint.setBackground(drawable);
                                }
                            } else {
                                constraint.setBackground(ContextCompat.getDrawable(context, R.drawable.cover));
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

    private void loadCurrent() {
        bottomT.setTranslationX(0);
        bCurrent = -1;
        List<Movie> currentList = list.get(current);
        bottomB.removeAllViews();
        if (currentList.size() > 0) {
            loadMovies();
        }
    }

    private void loadMovies() {
        int i;
        List<Movie> currentList = list.get(current);
        size = currentList.size();
        for (i = 0; i < size; i++) {
            Movie movie = currentList.get(i);
            CardView card = new CardView(context);
            LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(380, 410);
            params.rightMargin = 10;
            params.gravity = Gravity.CENTER_VERTICAL;
            ViewGroup.LayoutParams imgParams = new ViewGroup.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT);
            ImageView img = new ImageView(context);
            Glide.with(context)
                    .load(movie.getImg())
                    .centerCrop()
                    .error(R.drawable.avatar)
                    .transition(DrawableTransitionOptions.withCrossFade())
                    .into(img);
            img.setLayoutParams(imgParams);
            card.setPreventCornerOverlap(false);
            card.setUseCompatPadding(true);
            card.setCardBackgroundColor(Color.parseColor("#80FFFFFF"));
            card.setLayoutParams(params);
            card.addView(img);
            bottomB.addView(card);
        }
    }

}
