package com.techhack.rememberme;

import android.app.Activity;
import android.graphics.BitmapFactory;
import android.os.Bundle;
import android.view.Window;
import android.view.WindowManager;

import com.marvinlabs.widget.slideshow.SlideShowAdapter;
import com.marvinlabs.widget.slideshow.SlideShowView;
import com.marvinlabs.widget.slideshow.adapter.GenericBitmapAdapter;
import com.marvinlabs.widget.slideshow.adapter.RemoteBitmapAdapter;
import com.marvinlabs.widget.slideshow.picasso.GenericPicassoBitmapAdapter;
import com.marvinlabs.widget.slideshow.picasso.PicassoRemoteBitmapAdapter;
import com.squareup.picasso.Picasso;

import java.util.Arrays;


public class ViewSlideActivity extends Activity {

    private SlideShowView slideShowView;
    private SlideShowAdapter adapter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        // Go fullscreen
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN, WindowManager.LayoutParams.FLAG_FULLSCREEN);

        // Activity layout
        setContentView(R.layout.activity_slide);

        slideShowView = (SlideShowView) findViewById(R.id.slideshow);
    }

    @Override
    protected void onResume() {
        super.onResume();
        startSlideShow();
    }

    @Override
    protected void onStop() {
        if (adapter instanceof GenericBitmapAdapter) {
            ((GenericBitmapAdapter) adapter).shutdown();
        } else if (adapter instanceof GenericPicassoBitmapAdapter) {
            ((GenericPicassoBitmapAdapter) adapter).shutdown();
        }
        super.onStop();
    }

    private SlideShowAdapter createRemoteAdapter() {
        String[] slideUrls = new String[]{
                "http://lorempixel.com/1280/720/sports",
                "http://lorempixel.com/1280/720/nature",
                "http://lorempixel.com/1280/720/people",
                "http://lorempixel.com/1280/720/city",
        };
        BitmapFactory.Options opts = new BitmapFactory.Options();
        opts.inSampleSize = 2;
        adapter = new RemoteBitmapAdapter(this, Arrays.asList(slideUrls), opts);
        return adapter;
    }

    private SlideShowAdapter createPicassoAdapter() {
        Picasso.with(this).setLoggingEnabled(true);

        String[] slideUrls = new String[]{
                "http://www.marvinlabs.com/wp-content/uploads/2013/10/logo.png",
                "http://lorempixel.com/1280/720/sports",
                "http://lorempixel.com/1280/720/nature",
                "http://lorempixel.com/1280/720/people",
                "http://lorempixel.com/1280/720/city",
        };
        adapter = new PicassoRemoteBitmapAdapter(this, Arrays.asList(slideUrls));
        return adapter;
    }


    private void startSlideShow() {
        // Create an adapter
        // slideShowView.setAdapter(createResourceAdapter());
        slideShowView.setAdapter(createRemoteAdapter());
        // slideShowView.setAdapter(createPicassoAdapter());

        // Optional customisation follows
        // slideShowView.setTransitionFactory(new RandomTransitionFactory());
        // slideShowView.setPlaylist(new RandomPlayList());

        // Some listeners if needed
        //slideShowView.setOnSlideShowEventListener(slideShowListener);
        //slideShowView.setOnSlideClickListener(slideClickListener);

        // Then attach the adapter
        slideShowView.play();
    }
}
