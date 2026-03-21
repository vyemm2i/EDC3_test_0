*** Settings ***
Resource    ${CURDIR}/BasePages.resource


*** Variables ***
# BUTTONS
${LOCATOR_BUTTON_PAGE_FACTURE}    xpath=//button[contains(., "Factures")]


# CHECKS DE PRESENCE 
${LOCATOR_CHECK_PARTIE_FACTURES_A_PAYER}    xpath=//h2[contains(., "Factures à payer")]

${LOCATOR_CHECK_PARTIE_FACTURES_PAYEES}    xpath=//h3[contains(., "Factures payées")]


# Liste/Nombre de factures en attente
${LOCATOR_PENDING_BILLS}   xpath=//div[@data-testid='pending-bills']//div[@class='bill-item']

# Liste/Nombre de factures payées

${LOCATOR_PAID_BILLS}    xpath=//div[@data-testid='paid-bills']//div[@class='bill-item']


# Intitulé de chaque factures
${LOCATOR_BILL_PROVIDER}   xpath=//span[@class='bill-provider']

# Réference de chaque facture
${LOCATOR_BILL_REFERENCE}  xpath=//span[@class='bill-reference']

# Echeance de chaque facture
${LOCATOR_BILL_DUE}        xpath=//span[@class='bill-due']

# Montant de la facture
${LOCATOR_BILL_AMOUNT}     xpath=//span[@class='bill-amount']





*** Keywords ***
Parcourir Factures A Payer
    [Arguments]    ${locator_pending_bills}

    # Vérifier si l'élément de la section des factures à payer est présent
    ${section_present}=    Run Keyword And Return Status    Page Should Contain Element    ${LOCATOR_CHECK_PARTIE_FACTURES_A_PAYER}

    # Si la section des factures à payer n'est pas présente, logguer un message et sortir du keyword
    Run Keyword If    not ${section_present}    Log To Console    "La section des factures à payer n'est pas présente"    RETURN

    

    # Vérifier que la page contient la liste des factures en attente
    Wait Until Page Contains Element    ${locator_pending_bills}    timeout=10s
    Page Should Contain Element    ${locator_pending_bills}

    # Compter le nombre de factures en attente
    ${count}=    Get Element Count    ${locator_pending_bills}
    Log To Console    Nombre de factures en attente : ${count}

    IF    ${count} > 0

        # Boucle pour parcourir chaque facture
        FOR    ${i}    IN RANGE    1    ${count+1}

            # Récupérer les informations de la facture (nom du fournisseur, référence, échéance, montant)
            ${intitulé}=    Get Text    xpath=(//div[@class='bill-item'])[${i}]//span[@class='bill-provider']
            ${reference}=    Get Text    xpath=(//div[@class='bill-item'])[${i}]//span[@class='bill-reference']
            ${echeance}=    Get Text    xpath=(//div[@class='bill-item'])[${i}]//span[@class='bill-due']
            ${montant}=    Get Text    xpath=(//div[@class='bill-item'])[${i}]//span[@class='bill-amount']

            # Log des informations de la facture
            Log To Console    Facture ${i}: Fournisseur: ${intitulé} | Référence: ${reference} | Échéance: ${echeance} | Montant: ${montant}

        END
    ELSE
        Log To Console    Aucune facture en attente à payer.
    END



Parcourir Factures Payees
    [Arguments]    ${locator_paid_bills}

    # Vérifier si la section des factures payées est présente
    ${section_present}=    Run Keyword And Return Status    Page Should Contain Element    ${LOCATOR_CHECK_PARTIE_FACTURES_PAYEES}

    # Si la section des factures payées n'est pas présente, sortir du keyword
    Run Keyword If    not ${section_present}    Log To Console    "La section des factures payées n'est pas présente. Sortie du keyword."    RETURN

    # Vérifier que la page contient la liste des factures payées
    Wait Until Element Is Visible    ${locator_paid_bills}    timeout=10s
    Page Should Contain Element    ${locator_paid_bills}

    # Compter le nombre de factures payées
    ${count}=    Get Element Count    ${locator_paid_bills}
    Log To Console    Nombre de factures payées : ${count}

    IF    ${count} > 0

        # Boucle pour parcourir chaque facture payée
        FOR    ${i}    IN RANGE    1    ${count+1}

            # Récupérer les informations de la facture payée (nom du fournisseur, référence, montant)
            #${intitulé}=    Get Text    xpath=(//div[@class='bill-item'])[${i}]//span[@class='bill-provider']
            ${intitulé}=    Get Text    xpath=//div[@data-testid='paid-bills']//div[@class='bill-item'][${i}]//span[@class='bill-provider']

            #${reference}=    Get Text    xpath=(//div[@class='bill-item'])[${i}]//span[@class='bill-reference']
            ${reference}=    Get Text    xpath=//div[@data-testid='paid-bills']//div[@class='bill-item'][${i}]//span[@class='bill-reference']

            #${montant}=    Get Text    xpath=(//div[@class='bill-item'])[${i}]//span[@class='bill-amount']
            ${statut}=    Get Text    xpath=//div[@data-testid='paid-bills']//div[@class='bill-item'][${i}]//span[@class='bill-status paid']




            # Attendre que la page affiche les factures payées après paiement
            Wait Until Page Contains Element    ${locator_paid_bills}    timeout=10s
            Page Should Contain Element    ${locator_paid_bills}

            # Vérifier que la facture payée a été correctement ajoutée à la liste des factures payées
            ${count_paid}=    Get Element Count    ${locator_paid_bills}
            Log To Console    Nombre de factures payées après paiement : ${count_paid}

            # Si le nombre de factures payées correspond à ce qui est attendu
            Should Be Equal As Numbers    ${count_paid}    1  # Vérifie qu'il n'y en a qu'une



            # Log des informations de la facture payée
            Log To Console    Facture payée ${i}: Intitulé: ${intitulé} | Référence: ${reference} | Montant: ${statut}

        END
    ELSE
        Log To Console    Aucune facture payée trouvée.
    END



