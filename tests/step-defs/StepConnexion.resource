*** Settings ***
Documentation       Step Definitions Connexion

Resource            ${CURDIR}/../page-objects/PageConnexion.resource

*** Variables ***
${JSON_FILE_PATH}    ${CURDIR}/path/to/data-part.json

*** Keywords ***
Charger Donnees Compte
    [Documentation]    Charger les données depuis le fichier JSON
    ${data}=    Load JSON From File    ${JSON_FILE_PATH}
    ${compte_1}=    Get From Dictionary    ${data}    compte_1
    [Return]    ${compte_1}

*** Keywords ***
Se Connecter
    [Documentation]    Se Connecter
    [Arguments]    ${compte}
    Log To Console    Se connecter ${compte}[username]
    PageConnexion.Set Username    ${compte}[username]
    PageConnexion.Set Password    ${compte}[password]
    PageConnexion.Sign In

Verifier Connexion Ok
    [Documentation]    Verifier Connexion Ok
    [Arguments]    ${compte}
    Log To Console    Verifier Connexion Ok ${compte}[username]
    # Check Connection    Bienvenue formation admin
    BasePages.Check Connection    Mes Comptes

#Verifier Connexion Ko
#    [Documentation]    Verifier Connexion Ko
#    ...    CNX_ERROR_00001 identifiant invalide
#    ...    CNX_ERROR_00003 compte bloqué
#    [Arguments]    ${code_erreur}
#    Log To Console    Verifier Connexion Ko
#    BasePages.Check Popup Message    ${TRANSLATE}[exception][connexion][${code_erreur}]

Se Deconnecter
    [Documentation]    Se Deconnecter
    Log To Console    Se Deconnecter
    BasePages.Log Off
