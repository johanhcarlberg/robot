*** Settings ***
Suite Setup    Open Browser To 'Automationplayground.com' Start Page
Documentation    test for automationplayground.com    # info text
Library    SeleniumLibrary    # Which Library is being used

*** Variables ***
${userEmail}    JohnDoe@hotmail.com    # Dummy email
${userPass}    162534    # Dummy password

${newCustomerButton}    //a[@id="new-customer"]

${emailInput}    //*[@id="EmailAddress"]
${firstNameInput}    //*[@id="FirstName"]
${lastNameInput}    //*[@id="LastName"]
${cityInput}    //*[@id="City"]
${stateInput}    //*[@id="StateOrRegion"]
${genderRadioName}    gender
${genderRadioValue}    male
${addToPromotionalListChecbox}    //input[@type="checkbox" and @name="promos-name"]
${submitButton}    //button[@type="submit" and text()="Submit"]

${firstName}    John
${lastName}    Doe
${city}    Detroit
${state}    MI

*** Test Cases ***
Scenario: Login 'Automationplayground.com'
    [Documentation]    User attempts to login 'Automationplayground.com'
    [Tags]    Login
    Set Selenium Speed    0.5    # Browser speed; lower = faster, higher = slower
    Given User enter the login page
    When User Inputs Their Credentials
    Then User Should Be Logged In And See The 'Our Happy Customers' Page

Scenario: Create new customer
    [Documentation]    User attempts to create a new customer
    [Tags]    Create Customer
    Given User has clicked new customer
    When User has entered info and clicked submit
    Then A new customer should be created

*** Keywords ***
# Setup
Open Browser To 'Automationplayground.com' Start Page
    Open Browser    https://automationplayground.com/crm/index.html    Chrome

# Chapter 1 - User Login
User enter the login page
    Click Link    //a[@id='SignIn']

User inputs their credentials
    Input Text    //input[@id='email-id']    ${userEmail}
    Input Password    //input[@id='password']    ${userPass}
    Click Button    //button[@id='submit-id']
    
User should be logged in and see the 'Our Happy Customers' page
    Wait Until Page Contains Element    //h2[normalize-space()='Our Happy Customers']
    Wait Until Page Contains Element    //a[@id='new-customer']

# Chapter 2 - User Adds New Customer With Information
User has clicked new customer
    Click Link    ${newCustomerButton}
    Wait Until Page Contains Element    //h2[text()="Add Customer"]
    
User has entered info and clicked submit
    Input Text    ${emailInput}    ${userEmail}
    Input Text    ${firstNameInput}    ${firstName}
    Input Text    ${lastNameInput}    ${lastName}
    Input Text    ${cityInput}    ${city}
    Select From List By Value   ${stateInput}    ${state}
    Select Radio Button    ${genderRadioName}    ${genderRadioValue}
    Select Checkbox    ${addToPromotionalListChecbox}
    Click Button    ${submitButton}

A new customer should be created
    Wait Until Page Contains Element    //div[@id="Success"]
    Wait Until Page Contains    Success! New customer added. 
    Close Browser
