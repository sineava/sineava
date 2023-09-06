package com.sineava.hulu;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.KeyEvent;
import android.view.WindowManager;
import android.webkit.WebChromeClient;
import android.webkit.WebResourceRequest;
import android.webkit.WebResourceResponse;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.GridLayout;
import android.widget.TextView;
import android.widget.Toast;

import androidx.fragment.app.FragmentActivity;

import com.google.android.exoplayer2.ExoPlayer;
import com.google.android.exoplayer2.MediaItem;
import com.google.android.exoplayer2.Player;
import com.google.android.exoplayer2.ui.StyledPlayerView;
import com.google.android.exoplayer2.util.MimeTypes;

import org.w3c.dom.Text;

import java.io.ByteArrayInputStream;
import java.io.InputStream;

public class PlayActivity  extends FragmentActivity {
    StyledPlayerView playerView;
    ExoPlayer player;
    int id;
    Context context;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.play);

        Intent intent = getIntent();
        context = getApplicationContext();
        TextView textView = findViewById(R.id.num);

        String url = intent.getStringExtra("url");
        id = Integer.valueOf(intent.getStringExtra("id"));
        int current = Integer.valueOf(intent.getStringExtra("current"));
        textView.setText("第" + (current + 1) + "集");

        player = new ExoPlayer.Builder(context).build();
        player.setRepeatMode(Player.REPEAT_MODE_OFF);
        playerView = findViewById(R.id.player);
        playerView.setPlayer(player);
        playerView.setControllerAutoShow(false);
        player.addListener(new Player.Listener() {
            @Override
            public void onPlaybackStateChanged(int playbackState) {
                // 如果视频播放结束
                if (playbackState == ExoPlayer.STATE_ENDED) {
                    player.release();
                    Intent intent = new Intent();
                    setResult(1, intent);
                    finish();
                }
            }
        });

        play(url);
    }

    private void play(String url) {
        MediaItem mediaItem = new MediaItem.Builder().setUri(url).setMimeType(MimeTypes.APPLICATION_M3U8).build();
        player.setMediaItem(mediaItem);
        player.prepare();
        player.play();
    }

    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        if (!playerView.isControllerFullyVisible()) {
            playerView.showController();
        }
        return super.onKeyDown(keyCode, event);
    }

    @Override
    public void onBackPressed() {
        player.release();
        super.onBackPressed();
    }
}
