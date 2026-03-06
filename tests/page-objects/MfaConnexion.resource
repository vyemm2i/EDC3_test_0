*** Settings ***

Resource    ${CURDIR}/BasePages.resource


*** Variables ***
# BUTTONS
${LOCATOR_BUTTON_MFA_VERIF}      xpath=//button[@id="btn-verify-2fa"]

# CHECKS
${LOCATOR_CHECK_MFA_LOGIN}    xpath=//h1[@class="login-title" and contains(text(), "Vérification en 2 étapes")]
${LOCATOR_CHECK_CONNECTION_2FA_KO}    xpath=//div[@id="2fa-error"]


*** Keywords ***

# Saisi du code pour la 2FA
Entrer Code 2FA
    [Arguments]    ${code}
    FOR    ${i}    IN RANGE    6
        ${digit}=    Get Substring    ${code}    ${i}    ${i+1}
        Input Text    xpath=//input[@class="code-input" and @data-index="${i}"]    ${digit}
    END

Verifier Page 2FA
    [Arguments]    ${texte}
    SeleniumLibrary.Wait Until Page Contains Element    ${LOCATOR_CHECK_MFA_LOGIN}
    ${actual_text}    SeleniumLibrary.Get Text    ${LOCATOR_CHECK_MFA_LOGIN}
        Log To Console    Texte attendu : ${texte}
        Log To Console    Texte récupéré : ${actual_text}
        Run Keyword And Continue On Failure    Should Be Equal    ${texte}    ${actual_text}

Verifier Code 2FA
    SeleniumLibrary.Click Element    ${LOCATOR_BUTTON_MFA_VERIF}


Check Connection 2FA Ko
    [Arguments]    ${texte}
    # Exemple d'attente d'un message d'erreur ou d'une alerte
    SeleniumLibrary.Wait Until Page Contains Element    ${LOCATOR_CHECK_CONNECTION_2FA_KO}    timeout=10s
    ${message}    SeleniumLibrary.Get Text    ${LOCATOR_CHECK_CONNECTION_2FA_KO}
    Run Keyword And Continue On Failure    Should Be Equal    ${texte}    ${message}