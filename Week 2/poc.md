Beschrijving van de PoC's
==========================

Geef een beschrijving van de test die je gedaan hebt met elk Proof of Concept. Voeg 
 de code ook toe in de map **code**.
 
ARKit
----------------
* **hypothese:**  
Is het handig om vacatures aan te bieden via AR met behulp van een virtele tegel?

* **testopzet:**  
 1. Inlezen wat ARKit precies is, en kijken naar de basis functionaliteiten
 2. Implementeren van basic AR

* **resultaat:**  
Vacatures op een bepaalde locatie kunnen met behulp van AR getoond worden. Echter biedt ARKit zelf niet de functionaliteiten om een Node op een locatie plaatsen. Een Node plaats je namelijk op (x, y, z) meters van de camera. Toevallig kwam ik een [library](https://github.com/ProjectDent/ARKit-CoreLocation) tegen die dat probleem oploste. Echter er zit een probleem in dat de Nodes meelopen met de camera.