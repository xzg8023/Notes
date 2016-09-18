package com.example.login;

/**
 * Created by xzg on 2016/9/18.
 */
public class LoginPresenterImpl implements LoginPresenter, LoginInteractor.OnLoginFinishedListener {

    private LoginView mLoginView;
    private LoginInteractor mLoginInteractor;

    public LoginPresenterImpl(LoginView loginView) {
        mLoginView = loginView;
        mLoginInteractor = new LoginInteractorImpl();
    }


    @Override
    public void onNameError() {
        if (mLoginView != null){
            mLoginView.hideDialog();
            mLoginView.loginFailName();
        }
    }

    @Override
    public void onPasError() {
        if (mLoginView != null) {
            mLoginView.hideDialog();
            mLoginView.loginFailPas();
        }
    }

    @Override
    public void onSuccess() {
        if (mLoginView != null) {
            mLoginView.hideDialog();
            mLoginView.loginSucess();
        }
    }

    @Override
    public void onDestroy() {
        mLoginView = null;
    }

    @Override
    public void verifyInfo(String name, String pas) {

        if (mLoginView != null) {
            mLoginView.showDialog();
        }
        mLoginInteractor.login(name, pas, this);
    }
}
