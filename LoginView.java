package com.example.login;

/**
 * UI使用
 * Created by xzg on 2016/9/18.
 */
public interface LoginView {

    void loginSucess();

    void loginFailName();

    void loginFailPas();

    void showDialog();

    void hideDialog();
}
