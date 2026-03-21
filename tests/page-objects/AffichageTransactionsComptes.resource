*** Settings ***
Resource    ${CURDIR}/BasePages.resource

*** Variables ***

${LOCATOR_CHECK_LAST_TRANSACTIONS}    
...    xpath=//h3[contains(@class,"card-title") and contains(.,"Dernières transactions")]

${LOCATOR_TRANSACTION_ITEMS}          
...    xpath=//div[contains(@class,"transaction-list")]//div[contains(@class,"transaction-item")]


