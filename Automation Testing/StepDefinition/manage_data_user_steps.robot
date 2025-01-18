*** Settings ***
Library     RequestsLibrary
Library     JSONLibrary
Library     Collections
Resource    ../resources.robot

*** Variable ***
${APP_JSON}                application/json
${FILE_CREATE_USER}        create_user_schema.json
${FILE_UPDATE_USER}        update_user_schema.json
${BASE_URL}                https://petstore.swagger.io
${URI_CREATE_USER}         v2/user/createWithList
${URI_USER}                v2/user

*** Keywords ***
User want to create user with ${id} ${username} ${firstName} ${lastName} ${email} ${password} ${phone} ${userStatus}
   [Documentation]     Step to set header with create user
   Set header with Content Type ${APP_JSON}
   Load ${FILE_CREATE_USER} API JSON schema
   ${id}              Convert To Integer           ${id} 
   ${userStatus}      Convert To Integer           ${userStatus} 
   ${value}    Update Value to Json    ${JSON_SCHEMA}  $..id                   ${id}
   ${value}    Update Value to Json    ${JSON_SCHEMA}  $..username             ${username}
   ${value}    Update Value to Json    ${JSON_SCHEMA}  $..firstName            ${firstName}
   ${value}    Update Value to Json    ${JSON_SCHEMA}  $..lastName             ${lastName}
   ${value}    Update Value to Json    ${JSON_SCHEMA}  $..email                ${email}
   ${value}    Update Value to Json    ${JSON_SCHEMA}  $..password             ${password}
   ${value}    Update Value to Json    ${JSON_SCHEMA}  $..phone                ${phone}
   ${value}    Update Value to Json    ${JSON_SCHEMA}  $..userStatus           ${userStatus}
   Set Test Variable       ${JSON_VALUE}       ${value}
   ${response}   POST On Session    ${USER_SESSION}     url=${BASE_URL}/${URI_CREATE_USER}  headers=${STANDAR_HEADER}    json=${JSON_VALUE}      expected_status=any
   Set Test Variable    ${RESPONSE}   ${response}
   Get Response Object

Response create user ${code_success} ${expected_message}
   [Documentation]     Steps to describe what responses get from create user
   Get Response Object
   Status code should be ${code_success}
   Should Contain     '${OBJECT['message']}'       ${expected_message}

User want to get user with ${user}
   [Documentation]     Step to get user
   Set header with Content Type ${APP_JSON}
   ${response}         GET On Session  ${USER_SESSION}     url=${BASE_URL}/${URI_USER}/${user}   headers=${STANDAR_HEADER}    expected_status=any
   Set Test Variable       ${RESPONSE}      ${response}

Success get user with response ${expected_code} ${expected_user}
   [Documentation]     Steps to validate response get user
   Get Response Object
   ${id}                   Convert To String                ${OBJECT['id']}
   ${userStatus}           Convert To String                ${OBJECT['userStatus']}
   Should Be Equal         ${expected_user}                 ${OBJECT['username']}
   Should Not Be Empty     ${id}
   Should Not Be Empty     ${OBJECT['username']}
   Should Not Be Empty     ${OBJECT['firstName']}
   Should Not Be Empty     ${OBJECT['lastName']}
   Should Not Be Empty     ${OBJECT['email']}
   Should Not Be Empty     ${OBJECT['password']}
   Should Not Be Empty     ${OBJECT['phone']}
   Should Not Be Empty     ${userStatus}

Failed with response ${expected_code} ${expected_message}
    [Documentation]      Step to makesure response and message
    Get Response Object
    Status code should be ${expected_code}
    Fill message should be ${expected_message}

User want to update user with ${id} ${usernameBefore} ${usernameAfter} ${firstName} ${lastName} ${email} ${password} ${phone} ${userStatus}
   [Documentation]     Step to set header with update user
   Set header with Content Type ${APP_JSON}
   Load ${FILE_UPDATE_USER} API JSON schema
   ${id}              Convert To Integer           ${id} 
   ${userStatus}      Convert To Integer           ${userStatus} 
   ${value}    Update Value to Json    ${JSON_SCHEMA}  $..id                   ${id}
   ${value}    Update Value to Json    ${JSON_SCHEMA}  $..username             ${usernameAfter}
   ${value}    Update Value to Json    ${JSON_SCHEMA}  $..firstName            ${firstName}
   ${value}    Update Value to Json    ${JSON_SCHEMA}  $..lastName             ${lastName}
   ${value}    Update Value to Json    ${JSON_SCHEMA}  $..email                ${email}
   ${value}    Update Value to Json    ${JSON_SCHEMA}  $..password             ${password}
   ${value}    Update Value to Json    ${JSON_SCHEMA}  $..phone                ${phone}
   ${value}    Update Value to Json    ${JSON_SCHEMA}  $..userStatus           ${userStatus}
   Set Test Variable       ${JSON_VALUE}       ${value}
   ${response}    PUT On Session   ${USER_SESSION}     url=${BASE_URL}/${URI_USER}/${usernameBefore}  headers=${STANDAR_HEADER}    json=${JSON_VALUE}      expected_status=any
   Set Test Variable    ${RESPONSE}   ${response}
   Get Response Object

Response update user ${code_success}
   [Documentation]     Steps to describe what responses get from update user
   Get Response Object
   Status code should be ${code_success}
   Should Not Be Empty   ${OBJECT['message']}