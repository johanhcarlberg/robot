*** Settings ***
Documentation    test for automationplayground.com    # info text
Library    SeleniumLibrary    # Which Library is being used

*** Variables ***
${userEmail}    JohnDoe@hotmail.com    # Dummy email
${userPass}    162534    # Dummy password

*** Test Cases ***
Scenario: Login 'Automationplayground.com'
    [Documentation]    User attempts to login 'Automationplayground.com'
    [Tags]    Login
    Set Selenium Speed    0.5    # Browser speed; lower = faster, higher = slower
    Given User Is On Login Page
    When User Inputs Their Credentials
    Then User Should Be Logged In And See The 'Our Happy Customers' Page

*** Keywords ***
User is on login page
    Open browser    browser=Chrome
    Go To    https://automationplayground.com/crm/login.html

User inputs their credentials
    Input Text    //input[@id='email-id']    ${userEmail}
    Input Password    //input[@id='password']    ${userPass}
    Click Button    //button[@id='submit-id']
    
User should be logged in and see the 'Our Happy Customers' page
    Wait Until Page Contains Element    //h2[normalize-space()='Our Happy Customers']
    Wait Until Page Contains Element    //a[@id='new-customer']