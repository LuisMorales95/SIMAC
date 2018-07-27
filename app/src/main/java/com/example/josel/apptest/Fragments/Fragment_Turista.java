package com.example.josel.apptest.Fragments;

import android.content.Context;
import android.net.Uri;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.android.volley.toolbox.ImageLoader;
import com.example.josel.apptest.Methods.VolleySingleton;
import com.example.josel.apptest.R;
import com.example.josel.apptest.UserData;
import com.squareup.picasso.Picasso;


/**
 * A simple {@link Fragment} subclass.
 * Activities that contain this fragment must implement the
 * {@link Fragment_Turista.OnFragmentInteractionListener} interface
 * to handle interaction events.
 * Use the {@link Fragment_Turista#newInstance} factory method to
 * create an instance of this fragment.
 */
public class Fragment_Turista extends Fragment {

    // TODO: Rename parameter arguments, choose names that match
    private static final String ARG_PARAM1 = "param1";
    private static final String ARG_PARAM2 = "param2";
    private RecyclerView MyRecyclerView;
    private RecyclerView.Adapter mAdapter;
    private RecyclerView.LayoutManager mLayoutManager;
    private String [] items = {
            "Playas",
            "Parques",
            "Restaurantes",
            "Hoteles",
            "Centros nocturnos",
            "Sitios de interes"
    };
    private String [] ImagenesUrl ={
            "sun-umbrella.png",
            "park.png",
            "Store.png",
            "hotel.png",
            "mirror-ball.png",
            "map.png"

    };

    // TODO: Rename and change types of parameters
    private String mParam1;
    private String mParam2;

    private OnFragmentInteractionListener mListener;

    public Fragment_Turista() {
    }
    // TODO: Rename and change types and number of parameters
    public static Fragment_Turista newInstance(String param1, String param2) {
        Fragment_Turista fragment = new Fragment_Turista();
        Bundle args = new Bundle();
        args.putString(ARG_PARAM1, param1);
        args.putString(ARG_PARAM2, param2);
        fragment.setArguments(args);
        return fragment;
    }
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (getArguments() != null) {
            mParam1 = getArguments().getString(ARG_PARAM1);
            mParam2 = getArguments().getString(ARG_PARAM2);
        }
    }
    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        return inflater.inflate(R.layout.fragment_turista, container, false);
    }
    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);

        MyRecyclerView = (RecyclerView) view.findViewById(R.id.MyRecyclerView);
        MyRecyclerView.setHasFixedSize(true);

        mLayoutManager = new LinearLayoutManager(getActivity());
        MyRecyclerView.setLayoutManager(mLayoutManager);





        mAdapter = new MyAdapter(items,ImagenesUrl);
        MyRecyclerView.setAdapter(mAdapter);
    }


























    public class MyAdapter extends RecyclerView.Adapter<MyAdapter.ViewHolder> {

        private String[] mDataset;
        private String[] imagenes;
	    ImageLoader imageLoader = VolleySingleton.getInstance().getImageLoader();

        public MyAdapter(String[] mDataset, String[] imagenes) {
            this.mDataset = mDataset;
            this.imagenes = imagenes;
        }

        @Override
        public MyAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {

            View itemView = LayoutInflater.from(parent.getContext()).inflate(R.layout.turiste_item, parent, false);
	        if (imageLoader == null) imageLoader = VolleySingleton.getInstance().getImageLoader();

            ViewHolder vh = new ViewHolder(itemView);

            return vh;
        }

        public  class ViewHolder extends RecyclerView.ViewHolder {
            public TextView name;
            public ImageView turiste_image;
            public ViewHolder(View view) {
                super(view);
                name = (TextView) view.findViewById(R.id.name);
                turiste_image = (ImageView) view.findViewById(R.id.turiste_image);
            }
        }
        @Override
        public void onBindViewHolder(ViewHolder holder, int position) {
            holder.name.setText(mDataset[position]);
            Picasso.get().load(UserData.SERVER_ADDRESS+"Zonas-Turisticas/"+imagenes[position]).into(holder.turiste_image);

        }
        @Override
        public int getItemCount() {
            return mDataset.length;
        }
    }


















    // TODO: Rename method, update argument and hook method into UI event
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
            throw new RuntimeException(context.toString()
                    + " must implement OnFragmentInteractionListener");
        }
    }

    @Override
    public void onDetach() {
        super.onDetach();
        mListener = null;
    }

    public interface OnFragmentInteractionListener {
        // TODO: Update argument type and name
        void onFragmentInteraction(Uri uri);
    }
}
