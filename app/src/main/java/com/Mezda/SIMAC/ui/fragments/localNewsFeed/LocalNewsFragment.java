package com.Mezda.SIMAC.ui.fragments.localNewsFeed;

import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AbsListView;

import com.Mezda.SIMAC.data.dao.Article;
import com.Mezda.SIMAC.ui.activities.detailArticle.Activity_DetailArticle;
import com.Mezda.SIMAC.ui.base.BaseFragment;
import com.Mezda.SIMAC.ui.base.OnItemClickListener;
import com.Mezda.SIMAC.utils.adapters.ArticleAdapter;
import com.Mezda.SIMAC.ui.activities.main.Activity_Main;

import com.Mezda.SIMAC.R;
import java.util.ArrayList;
import java.util.List;
import javax.inject.Inject;
import butterknife.BindView;

public class LocalNewsFragment extends BaseFragment implements OnItemClickListener, LocalNewsContract.View {

    public static final String TAG = "LocalNewsFragment";
    @Inject
    LocalNewsContract.Presenter presenter;
    @BindView(R.id.articleRecycler)
    RecyclerView mArticleRecycler;
    private LinearLayoutManager layoutManager;
    private ArticleAdapter articleAdapter;
    private List<Article> articles = new ArrayList<>();
    private Boolean isScrolling = false;
    private int currentItem=0;
    private int totalitems=0;
    private int outOfViewItem=0;

    static public List<Article> mArticleList;
    public static int posilista;

    
    public LocalNewsFragment() {
    }
    
    // TODO: Rename and change types and number of parameters
    public static LocalNewsFragment newInstance(String param1, String param2) {
        LocalNewsFragment fragment = new LocalNewsFragment();
        Bundle args = new Bundle();
        args.putString(ARG_PARAM1, param1);
        args.putString(ARG_PARAM2, param2);
        fragment.setArguments(args);
        return fragment;
    }


