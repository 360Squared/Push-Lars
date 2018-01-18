Beschrijving van de PoC's
==========================

Geef een beschrijving van de test die je gedaan hebt met elk Proof of Concept. Voeg de code ook toe in de map **code**.
 
ARKit
----------------
* **hypothese:**  
Is het handig om vacatures aan te bieden met behulp van Augmented Reality en virtuele tegels.

* **testopzet:**  
 1. Inlezen wat ARKit precies is, en kijken naar de basis functionaliteiten.
 2. Implementeren van basic AR.
 3. Testen of het werkt.

* **resultaat:**  
Vacatures op een bepaalde locatie kunnen met behulp van AR getoond worden. Echter biedt ARKit zelf niet de functionaliteiten om een node, een object in de augmented reality wereld, op een geolocatie plaatsen. Een node plaats je namelijk op een coördinaat, (x, y, z), waarbij er is aangegeven hoever die van de camera staat. Toevallig kwam ik een [library](https://github.com/ProjectDent/ARKit-CoreLocation) tegen die dat probleem oploste. Door deze library konden nodes wel op een bepaalde geolocatie geplaatst worden.  

Multipeer Connectivity
----------------
* **testopzet:**  
1. Lezen wat MultipeerConnectivity precies inhoudt en doet.
2. Implementeren ervan.
3. Testen of het werkt.

* **resultaat:**  
Na veel moeite het werkend gekregen. De documentatie van Apple was niet echt duidelijk. Toen een [tutorial](https://www.appcoda.com/intro-multipeer-connectivity-framework-ios-programming/) gevonden in Objective C, dat omgezet naar Swift maar die werkte ook niet. Hij wilde op de een of andere manier niet verbinden. Terwijl de GUI wel aangaf dat de devices verbonden waren. Op een gegeven moment kwam ik via een [stackoverflow](https://stackoverflow.com/questions/36193454/multipeer-connectivity-is-not-working-ios-9-3-xcode-7-3) post op een andere [tutorial](https://www.appcoda.com/chat-app-swift-tutorial/) terecht. Hierdoor werkte het wel.