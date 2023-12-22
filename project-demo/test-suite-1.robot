*** Settings ***
Library           SeleniumLibrary

*** variables ***
${BROWSER}     chrome
${HOST}    http://127.0.0.1:8000/login

${EMAIL}    demo@mail.net
${PASS-1}    admin123    # correct password
${PASS-2}    xxs12s2    # wrong password

${COMPANY}    global.inc
${TITLE}    [TEST] Testing SPK berbasis Web
${LOCATION}     Singapore
${TAGS}    engineering manager software
${JOBEMAIL}    jobs@global.co
${WEBSITE}    https://global.co
${DESCRIPTION}     Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. 

*** Test Cases ***

# login
# positive test
testcase-1
    Open Browser    ${HOST}    ${BROWSER}
    Page Should Contain Element   xpath://input[@id='email']
    input text        name:email       ${EMAIL}
    input text        name:password    ${PASS-1}
    Click Element     xpath://button[@class='btn btn-primary btn-user btn-block']
    Close Browser     

# negative test
testcase-2
    Open Browser    ${HOST}    ${BROWSER}
    Page Should Contain Element   xpath://input[@id='email']
    input text        name:email       ${EMAIL}
    input text        name:password    ${PASS-2}
    Click Element     xpath://button[@class='btn btn-primary btn-user btn-block']
    Close Browser 

# logout
testcase-3
    Open Browser    ${HOST}    ${BROWSER}
    Page Should Contain Element   xpath://input[@id='email']
    input text        name:email       ${EMAIL}
    input text        name:password    ${PASS-1}
    Click Element     xpath://button[@class='btn btn-primary btn-user btn-block']
    Click Element     xpath://a[@class='nav-link dropdown-toggle']
    Click Element     xpath://a[@data-target='#logoutModal']
    Submit Form

*** Keywords ***

Scroll Down Until End
    ${previous_height}=    Execute Javascript    return document.body.scrollHeight;
    FOR  ${i}    IN RANGE    10
        Execute Javascript    window.scrollTo(0, document.body.scrollHeight);
        Sleep    1s
        ${current_height}=    Execute Javascript    return document.body.scrollHeight;
        Exit For Loop If    '${current_height}' == '${previous_height}'
        ${previous_height}=    Set Variable    ${current_height}
        Sleep    2s
    END

Login Success
    Open Browser    ${HOST}    ${BROWSER}
    Click Element     xpath://a[@href='/login']
    Page Should Contain Element   xpath://input[@name='email']
    input text        name:email       ${EMAIL}
    input text        name:password    ${PASS-1}
    Click Element     xpath://button[@type='submit']
    Page Should Contain Element   xpath://a[@href='/listings/manage']