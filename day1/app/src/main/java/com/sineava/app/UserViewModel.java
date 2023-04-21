package com.sineava.app;

import androidx.lifecycle.MutableLiveData;
import androidx.lifecycle.ViewModel;

public class UserViewModel extends ViewModel {
    private MutableLiveData<Integer> age;

    public MutableLiveData<Integer> getAge() {
        if (age == null) {
            age = new MutableLiveData<>();
            age.setValue(0);
        }
        return age;
    };

    public void add() {
        age.setValue(age.getValue() + 1);
    }


}
