package com.Mezda.SIMAC.ui.base;

import com.Mezda.SIMAC.data.dao.Article;

public interface OnItemClickListener {
    void showDetailActivity(Article article);
    void manageLike(Article article);
    void showCommentActivity(Article article);
}
