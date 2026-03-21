*** Settings ***
Documentation       Suite DigitalBank

Resource            ${CURDIR}/../BaseTests.resource
Resource            ${CURDIR}/../step-defs/StepConnexion.resource
Resource            ${CURDIR}/../step-defs/StepConsultation.resource
Resource            ${CURDIR}/../step-defs/StepVirement.resource
Resource            ${CURDIR}/../step-defs/StepFacture.resource
Resource            ${CURDIR}/../step-defs/StepPaiement.resource


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

${INTITULE_FACTURE}    Assurance Auto
${REFERENCE_FACTURE}    AXA-2025-112233
${MONTANT_FACTURE}    89.00 €



*** Test Cases ***

# Cas N°1 (CAS-PASSANT) : Verifier factures
Verifier Factures Comptes 1 
    [Documentation]    Verifier Factures Comptes 1
    ${compte_1}=    Charger Donnees Compte    compte_1
    StepConnexion.Se Connecter    ${compte_1}
    Sleep    2s
    StepConnexion.Verifier Connexion Ok    ${compte_1}
    Sleep    2s
    StepConsultation.Verifier Solde Total    ${MONTANT_TOTAL_COMPTE_1}
    StepConsultation.Verifier Montants Comptes    ${MONTANT_COMPTE_COURANT_COMPTE_1}    ${MONTANT_LIVRET_A_COMPTE_1}

    StepFacture.Direction Virement
    StepFacture.Verifier Factures A Payer
    StepFacture.Payer Facture    ${INTITULE_FACTURE}
    StepPaiement.Verifier Contenu Page Confirmation Paiement
    Sleep    3s
    StepPaiement.Verifier Resume Paiement    ${INTITULE_FACTURE}    ${REFERENCE_FACTURE}    ${MONTANT_FACTURE}
    Sleep    3s
    StepPaiement.Confirmer Paiement

    StepFacture.Verifier Factures Payees
    Sleep    3s

    StepConnexion.Se Deconnecter

    