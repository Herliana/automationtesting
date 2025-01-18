*** Settings ***
Library     RequestsLibrary
Library     JSONLibrary
Library     Collections
Library     String

*** Variable ***
${BASE_URL}    https://petstore.swagger.io

*** Keywords ***
Create User Session
    [Documentation]     Step for create session user
    Create Session      userSession            ${BASE_URL}        verify=True
    Set Suite Variable   ${USER_SESSION}         userSession

Set header with Content Type ${APP_JSON}
    [Documentation]     Step for set header just 
    ${key_value}    Create Dictionary       Content-Type=${APP_JSON}
    Set Test Variable   ${STANDAR_HEADER}   ${key_value}

Get Response Object
    [Documentation]
    ${data}     Convert To String       ${RESPONSE.json()}
    ${value}    Evaluate    ${data}
    Set Test Variable       ${OBJECT}      ${value}

Load ${FILE_USER} API JSON schema
    [Documentation]
    ${json}     Load JSON From File     ${CURDIR}/SchemaObject/${FILE_USER}
    Set Test Variable   ${JSON_SCHEMA}      ${json}

Status code should be ${expected_code}
    [Documentation]     Step for validate expected code 
    ${actual_code}      Convert To String   ${OBJECT['code']}
    Should Be Equal     ${actual_code}      ${expected_code}

Fill message should be ${expected_message}
    [Documentation]      message for id response schema
    Get Response Object
    Should Contain     '${OBJECT['message']}'       ${expected_message}