*** Settings ***
Documentation       Step Definitions Consultation

Resource            ${CURDIR}/../page-objects/PageVirement.resource


*** Keywords ***
Selectionner Beneficiaire Pour Virement
    [Arguments]    ${nom_recherche}

    # Vérifie que la liste des bénéficiaires est présente
    Wait Until Page Contains Element    ${LOCATOR_CHECK_BENEFICIAIRES}    timeout=10s
    Page Should Contain Element    ${LOCATOR_CHECK_BENEFICIAIRES}

    # Compte le nombre de bénéficiaires
    ${count}=    Get Element Count    ${LOCATOR_CHECK_BENEFICIAIRES}
    Log To Console    Nombre de bénéficiaires : ${count}

    IF    ${count} > 0

        FOR    ${i}    IN RANGE    1    ${count+1}

            # Récupère le nom du bénéficiaire courant
            ${nom}=    Get Text
            ...    xpath=(//div[@data-testid="beneficiary-list"]//div[contains(@class,"beneficiary-option")])[${i}]//div[contains(@class,"beneficiary-name")]

            Log To Console    Vérification du bénéficiaire ${i} : ${nom}

            # Si le nom correspond, clique sur le bénéficiaire et quitte
            IF    '${nom}' == '${nom_recherche}'
                Click Element
                ...    xpath=(//div[@data-testid="beneficiary-list"]//div[contains(@class,"beneficiary-option")])[${i}]
                Log To Console    Bénéficiaire "${nom_recherche}" sélectionné
                RETURN
            END

        END

        Fail    Bénéficiaire "${nom_recherche}" introuvable

    ELSE
        Fail    Aucun bénéficiaire trouvé
    END


Saisir Montant
    [Documentation]    Saisir le montant
    [Arguments]    ${montant}    ${motif}
    Log To Console    SAISI DU MONTANT ${montant}
    PageVirement.Set Montant    ${montant}
    PageVirement.Set Motif    ${motif}


Direction Virement
    SeleniumLibrary.Click Element    ${LOCATOR_BUTTON_PAGE_VIREMENT}


Selectionner Vers Un Tiers
    SeleniumLibrary.Click Element    ${LOCATOR_BUTTON_VERSUNTIERS}


Selectionner Vers Livret A
    [Documentation]    Sélectionne l'option contenant "Livret A" 
    SeleniumLibrary.Click Element    ${LOCATOR_SELECT_VIREMENT_VERSLECOMPTE}
    SeleniumLibrary.Click Element    ${LOCATOR_OPTION_VIREMENT_VERS_LIVRETA}


Selectionner Depuis Compte Courant
    [Documentation]    Sélectionne l'option contenant "Compte Courant" 
    SeleniumLibrary.Click Element    ${LOCATOR_SELECT_VIREMENT_APARTIRDUCOMPTE}
    SeleniumLibrary.Click Element    ${LOCATOR_OPTION_VIREMENT_DU_CC}

Selectionner Depuis Livret A
    [Documentation]    Sélectionne l'option contenant "Livret A" 
    SeleniumLibrary.Click Element    ${LOCATOR_SELECT_VIREMENT_APARTIRDUCOMPTE}
    SeleniumLibrary.Click Element    ${LOCATOR_OPTION_VIREMENT_DU_LIVRETA}


Effectuer Virement
    SeleniumLibrary.Click Element    ${LOCATOR_BUTTON_VIREMENT}


Verifier Pop Up Message
    [Arguments]    ${texte}
    # Attendre que l'élément contenant le texte exact soit visible
    SeleniumLibrary.Wait Until Element Is Visible    ${LOCATOR_MESSAGE_VIREMENT_SUCCES}    10s
    # Vérifier que le texte attendu est dans l'élément
    SeleniumLibrary.Wait Until Element Contains    ${LOCATOR_MESSAGE_VIREMENT_SUCCES}    Virement effectué avec succès !    10s
    # Réinitialiser l'attente implicite
    SeleniumLibrary.Set Selenium Implicit Wait    0
    # Attendre que l'élément disparaisse
    SeleniumLibrary.Wait Until Element Is Not Visible    ${LOCATOR_MESSAGE_VIREMENT_SUCCES}    10s
    [Teardown]    SeleniumLibrary.Set Selenium Implicit Wait    ${IMPLICIT_WAIT}