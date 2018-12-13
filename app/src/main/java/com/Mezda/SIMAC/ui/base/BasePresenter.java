package com.Mezda.SIMAC.ui.base;

public interface BasePresenter<T> {

    public void attach(T view);

    public void onDetach();

}
