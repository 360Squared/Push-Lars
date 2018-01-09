package com.example.simplegesture;

import com.samsung.android.sdk.SsdkUnsupportedException;
import com.samsung.android.sdk.gesture.Sgesture;
import com.samsung.android.sdk.gesture.SgestureHand;
import com.samsung.android.sdk.gesture.SgestureHand.Info;

import android.app.Activity;
import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.Toast;

public class MainActivity extends Activity {
	private Sgesture mGesture;
	private GestureHand mGestureHand;
	private MainActivityView mainView;
	private boolean isGestureSupported= false;

	private final int[] nResInfo = { R.string.movement_up,
			R.string.movement_down, R.string.movement_left,
			R.string.movement_right };
	private SgestureHand.ChangeListener changeListener = new SgestureHand.ChangeListener() {

		@Override
		public void onChanged(Info info) {
			if (info.getType() == Sgesture.TYPE_HAND_PRIMITIVE) {
				int direction = mGestureHand.getDirection(info.getAngle());

				mainView.getTextView(R.id.degreeConatainer).setText(
						Integer.toString(info.getAngle()) + "�");
				mainView.getTextView(R.id.information).setText(
						nResInfo[direction - 1]);

			}
		}
	};

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);
		
		mainView = new MainActivityView();
		if (savedInstanceState == null) {
			getFragmentManager().beginTransaction()
					.add(R.id.container, mainView).commit();
		}
		
		mGesture = new Sgesture();
		try {
			mGesture.initialize(this);
		} catch (IllegalArgumentException | SsdkUnsupportedException e) {
			Toast.makeText(this, e.getMessage(),
					Toast.LENGTH_SHORT).show();
			//mainView.getTextView(R.id.information).setText(e.getMessage());
			return;
		}
		
		isGestureSupported = mGesture.isFeatureEnabled(Sgesture.TYPE_HAND_PRIMITIVE);

		mGestureHand = new GestureHand(getMainLooper(), mGesture);
		mGestureHand.setListener(changeListener);
		isGestureSupported = mGestureHand.start(Sgesture.TYPE_HAND_PRIMITIVE);
	}

	@Override
	protected void onStart() {
		if(isGestureSupported){
		mainView.getTextView(R.id.information).setText(
				R.string.gesture_available);
		}
		super.onStart();
	}

	@Override
	protected void onDestroy() {
		if (isGestureSupported) {
			mGestureHand.stop();
		}
		super.onDestroy();
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {

		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.main, menu);
		return true;
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		// Handle action bar item clicks here. The action bar will
		// automatically handle clicks on the Home/Up button, so long
		// as you specify a parent activity in AndroidManifest.xml.
		int id = item.getItemId();
		if (id == R.id.action_settings) {
			startActivityForResult(new Intent(
					android.provider.Settings.ACTION_SETTINGS), 0);
			return true;
		}
		return super.onOptionsItemSelected(item);
	}

}
