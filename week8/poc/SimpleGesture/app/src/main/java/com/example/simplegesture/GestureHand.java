package com.example.simplegesture;

import com.samsung.android.sdk.gesture.Sgesture;
import com.samsung.android.sdk.gesture.SgestureHand;

import android.os.Looper;

class GestureHand {

	public static final int UP = 1;
	public static final int DOWN = 2;
	public static final int LEFT = 3;
	public static final int RIGHT = 4;

	private SgestureHand mGestureHand = null;
	private SgestureHand.ChangeListener mChangeListener;

	GestureHand(Looper looper, Sgesture gesture) {
		mGestureHand = new SgestureHand(looper, gesture);
	}

	public void setListener(SgestureHand.ChangeListener changeListener) {
		mChangeListener = changeListener;
	}

	public boolean start(int mode) {
		if (mChangeListener != null) {
			mGestureHand.start(mode, mChangeListener);
			return true;
		}
		return false;

	}

	public void stop() {
		mGestureHand.stop();
	}

	public int getDirection(int angle) {
		if (angle < 45 || angle >= 315) {
			return DOWN;
		} else if (angle >= 45 && angle < 135) {
			return RIGHT;
		} else if (angle >= 135 && angle < 225) {
			return UP;
		} else if (angle >= 225 && angle < 315) {
			return LEFT;
		}
		return 0;
	}

}
