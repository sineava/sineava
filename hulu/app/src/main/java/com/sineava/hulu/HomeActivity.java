package com.sineava.hulu;

import android.annotation.SuppressLint;
import android.content.ContentValues;
import android.content.Context;
import android.content.Intent;
import android.database.Cursor;
import android.graphics.Typeface;
import android.graphics.drawable.Drawable;
import android.os.Bundle;
import android.os.StrictMode;
import android.util.TypedValue;
import android.view.Gravity;
import android.view.KeyEvent;
import android.view.ViewGroup;
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
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.bumptech.glide.Glide;
import com.bumptech.glide.load.resource.drawable.DrawableTransitionOptions;
import com.sineava.hulu.models.Movie;
import com.sineava.hulu.utils.Tool;

import org.json.JSONArray;
import org.json.JSONObject;

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
    MyDataManager dataManager;

    int page = 1;
    int current = 0;
    int bCurrent = -1;
    int size = 0;
    String focus = "header"; // 当前焦点
    List<List<Movie>> list = Arrays.asList(
            new ArrayList<>(),
            new ArrayList<>(),
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
                    if (current < 5) {
                        headerChange(prevTextView, "right");
                        if (current > 3) { // 收藏
                            dataManager = MyDataManager.getInstance(this);
                            Cursor cursor = dataManager.queryAllData(current == 4 ? "save" : "history");
                            List<Movie> movies = new ArrayList<>();
                            while (cursor.moveToNext()) {
                                @SuppressLint("Range") int id = cursor.getInt(cursor.getColumnIndex(MyDatabaseHelper.COLUMN_ID));
                                @SuppressLint("Range") String title = cursor.getString(cursor.getColumnIndex(MyDatabaseHelper.COLUMN_NAME));
                                @SuppressLint("Range") String url = cursor.getString(cursor.getColumnIndex(MyDatabaseHelper.COLUMN_URL));

                                Movie movie = new Movie();
                                movie.setId(id);
                                movie.setImg(url);
                                movie.setTitle(title);
                                movies.add(movie);
                            }
                            cursor.close();
                            list.set(current, movies);
                        }
                        loadCurrent();
                    }

                }
                if (focus == "bottom") {
                    if (bCurrent == size - 1) {
                        page += 1;
                        pageView.setText("第" + page + "页");
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
                    if (bCurrent != 0) {
                        bottomChange("left");
                    } else {
                        if (page > 1) {
                            page -= 1;
                            pageView.setText("第" + page + "页");
                            list.set(current, Tool.getMovies(current, page));
                            loadCurrent();
                            bottomChange("right");
                        }
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
            case 82:
                save(list.get(current).get(bCurrent), "save");
                Toast.makeText(HomeActivity.this,"收藏成功♥", Toast.LENGTH_SHORT).show();
            case 66:
                Movie movie = list.get(current).get(bCurrent == -1 ? 0 : bCurrent);
                Intent intent = new Intent(HomeActivity.this, DetailActivity.class);
                intent.putExtra("movie", movie);
                startActivity(intent);
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
            prevParams.width = 370;
            prevParams.height = 404;
            prevCard.setLayoutParams(prevParams);
        }
        int offset = (int)bottomT.getTranslationX();
        if (type == "left") {
            bCurrent -= 1;
            int offsetReal = offset + 380;
            if (bCurrent > 1 && bCurrent <= 26) {
                bottomT.setTranslationX(bCurrent == 0 ? 0 : offsetReal);
            }
        } else {
            bCurrent += 1;
            if (bCurrent > 2 && bCurrent <= 27) {
                bottomT.setTranslationX(offset - 380);
            }
        }
        CardView currentCard = (CardView) bottomB.getChildAt(bCurrent);
        ViewGroup.LayoutParams currentParams = currentCard.getLayoutParams();
        currentParams.width = 420;
        currentParams.height = 450;
        currentCard.setLayoutParams(currentParams);
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
            LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(370, 404);
            params.rightMargin = 10;
            params.gravity = Gravity.CENTER_VERTICAL;
            ViewGroup.LayoutParams imgParams = new ViewGroup.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT);
            ImageView img = new ImageView(context);
            img.setScaleType(ImageView.ScaleType.CENTER_CROP);
            TextView text = new TextView(context);
            text.setTypeface(null, Typeface.BOLD);
            text.setGravity(Gravity.CENTER_HORIZONTAL);
            text.setBackgroundColor(0x66000000);
            text.setHeight(ViewGroup.LayoutParams.WRAP_CONTENT);
            int total = movie.getTotal();
            if (total > 0) {
                text.setText(movie.getTitle() + " / " + total + "集");
            } else {
                text.setText(movie.getTitle());
            }
            text.setTextSize(TypedValue.COMPLEX_UNIT_SP, 18);
            text.setTextColor(0xFFFFFFFF);
            Glide.with(context)
                    .load(movie.getImg())
                    .centerCrop()
                    .error(R.drawable.avatar)
                    .transition(DrawableTransitionOptions.withCrossFade())
                    .into(img);
            img.setLayoutParams(imgParams);
            card.setPreventCornerOverlap(false);
            card.setUseCompatPadding(true);
            card.setRadius(8f);
            card.setLayoutParams(params);
            card.addView(img);
            card.addView(text);
            bottomB.addView(card);
        }
    }

    private void save(Movie movie, String tableName) {
        dataManager = MyDataManager.getInstance(this);
        ContentValues values = new ContentValues();
        values.put(MyDatabaseHelper.COLUMN_ID, movie.getId());
        values.put(MyDatabaseHelper.COLUMN_URL, movie.getImg());
        values.put(MyDatabaseHelper.COLUMN_NAME, movie.getTitle());
        dataManager.insertData(tableName, values);
    }
}
