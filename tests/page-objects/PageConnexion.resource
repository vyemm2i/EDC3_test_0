*** Settings ***
Resource    ${CURDIR}/BasePages.resource


*** Variables ***
# Les locator peuvent se placer en variable globale mais ce n'est pas une obligation
# L'interêt est fort si un même locator est utilisé par plusieurs keywords afin de ne pas le duppliquer
# Si ce n'est pas le cas, libre à vous de définir vos bonnes pratiques
# ATTENTION, les locators contenant des variables pouvant évoluer en cours d'exécution ne pouront pas être placés en variable globale
# Exemple des locators basés sur les label de l'application soumis au changement de langue


*** Keywords ***
Set Username
    [Arguments]    ${texte}
    SeleniumLibrary.Input Text    xpath=//input[@id="email" and @type="email"]    ${texte}

Set Password
    [Arguments]    ${texte}
    SeleniumLibrary.Input Password    xpath=//input[@id="password" and @type="password"]    ${texte}

Sign In
    SeleniumLibrary.Click Element    xpath=//button[contains(text(), "Se connecter")]
