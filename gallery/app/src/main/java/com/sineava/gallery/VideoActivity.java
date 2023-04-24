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
    FloatingActionButton btn;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN, WindowManager.LayoutParams.FLAG_FULLSCREEN);
        setContentView(R.layout.activity_video);
        Intent intent = getIntent();
        String url = intent.getStringExtra("url");
        id = intent.getStringExtra("id");
        btn = findViewById(R.id.config);
        StyledPlayerView playerView = findViewById(R.id.player);
        player = new ExoPlayer.Builder(this).build();
        playerView.setPlayer(player);
        GridLayout layout = findViewById(R.id.recommend);
        // 显示
        btn.setOnClickListener(view -> {
            layout.setVisibility(View.VISIBLE);
            if (isInit == true) {
                ScrollView scrollView = findViewById(R.id.scroll_view);
                String playUrl = "https://bad.news/dm/play/id-" + id;
                Log.d("PURL", playUrl);
                new Hanime(player, playerView, layout).loadHanime(layout, playUrl, scrollView, 0);
                isInit = false;
            }
        });
        new Hanime().play(player, url);
    }

    @Override
    public void onBackPressed() {
        super.onBackPressed();
        player.release();
    }
}