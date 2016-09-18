package com.example.login;

import android.text.TextUtils;

/**
 * Created by xzg on 2016/9/18.
 */
public class LoginInteractorImpl implements LoginInteractor {
    @Override
    public void login(String name, String pas, OnLoginFinishedListener onLoginFinishedListener) {
        boolean infoIsError = false;

        if (TextUtils.isEmpty(name)){
            onLoginFinishedListener.onNameError();
            infoIsError = true;
        }
        if (TextUtils.isEmpty(pas)){
            onLoginFinishedListener.onPasError();
            infoIsError = true ;
        }
        if (!infoIsError){
            onLoginFinishedListener.onSuccess();
        }

    }
}
