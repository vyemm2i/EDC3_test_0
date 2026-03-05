*** Settings ***
Documentation       Keywords pour le run configuration

Library             ${CURDIR}/../libs/Common.py

Resource            ${CURDIR}/BaseLibrary.resource
Resource            ${CURDIR}/BaseSelenium.resource
Resource            ${CURDIR}/data-env/env.resource


*** Keywords ***
Log Context
    [Documentation]    Log Context
    Log To Console    ${EMPTY}
    Log To Console    ================================================================== SUITE SETUP
    Log To Console    CURDIR____________\t${CURDIR}
    Log To Console    EXECDIR___________\t${EXECDIR}
    Log To Console    OUTPUT DIR________\t${OUTPUT DIR}
    Log To Console    ENV_______________\t${ENV}
    Log To Console    BROWSER___________\t${BROWSER}
    Log To Console    BROWSER_HEADLESS__\t${BROWSER_HEADLESS}
    Log To Console    URL_______________\t${URL_DIGITALBANK_TEST}
    Log To Console    ${EMPTY}

Suite Setup
    [Documentation]    Suite Setup
    Log Context
    RequestsLibrary.GET    ${URL_DIGITALBANK_${ENV}}    expected_status=200
    Set Log Level    NONE

Test Setup
    [Documentation]    Test Setup
    Log To Console    ${EMPTY}
    Log To Console    ================================================================== TEST SETUP

    #${TEST NAME} est une variable interne de Robot Framework qui contient le nom du test en cours d’exécution.
    #Sert à nommer nos fichier en sortie comme artéfacts
    ${filename}    Common.Clean String Filename    ${TEST NAME}_Env_${ENV}_${BROWSER}_
    Set Global Variable    ${FILENAME}    ${filename}

    Register Keyword To Run On Failure    NONE
    Run Keyword    Open${BROWSER}
    Set Selenium Implicit Wait    ${IMPLICIT_WAIT}
    Maximize Browser Window

Test Teardown
    [Documentation]    Test Teardown
    # Prend une capture d'écran avec un nom dynamique basé sur l’état du test.
    # Cela permet d’avoir un fichier de capture qui indique si le test a passé ou échoué.
    # Le ${TEST_STATUS} fait référence à une variable automatique de Robot Framework qui contient l’état de l’exécution du test.
    # PASS si le test a réussi.
    # FAIL si le test a échoué.
    Capture Step ScreenShot    ${TEST_STATUS}
    Close Browser

Suite Teardown
    [Documentation]    Suite Teardown
    Log To Console    ${EMPTY}
