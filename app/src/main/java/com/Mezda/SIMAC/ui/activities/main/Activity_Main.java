package com.Mezda.SIMAC.ui.activities.main;

import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.os.Handler;
import android.support.annotation.NonNull;
import android.support.design.widget.NavigationView;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.view.GravityCompat;
import android.support.v4.widget.DrawerLayout;
import android.support.v7.app.ActionBarDrawerToggle;
import android.support.v7.app.AlertDialog;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import com.Mezda.SIMAC.ui.base.BaseActivity;
import com.Mezda.SIMAC.pending.Fragments.Fragment_Facturar_Busqueda;
import com.Mezda.SIMAC.pending.Fragments.Fragment_Facturar_Datos;
import com.Mezda.SIMAC.ui.fragments.localNewsFeed.LocalNewsFragment;
import com.bumptech.glide.Glide;
import com.Mezda.SIMAC.pending.Fragments.Fragment_AdministrarUsuarios;
import com.Mezda.SIMAC.pending.Fragments.Fragment_Alcalde;
import com.Mezda.SIMAC.ui.fragments.GenerateAlert.Fragment_GenerateAlert;
import com.Mezda.SIMAC.pending.Fragments.Fragment_Emergencia;
import com.Mezda.SIMAC.pending.Fragments.Fragment_Empty;
import com.Mezda.SIMAC.pending.Fragments.Fragment_FacturaE;
import com.Mezda.SIMAC.pending.Fragments.Fragment_Login;
import com.Mezda.SIMAC.pending.Fragments.Fragment_MisReporte;
import com.Mezda.SIMAC.pending.Fragments.Fragment_Noticias;
import com.Mezda.SIMAC.pending.Fragments.Fragment_Predial;
import com.Mezda.SIMAC.pending.Fragments.Fragment_Reportar;
import com.Mezda.SIMAC.pending.Fragments.Fragment_Reporte;
import com.Mezda.SIMAC.pending.Fragments.Fragment_Turista;

import com.Mezda.SIMAC.R;

import java.util.Objects;

import javax.inject.Inject;

import butterknife.BindView;
import butterknife.ButterKnife;


