*** Settings ***
Documentation       Step Definitions Consultation

Resource            ${CURDIR}/../page-objects/AffichageSoldesComptes.resource
Resource            ${CURDIR}/../page-objects/AffichageTransactionsComptes.resource

*** Keywords ***

Verifier Solde Total
    [Arguments]    ${montant}
    ${elements}=    Get WebElements    ${LOCATOR_SOLDES_COMPTES}

    ${total}=    Set Variable    0

    FOR    ${el}    IN    @{elements}
        ${txt}=    Get Text    ${el}
        ${value}=  Convertir Montant    ${txt}
        ${total}=  Evaluate    ${total} + ${value}

    END
    Log To Console    Montant attendu : ${montant}
    Log To Console    Montant récupéré : ${total}
    Should Be Equal As Numbers    ${total}    ${montant}


Verifier Montants Comptes
    [Arguments]    ${montant_compte_1}    ${montant_compte_2}
    ${cc_present}=    Run Keyword And Return Status    Page Should Contain Element    ${LOCATOR_CHECK_COMPTE_COURANT}
    ${livret_present}=    Run Keyword And Return Status    Page Should Contain Element    ${LOCATOR_CHECK_LIVRET_A}

    IF    ${cc_present}
        ${solde_cc_txt}=    Get Text    ${LOCATOR_SOLDE_COMPTE_COURANT}
        ${solde_cc}=        Convertir Montant    ${solde_cc_txt}
        Should Be True      ${solde_cc} >= 0
        Log To Console    Montant attendu : ${montant_compte_1}
        Log To Console    Montant récupéré : ${solde_cc}
        Should Be Equal As Numbers    ${solde_cc}    ${montant_compte_1}
    #AJOUT
    ELSE
        Log To Console    Pas de compte courant
    END

    IF    ${livret_present}
        ${solde_livret_txt}=    Get Text    ${LOCATOR_SOLDE_LIVRET_A}
        ${solde_livret}=        Convertir Montant    ${solde_livret_txt}
        Should Be True          ${solde_livret} >= 0
        Log To Console    Montant attendu : ${montant_compte_2}
        Log To Console    Montant récupéré : ${solde_livret}
        Should Be Equal As Numbers    ${solde_livret}    ${montant_compte_2}

    #AJOUT
    ELSE
        Log To Console    Pas de livret A
    END


Verifier Les Dernieres Transactions

    Page Should Contain Element    ${LOCATOR_CHECK_LAST_TRANSACTIONS}

    ${count}=    Get Element Count    ${LOCATOR_TRANSACTION_ITEMS}
    Log To Console    Nombre de transactions : ${count}

    IF    ${count} > 0

        FOR    ${i}    IN RANGE    1    ${count+1}

            ${title}=    Get Text
            ...    xpath=(//div[contains(@class,"transaction-list")]//div[contains(@class,"transaction-item")])[${i}]//span[contains(@class,"transaction-description")]

            ${amount}=    Get Text
            ...    xpath=(//div[contains(@class,"transaction-list")]//div[contains(@class,"transaction-item")])[${i}]//span[contains(@class,"transaction-amount")]

            Log To Console    Transaction ${i} : "${title}" = ${amount}

        END

    ELSE
        Log To Console    Aucune transaction récente
    END