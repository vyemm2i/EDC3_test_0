*** Settings ***
Documentation       Suite DigitalBank

Resource            ${CURDIR}/../BaseTests.resource
Resource            ${CURDIR}/../step-defs/StepConnexion.resource
Resource            ${CURDIR}/../step-defs/StepConsultation.resource
Resource            ${CURDIR}/../step-defs/StepVirement.resource


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

${NOM_BENEFICIAIRE}    Marc Bernard
${MONTANT_2}    100
${MOTIF_2}    Remboursement essence


${MONTANT_1}    100
${MOTIF_1}    Economie

*** Test Cases ***

# Cas N°1 (CAS-PASSANT) : Virement avec compte sans Mfa vers Livret A
Verifier Virement Comptes 1 CC Vers Livret A Ok
    [Documentation]    Verifier Virement Comptes 1 CC Vers Livret A Ok
    ${compte_1}=    Charger Donnees Compte    compte_1
    StepConnexion.Se Connecter    ${compte_1}
    Sleep    2s
    StepConnexion.Verifier Connexion Ok    ${compte_1}
    Sleep    2s
    StepConsultation.Verifier Solde Total    ${MONTANT_TOTAL_COMPTE_1}
    StepConsultation.Verifier Montants Comptes    ${MONTANT_COMPTE_COURANT_COMPTE_1}    ${MONTANT_LIVRET_A_COMPTE_1}

    StepVirement.Direction Virement
    StepVirement.Selectionner Depuis Compte Courant
    Sleep    2s
    StepVirement.Selectionner Vers Livret A
    Sleep    2s
    StepVirement.Saisir Montant    ${MONTANT_1}    ${MOTIF_1}
    Sleep    5s
    StepVirement.Effectuer Virement
    StepVirement.Verifier Pop Up Message    Virement effectué avec succès !
    StepConnexion.Se Deconnecter


# Cas N°2 (CAS-PASSANT) : Virement avec compte sans Mfa vers Compte tiers
Verifier Virement Comptes 1 CC Vers Tiers Ok
    [Documentation]    Verifier Virement Comptes 1 CC Vers Tiers Ok
    ${compte_1}=    Charger Donnees Compte    compte_1
    StepConnexion.Se Connecter    ${compte_1}
    Sleep    2s
    StepConnexion.Verifier Connexion Ok    ${compte_1}
    Sleep    2s
    StepConsultation.Verifier Solde Total    ${MONTANT_TOTAL_COMPTE_1}
    StepConsultation.Verifier Montants Comptes    ${MONTANT_COMPTE_COURANT_COMPTE_1}    ${MONTANT_LIVRET_A_COMPTE_1}

    StepVirement.Direction Virement
    StepVirement.Selectionner Vers Un Tiers
    StepVirement.Selectionner Depuis Compte Courant
    Sleep    2s
    StepVirement.Selectionner Beneficiaire Pour Virement    ${NOM_BENEFICIAIRE}
    Sleep    2s
    StepVirement.Saisir Montant    ${MONTANT_2}    ${MOTIF_2}
    Sleep    5s
    StepVirement.Effectuer Virement
    StepVirement.Verifier Pop Up Message    Virement effectué avec succès !
    StepConnexion.Se Deconnecter