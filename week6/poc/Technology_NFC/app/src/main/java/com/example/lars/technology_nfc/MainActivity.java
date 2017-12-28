package com.example.lars.technology_nfc;

import android.app.Activity;
import android.content.ContextWrapper;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.nfc.*;
import android.content.Context;

import static android.app.PendingIntent.getActivity;
import static android.nfc.NfcAdapter.FLAG_READER_NFC_A;
import static android.nfc.NfcAdapter.FLAG_READER_SKIP_NDEF_CHECK;

public class MainActivity extends AppCompatActivity {

    private NfcManager nfcManager;
    private NfcAdapter nfcAdapter;
    private NFCReadCallBack callBack;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        nfcManager = (NfcManager) new ContextWrapper(this).getSystemService(Context.NFC_SERVICE);
        callBack = new NFCReadCallBack();
        nfcAdapter = nfcManager.getDefaultAdapter();
        Activity activity = this;
        nfcAdapter.enableReaderMode(activity, callBack, (FLAG_READER_NFC_A | FLAG_READER_SKIP_NDEF_CHECK), null);
    }
}
