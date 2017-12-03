Beschrijving van de PoC's
==========================

Geef een beschrijving van de test die je gedaan hebt met elk Proof of Concept. Voeg 
 de code ook toe in de map **code**.
 
ARKit
----------------
* **hypothese:**  
Is het handig om vacatures aan te bieden met behulp van Augmented Reality en virtuele tegels.

* **testopzet:**  
 1. Inlezen wat ARKit precies is, en kijken naar de basis functionaliteiten.
 2. Implementeren van basic AR.
 3. Testen of het werkt.

* **resultaat:**  
Vacatures op een bepaalde locatie kunnen met behulp van AR getoond worden. Echter biedt ARKit zelf niet de functionaliteiten om een Node op een locatie plaatsen. Een Node plaats je namelijk op (x, y, z) meters van de camera. Toevallig kwam ik een [library](https://github.com/ProjectDent/ARKit-CoreLocation) tegen die dat probleem oploste. Hiermee konden wel Nodes op een bepaalde locatie geplaatst worden, echter wanneer je langs een Node liep ging deze een eindje mee, waardoor deze voor jou niet meer opdezelfde plek staat, zolang de app niet wordt afgesloten.


Multipeer Connectivity
----------------
* **hypothese:**  


* **testopzet:**  
1. Lezen wat MultipeerConnectivity precies inhoudt.
2. Implementeren ervan.
3. Testne of het werkt.

* **resultaat:**  
Na veel moeite het werkend gekregen. De documentatie van Apple was niet echt duidelijk. Toen een [tutorial](https://www.appcoda.com/intro-multipeer-connectivity-framework-ios-programming/) gevonden in Objective C, dat omgezet naar Swift maar die werkte ook niet. Daarna kwam ik via een [stackoverflow](https://stackoverflow.com/questions/36193454/multipeer-connectivity-is-not-working-ios-9-3-xcode-7-3) post op een andere [tutorial](https://www.appcoda.com/chat-app-swift-tutorial/) in ene oudere swift versie, die ook omgezet en dat werkte wel.