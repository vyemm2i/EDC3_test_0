*** Settings ***
Documentation       Step Definitions Connexion

Resource            ${CURDIR}/../page-objects/PageConnexion.resource
Resource            ${CURDIR}/../page-objects/MfaConnexion.resource

*** Variables ***
${JSON_FILE_PATH}    ${CURDIR}/path/to/data-part.json

*** Keywords ***
Charger Donnees Compte
    [Documentation]    Charger les données depuis le fichier JSON

    [Arguments]    ${compte}
    ${data}=    Load JSON From File    ${JSON_FILE_PATH}

    ${compte_0}=    Get From Dictionary    ${data}    ${compte}
    Log To Console    Compte : ${compte}
    [Return]    ${compte_0}

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
    PageConnexion.Check Connection Ok   Mes Comptes

*** Keywords ***
Verifier Connexion Ko
    [Arguments]    ${compte}
    Log To Console    Verifier Connexion Ko ${compte}[username]
    PageConnexion.Check Connection Ko    Email ou mot de passe incorrect

Se Connecter Avec 2FA
    [Documentation]    Se Connecter avec 2FA
    [Arguments]    ${compte}
    Log To Console    Se connecter avec 2fa ${compte}[username]
    MfaConnexion.Verifier Page 2FA    Vérification en 2 étapes
    MfaConnexion.Entrer Code 2FA    ${compte}[code]
    MfaConnexion.Verifier Code 2FA

Se Deconnecter
    [Documentation]    Se Deconnecter
    Log To Console    Se Deconnecter
    PageConnexion.Sign Out
