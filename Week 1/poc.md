Beschrijving van de PoC's
==========================

Geef een beschrijving van de test die je gedaan hebt met elk Proof of Concept. Voeg 
 de code ook toe in de map **code**.
 
Reactnative met geo-fencing
----------------
* **hypothese:**  
Is het handig om React Native te gebruiken in combinatie met geo-fencing.

* **testopzet:**  
1. Starter project van react native werkend krijgen
2. Geo-fencing library zoeken voor React Native
3. Library implementeren
4. Testen van de poc
 
* **resultaat:**  
Aantal plugins gevonden voor [geo-fencing](https://www.npmjs.com/package/react-native-geo-fence). De meeste waren voor een oudere versie van react native. Wanneer ik probeerde om de React Native project te downgraden naar een oudere versie lukte dat niet.

Toen ik uiteindelijk een [plugin](https://www.npmjs.com/package/react-native-expo-geofence) gevonden had bleek dat niet echt geo-fencing te zien maar een functie om te kijken of een punten binnen een bepaalde afstand van een ander punt ligt.

Uiteindelijk vond ik een [plugin](https://github.com/transistorsoft/react-native-background-geolocation#large_blue_diamond-setup-guides) die eigenlijk veel meer dan geo-fencing doet. 

Doordat het plugin aanbod niet zo groot is, en de plugins die werken te veel aanbieden wat niet nodig is, is het handiger om je eigen plugin te maken.