    @Override
    protected void onCreation(Bundle savedBundle) {
        if (getArguments() != null) {
            mParam1 = getArguments().getString(ARG_PARAM1);
            mParam2 = getArguments().getString(ARG_PARAM2);
        }
    }
    @Override
    protected View provideView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        return inflater.inflate(R.layout.fragment_localnewsfeed, container, false);
    }
    @Override
    protected void onCreated(View view, Bundle savedInstanceState) {
        ((Activity_Main) getActivity()).setActionBarTitle("Local Feed");
        ((Activity_Main) getActivity()).selectItem(R.id.LocalFeed);
        articleAdapter = new ArticleAdapter(view.getContext(),articles,this);
        mArticleRecycler.setHasFixedSize(true);
        layoutManager = new LinearLayoutManager(view.getContext());
        mArticleRecycler.setLayoutManager(layoutManager);
        mArticleRecycler.setAdapter(articleAdapter);
        presenter.attach(this);
        presenter.fetchData();
        mArticleRecycler.setOnScrollListener(new RecyclerView.OnScrollListener() {
            @Override
            public void onScrollStateChanged(RecyclerView recyclerView, int newState) {
                super.onScrollStateChanged(recyclerView, newState);
                if (newState == AbsListView.OnScrollListener.SCROLL_STATE_TOUCH_SCROLL){
                     isScrolling = true;
                }
            }

            @Override
            public void onScrolled(RecyclerView recyclerView, int dx, int dy) {
                super.onScrolled(recyclerView, dx, dy);
                currentItem = layoutManager.getChildCount();
                totalitems = layoutManager.getItemCount();
                outOfViewItem = layoutManager.findFirstVisibleItemPosition();

                if (isScrolling && (currentItem + outOfViewItem == totalitems)){
                    isScrolling=false;
                    showToast("Geting more data");
                    presenter.fetchData();
                }
            }
        });
    }

    @Override
    public void addItem(Article article) {
        articles.add(article);
        articleAdapter.notifyDataSetChanged();
    }

    @Override
    public void clearAdapter() {
        articles.clear();
        articleAdapter.notifyDataSetChanged();
    }

    public void onButtonPressed(Uri uri) {
        if (mListener != null) {
            mListener.onFragmentInteraction(uri);
        }
    }
    
    @Override
    public void onAttach(Context context) {
        super.onAttach(context);
        if (context instanceof OnFragmentInteractionListener) {
            mListener = (OnFragmentInteractionListener) context;
        } else {
            throw new RuntimeException(context.toString() + " must implement " +
                    "OnFragmentInteractionListener");
        }
    }
    
    @Override
    public void onDetach() {
        super.onDetach();
        mListener = null;
        presenter.onDetach();
    }

    @Override
    public void showDetailActivity(Article article) {
        presenter.setItemClicked(article);
        startActivity(new Intent(getActivity(),Activity_DetailArticle.class));
    }

    @Override
    public void manageLike(Article article) {
        ((Activity_Main)getActivity()).showToast("clicked on a article like");
    }

    @Override
    public void showCommentActivity(Article article) {
        ((Activity_Main)getActivity()).showToast("display comment section");
    }

    @Override
    public void showToast(String message) {
        ((Activity_Main)getActivity()).showToast(message);
    }

    @Override
    public Context getContexts() {
        return getActivity();
    }








    /*
    
    public static class Like_Management extends AsyncTask<Void, Integer, Integer> {
        View v;
        int iduser, idnews, opcion;
        int reaccion = 1;
        Article noticia;
        CustomListAdapter adapter;
        
        public Like_Management(View v, int iduser, int idnews, int opcion, Article
                noticia, CustomListAdapter adapter) {
            this.v = v;
            this.iduser = iduser;
            this.idnews = idnews;
            this.opcion = opcion;
            this.noticia = noticia;
            this.adapter = adapter;
        }
        
        @Override
        protected void onPreExecute() {
            super.onPreExecute();
        }
        
        @Override
        protected Integer doInBackground(Void... voids) {
            ArrayList<NameValuePair> datatosend = new ArrayList<>();
            datatosend.add(new BasicNameValuePair("id_usuario", String.valueOf(iduser)));
            datatosend.add(new BasicNameValuePair("id_noticia", String.valueOf(idnews)));
            datatosend.add(new BasicNameValuePair("id_reaccion", String.valueOf(reaccion)));
            datatosend.add(new BasicNameValuePair("opcion", String.valueOf(opcion))); //TODO: "0"
            // es para crear "1" borrar
            HttpParams httpRequestParams = HTTPPARAMS.GETHTTPREQUESTPARAMS();
            HttpClient client = new DefaultHttpClient(httpRequestParams);
            HttpPost post = new HttpPost(UserData.SERVER_ADDRESS + "likemanage.php");
            HttpResponse httpResponse = null;
            String responsedecoded = "";
            try {
                post.setEntity(new UrlEncodedFormEntity(datatosend));
                httpResponse = client.execute(post);
                HttpEntity httpEntity = httpResponse.getEntity();
                responsedecoded = EntityUtils.toString(httpEntity, "UTF-8");
                JSONArray jsonArray = new JSONArray(responsedecoded);
                String respuesta = jsonArray.getJSONObject(0).getString("EXITO");
                httpEntity.consumeContent();
                if (respuesta.equals("SI CREEO")) {
                    return 2;
                } else if (respuesta.equals("NO CREEO")) {
                    return 3;
                } else if (respuesta.equals("SI BORRO")) {
                    return 4;
                } else if (respuesta.equals("NO BORRO")) {
                    return 5;
                }
            } catch (Exception e) {
                e.printStackTrace();
                return 0;
            }
            return 1;
        }
        
        @Override
        protected void onPostExecute(Integer aInteger) {
            switch (aInteger) {
                case 0:
                    Toast.makeText(v.getContext(), "ERROR: 101 Actualize la ventana", Toast
                            .LENGTH_SHORT).show();
                    break;
                case 1:
                    Toast.makeText(v.getContext(), "Operación Fallida OF001", Toast.LENGTH_SHORT)
                            .show();
                    break;
                case 2:
                    noticia.setLike("1");
                    adapter.notifyDataSetChanged();
                    break;
                case 3:
                    Toast.makeText(v.getContext(), "Operación Fallida OF002", Toast.LENGTH_SHORT)
                            .show();
                    break;
                case 4:
                    noticia.setLike("0");
                    adapter.notifyDataSetChanged();
                    break;
                case 5:
                    Toast.makeText(v.getContext(), "Operación Fallida OF003", Toast.LENGTH_SHORT)
                            .show();
                    break;
            }
        }
    }
    
    public class borrarNoticia extends AsyncTask<Void, Boolean, Boolean> {
        int id;
        int position;
        
        public borrarNoticia(int id, int position) {
            this.id = id;
            this.position = position;
        }
        
        @Override
        protected Boolean doInBackground(Void... voids) {
            // ++ ARRAY DE PARAMETROS QUE VAS A MANDAR AL WEB SERVICE ++
            ArrayList<NameValuePair> datatosend = new ArrayList<>();
            datatosend.add(new BasicNameValuePair("id", String.valueOf(id)));
            
            // ++ CONECCION PARA MANDAR LOS PARAMETROS ++
            HttpParams httpRequestParams = HTTPPARAMS.GETHTTPREQUESTPARAMS();
            HttpClient client = new DefaultHttpClient(httpRequestParams);
            HttpPost post = new HttpPost(UserData.SERVER_ADDRESS + "JSONBorrarPublicacion.php");
            
            // ++ RESPONSE FROM SERVER ++
            HttpResponse httpResponse = null;
            String responsedecoded = "";
            
            try {
                post.setEntity(new UrlEncodedFormEntity(datatosend));
                httpResponse = client.execute(post);
                HttpEntity httpEntity = httpResponse.getEntity();
                responsedecoded = EntityUtils.toString(httpEntity, "UTF-8");
                JSONArray jsonArray = new JSONArray(responsedecoded);
                String answer = jsonArray.getJSONObject(0).getString("EXITO");
                httpEntity.consumeContent();
                if (answer.equals("SI")) {
                    return true;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            return false;
        }
        
        @Override
        protected void onPostExecute(Boolean aBoolean) {
            if (aBoolean) {
                successDialog.setContentText("¡Se ha borrado la Noticia!");
                successDialog.setCancelable(false);
                successDialog.show();
                
                Button cerrar = (Button) successDialog.findViewById(cn.pedant.SweetAlert.R.id
                        .confirm_button);
                if (cerrar != null) {
                    Log.e("Messeage from pdialog", "showErrorMsg: Button view Found yep");
                    cerrar.setBackgroundColor(getResources().getColor(R.color.colorPrimaryDark));
                    cerrar.setTextColor(getResources().getColor(R.color.TextInPrimary));
                    cerrar.setText(" Esta Bien ");
                }
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
                    Objects.requireNonNull(cerrar).setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View view) {
                            successDialog.dismiss();
                            mArticleList.remove(position);
                            adapter.notifyDataSetChanged();
                        }
                    });
                }
            } else {
            
            }
        }
    }
    
    public class MyHandler extends Handler {
        @Override
        public void handleMessage(Message msg) {
            switch (msg.what) {
                case 0:
                    //Add loading view during search processing
                    listView.addFooterView(ftView);
                    break;
                case 1:
                    //Update data adapter and UI
                    adapter.addListItemToAdapter((ArrayList<Article>) msg.obj);
                    //Remove loading view after update listview
                    listView.removeFooterView(ftView);
                    isLoading = false;
                    break;
                default:
                    break;
            }
        }
    }
    
    public class ThreadGetMoreData extends Thread {
        @Override
        public void run() {
            //Add footer view after get data
            mHandler.sendEmptyMessage(0);
            //Search more data
            ArrayList<Article> lstResult = getMoreData();
            //Delay time to show loading footer when debug, remove it when release
            try {
                Thread.sleep(5000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            //Send the result to Handle
            Message msg = mHandler.obtainMessage(1, lstResult);
            mHandler.sendMessage(msg);
    
        }
    }*/

   /* public class CustomListAdapter extends BaseAdapter {
        ImageLoader imageLoader = VolleySingleton.getInstance().getImageLoader();
        private Activity activity;
        private List<Article> Article;
        private LayoutInflater inflater;
        
        public CustomListAdapter(Activity activity, List<Article> Article) {
            this.activity = activity;
            this.Article = Article;
        }
        
        public void addListItemToAdapter(List<Article> list) {
            //Add list to current array list of data
            Article.addAll(list);
            //Notify UI
            this.notifyDataSetChanged();
        }
        
        @Override
        public int getCount() {
            return Article.size();
        }
        
        @Override
        public Object getItem(int location) {
            return Article.get(location);
        }
        
        @Override
        public long getItemId(int position) {
            return position;
        }
        
        @Override
        public View getView(final int position, View convertView, final ViewGroup parent) {
            
            if (inflater == null)
                inflater = (LayoutInflater) activity.getSystemService(Context
                        .LAYOUT_INFLATER_SERVICE);
            
            if (convertView == null)
                convertView = inflater.inflate(R.layout.item_article, null);
            
            if (imageLoader == null)
                imageLoader = VolleySingleton.getInstance().getImageLoader();
            
            
            ImageView Imageuser = (ImageView) convertView.findViewById(R.id
                    .article_userImage);
            ImageView noticiaimg = (ImageView) convertView.findViewById(R.id
                    .article_Image);
            TextView noticiatit = (TextView) convertView.findViewById(R.id.article_headline);
            TextView noticiaubica = (TextView) convertView.findViewById(R.id.noticiaubicacion);
            TextView noticiades = (TextView) convertView.findViewById(R.id.noticiades);
            TextView noticiafecha = (TextView) convertView.findViewById(R.id.article_date);
            TextView noticiausu = (TextView) convertView.findViewById(R.id.article_userName);
            ImageView image_user = convertView.findViewById(R.id.article_ownedIdentifier);
            View clickAlert = (View) convertView.findViewById(R.id.article_selecter);
            final ImageView MeGusta = (ImageView) convertView.findViewById(R.id.article_likeImage);
            TextView txt_megusta = (TextView) convertView.findViewById(R.id.article_likeText);
            ImageView Comentar = (ImageView) convertView.findViewById(R.id.article_commentImage);
            TextView txt_comentar = (TextView) convertView.findViewById(R.id.article_commentText);
            
            final Article m = Article.get(position);
            
            Glide.with(convertView.getContext()).load(UserData.SERVER_ADDRESS + m.getImage()).into(noticiaimg);
            Glide.with(convertView.getContext()).load(UserData.SERVER_ADDRESS + m.getUserImage()).into(Imageuser);
            image_user.setImageResource(R.drawable.ic_menu_empty);
            noticiatit.setText(m.getHeadline());
            noticiaubica.setText(m.getPlace());
            noticiades.setText(m.getContent());
            noticiafecha.setText(m.getDate());
            noticiausu.setText(m.getUserName());
            if (m.getLike().equals("1")) {
                Glide.with(convertView.getContext()).load(R.drawable.ic_menu_like_blue).into(MeGusta);
                txt_megusta.setTextColor(getResources().getColor(R.color.colorAccent));
            } else {
                Glide.with(convertView.getContext()).load(R.drawable.ic_menu_like_gray).into(MeGusta);
                txt_megusta.setTextColor(getResources().getColor(R.color.grey));
            }
            
            if (m.getComment().equals("1")) {
                Glide.with(convertView.getContext()).load(R.drawable.ic_menu_comment_gray).into(Comentar);
                txt_comentar.setTextColor(getResources().getColor(R.color.grey));
            } else {
                Glide.with(convertView.getContext()).load(R.drawable.ic_menu_comment_gray).into(Comentar);
                txt_comentar.setTextColor(getResources().getColor(R.color.grey));
            }
            
            MeGusta.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    if (GETSharedPreferences("ID", "").isEmpty()) {
                        Toast.makeText(getActivity(), "Necesita Iniciar sesión", Toast
                                .LENGTH_SHORT).show();
                    } else {
                        if (m.getLike().equals("1")) {
                            //                          TODO: AQUI SE BORRA
                            new Like_Management(LocalNewsFragment.this.getView(), Integer
                                    .valueOf(GETSharedPreferences("ID", "")), Integer.valueOf(m
                                    .getId()), Integer.valueOf(m.getLike()), m, adapter).execute();
                            *//*m.setLike("0");*//*
                        } else {
                            //                          TODO: AQUI SE CREEA
                            new Like_Management(LocalNewsFragment.this.getView(), Integer
                                    .valueOf(GETSharedPreferences("ID", "")), Integer.valueOf(m
                                    .getId()), Integer.valueOf(m.getLike()), m, adapter).execute();
                            *//*m.setLike("1");*//*
                        }
        
                    }
                }
            });
            Comentar.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    if (GETSharedPreferences("ID", "").isEmpty()) {
                        Toast.makeText(getActivity(), "Necesita Iniciar sesión", Toast
                                .LENGTH_SHORT).show();
                    } else {
                        Activity_Comments.commentposition = Integer.valueOf(m.getId());
                        startActivity(new Intent(getContext(), Activity_Comments.class));
                    }
                }
            });
            clickAlert.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    posilista = position;
                    Activity_DetailArticle.opcion = 1;
                    startActivity(new Intent(LocalNewsFragment.this.getView().getContext(),
                            Activity_DetailArticle.class));
                    //                    Snackbar.make(LocalNewsFragment.this.getView(),
                    // "position: "+position,Snackbar.LENGTH_LONG).show();
                }
            });
            if (m.getUserId().equals(GETSharedPreferences("ID", ""))) {
                image_user.setImageResource(R.drawable.ic_menu_accountsignup);
                clickAlert.setOnLongClickListener(new View.OnLongClickListener() {
                    @Override
                    public boolean onLongClick(View view) {
                        // TODO Auto-generated method stub
                        final SweetAlertDialog sweetAlertDialog = new SweetAlertDialog
                                (getActivity(), SweetAlertDialog.WARNING_TYPE);
                        sweetAlertDialog.setContentText("¿Desea borrar esta publicacion?");
                        sweetAlertDialog.show();
                        sweetAlertDialog.showCancelButton(true);
                        Button cancel = (Button) sweetAlertDialog.findViewById(cn.pedant
                                .SweetAlert.R.id.cancel_button);
                        if (cancel != null) {
                            Log.e("Messeage from pdialog", "showErrorMsg: Button view Found yep");
                            cancel.setBackgroundColor(getResources().getColor(R.color
                                    .colorPrimaryDark));
                            cancel.setTextColor(getResources().getColor(R.color.TextInPrimary));
                            cancel.setText("No, Gracias");
                        }
                        cancel.setOnClickListener(new View.OnClickListener() {
                            @Override
                            public void onClick(View view) {
                                sweetAlertDialog.dismiss();
                            }
                        });
                        Button accept = (Button) sweetAlertDialog.findViewById(cn.pedant
                                .SweetAlert.R.id.confirm_button);
                        if (accept != null) {
                            Log.e("Messeage from pdialog", "showErrorMsg: Button view Found yep");
                            accept.setBackgroundColor(getResources().getColor(R.color
                                    .colorPrimaryLight));
                            accept.setTextColor(getResources().getColor(R.color
                                    .TextInPrimaryLight));
                            accept.setText("Si, Hazlo");
                        }
                        accept.setOnClickListener(new View.OnClickListener() {
                            @Override
                            public void onClick(View view) {
                                sweetAlertDialog.dismiss();
                                new borrarNoticia(Integer.valueOf(m.getId()), position).execute();
                                
                            }
                        });
                        //                Toast.makeText(getContext(), "long clicked, "+"pos: " +
                        // pos, Toast.LENGTH_LONG).show();
                        return true;
                    }
                });
            }
            
            return convertView;
            
        }
        
    }*/
}
