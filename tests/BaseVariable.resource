*** Settings ***
Documentation       variables pour le run configuration


*** Variables ***
# Les valeurs par défaut lors du développement à ne pas modifier ici
# Faites les modification soit dans le "launch.json" soit dans votre ligne de commande de lancement des tests
${BROWSER}              chrome    # chrome | chromemobileemulation | edge | firefox
${BROWSER_HEADLESS}     no    # no | yes
${IMPLICIT_WAIT}        5s
${ENV}    TEST    # Ou dev, prod selon ton environnement

${FILENAME}             ${EMPTY}