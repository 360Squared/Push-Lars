package com.example.lars.technology_nfc;

import android.nfc.NfcAdapter;
import android.nfc.Tag;
import android.nfc.tech.IsoDep;

/**
 * Created by Lars on 22/12/2017.
 */

public class NFCReadCallBack implements NfcAdapter.ReaderCallback {

    @Override
    public void onTagDiscovered(Tag tag) {
        IsoDep isoDep = IsoDep.get(tag);
    }
}
