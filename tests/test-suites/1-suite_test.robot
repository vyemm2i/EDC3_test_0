*** Settings ***
Documentation       Suite DigitalBank

Resource            ${CURDIR}/../BaseTests.resource
Resource            ${CURDIR}/../step-defs/StepConnexion.resource


Suite Setup         BaseTests.Suite Setup
Suite Teardown      BaseTests.Suite Teardown
Test Setup          BaseTests.Test Setup
Test Teardown       BaseTests.Test Teardown

Test Tags           type_tnr    env_${ENV}    browser_${BROWSER}
# type_
# env_
# browser_(chrome/edge/firefox/chromemobileemulation)
# jira_
# test_(positive/negative)
# dev_(inprogress/maintains/done)

*** Variables ***
${JSON_FILE_PATH}    ${CURDIR}/../data-env/data-part.json


*** Test Cases ***
Check Chrome Open
    [Tags]    sanity
    Sleep    2s   # Attendre en secondes pour voir la page
    No Operation


*** Test Cases ***
Se Connecter Compte_1
    [Documentation]    Se Connecter Compte
    [Tags]    jira_01    test_positive    dev_done
    ${compte_1}=    Charger Donnees Compte
    StepConnexion.Se Connecter    ${compte_1}
    Sleep    3s
    StepConnexion.Verifier Connexion Ok    ${compte_1}
    Sleep    3s

Se Deconnecter Compte_1
    [Documentation]    Se Déconnecter Compte
    [Tags]    jira_02    test_positive    dev_done
    ${compte_1}=    Charger Donnees Compte
    StepConnexion.Se Connecter    ${compte_1}
    Sleep    3s
    StepConnexion.Verifier Connexion Ok    ${compte_1}
    Sleep    3s
    StepConnexion.Se Deconnecter
    Sleep    2s
