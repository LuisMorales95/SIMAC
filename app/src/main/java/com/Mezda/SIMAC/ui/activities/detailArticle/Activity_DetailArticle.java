package com.Mezda.SIMAC.ui.activities.detailArticle;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.ActionBar;
import android.view.View;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.TextView;

import com.Mezda.SIMAC.ui.activities.Map.Activity_Maps;
import com.Mezda.SIMAC.ui.base.BaseActivity;
import com.Mezda.SIMAC.utils.Constants;
import com.Mezda.SIMAC.R;
import com.bumptech.glide.Glide;

import javax.inject.Inject;

import butterknife.BindView;

public class Activity_DetailArticle extends BaseActivity implements DetailArticleContract.View, View.OnClickListener {

    @BindView(R.id.articleHeadline)
	TextView articleHeadline;
	@BindView(R.id.articleUser)
	TextView articleUser;
	@BindView(R.id.articleImage)
	ImageView articleImage;
	@BindView(R.id.articleContent)
	TextView articleContent;
	@BindView(R.id.articleMap)
	ImageButton articleMap;
    private boolean Visible=true;

	@Inject
	DetailArticleContract.Presenter presenter;


	@Override
	protected int getLayout() {
		return R.layout.activity_detailarticle;
	}
	@Override
	public void onCreating(Bundle savedBundle, Intent intent) {
		ActionBar actionBar = getSupportActionBar();
		actionBar.hide();
		presenter.attach(this);
		presenter.showArticle();
		articleImage.setOnClickListener(this);
		articleMap.setOnClickListener(this);
	}

	@Override
	public void setHeadline(String headline) {
		articleHeadline.setText(headline);
	}

	@Override
	public void setUserName(String userName) {
		articleUser.setText(userName);
	}

	@Override
	public void setImage(String url) {
		Glide.with(this).load(Constants.Base+url).into(articleImage);
	}

	@Override
	public void setContent(String content) {
		articleContent.setText(content);
	}

    @Override
    public void onClick(View v) {
		switch(v.getId()){
			case R.id.articleImage:
				if (Visible){
					articleContent.setVisibility(View.INVISIBLE);
					Visible=false;
				}else{
					articleContent.setVisibility(View.VISIBLE);
					articleContent.setBackgroundColor(getResources().getColor(R.color.detailContentBack));
                    Visible=true;
				}
				break;
			case R.id.articleMap:
				presenter.createMapMarker();
				startActivity(new Intent(this,Activity_Maps.class));
				break;
		}
    }

    @Override
	protected void onResuming() {

	}

	@Override
	protected void onDestroying() {
		presenter.onDetach();
	}




	/*
	private void op1() {
		
		getSupportActionBar().setTitle("Atención Ciudadana");
		oneescudo.setImageUrl(UserData.SERVER_ADDRESS + LocalNewsFragment.mArticleList.get(LocalNewsFragment.posilista).getUserImage(), imageLoader);
		oneimgprin.setImageUrl(UserData.SERVER_ADDRESS + LocalNewsFragment.mArticleList.get(LocalNewsFragment.posilista).getImage(), imageLoader);
		noticiaone_maps.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				Activity_Maps.opcion = 1;
				startActivity(new Intent(Activity_DetailArticle.this, Activity_Maps.class));
			}
		});

//       PhotoViewAttacher pAttacher;
//       pAttacher = new PhotoViewAttacher(oneimgprin);
//       pAttacher.update();
		
		
		onedesc.setText(LocalNewsFragment.mArticleList.get(LocalNewsFragment.posilista).getContent());
		onedesc.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				if (onedesc.getAlpha() >= 0.8f) {
					onedesc.setAlpha(0.5f);
				} else {
					onedesc.setAlpha(1.0f);
				}
			}
		});
		oneperson.setText(LocalNewsFragment.mArticleList.get(LocalNewsFragment.posilista).getUserName());
		onetitle.setText(LocalNewsFragment.mArticleList.get(LocalNewsFragment.posilista).getHeadline());
//        oneaddr.setText(LocalNewsFragment.mArticleList.get(LocalNewsFragment.posilista).getPlace());
	}
  *//*  // create an action bar button
    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.googlemap, menu);
        return super.onCreateOptionsMenu(menu);
    }
    // handle button activities
    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        int id = item.getItemId();
        if (id == R.id.locate) {
            Activity_Maps.opcion=1;
            startActivity(new Intent(Activity_DetailArticle.this,Activity_Maps.class));
        }
        return super.onOptionsItemSelected(item);
    }*/
}
