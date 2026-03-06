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

# Sanity check
Check Chrome Open
    [Tags]    sanity
    Sleep    2s   # Attendre en secondes pour voir la page
    No Operation

# CAS N°1 (PASSANT) : Connexion avec identifiant et mot de passe
Se Connecter Compte_1
    [Documentation]    Se Connecter Compte_1
    [Tags]    jira_01    test_positive    dev_done
    ${compte_1}=    Charger Donnees Compte    compte_1
    StepConnexion.Se Connecter    ${compte_1}
    Sleep    2s
    StepConnexion.Verifier Connexion Ok    ${compte_1}
    Sleep    2s
    StepConnexion.Se Deconnecter
    Sleep    2s

# CAS N°2 (NON-PASSANT) : Connexion avec identifiant et mot de passe
Se Connecter Compte_2
    [Documentation]    Se Connecter Compte_2
    [Tags]    jira_02    test_negatif    dev_done
    ${compte_2}=    Charger Donnees Compte    compte_2
    StepConnexion.Se Connecter    ${compte_2}
    Sleep    2s
    StepConnexion.Verifier Connexion Ko    ${compte_2}
    Sleep    2s

# CAS N°3 (PASSANT) : Connexion avec identifiant, mot de passe et MFA
Se connecter Compte_MFA_1
    [Documentation]    Se Connecter Compte_MFA_1
    [Tags]    jira_03    test_positif    dev_done
    ${compte_mfa_1}=    Charger Donnees Compte    compte_mfa_1
    StepConnexion.Se Connecter    ${compte_mfa_1}
    StepConnexion.Se Connecter Avec 2FA    ${compte_mfa_1}
    Sleep    2s
    StepConnexion.Verifier Connexion Ok    ${compte_mfa_1}
    Sleep    2s
    StepConnexion.Se Deconnecter
    Sleep    2s