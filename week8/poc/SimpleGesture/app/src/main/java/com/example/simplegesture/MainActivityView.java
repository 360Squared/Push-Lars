package com.example.simplegesture;

import android.app.Fragment;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

public class MainActivityView extends Fragment {
	/**
	 * A placeholder fragment containing a simple view.
	 */

	public MainActivityView() {
	}

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {
		View rootView = inflater.inflate(R.layout.fragment_main, container,
				false);
		return rootView;
	}

	public TextView getTextView(int resIdTextView) {
			return (TextView) getView().findViewById(resIdTextView);
	}
}
