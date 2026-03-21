*** Settings ***
Documentation       Step Definitions Facture

Resource            ${CURDIR}/../page-objects/PageFactures.resource


*** Keywords ***

Direction Virement
    SeleniumLibrary.Click Element    ${LOCATOR_BUTTON_PAGE_FACTURE}


Verifier Factures A Payer
    Parcourir Factures A Payer    ${LOCATOR_PENDING_BILLS}


Verifier Factures Payees


    Parcourir Factures Payees    ${LOCATOR_PAID_BILLS}


Payer Facture
    [Arguments]    ${intitule_facture}

    # Vérifier que la liste des factures à payer est présente
    Wait Until Page Contains Element    ${LOCATOR_PENDING_BILLS}    timeout=10s
    Page Should Contain Element    ${LOCATOR_PENDING_BILLS}

    # Compter le nombre de factures en attente
    ${count}=    Get Element Count    ${LOCATOR_PENDING_BILLS}
    Log To Console    Nombre de factures en attente : ${count}

    IF    ${count} > 0

        # Boucle pour parcourir chaque facture
        FOR    ${i}    IN RANGE    1    ${count+1}

            # Récupérer l'intitulé de la facture (fournisseur)
            ${fournisseur}=    Get Text    xpath=(//div[@class='bill-item'])[${i}]//span[@class='bill-provider']
            Log To Console    Vérification de la facture ${i} : Fournisseur: ${fournisseur}

            # Si l'intitulé du fournisseur correspond, cliquer sur le bouton "Payer" et sortir
            IF    '${fournisseur}' == '${intitule_facture}'
                Click Element    xpath=(//div[@class='bill-item'])[${i}]//button[contains(., 'Payer')]
                Log To Console    Facture "${fournisseur}" sélectionnée pour le paiement
                RETURN
            END

        END

        Fail    Facture "${intitule_facture}" introuvable dans les factures à payer

    ELSE
        Fail    Aucune facture à payer trouvée
    END