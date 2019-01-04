# rootTheVacbot
Dieses Projekt setzt eine komplette virtuelle Maschine auf, um Custom-Firmware (dustcloud, valetudo) für einen Xiaomi/Roborock Saugroboter zu bauen und zu flashen.

Es ist nichts besonderes, keine Magic, aber für mich als Windows-Benutzer ist es einfacher ein `vagrant up` abzusetzen als eine komplette Linuxumgebung mit Python-Installation durchzuführen.

## Was ist enthalten?
* Debian 9
* Python 3.5
* Libs und Tools, die von dustcloud und valetudo benötigt werden

## Voraussetzungen
* Virtual Box
* Vagrant
* Power Shell 3 (benötigt von Vagrant)

## Wie starten?
die Skripte online.sh und offline.sh funktionieren heute (4.1.2019). Vielleicht funktionieren sie nicht mehr, wenn sich etwas in den verwendeten Repositories ändert. Dann deren Dokumentation sorgfältig lesen. Als Arbeitsgrundlage kann aber diese VM trotzdem genutzt werden. Alternativ könnten die Repositories auf meine Forks (online.sh) umgebogen werden.

* dieses Repository downloaden oder clonen `git clone https://github.com/justcoke/vagrant-rootTheVacbot.git`
* auf der Shell in 'vagrant-rootTheVacbot' wechseln
* `vagrant up` ausführen (erstellt eine virtuelle Maschine in deiner Virtual Box und startet sie)
  * dabei wird das 'vagrant-rootTheVacbot' Verzeichnis automatisch nach /vagrant gemounted
* `vagrant ssh` ausführen und auf die VM verbinden
* Sicherstellen, dass ein Public-Key in /vagrant existiert
  * wenn nicht: `ssh-keygen -t rsa -b 4096` ausführen und die generierten Schlüssel nach /vagrant/... speichern/kopieren
* properties.conf editieren
* `/vagrant/online.sh` ausführen
  * dieses Wrapper-Skript
    * clont die Repositories dustcloud und valetudo
    * patcht ein Bug, der verhindert, dass die korrekte IP der M ermittelt wird
    * lädt die Firmware herunter
    * führt das Skript imagebuilder.sh (dustcloud) mit der Konfiguration aus properties.config aus
* Wifi ins Saugroboter-Wifi wechseln (Reset-Knopf neben der Wifi-LED drücken)
* Sicherstellen, dass die VM eine IP-Adresse vom Saugroboter erhalten hat (Ich musste mich aus der VM ausloggen und dann die VM neu starten: `vagrant halt`, `vagrant up`, `vagrant ssh`)
* `/vagrant/offline.sh` ausführen
* nach dem Flashen sollte der Saugroboter einen verbalen Hinweis auf das Aktualisieren der Firmware geben
* wenn er komplett fertig ist, gibt es einen neuen verbalen Hinweis
* via `ssh root@<vacbot-ip>` kann man sich nun auf den Saugroboter unter Verwendung seines privaten Schlüssels verbinden

Viel Spaß
