package com.example.login;

/**
 * Created by xzg on 2016/9/18.
 */
public interface LoginPresenter {

    void onDestroy();

    void verifyInfo(String name,String pas);
}
