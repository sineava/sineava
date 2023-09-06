package com.sineava.gallery;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.os.StrictMode;
import android.util.Log;
import android.webkit.JavascriptInterface;
import android.webkit.ValueCallback;
import android.webkit.WebResourceRequest;
import android.webkit.WebResourceResponse;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.Button;
import android.widget.EditText;
import android.widget.GridLayout;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.Spinner;
import android.widget.TextView;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.google.android.material.appbar.MaterialToolbar;
import com.sineava.gallery.utils.Hanime;
import com.sineava.gallery.utils.Utils;

import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

public class MainActivity extends AppCompatActivity {
    Button btnPrev;
    Button btnNext;
    Button btnSearch;
    Integer page = 1;
    EditText input;
    ScrollView scrollView;
    TextView textView;
    MaterialToolbar toolbar;
    String keyword = "";
    Spinner spinner;
    Map<String, String> map;
    enum Type {
        PREV,
        NEXT,
        NONE
    }
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        getWindow().setStatusBarColor(0xFF6750a4);
        setContentView(R.layout.activity_main);
        if (android.os.Build.VERSION.SDK_INT > 9) {
            StrictMode.ThreadPolicy policy = new StrictMode.ThreadPolicy.Builder().permitAll().build();
            StrictMode.setThreadPolicy(policy);
        }

        // 类目键值对
        map = new HashMap<>();
        map.put("动漫", "dm");
        map.put("av", "av");
        map.put("经典", "classic");

        // 获取元素
        btnPrev = findViewById(R.id.prev);
        btnNext = findViewById(R.id.next);
        scrollView = findViewById(R.id.scroll);
        toolbar = findViewById(R.id.toolbar);
        input = findViewById(R.id.edit_text);
        btnSearch = findViewById(R.id.search);
        spinner = findViewById(R.id.spinner);
        btnPrev.setOnClickListener(view -> {
            fetchAnime(Type.PREV);
        });
        btnNext.setOnClickListener(view -> {
            fetchAnime(Type.NEXT);
        });
        btnSearch.setOnClickListener(view -> {
            keyword = input.getText().toString();
            page = 1;
            fetchAnime(Type.NONE);
        });
        fetchAnime(Type.NONE);
    }

    private void fetchAnime (Type type) {
        GridLayout hanime = findViewById(R.id.grid);
        String url;
        String selectedType = map.get(spinner.getSelectedItem().toString());
        if (!type.equals(Type.NONE)) {
            if (type == Type.PREV) {
                if (page > 1) page--;
            } else {
                page++;
            }
        }
        if (btnPrev != null) {
            if (page == 1) {
                btnPrev.setEnabled(false);
            } else {
                btnPrev.setEnabled(true);
            }
        }
        Utils utils = new Utils();
        url = utils.getUrl(selectedType, keyword, page);
        toolbar.setSubtitle("第" + page + "页");
        hanime.removeAllViews();
        Hanime hanimeInstance = new Hanime();
        if (selectedType == "dm") hanimeInstance.loadHanime(hanime, url, scrollView, 1);
        if (selectedType == "av") hanimeInstance.loadAv(hanime, url, scrollView, 1);
        if (selectedType == "classic") {
            if (!keyword.equals("")) {
                WebView webView = findViewById(R.id.webview);
                hanimeInstance.LoadTrandition(hanime, webView, keyword);
            }
        }
    }
}