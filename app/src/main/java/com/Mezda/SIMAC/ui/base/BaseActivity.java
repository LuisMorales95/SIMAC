package com.Mezda.SIMAC.ui.base;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;

import butterknife.ButterKnife;
import dagger.android.AndroidInjection;

public abstract class BaseActivity extends AppCompatActivity {

    private AlertDialog alertDialog;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        AndroidInjection.inject(this);
        super.onCreate(savedInstanceState);
        setContentView(getLayout());
        ButterKnife.bind(this);
        onCreating(savedInstanceState,getIntent());
    }

    @Override
    protected void onResume() {
        super.onResume();
        onResuming();
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        onDestroying();
    }


    public abstract void onCreating(Bundle savedBundle, Intent intent);
    protected abstract int getLayout();
    protected abstract void onResuming();
    protected abstract void onDestroying();

}
