package com.Mezda.SIMAC.utils.adapters;

import android.content.Context;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.Mezda.SIMAC.R;
import com.Mezda.SIMAC.UserData;
import com.Mezda.SIMAC.data.dao.Article;
import com.Mezda.SIMAC.ui.base.OnItemClickListener;
import com.bumptech.glide.Glide;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

public class ArticleAdapter extends RecyclerView.Adapter<ArticleAdapter.ViewHolder>{

    Context context;
    List<Article> articleList;
    OnItemClickListener onItemClickListener;

    public ArticleAdapter(Context context, List<Article> articleList, OnItemClickListener onItemClickListener) {
        this.context = context;
        this.articleList = articleList;
        this.onItemClickListener = onItemClickListener;
    }

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext())
                .inflate(R.layout.item_article, parent,false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(ViewHolder holder, int position) {
        Article currentArticle = articleList.get(position);

        Glide.with(context).load(UserData.SERVER_ADDRESS+currentArticle.getImage()).into(holder.article_Image);
        holder.article_headline.setText(currentArticle.getHeadline());
        holder.article_userName.setText(currentArticle.getUserName());
//        todo: owner logic
        holder.article_ownedIdentifier.setImageResource(R.drawable.ic_menu_empty);
        holder.article_date.setText(currentArticle.getDate());
        holder.article_selecter.setOnClickListener(v->
                onItemClickListener.showDetailActivity(currentArticle));
        if (currentArticle.getLike().equals("1")){
            Glide.with(context).load(R.drawable.ic_menu_like_blue).into(holder.article_likeImage);
            holder.article_likeText.setTextColor(context.getResources().getColor(R.color.colorAccent));
        }else{
            Glide.with(context).load(R.drawable.ic_menu_like_gray).into(holder.article_likeImage);
            holder.article_likeText.setTextColor(context.getResources().getColor(R.color.grey));
        }
        holder.article_likeImage.setOnClickListener(v -> onItemClickListener.manageLike(currentArticle));
        holder.article_commentImage.setOnClickListener(v -> onItemClickListener.showCommentActivity(currentArticle));

    }

    @Override
    public int getItemCount() {
        return articleList.size();
    }


    public class ViewHolder extends RecyclerView.ViewHolder{
        @BindView(R.id.article_Image) ImageView article_Image;
        @BindView(R.id.article_headline) TextView article_headline;
        @BindView(R.id.article_userName) TextView article_userName;
        @BindView(R.id.article_ownedIdentifier) ImageView article_ownedIdentifier;
        @BindView(R.id.article_date) TextView article_date;
        @BindView(R.id.article_selecter) View article_selecter;
        @BindView(R.id.article_likeText) TextView article_likeText;
        @BindView(R.id.article_likeImage) ImageView article_likeImage;
        @BindView(R.id.article_commentImage) ImageView article_commentImage;

        public ViewHolder(View itemView) {
            super(itemView);
            ButterKnife.bind(this,itemView);
        }
    }
}
