package com.Mezda.SIMAC.ui.main;

import android.content.SharedPreferences;
import android.util.Log;

import com.Mezda.SIMAC.data.dao.Credentials;
import javax.inject.Inject;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.disposables.CompositeDisposable;
import io.reactivex.schedulers.Schedulers;

import static com.Mezda.SIMAC.utils.SharedPreference.GETSharedPreferences;

public class MainPresenter implements Activity_MainContract.Presenter{

    private SharedPreferences preferences;
    private Activity_MainContract.Model model;
    private Activity_MainContract.View view;
    private CompositeDisposable disposable  = new CompositeDisposable();
    private final String TAG = "MainPresenter";

    @Inject
    public MainPresenter(Activity_MainContract.Model model, SharedPreferences preference) {
        this.model = model;
        this.preferences = preference;
    }

    @Override
    public void attach(Activity_MainContract.View view) {
        this.view = view;
    }

    @Override
    public void onDetach() {
        disposable.clear();
    }

    @Override
    public void startup() {
        if (view!=null){
            Credentials credentials = new Credentials(GETSharedPreferences("ID", "0"),
                    GETSharedPreferences("TOKEN", "asdasd"));

            disposable.add(model.getUserValidation(credentials).subscribeOn(Schedulers.io())
                    .observeOn(AndroidSchedulers.mainThread())
                    .subscribe(obj->{
                        if (obj.getMessage().isEmpty()){
                            view.showMessage(obj.getCorreoE());
                        } else{
                            view.showMessage(obj.getMessage());
                        }
                    },throwable -> Log.i(TAG,"something was wrong: "+throwable.getMessage())));
        }
    }

}
