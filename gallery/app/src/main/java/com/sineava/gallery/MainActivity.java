package com.sineava.gallery;

import androidx.appcompat.app.AppCompatActivity;
import android.os.Bundle;
import android.os.StrictMode;
import android.widget.Button;
import android.widget.EditText;
import android.widget.GridLayout;
import android.widget.ScrollView;
import android.widget.TextView;
import com.google.android.material.appbar.MaterialToolbar;
import com.sineava.gallery.utils.Hanime;

public class MainActivity extends AppCompatActivity {
    Button btnPrev;
    Button btnNext;
    Button btnSearch;
    Integer page = 0;
    EditText input;
    ScrollView scrollView;
    TextView textView;
    MaterialToolbar toolbar;
    String keyword = "";
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
        fetchAnime(Type.NONE);

        btnPrev = findViewById(R.id.prev);
        btnNext = findViewById(R.id.next);
        scrollView = findViewById(R.id.scroll);
        toolbar = findViewById(R.id.toolbar);
        input = findViewById(R.id.edit_text);
        btnSearch = findViewById(R.id.search);
        btnPrev.setOnClickListener(view -> {
            fetchAnime(Type.PREV);
        });
        btnNext.setOnClickListener(view -> {
            fetchAnime(Type.NEXT);
        });
        btnSearch.setOnClickListener(view -> {
            keyword = input.getText().toString();
            page = 0;
            fetchAnime(Type.NONE);
        });
    }

    private void fetchAnime (Type type) {
        GridLayout hanime = findViewById(R.id.grid);
        String url;
        if (type == Type.NONE && keyword == "") {
            url = "https://bad.news/dm";
        } else {
            if (type == Type.PREV && page != 0) {
                page--;
            } else {
                page++;
            }
            if (keyword == "") {
                url = "https://bad.news/dm/page-" + page;
            } else {
                url = "https://bad.news/dm/search/q-"+ keyword +"/type-title/page-" + page;
            }
            toolbar.setSubtitle("第" + page + "页");
        }
        hanime.removeAllViews();
        new Hanime().loadHanime(hanime, url, scrollView, 1);
    }
}