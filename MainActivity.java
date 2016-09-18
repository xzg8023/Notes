package com.example.login;

import android.content.Context;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.ProgressBar;
import android.widget.Toast;

public class MainActivity extends AppCompatActivity implements LoginView {

    private EditText name;
    private EditText pas;
    private ProgressBar progress;
    private LoginPresenter loginPresenter;
    private Context mContext;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        mContext = this;
        name = (EditText) findViewById(R.id.name);
        pas = (EditText) findViewById(R.id.pas);
        progress = (ProgressBar) findViewById(R.id.progress);

        loginPresenter = new LoginPresenterImpl(this);
    }

    public void  login(View view){
        loginPresenter.verifyInfo(name.getText().toString(),pas.getText().toString());
    }

    @Override
    protected void onDestroy() {
        loginPresenter.onDestroy();
        super.onDestroy();
    }

    @Override
    public void loginSucess() {
        showToast("loginSucess");
    }

    @Override
    public void loginFailName() {
        showToast("loginFailName");
    }

    @Override
    public void loginFailPas() {
        showToast("loginFailPas");
    }

    @Override
    public void showDialog() {
        progress.setVisibility(View.VISIBLE);
    }

    @Override
    public void hideDialog() {
        
        progress.setVisibility(View.GONE);
    }

    private void showToast(String msg){
        Toast.makeText(mContext,msg,Toast.LENGTH_SHORT).show();
    }
}
