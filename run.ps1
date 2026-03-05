# Afin de centraliser les artefacts d’exécution, j’utilise l’option --outputdir de Robot Framework pour diriger les rapports vers un dossier dédié.
# Cela facilite l’intégration CI/CD et permet une meilleure gestion des artefacts.

# Lancer la commande à la racine : .\run.ps1

# POWERSHELL depuis le nom des fichiers : 

# Pour lancer TOUTES les suites de test :
# robot -d output tests/test-suites

# Pour lancer certaines suites : 
robot -d output tests/test-suites/1-suite_test.robot

#---------------------------------------------------

# POWERSHELL depuis le nom des TAGS : [Tags]    jira_01    test_positive    dev_done

# Lancer uniquement les tests : "test_positive"
#-i = include
#-e = exclude

# robot -d output -i test_positive tests/test-suites

# Lancer en TAGS combinés : Robot permet AND / OR logique.
# Exemple : 
# robot -d output -i sanityANDenv_test tests/test-suites