package com.example.login;

/**
 * Created by xzg on 2016/9/18.
 */
public interface LoginInteractor {

    interface OnLoginFinishedListener{
        void onNameError();
        void onPasError();
        void onSuccess();
    }

    void login(String name,String pas,OnLoginFinishedListener onLoginFinishedListener);
}
