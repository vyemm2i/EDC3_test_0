*** Settings ***
Documentation       variables pour le run configuration

Resource            ${CURDIR}/data-env/env.resource

Resource            BaseLibrary.resource

*** Variables ***
# Les valeurs par défaut lors du développement à ne pas modifier ici
# Faites les modification soit dans le "launch.json" soit dans votre ligne de commande de lancement des tests
${BROWSER}              %{VAR_ENV_NAVIGATEUR=chrome}    # chrome | chromemobileemulation | edge | firefox
${BROWSER_HEADLESS}     yes    # no | yes
${IMPLICIT_WAIT}        5s
${ENV}    TEST    # Ou dev, prod selon ton environnement

${FILENAME}             ${EMPTY}