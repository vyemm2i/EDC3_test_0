*** Settings ***

Resource    ${CURDIR}/BasePages.resource


*** Variables ***
# BUTTONS
${LOCATOR_BUTTON_MFA_VERIF}      xpath=//button[@id="btn-verify-2fa"]

# CHECKS
${LOCATOR_CHECK_MFA_LOGIN}    xpath=//h1[@class="login-title" and contains(text(), "Vérification en 2 étapes")]

*** Keywords ***

# Saisi du code pour la 2FA
Entrer Code 2FA
    [Arguments]    ${code}
    FOR    ${i}    IN RANGE    6
        ${digit}=    Get Substring    ${code}    ${i}    ${i+1}
        Input Text    xpath=//input[@class="code-input" and @data-index="${i}"]    ${digit}
    END

Verifier Page 2FA
    [Arguments]    ${text_2fa}
    SeleniumLibrary.Wait Until Page Contains Element    ${LOCATOR_CHECK_MFA_LOGIN}
    ${actual_text_2fa}    SeleniumLibrary.Get Text    ${LOCATOR_CHECK_MFA_LOGIN}
        Log To Console    Texte attendu : ${text_2FA}
        Log To Console    Texte récupéré : ${actual_text_2fa}
        Run Keyword And Continue On Failure    Should Be Equal    ${text_2fa}    ${actual_text_2fa}

Verifier Code 2FA
    SeleniumLibrary.Click Element    ${LOCATOR_BUTTON_MFA_VERIF}
    