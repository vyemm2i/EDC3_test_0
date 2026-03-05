*** Settings ***

Resource    ${CURDIR}/../BaseLibrary.resource
Resource    ${CURDIR}/../BaseSelenium.resource


*** Variables ***
${LOCATOR_LINK_LOGO}        css=.logo
${LOCATOR_CHECK_CONNECTION}    xpath=//button[contains(text(), "Mes Comptes")]
${LOCATOR_BUTTON_DISCONNECTION}      xpath=//button[@id="btn-logout"]
${LOCATOR_CHECK_LOGIN}    xpath=//p[@class="login-subtitle" and contains(text(), "Connectez-vous à votre espace")]
# A CHANGER PROCHAINEMENT
#${LOCATOR_ALERT_DIALOG}     xpath=//div[@role="alertdialog"]
#${LOCATOR_BUTTON_CONFIG}    id=adminConfig


*** Keywords ***
Check Connection
    [Arguments]    ${texte}
    SeleniumLibrary.Wait Until Page Contains Element    ${LOCATOR_CHECK_CONNECTION}
    ${actual_text}    SeleniumLibrary.Get Text    ${LOCATOR_CHECK_CONNECTION}
    Log To Console    Texte attendu : ${texte}
    Log To Console    Texte récupéré : ${actual_text}
    Run Keyword And Continue On Failure    Should Be Equal    ${texte}    ${actual_text}

#Check Popup Message
#    [Arguments]    ${texte}
#    SeleniumLibrary.Wait Until Element Contains    ${LOCATOR_ALERT_DIALOG}    ${texte}
#    SeleniumLibrary.Click Element    ${LOCATOR_ALERT_DIALOG}
#    SeleniumLibrary.Set Selenium Implicit Wait    0
#    SeleniumLibrary.Wait Until Page Does Not Contain Element    ${LOCATOR_ALERT_DIALOG}
#    [Teardown]    SeleniumLibrary.Set Selenium Implicit Wait    ${IMPLICIT_WAIT}

#Access Config
#    SeleniumLibrary.Click Element    ${LOCATOR_BUTTON_CONFIG}

Log Off
    SeleniumLibrary.Click Element    ${LOCATOR_BUTTON_DISCONNECTION}
    SeleniumLibrary.Wait Until Page Contains Element    ${LOCATOR_CHECK_LOGIN}

#Return Home Page
#    SeleniumLibrary.Click Element    ${LOCATOR_LINK_LOGO}
#    SeleniumLibrary.Wait Until Page Contains Element    css=.OC_home-banner
