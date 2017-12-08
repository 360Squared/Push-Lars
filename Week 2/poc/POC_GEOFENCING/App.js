import React from 'react';
import { StyleSheet, Text, View } from 'react-native';
import BackgroundGeolocation from "react-native-background-geolocation";


export default class App extends React.Component {
  
  constructor() {
    super()
    this.state = {geoFenceState: "Start"}
  }

  componentWillMount() {
    BackgroundGeolocation.configure({
      desiredAccuracy: 0,
      distanceFilter: 50,
      stationaryRadius: 25,
      locationUpdateInterval: 1000,
      foregroundService: true
    }, (state) => {
      console.log("Background Geolocation started now.  Current state: ", state.enabled);
      if (!state.enabled) {// <-- plugin persists its enabled state.  it may have already started.
        BackgroundGeolocation.start();
      }
    }, (error) => {
      console.warn("Background Geolocation failed to configure");
    })

    BackgroundGeolocation.on("geofence", (geofence) => {
      let location    = geofence.location;
      let identifier  = geofence.identifier;
      let action      = geofence.action;
      console.log("Geofence change", geofence)
      this.setState(() => {
        return { geoFenceState: action }
      })
    })



    BackgroundGeolocation.setConfig({geofenceProximityRadius: 100});
    BackgroundGeolocation.addGeofence({
      identifier: "Home",
      radius: 50,
      latitude: 51.98683,
      longitude: 5.95158,
      notifyOnEntry: true,
      notifyOnExit: true,
      notifyOnDwell: true,

    }, () => {
      console.log("Successfully added geofence");
    }, (error) => {
      console.warn("Failed to add geofence", error);
    });
    
  }


  
  render() {
    return (
      <View style={styles.container}>
        <Text>{this.state.geoFenceState}</Text>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center',
  },
});
