package com.sineava.tv;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.KeyEvent;
import android.view.WindowManager;
import android.widget.Toast;

import androidx.fragment.app.FragmentActivity;

import com.google.android.exoplayer2.ExoPlayer;
import com.google.android.exoplayer2.MediaItem;
import com.google.android.exoplayer2.ui.StyledPlayerView;
import com.google.android.exoplayer2.util.MimeTypes;

/**
 * Loads {@link PlaybackVideoFragment}.
 */
public class PlaybackActivity extends FragmentActivity {
    ExoPlayer player;
    StyledPlayerView playerView;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_play);

        Intent intent = getIntent();
        Movie movie = (Movie) intent.getSerializableExtra(DetailsActivity.MOVIE);
        play(movie.getVideoUrl());
    }

    public void play(String url) {
        player = new ExoPlayer.Builder(this).build();
        playerView = findViewById(R.id.player);
        playerView.setPlayer(player);
        playerView.setControllerAutoShow(false);
        MediaItem mediaItem = new MediaItem.Builder().setUri(url).setMimeType(MimeTypes.APPLICATION_M3U8).build();
        player.setMediaItem(mediaItem);
        player.prepare();
        player.play();
    }

    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
//        Toast.makeText(PlaybackActivity.this, "Hello World!", Toast.LENGTH_SHORT).show();
        if (!playerView.isControllerFullyVisible()) {
            playerView.showController();
        }
        return super.onKeyDown(keyCode, event);
    }

    @Override
    public void onBackPressed() {
        if (playerView.isControllerFullyVisible()) {
            playerView.hideController();
        } else {
            super.onBackPressed();
            player.release();
        }
    }

    @Override
    protected void onResume() {
        super.onResume();
        getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
        getWindow().getDecorView().setFocusable(true);
        getWindow().getDecorView().setFocusableInTouchMode(true);
        getWindow().getDecorView().requestFocus();
    }
}