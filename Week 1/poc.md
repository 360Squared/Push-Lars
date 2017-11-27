Beschrijving van de PoC's
==========================

Geef een beschrijving van de test die je gedaan hebt met elk Proof of Concept. Voeg 
 de code ook toe in de map **code**.
 
Reactnative met geofencing
----------------
* **hypothese:**  
Is het handig om React Native te gebruiken in combinatie voor geofencing.

* **testopzet:**  
1. Starter project van react native werkend krijgen
2. Geofencing library zoeken voor React Native
3. library implementeren
4. testen van de poc
 
* **resultaat:**  
Aantal plugins gevonden voor [geofencing](https://www.npmjs.com/package/react-native-geo-fence). De meeste waren voor een oudere versie van react native. Wanneer ik oudere versie van react wilde gebruiken compileerde het starter project niet meer.

Toen ik uiteindelijk een [plugin](https://www.npmjs.com/package/react-native-expo-geofence) gevonden had bleek dat niet echt geofencing te zien maar een functie om te kijken of een punten binnen een bepaalde afstand van een ander punt ligt.

Uiteindelijk vond ik een [plugin](https://github.com/transistorsoft/react-native-background-geolocation#large_blue_diamond-setup-guides) die eigenlijk veel meer dan GeoFencing doet. Kan handiger zijn om zelf een GeoFencing plugin te schrijven voot react native.

* **conclusie**
Plugin aanbod is veel kleiner dat die van Ionic.