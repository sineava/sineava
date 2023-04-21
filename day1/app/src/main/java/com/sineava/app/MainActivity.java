package com.sineava.app;

import androidx.appcompat.app.AppCompatActivity;
import androidx.lifecycle.Observer;
import androidx.lifecycle.ViewModelProvider;

import android.os.Bundle;
import android.util.Log;
import android.widget.Button;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity {

    final String TAG = "MTag";
    Button btn1, btn2, btn3;
    TextView text;
    UserViewModel userViewModel;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.home);
        Log.d(TAG, "onCreate execute");
        init();
        initBtn();
    }

    protected void init() {
        btn1 = findViewById(R.id.btn_left);
        btn2 = findViewById(R.id.btn_right);
        btn3 = findViewById(R.id.btn_add);
        text = findViewById(R.id.textView);
        userViewModel = new ViewModelProvider(this).get(UserViewModel.class);
        userViewModel.getAge().observe(this, new Observer<Integer>() {
            @Override
            public void onChanged(Integer integer) {
                text.setText(String.valueOf(integer));
            }
        });
    }

    protected void initBtn() {
        btn1.setOnClickListener(view ->  text.setText("左"));
        btn2.setOnClickListener(view ->  text.setText("右"));
        btn3.setOnClickListener(view ->  userViewModel.add());
    }
}
