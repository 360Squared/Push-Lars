package com.example.lars.sensors;

import android.content.Context;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.hardware.*;
import android.widget.TextView;


public class MainActivity extends AppCompatActivity implements SensorEventListener {

    private enum SENSORS {
        BAROMETER (0), HUMIDITY (1), MAGNETIC (2), TEMPERATURE (3);

        private int value;
        SENSORS(int value) {
            this.value = value;
        }

        public int getValue() {
            return value;
        }
    }

    private SensorManager sensorManager;
    private Sensor sensorPressure;
    private Sensor sensorHumidity;
    private Sensor sensorTemperature;
    private Sensor sensorMagnetic;
    //Labels
    private TextView humidityValue;
    private TextView barometerValue;
    private TextView magneticValue;
    private TextView temperatureValue;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        humidityValue = findViewById(R.id.humidityValue);
        barometerValue = findViewById(R.id.barometerValue);
        magneticValue = findViewById(R.id.magneticValue);
        temperatureValue = findViewById(R.id.temperatureValue);

        sensorManager = (SensorManager) getSystemService(Context.SENSOR_SERVICE);
        sensorPressure = sensorManager.getDefaultSensor(Sensor.TYPE_PRESSURE);
        sensorHumidity = sensorManager.getDefaultSensor(Sensor.TYPE_RELATIVE_HUMIDITY);
        sensorTemperature = sensorManager.getDefaultSensor(Sensor.TYPE_AMBIENT_TEMPERATURE);
        sensorMagnetic = sensorManager.getDefaultSensor(Sensor.TYPE_MAGNETIC_FIELD);
    }

    @Override
    public final void onAccuracyChanged(Sensor sensor, int accuracy) {
    }

    @Override
    public final void onSensorChanged(SensorEvent event) {
        System.out.print("ID: " + event.sensor.getId() + " Name: " + event.sensor.getName() + " ");
        for (float s : event.values) {
            System.out.print(s + "\t");
        }
        System.out.println();

        if (event.sensor.getName() == sensorPressure.getName()) {
            barometerValue.setText(Float.toString(event.values[0]) + " hPa");
        } else if (event.sensor.getName() == sensorHumidity.getName()) {
            humidityValue.setText(Float.toString(event.values[0]) +"%");
        } else if (event.sensor.getName() == sensorTemperature.getName()) {
            temperatureValue.setText(Float.toString(event.values[0]) + " ℃");
        } else if (event.sensor.getName() == sensorMagnetic.getName()) {
            double mag = Math.sqrt(Math.pow((double)event.values[0], 2) + Math.pow((double)event.values[1], 2) + Math.pow((double)event.values[2], 2));
            magneticValue.setText(Double.toString(mag) + " µT");
        }
    }

    @Override
    protected void onResume() {
        super.onResume();
        sensorManager.registerListener(this, sensorPressure, SensorManager.SENSOR_DELAY_NORMAL);
        sensorManager.registerListener(this, sensorHumidity, SensorManager.SENSOR_DELAY_NORMAL);
        sensorManager.registerListener(this, sensorTemperature, SensorManager.SENSOR_DELAY_NORMAL);
        sensorManager.registerListener(this, sensorMagnetic, SensorManager.SENSOR_DELAY_NORMAL);
    }

    @Override
    protected void onPause() {
        super.onPause();
        sensorManager.unregisterListener(this);
    }
}
