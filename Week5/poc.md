Beschrijving van de PoC's
==========================

Geef een beschrijving van de test die je gedaan hebt met elk Proof of Concept. Voeg 
 de code ook toe in de map **code**.
 
Sensors uitlezen in android
----------------
* **testopzet:**  
1. Inlezen wat je precies met de sensors kunt doen, en aantal leuke sensors uitkiezen die ondersteund worden door mijn telefoon (I-9505)
2. Aantal sensors uitlezen.
3. Waarde van sensors op de UI zetten.
4. UI uitlijnen

* **resultaat:**  
De volgende code is hiervoor gebruikt:
```java
    public final void onSensorChanged(SensorEvent event) {
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
```
Dat geeft onderstaand resultaat.
![alt Weerstation](./weatherstation.PNG "Weerstation")
