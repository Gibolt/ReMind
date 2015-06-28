package com.techhack.rememberme;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;

import com.google.android.gms.common.SignInButton;


public class LoginActivity extends Activity{

    private SignInButton mloginBtn;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);
        mloginBtn = (SignInButton) findViewById(R.id.sign_in_button);
        mloginBtn.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View v) {
                Intent intent = new Intent(LoginActivity.this, PhotoUpload.class);
                startActivity(intent);
            }
        });

    }

}
