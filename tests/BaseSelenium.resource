*** Settings ***
Documentation       Keyword de base de selenium

Library             OperatingSystem
Library             SeleniumLibrary

Resource            BaseVariable.resource


*** Keywords ***
Openchrome
    [Documentation]    Openchrome
    ${options}    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${options}    add_argument    incognito
    Call Method    ${options}    add_argument    disable-search-engine-choice-screen
    ${excludeSwitches}    Create List    enable-automation    enable-logging    disable-popup-blocking
    Call Method    ${options}    add_experimental_option    excludeSwitches    ${excludeSwitches}
    IF    '''${BROWSER_HEADLESS}'''.upper() == 'YES'
        Call Method    ${options}    add_argument    headless
    END
    Open Browser
    ...    url=${URL_DIGITALBANK_${ENV}}
    ...    browser=chrome
    ...    options=${options}

Openchromemobileemulation
    [Documentation]    Openchromemobileemulation
    ${options}    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    &{mobile_emulation}    Create Dictionary    deviceName=Nexus 7
    Call Method    ${options}    add_experimental_option    mobileEmulation    ${mobile_emulation}
    Call Method    ${options}    add_argument    incognito
    ${excludeSwitches}    Create List    enable-automation    enable-logging    disable-popup-blocking
    Call Method    ${options}    add_experimental_option    excludeSwitches    ${excludeSwitches}
    IF    '''${BROWSER_HEADLESS}'''.upper() == 'YES'
        Call Method    ${options}    add_argument    headless
    END
    Open Browser
    ...    url=${URL_DIGITALBANK_${ENV}}
    ...    browser=chrome
    ...    options=${options}

Openedge
    [Documentation]    Openedge
    ${options}    Evaluate    sys.modules['selenium.webdriver'].EdgeOptions()    sys, selenium.webdriver
    Call Method    ${options}    add_argument    incognito
    IF    '''${BROWSER_HEADLESS}'''.upper() == 'YES'
        Call Method    ${options}    add_argument    headless
    END
    Open Browser
    ...    url=${URL_OPENCRUISE_${ENV}}
    ...    browser=edge
    ...    options=${options}

Openfirefox
    [Documentation]    Openfirefox
    ${options}    Evaluate    sys.modules['selenium.webdriver'].FirefoxOptions()    sys, selenium.webdriver
    # Call Method    ${options}    add_argument    private
    ${firefox}    Set Variable If    '''${BROWSER_HEADLESS}'''.upper() == 'YES'    headlessfirefox    firefox
    Open Browser
    ...    url=${URL_OPENCRUISE_${ENV}}
    ...    browser=${firefox}
    ...    options=${options}

Capture Step ScreenShot
    [Documentation]    Capture avec règle de nommage du fichier
    ...    Le step permet d'identifier l'étape et de faire plusieurs captures par test
    [Arguments]    ${step}
    SeleniumLibrary.Capture Page Screenshot    ${OUTPUT DIR}${/}${FILENAME}_${step}.png
    IF    '''${step}''' == 'FAIL'
        ${html}    SeleniumLibrary.Get Source
        OperatingSystem.Create File
        ...    path=${OUTPUT DIR}${/}${FILENAME}_${step}.html
        ...    content=${html}
        ...    encoding=UTF-8
    END

Capture Step Element ScreenShot
    [Documentation]    Capture avec règle de nommage du fichier
    ...    Le step permet d'identifier l'étape et de faire plusieurs captures par test
    [Arguments]    ${step}    ${locator}
    SeleniumLibrary.Capture Element Screenshot    ${locator}    ${OUTPUT DIR}${/}${FILENAME}_${step}.png