Beschrijving van de PoC
==========================

Geef een beschrijving van de test die je gedaan hebt met elk Proof of Concept. Voeg 
 de code ook toe in de map **code**.
 
React Native en geo-fencing
----------------
* **hypothese:**  
Is het handig om React Native te gebruiken in combinatie met geo-fencing.

* **testopzet:**  
1. Starter project van React Native werkend krijgen
2. Geo-fencing plugin zoeken voor React Native
3. Plugin toepassen
4. Testen van het Proof of Concept
 
* **resultaat:**  
Aantal plugins gevonden voor [geo-fencing](https://www.npmjs.com/package/react-native-geo-fence). De meeste waren voor een oudere versie van react native. Wanneer ik probeerde om de React Native project te downgraden naar een oudere versie lukte dat niet. 

Toen ik uiteindelijk een [plugin](https://www.npmjs.com/package/react-native-expo-geofence) gevonden had, bleek dat geen geo-fencing te zijn. Het was te kijken of een punt binnen een bepaalde gebied viel. Deze plugin maakte niet eens gebruikt van de GPS.

Uiteindelijk vond ik een [plugin](https://github.com/transistorsoft/react-native-background-geolocation#large_blue_diamond-setup-guides) die eigenlijk veel meer dan alleen geo-fencing doet.

Daarnaast is het plugin aanbod voor geofencing niet heel groot, is en de meeste daarvan voor een oudere versie geschreven / er een aantal plugins veel meer dan alleen geofencing aanbieden kan het handiger zijn om je eigen geo-fencing plugin te schrijven.