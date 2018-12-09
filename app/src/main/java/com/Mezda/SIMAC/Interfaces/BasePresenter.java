package com.Mezda.SIMAC.Interfaces;

public interface BasePresenter<T> {

    public void attach(T view);

    public void onDetach();

}
