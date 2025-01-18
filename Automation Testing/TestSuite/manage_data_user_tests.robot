*** Settings ***
Documentation       API Test for user feature
Library             RequestsLibrary
Resource            ../resources.robot
Resource            ../StepDefinition/manage_data_user_steps.robot
Test Setup          Create User Session

*** Variable ***
${SUCCESS_CODE}                200
${EXPECTED_MESSAGE_CREATE}     ok

*** Test Case ***
As an User, I want to create user with valid data
    [Documentation]     Scenario for create user with valid data
    [Tags]              Positive   
    [Template]          Create user
    #id         username           firstname          lastname        email                    password            phone                userstatus  
    4           herlitesting        herli              ana             herli@yopmail.com        12345678            08123400001          1
    5           lecatesting         leca               cantik          leca@yopmail.com         11111111            08123400002          0

As an User, I want to get user
    [Documentation]     Scenario for get user
    [Tags]              Positive        
    [Template]          Get user
    #user           
    herlitesting    

As an User, I want to get user with invalid data
    [Documentation]     Scenario for get user with invalid data
    [Tags]              Negative    
    [Template]          Get user with invalid data
    #user                expected_code         expected_message
    27387128318          1                     User not found

As an User, I want to update user with valid data
    [Documentation]     Scenario for update user with valid data
    [Tags]              Positive     
    [Template]          Update user
    #id         usernamebefore         usernameafter      firstname          lastname        email                        password            phone                userstatus  
    4           herlitesting            herliupdate        herliupdatelagi     ana123         herliupdate@yopmail.com      12349875           08123400003           0
    5           lecatesting             lecaupdate12       lecaupdate          baru           lecaupd@yopmail.com          22223333           08123400006           1
       
          
*** Keywords ***
Create user
    [Documentation]    Scenario for create user
    [Arguments]        ${id}    ${username}    ${firstname}    ${lastname}    ${email}    ${password}    ${phone}    ${userstatus}
    GIVEN Create User Session
    WHEN User want to create user with ${id} ${username} ${firstname} ${lastname} ${email} ${password} ${phone} ${userstatus}
    THEN Response create user ${SUCCESS_CODE} ${EXPECTED_MESSAGE_CREATE}

Get user
    [Documentation]     Scenario for get user
    [Arguments]         ${user}
    GIVEN Create User Session
    WHEN User want to get user with ${user}
    THEN Success get user with response ${SUCCESS_CODE} ${user}

Get user with invalid data
    [Documentation]     Scenario for get user with invalid data
    [Arguments]         ${user}    ${expected_code}    ${expected_message}
    GIVEN Create User Session
    WHEN User want to get user with ${user}
    THEN Failed with response ${expected_code} ${expected_message}

Update user
    [Documentation]    Scenario for update user
    [Arguments]        ${id}    ${usernamebefore}    ${usernameafter}    ${firstname}    ${lastname}    ${email}    ${password}    ${phone}    ${userstatus}
    GIVEN Create User Session
    WHEN User want to update user with ${id} ${usernamebefore} ${usernameafter} ${firstname} ${lastname} ${email} ${password} ${phone} ${userstatus}
    THEN Response update user ${SUCCESS_CODE}


