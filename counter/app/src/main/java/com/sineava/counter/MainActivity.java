package com.sineava.counter;

import androidx.appcompat.app.AppCompatActivity;
import androidx.databinding.DataBindingUtil;
import androidx.lifecycle.ViewModelProvider;

import android.os.Bundle;
import android.util.Log;
import android.widget.Button;
import android.widget.TextView;

import com.sineava.counter.databinding.ActivityMainBinding;

public class MainActivity extends AppCompatActivity {

    Button btn1,btn2,btn3,btn4,btn5,btn6,btnBack,btnReset;
    TextView view1, view2;

    CounterViewModel viewModel;
    ActivityMainBinding binding;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        init();
    }

    protected void init() {
        binding = DataBindingUtil.setContentView(this, R.layout.activity_main);
        btn1 = findViewById(R.id.button1);
        btn2 = findViewById(R.id.button2);
        btn3 = findViewById(R.id.button3);
        btn4 = findViewById(R.id.button4);
        btn5 = findViewById(R.id.button5);
        btn6 = findViewById(R.id.button6);
        btnBack = findViewById(R.id.button7);
        btnReset = findViewById(R.id.button8);
        view1 = findViewById(R.id.view1);
        view2 = findViewById(R.id.view2);
        viewModel = new ViewModelProvider(this).get(CounterViewModel.class);
        viewModel.getCount1().observe(this, integer -> view1.setText(String.valueOf(integer)));
        viewModel.getCount2().observe(this, integer -> view2.setText(String.valueOf(integer)));
        btn1.setOnClickListener(view -> viewModel.add(1, 0));
        btn2.setOnClickListener(view -> viewModel.add(1, 1));
        btn3.setOnClickListener(view -> viewModel.add(2, 0));
        btn4.setOnClickListener(view -> viewModel.add(2, 1));
        btn5.setOnClickListener(view -> viewModel.add(3, 0));
        btn6.setOnClickListener(view -> viewModel.add(3, 1));
        btnBack.setOnClickListener(view -> {
            int[] num = viewModel.remove();
            Log.d("DDD", String.valueOf(num[0]));
            Log.d("DDD", String.valueOf(num[1]));
            if (num.length > 0) {
                if (num[0] == 0) {
                    viewModel.setCount1(num[1]);
                } else {
                    viewModel.setCount2(num[1]);
                }
            }
        });
        btnReset.setOnClickListener(view -> viewModel.reset());
    }
}