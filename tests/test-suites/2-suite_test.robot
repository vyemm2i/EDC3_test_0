*** Settings ***
Documentation       Suite DigitalBank

Resource            ${CURDIR}/../BaseTests.resource
Resource            ${CURDIR}/../step-defs/StepConnexion.resource
Resource            ${CURDIR}/../step-defs/StepConsultation.resource


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

${MONTANT_TOTAL_COMPTE_1}    20000
${MONTANT_COMPTE_COURANT_COMPTE_1}    5000
${MONTANT_LIVRET_A_COMPTE_1}    15000

${MONTANT_TOTAL_COMPTE_2}    8923.45
${MONTANT_COMPTE_COURANT_COMPTE_2}    8923.45
${MONTANT_LIVRET_A_COMPTE_2}    0


*** Test Cases ***

# Cas N°1 (CAS-PASSANT) : Consultation des comptes et transactions avec compte sans Mfa
Verifier Consultation Comptes Ok 1
    [Documentation]    Verifier Consultation Comptes Ok
    ${compte_1}=    Charger Donnees Compte    compte_1
    StepConnexion.Se Connecter    ${compte_1}
    Sleep    2s
    StepConnexion.Verifier Connexion Ok    ${compte_1}
    Sleep    2s
    StepConsultation.Verifier Solde Total    ${MONTANT_TOTAL_COMPTE_1}
    StepConsultation.Verifier Montants Comptes    ${MONTANT_COMPTE_COURANT_COMPTE_1}    ${MONTANT_LIVRET_A_COMPTE_1}
    StepConsultation.Verifier Les Dernieres Transactions
    StepConnexion.Se Deconnecter

# Cas N°2 (CAS-PASSANT) : Consultation des comptes et transactions avec compte Mfa
# Sur ce test nous pouvons voir qu'il y a un problème dans le contenu de texte qui se trouve dans le DOM de la page.
# On ne retrouve pas le locator car il y a pleins d'espaces dans le contenu. C'est une anomalie type mineure mais peut-être considéré comme un faux positif.

Verifier Consultation Comptes Ok Mfa
    [Documentation]    Verifier Consultation Comptes Ok
    ${compte_mfa_1}=    Charger Donnees Compte    compte_mfa_1
    StepConnexion.Se Connecter    ${compte_mfa_1}
    Sleep    2s
    StepConnexion.Se Connecter Avec 2FA    ${compte_mfa_1}
    StepConnexion.Verifier Connexion Ok    ${compte_mfa_1}
    Sleep    2s
    StepConsultation.Verifier Solde Total    ${MONTANT_TOTAL_COMPTE_2}
    StepConsultation.Verifier Montants Comptes    ${MONTANT_COMPTE_COURANT_COMPTE_2}    ${MONTANT_LIVRET_A_COMPTE_2}
    StepConsultation.Verifier Les Dernieres Transactions
    StepConnexion.Se Deconnecter