*** Settings ***
Resource    ${CURDIR}/BasePages.resource


*** Variables ***

# BUTTONS
${LOCATOR_BUTTON_PAGE_VIREMENT}    xpath=//button[contains(., "Virements")]

${LOCATOR_BUTTON_ENTREMESCOMPTES}    xpath=//button[contains(., "Entre mes comptes")]

${LOCATOR_BUTTON_VERSUNTIERS}    xpath=//button[contains(., "Vers un tiers")]

${LOCATOR_BUTTON_VIREMENT}    xpath=//button[contains(., "Effectuer le virement")]

# CHECKS DE PRESENCE 
${LOCATOR_CHECK_PARTIE_VIREMENT}    xpath=//h2[contains(., "Effectuer un virement")]

${LOCATOR_CHECK_LABEL_COMPTEDEBITEUR}    xpath=//label[contains(., "Compte débiteur")]

${LOCATOR_CHECK_LABEL_MONTANT}    xpath=//label[contains(.,"Montant (€)")]

${LOCATOR_CHECK_LABEL_MOTIF}    xpath=//label[contains(.,"Motif (optionnel)")]

# INPUTS
${LOCATOR_INPUT_MONTANT}    xpath=//input[@id= "amount"]

${LOCATOR_INPUT_MOTIF}    xpath=//input[@id= "description"]



#------ ENTRE COMPTES PROPRES------

# LISTE DEROULANTE SELECT
${LOCATOR_SELECT_VIREMENT_APARTIRDUCOMPTE}    xpath=//select[@id="from-account"]

${LOCATOR_SELECT_VIREMENT_VERSLECOMPTE}    xpath=//select[@id="to-account"]

# OPTIONS
${LOCATOR_OPTION_VIREMENT_DU_CC}    xpath=//select[@id="from-account"]/option[contains(., "Compte Courant")]

${LOCATOR_OPTION_VIREMENT_DU_LIVRETA}    xpath=//select[@id="from-account"]/option[contains(., "Livret A")]

${LOCATOR_OPTION_VIREMENT_PARDEFAUT}    xpath=//select[@id="to-account"]/option[contains(., "Sélectionner un compte")]

${LOCATOR_OPTION_VIREMENT_VERS_LIVRETA}    xpath=//select[@id="to-account"]/option[contains(., "Livret A")]

# CHECKS DE PRESENCE 
${LOCATOR_CHECK_LABEL_COMPTECREDITEUR}    xpath=//label[contains(., "Compte créditeur")]



#------ ENTRE COMPTES TIERS ------

# BUTTONS
${LOCATOR_BUTTON_AJOUT_BENEFICIAIRE}    xpath=//button[@id="btn-add-beneficiary"]

# CHECKS DE PRESENCE
${LOCATOR_CHECK_LABEL_BENEFICIAIRE}    xpath=//label[contains(., "Bénéficiaire")]

${LOCATOR_CHECK_BENEFICIAIRES}        xpath=//div[@data-testid="beneficiary-list"]//div[contains(@class,"beneficiary-option")]

${LOCATOR_CHECK_NOM_BENEFICIAIRE}    xpath=.//div[contains(@class,"beneficiary-name")]

${LOCATOR_CHECK_IBAN_BENEFICIAIRE}    xpath=.//div[contains(@class,"beneficiary-iban")]

# ERROR
${LOCATOR_ERROR_SOLDE_INSUFFISANT}    xpath=//div[@id="transfer-error" and contains(., "Solde insuffisant pour effectuer ce virement")]


# POP UP MESSAGES
${LOCATOR_MESSAGE_VIREMENT_SUCCES}    xpath=//div[@id="transfer-success"] 




*** Keywords ***
Set Montant
    [Arguments]    ${montant}
    SeleniumLibrary.Input Text    ${LOCATOR_INPUT_MONTANT}    ${montant}

Set Motif
    [Arguments]    ${motif}
    SeleniumLibrary.Input Text    ${LOCATOR_INPUT_MOTIF}    ${motif}


