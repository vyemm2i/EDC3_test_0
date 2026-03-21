*** Settings ***
Resource    ${CURDIR}/BasePages.resource


*** Variables ***

# CHECKS DE PRESENCE 
${LOCATOR_CHECK_SOLDE_TOTAL}    xpath= //span[@class="total-balance" and contains(text(), "Solde total: ")]

${LOCATOR_CHECK_COMPTE_COURANT}    xpath= //div[@class="balance-card-type" and contains(text(), "Compte Courant") ]

${LOCATOR_CHECK_LIVRET_A}    xpath= //div[@class="balance-card-type" and contains(text(), "Livret A") ]

${LOCATOR_SOLDES_COMPTES}    xpath=//div[contains(@class,"balance-amount")]

${LOCATOR_SOLDE_COMPTE_COURANT}    xpath=//div[contains(text(),"Compte Courant")]/following-sibling::div[2]

${LOCATOR_SOLDE_LIVRET_A}        xpath=//div[contains(text(),"Livret A")]/following-sibling::div[2]

*** Keywords ***

Convertir Montant
    [Arguments]    ${texte}

    ${montant}=    Replace String    ${texte}    €    ${EMPTY}
    ${montant}=    Replace String    ${montant}    Solde total:    ${EMPTY}
    ${montant}=    Replace String    ${montant}    ${SPACE}    ${EMPTY}
    ${montant}=    Replace String    ${montant}    ,    .

    ${montant}=    Convert To Number    ${montant}

    [Return]    ${montant}
