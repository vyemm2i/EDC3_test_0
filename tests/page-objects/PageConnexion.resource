*** Settings ***
Resource    ${CURDIR}/BasePages.resource


*** Variables ***
# Les locator peuvent se placer en variable globale mais ce n'est pas une obligation


# BUTTONS
${LOCATOR_BUTTON_CONNECTION}    xpath=//button[contains(., "Se connecter")]
${LOCATOR_BUTTON_DISCONNECTION}      xpath=//button[@id="btn-logout"]

# INPUTS
${LOCATOR_INPUT_USERNAME}    xpath=//input[@id="email" and @type="email"]
${LOCATOR_INPUT_PASSWORD}    xpath=//input[@id="password" and @type="password"]

# CHECKS DE CONNEXION 
${LOCATOR_CHECK_LOGIN}    xpath=//p[@class="login-subtitle" and contains(., "Connectez-vous à votre espace")]

${LOCATOR_CHECK_CONNECTION_OK}    xpath=//button[contains(., "Mes Comptes")]
${LOCATOR_CHECK_CONNECTION_KO}    xpath=//div[@id="login-error"]



*** Keywords ***
Set Username
    [Arguments]    ${texte}
    SeleniumLibrary.Input Text    ${LOCATOR_INPUT_USERNAME}    ${texte}

Set Password
    [Arguments]    ${texte}
    SeleniumLibrary.Input Password    ${LOCATOR_INPUT_PASSWORD}    ${texte}

Sign In
    SeleniumLibrary.Click Element    ${LOCATOR_BUTTON_CONNECTION}


Sign Out
    SeleniumLibrary.Click Element    ${LOCATOR_BUTTON_DISCONNECTION}
    SeleniumLibrary.Wait Until Page Contains Element    ${LOCATOR_CHECK_LOGIN}


*** Keywords ***
Check Connection Ok
    [Arguments]    ${texte}
    SeleniumLibrary.Wait Until Page Contains Element    ${LOCATOR_CHECK_CONNECTION_OK}    10s
    ${actual_text}    SeleniumLibrary.Get Text    ${LOCATOR_CHECK_CONNECTION_OK}
    Log To Console    Texte attendu : ${texte}
    Log To Console    Texte récupéré : ${actual_text}
    Run Keyword And Continue On Failure    Should Be Equal    ${texte}    ${actual_text}

Check Connection Ko
    [Arguments]    ${texte}
    # Exemple d'attente d'un message d'erreur ou d'une alerte
    SeleniumLibrary.Wait Until Page Contains Element    ${LOCATOR_CHECK_CONNECTION_KO}    timeout=10s
    ${message}    SeleniumLibrary.Get Text    ${LOCATOR_CHECK_CONNECTION_KO}
    Run Keyword And Continue On Failure    Should Be Equal    ${texte}    ${message}