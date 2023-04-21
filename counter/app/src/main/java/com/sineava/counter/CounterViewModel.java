package com.sineava.counter;

import androidx.lifecycle.MutableLiveData;
import androidx.lifecycle.ViewModel;
import java.util.LinkedList;

public class CounterViewModel extends ViewModel {
    private MutableLiveData<Integer> total1;
    private MutableLiveData<Integer> total2;
    private LinkedList<int[]> origin = new LinkedList<>();

    public MutableLiveData<Integer> getCount1() {
        if (total1 == null) {
            total1 = new MutableLiveData<>();
            total1.setValue(0);
        }
        return total1;
    }

    public void setCount1(Integer num) {
        total1.setValue(num);
    }
    public void setCount2(Integer num) {
        total2.setValue(num);
    }

    public MutableLiveData<Integer> getCount2() {
        if (total2 == null) {
            total2 = new MutableLiveData<>();
            total2.setValue(0);
        }
        return total2;
    }

    public int[] remove() {
        Integer size = origin.size();
        if (size > 0) return origin.remove(size - 1);
        return new int[]{0, 0};
    }

    public void reset() {
        total1.setValue(0);
        total2.setValue(0);
        origin = new LinkedList<>();
    }

    public void add(Integer step, Integer group) {
        Integer val;
        if (group == 0) {
            val = total1.getValue();
            total1.setValue(val + step);
        } else {
            val = total2.getValue();
            total2.setValue(val + step);
        }
        origin.add(new int[]{group, val});
    }
}