public class Activity_Main extends BaseActivity implements NavigationView.OnNavigationItemSelectedListener, Fragment_FacturaE.OnFragmentInteractionListener, Fragment_GenerateAlert.OnFragmentInteractionListener,
		LocalNewsFragment.OnFragmentInteractionListener, Fragment_Alcalde.OnFragmentInteractionListener, Fragment_Noticias.OnFragmentInteractionListener, Fragment_Predial.OnFragmentInteractionListener,
		Fragment_Turista.OnFragmentInteractionListener, Fragment_Emergencia.OnFragmentInteractionListener, Fragment_Login.OnFragmentInteractionListener, Fragment_AdministrarUsuarios.OnFragmentInteractionListener,
		Fragment_Reporte.OnFragmentInteractionListener, Fragment_Reportar.OnFragmentInteractionListener, Fragment_MisReporte.OnFragmentInteractionListener,
		Fragment_Empty.OnFragmentInteractionListener, Fragment_Facturar_Busqueda.OnFragmentInteractionListener, Fragment_Facturar_Datos.OnFragmentInteractionListener,MainContract.View{

    @BindView(R.id.toolbar) Toolbar toolbar;
    @BindView(R.id.drawerLayout) DrawerLayout drawerLayout;
    @BindView(R.id.navigationView) NavigationView navigationView;
	private HeaderHolder headerHolder;
	@Inject
    public MainContract.Presenter presenter;

	private static final String TAG = "Activity_Main";

	private FragmentManager fragmentManager = getSupportFragmentManager();
	private Bundle bundle;



	@Override
	public int getLayout() {
		return R.layout.activity_main;
	}

	@Override
	public void onCreating(Bundle savedBundle, Intent intent) {
		presenter.attach(this);
		bundle=savedBundle;
		presenter.startup();
	}

	@Override
	protected void onResuming() {
	}

	@Override
	protected void onDestroying() {
		presenter.onDetach();
	}

	@Override
	public void showToast(String msg) {
		Toast.makeText(this, msg , Toast.LENGTH_SHORT).show();
	}


	@Override
    public void defaultSetup() {
        setSupportActionBar(toolbar);
        toolbar.setBackgroundResource(R.drawable.gradient);
        if (bundle == null) {
            Fragment fragment = null;
            Class fragmentClass = LocalNewsFragment.class;
            try {
                fragment = (Fragment) fragmentClass.newInstance();
            } catch (Exception e) {
                e.printStackTrace();
            }
            fragmentManager.beginTransaction().replace(R.id.flContent, fragment).commit();
            setActionBarTitle("News Feed");
        }
        ActionBarDrawerToggle toggle = new ActionBarDrawerToggle(Activity_Main.this, drawerLayout, toolbar,
                R.string.navigation_drawer_open, R.string.navigation_drawer_close);
        drawerLayout.addDrawerListener(toggle);
        toggle.syncState();

        View headerView = navigationView.getHeaderView(0);
		headerHolder = new HeaderHolder(headerView);

		presenter.menuitems();

		navigationView.getMenu().getItem(0).setChecked(true);
        navigationView.setNavigationItemSelectedListener(this);

	}

	class HeaderHolder{
		@BindView(R.id.headerBackground) ImageView headerBackground;
		@BindView(R.id.headerProfilePic) ImageView mHeaderProfilePic;
		@BindView(R.id.headerName) TextView mHeaderName;
		@BindView(R.id.headerEmail) TextView mHeaderEmail;
		HeaderHolder(View view) {
			ButterKnife.bind(this,view);
		}
	}

	@Override
	public void setProfilPic(String url) {
		Glide.with(this).load(R.drawable.profile_background).into(headerHolder.headerBackground);
		Glide.with(this).load(url).into(headerHolder.mHeaderProfilePic);
	}

	@Override
	public void setUserName(String userName) {
		headerHolder.mHeaderName.setText(userName);
	}

	@Override
	public void setUserEmail(String userEmail) {
		headerHolder.mHeaderEmail.setText(userEmail);
	}

	@Override
	public void itemAuthorization(int authorization) {
		navigationView.getMenu().getItem(4).setVisible(false);
		navigationView.getMenu().getItem(6).setVisible(false);
		switch (authorization) {
			case 0:
				navigationView.getMenu().getItem(1).setVisible(false);
				navigationView.getMenu().getItem(3).setVisible(false);
				break;
			case 1:
				navigationView.getMenu().getItem(1).setVisible(true);
				navigationView.getMenu().getItem(3).setVisible(true);
				break;
		}
	}

	@Override
	public Context getContext() {
		return this;
	}

	@Override
	public void sessionStatusItem(boolean status) {
		if (status) {
			navigationView.getMenu().getItem(9).setVisible(true);
		}else {
			navigationView.getMenu().getItem(9).setVisible(false);
		}
	}

	@Override
	public void onBackPressed() {
		FragmentManager fm = getSupportFragmentManager();
		if (drawerLayout.isDrawerOpen(GravityCompat.START)) {
			drawerLayout.closeDrawer(GravityCompat.START);
		}else
		if (fm.getBackStackEntryCount() > 0) {
			Log.i(TAG, "popping backstack"+ String.valueOf(fm.getBackStackEntryCount()));
			fm.popBackStack();
		}else if(!(this.getSupportFragmentManager().findFragmentById(R.id.flContent) instanceof LocalNewsFragment)) {
			fm.beginTransaction().replace(R.id.flContent,new LocalNewsFragment()).commit();
			Log.i(TAG, "Not in the main");
		}else {
			new AlertDialog.Builder(this).setMessage("Desea cerrar la aplicación?")
					.setPositiveButton("Si", (dialog, which) -> finish())
					.setNegativeButton("No", null)
					.show();
		}
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		if (presenter.getToken().equals("")){
			getMenuInflater().inflate(R.menu.iniciasesion, menu);
		}else if (presenter.getAutorization().equals("3")){
			getMenuInflater().inflate(R.menu.main, menu);
		}
		return true;
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		int id = item.getItemId();
		if (id == R.id.Administar_Usuarios) {
			Fragment_AdministrarUsuarios fragmentAdministrarUsuarios = new Fragment_AdministrarUsuarios();
			this.getSupportFragmentManager().beginTransaction().replace(R.id.flContent, fragmentAdministrarUsuarios).addToBackStack(null).commit();
		} else if (id == R.id.Inicia_Sesión) {
			Fragment_Login fragmentLogin = new Fragment_Login();
			this.getSupportFragmentManager().beginTransaction().replace(R.id.flContent, fragmentLogin).addToBackStack(null).commit();
		}
		return super.onOptionsItemSelected(item);
	}

	@SuppressWarnings("StatementWithEmptyBody")
	@Override
	public boolean onNavigationItemSelected(@NonNull final MenuItem item) {
		final int id = item.getItemId();
		new Handler().postDelayed(() -> {
			Fragment fragment = null;
			Class fragmenteclass = null;
			if (id == R.id.LocalFeed) {
				fragmenteclass = LocalNewsFragment.class;
			} else if (id == R.id.Alerts) {
				if (!presenter.getToken().isEmpty()){
					fragmenteclass = Fragment_GenerateAlert.class;
				}else{ showToast("Account must be created"); }
			} else if (id == R.id.Danos_tu_reporte) {
				if (!presenter.getToken().isEmpty()) {
//					fragmenteclass = Fragment_Reporte.class;
				} else { showToast("Account must be created"); }
			} else if (id == R.id.FacturaElectronica) {
//				fragmenteclass = Fragment_FacturaE.class;
			} else if (id == R.id.consulta_predial) {
//				fragmenteclass = Fragment_Empty.class;
			} else if (id == R.id.noticias) {
//				fragmenteclass = Fragment_Noticias.class;
			} else if (id == R.id.Turismo) {
//				fragmenteclass = Fragment_Empty.class;
			} else if (id == R.id.CoAlcalde) {
//				fragmenteclass = Fragment_Alcalde.class;
			} else if (id == R.id.NumEmergencia) {
//				fragmenteclass = Fragment_Emergencia.class;
			} else if (id == R.id.cerrar_Sesion) {
				showToast("LoggedOut");
				presenter.logOut();
			}
			if (fragmenteclass != null) {
				try {
					fragment = (Fragment) fragmenteclass.newInstance();

				} catch (Exception e) {
					e.printStackTrace();
				}
				Fragment frag = getSupportFragmentManager().findFragmentById(R.id.flContent);
				fragmentManager.beginTransaction().remove(frag).replace(R.id.flContent, fragment).commit();
			}
			if (item.getItemId() != R.id.cerrar_Sesion) {
				item.setChecked(true);
			}


		}, 450);
		drawerLayout.closeDrawer(GravityCompat.START);
		return true;
	}

	@Override
	public void onFragmentInteraction(Uri uri) {
	}

	@Override
	public void setActionBarTitle(String title){
		Objects.requireNonNull(getSupportActionBar()).setTitle(title);
	}

	@Override
	public void selectItem(int id){
		navigationView.setCheckedItem(id);
	}

}