*** Settings ***

Resource    ${CURDIR}/../BaseLibrary.resource
Resource    ${CURDIR}/../BaseSelenium.resource


*** Variables ***
${LOCATOR_LINK_LOGO}        css=.logo
${LOCATOR_CHECK_CONNECTION_OK}    xpath=//button[contains(text(), "Mes Comptes")]
${LOCATOR_BUTTON_DISCONNECTION}      xpath=//button[@id="btn-logout"]
${LOCATOR_CHECK_LOGIN}    xpath=//p[@class="login-subtitle" and contains(text(), "Connectez-vous à votre espace")]

${LOCATOR_CHECK_CONNECTION_KO}    xpath=//div[@id="login-error"]

*** Keywords ***
Check Connection Ok
    [Arguments]    ${texte}
    SeleniumLibrary.Wait Until Page Contains Element    ${LOCATOR_CHECK_CONNECTION_OK}
    ${actual_text}    SeleniumLibrary.Get Text    ${LOCATOR_CHECK_CONNECTION_OK}
    Log To Console    Texte attendu : ${texte}
    Log To Console    Texte récupéré : ${actual_text}
    Run Keyword And Continue On Failure    Should Be Equal    ${texte}    ${actual_text}

# Ajout
Check Connection Ko
    [Arguments]    ${texte}
    # Exemple d'attente d'un message d'erreur ou d'une alerte
    SeleniumLibrary.Wait Until Page Contains Element    ${LOCATOR_CHECK_CONNECTION_KO}    timeout=10s
    ${message}    SeleniumLibrary.Get Text    ${LOCATOR_CHECK_CONNECTION_KO}
    Run Keyword And Continue On Failure    Should Be Equal    ${texte}    ${message}


Log Off
    SeleniumLibrary.Click Element    ${LOCATOR_BUTTON_DISCONNECTION}
    SeleniumLibrary.Wait Until Page Contains Element    ${LOCATOR_CHECK_LOGIN}
