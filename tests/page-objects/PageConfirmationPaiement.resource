*** Settings ***
Resource    ${CURDIR}/BasePages.resource


*** Variables ***

# BUTTONS
${LOCATOR_BUTTON_ANNULER_PAIEMENT}    xpath=//button[@id="btn-cancel-payment" and contains(., "Annuler")]

${LOCATOR_BUTTON_CONFIRMER_PAIEMENT}    xpath=//button[@id="btn-confirm-payment" and contains(., "Confirmer le paiement")]


# CHECKS DE PRESENCE 

${LOCATOR_RESUME_CONFIRMATION_PAIEMENT}    xpath=//div[@id='payment-summary']

${LOCATOR_CHECK_PAGE_CONFIRMATION_PAIEMENT}    xpath=//h3[contains(., "Confirmer le paiement")]

${LOCATOR_CHECK_CONFIRMATION_PAIEMENT}    xpath=//p[contains(., "Vous êtes sur le point de payer la facture suivante :")]



# ATTENTION IL Y A UN MESSAGE : Facture INTITULE effectué avec succès