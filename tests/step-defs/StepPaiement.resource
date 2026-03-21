*** Settings ***
Documentation       Step Definitions Facture

Resource            ${CURDIR}/../page-objects/PageConfirmationPaiement.resource



*** Keywords ***

Verifier Contenu Page Confirmation Paiement
    Wait Until Page Contains Element    ${LOCATOR_RESUME_CONFIRMATION_PAIEMENT}   timeout=10s
    Page Should Contain Element    ${LOCATOR_RESUME_CONFIRMATION_PAIEMENT}

    Page Should Contain Element    ${LOCATOR_CHECK_PAGE_CONFIRMATION_PAIEMENT}
    Page Should Contain Element    ${LOCATOR_CHECK_CONFIRMATION_PAIEMENT}

Confirmer Paiement
    SeleniumLibrary.Click Element    ${LOCATOR_BUTTON_CONFIRMER_PAIEMENT}



Verifier Resume Paiement
    [Arguments]    ${intitule}    ${reference}    ${montant}


    # Vérifier que l'intitulé du fournisseur correspond
    ${intitule_element}=    Get Text    xpath=//div[@id='payment-summary']//p[strong]
    Log To Console    Fournisseur affiché dans le résumé : ${intitule_element}
    Should Be Equal As Strings    ${intituleelement}    ${intitule}

    # Vérifier que la référence de la facture correspond
    ${reference_element}=    Get Text    xpath=//div[@id='payment-summary']//p[contains(text(), '${reference}')]
    Log To Console    Référence affichée dans le résumé : ${reference_element}
    Should Be Equal As Strings    ${reference_element}    ${reference}

    # Vérifier que le montant correspond
    ${montant_element}=    Get Text    xpath=//div[@id='payment-summary']//p[@class='summary-amount']
    Log To Console    Montant affiché dans le résumé : ${montant_element}
    Should Be Equal As Strings    ${montant_element}    ${montant}