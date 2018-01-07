package com.example.lars.barcodescanner;

import android.app.Activity;
import android.os.Bundle;
import android.webkit.URLUtil;
import android.webkit.WebChromeClient;
import android.webkit.WebResourceRequest;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.Toast;

/**
 * Created by Lars on 03/01/2018.
 */

public class WebViewActivity extends Activity {

    private WebView webView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_webview);
        Bundle extras = getIntent().getExtras();
        webView = findViewById(R.id.webView);
        webView.getSettings().setJavaScriptEnabled(true);
        if (extras != null) {
            String url = extras.getString("URL");
            if (!URLUtil.isValidUrl(url)) {
                CharSequence text = "Invalid URL!";
                int duration = Toast.LENGTH_SHORT;

                Toast toast = Toast.makeText(this, text, duration);
                toast.show();
                //https://stackoverflow.com/a/14848906
                finish();
            }
            // Set WebView client
            //https://stackoverflow.com/a/34924153 it opend in chrome instead of in the webview.
            webView.setWebChromeClient(new WebChromeClient());

            webView.setWebViewClient(new WebViewClient() {

                //deprecated in API level 24.
                @Override
                public boolean shouldOverrideUrlLoading(WebView view, String url) {
                    view.loadUrl(url);
                    return true;
                }

                @Override
                public boolean shouldOverrideUrlLoading(WebView view, WebResourceRequest request) {
                    view.loadUrl(request.getUrl().toString());
                }
            });
            webView.loadUrl(url);
            // Load the webpage
        }
    }
}
