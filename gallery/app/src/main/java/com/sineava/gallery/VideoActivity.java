package com.sineava.gallery;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.view.WindowManager;
import android.widget.GridLayout;
import android.widget.ScrollView;

import androidx.appcompat.app.AppCompatActivity;
import com.google.android.exoplayer2.ExoPlayer;
import com.google.android.exoplayer2.ui.StyledPlayerView;
import com.google.android.material.floatingactionbutton.FloatingActionButton;
import com.sineava.gallery.utils.Hanime;

/**
 * An example full-screen activity that shows and hides the system UI (i.e.
 * status bar and navigation/system bar) with user interaction.
 */
public class VideoActivity extends AppCompatActivity {
    Boolean isInit = true;
    ExoPlayer player;
    String id;
    String type;
    FloatingActionButton btn;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN, WindowManager.LayoutParams.FLAG_FULLSCREEN);
        setContentView(R.layout.activity_video);
        Intent intent = getIntent();
        String url = intent.getStringExtra("url");
        type = intent.getStringExtra("type");
        id = intent.getStringExtra("id");
        btn = findViewById(R.id.config);
        StyledPlayerView playerView = findViewById(R.id.player);
        player = new ExoPlayer.Builder(this).build();
        playerView.setPlayer(player);
        GridLayout layout = findViewById(R.id.recommend);
        ScrollView scrollView = findViewById(R.id.scroll_view);
        // 显示
        btn.setOnClickListener(view -> {
            if (layout.getVisibility() == View.VISIBLE) {
                layout.removeAllViews();
                layout.setVisibility(View.INVISIBLE);
            } else {
                String playUrl;
                Hanime hanime = new Hanime(player, playerView, layout);
                if (type.equals("dm")) {
                    playUrl = "https://bad.news/dm/play/id-" + id;
                    hanime.loadHanime(layout, playUrl, scrollView, 0);
                } else {
                    playUrl = "https://bad.news/av/" + id;
                    hanime.loadAv(layout, playUrl, scrollView, 0);
                }
                layout.setVisibility(View.VISIBLE);
            }
        });
        new Hanime().play(player, url, type);
    }

    @Override
    public void onBackPressed() {
        super.onBackPressed();
        player.release();
    }
}