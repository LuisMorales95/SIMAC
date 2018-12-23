package com.Mezda.SIMAC.ui.base;

import android.net.Uri;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;


import com.Mezda.SIMAC.ui.fragments.localNewsFeed.LocalNewsFragment;

import butterknife.ButterKnife;
import dagger.android.support.AndroidSupportInjection;

public abstract class BaseFragment extends Fragment {


    protected static final String ARG_PARAM1 = "param1";
    protected static final String ARG_PARAM2 = "param2";

    protected OnFragmentInteractionListener mListener;
    // TODO: Rename and change types of parameters
    protected String mParam1;
    protected String mParam2;

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        AndroidSupportInjection.inject(this);
        super.onCreate(savedInstanceState);
        onCreation(savedInstanceState);

    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View view = provideView(inflater,container,savedInstanceState);
        return view;
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        ButterKnife.bind(this,view);
        onCreated(view,savedInstanceState);
    }
    protected abstract void onCreation(Bundle savedBundle);
    protected abstract View provideView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState);
    protected abstract void onCreated(View view, Bundle savedInstanceState);

    public interface OnFragmentInteractionListener {
        // TODO: Update argument type and name
        void onFragmentInteraction(Uri uri);
    }

}