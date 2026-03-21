# TUTO : 

NOM_DU_PROJET
-.vscode
-doc
-libs
-output
-tests
--data-env
--page-objects
--step-defs
--testsuites
--BaseSelenium.resource
--BaseTests.resource
--BaseVariable.resource
-venv
-.gitignore
-README.md


# CREATION VENV : digitalbank/
py -3.11 -m venv venv

#Activer venv : 
.\venv\Scripts\Activate.ps1

#MAJ PYTHON : 
pip install --upgrade pip

#INSTALLER RBF : 
pip install robotframework robotframework-seleniumlibrary webdriver-manager

#LANCER TEST : depuis la racine (mettre à jour)

robot tests\test-suites\1-suite_test.robot

# Desactiver le venv : 
deactivate   

# INSTALLER REQUESTLIBRARY pour faire des requetes sur l'url : 
#(Depuis n'importe quel dossier dans le dossier projet "digitalbank" du moment qu'on reste dans le (venv))
pip install robotframework-requests

#AJOUT D'UN FICHIER DE CONFIGURATION POUR AVOIR LES SORTIES DE TEST DANS UN DOSSIER OUTPUT : 
#Dans VSCode / RUN / Add configuration

#Cela va créer un fichier launch.json

cd.. pour revenir en arrière

#Mais pour être sûr que les sorties arrivent dans output : 
#(Dans le terminal à partir du projet : digitalbank)

robot --outputdir output tests/test-suites/1-suite_test.robot
#ou
robot -d ../output .\1-suite_test.robot

#sinon depuis le projet : DIGITALBANK 

robot -d output tests/test-suites/1-suite_test.robot



#Vérifier que VSCode utilise le bon environnement virtuel
#Sur VSCode / View/ Command Palette / Python:Select Interpreter
#Choisir venv
#Verif en bas à gauche (venv)


#Verif de robotframework : robot --version

#Installer JSONLIBRARY pour lire les fichiers et utiliser des méthodes json ; 

#Pour build le conteneur :
docker compose up -d

#POur supprimer les volumes : 
docker compose down -v