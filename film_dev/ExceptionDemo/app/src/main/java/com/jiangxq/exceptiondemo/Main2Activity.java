package com.jiangxq.exceptiondemo;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.Button;
import android.widget.Toast;

public class Main2Activity extends AppCompatActivity {
    Button exception;
    Button error;
    Button throwable;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        exception = findViewById(R.id.exception);
        error = findViewById(R.id.error);
        throwable = findViewById(R.id.throwable);
        exception.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                try {
                    throw new RuntimeException();
                } catch (Throwable e) {
                    Toast.makeText(Main2Activity.this,"catch Exception",Toast.LENGTH_SHORT).show();
                }
            }
        });
        error.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                try {
                    throw new Error();
                } catch (Throwable e) {
                    Toast.makeText(Main2Activity.this,"catch Error",Toast.LENGTH_SHORT).show();
                }
            }
        });
        throwable.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                try {
                    testThrowable();
                } catch (Throwable e) {
                    Toast.makeText(Main2Activity.this,"catch Throwable",Toast.LENGTH_SHORT).show();
                }
            }
        });
    }
    void testThrowable() throws Throwable{
        throwError();
    }
    void testError() throws  Error{

    }
    void testException() throws  Exception{

    }

    void throwThrowable() throws Throwable{
        throw new Throwable();
    }
    void throwException() throws Exception{
        throw new Exception();

    }
    void throwError() throws  Error{
        throw new Error();
    }
}
