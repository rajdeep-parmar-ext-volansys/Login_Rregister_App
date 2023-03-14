*** Settings ***
Library          AppiumLibrary
Library          Collections
Library          String
Library          OperatingSystem

Resource        locators.robot
*** Keywords ***

Open app
    open application   ${REMOTE_URL}
    ...  platformName=${PLATFORM_NAME}
    ...  platformVersion=${PLATFORM_VERSION}
    ...  deviceName=${DeviceName}
    ...  appPackage=${App_Package}
    ...  appActivity=${APP_ACTIVITY}
    ...  automationName=${AUTOMATION_NAME}

Create An Account
    Open app
    Wait until page contains element  ${SignIn_Email}  ${default_dealy}
    click element  ${Create_account_button}
    wait until page contains element  ${Input_Email_field}  ${default_dealy}
    page should contain element  ${Input_Name_field}
    click element  ${INPUT_NAME_FIELD}
    ${name}=  generate random string  5
    input text  ${Input_Name_field}   ${name}
    go back
    page should contain element  ${input_email_field}
    click element  ${input_email_field}
    ${a}=  set variable  @rj.com
    ${number}=  generate random string  3  [NUMBERS]
    ${enter_emailid}=  set variable  ${email}${number}${a}
    input text  ${input_email_field}  ${enter_emailid}
    go back
    page should contain element  ${Input_Password_field}
    click element  ${input_password_field}
    ${password}=  generate random string  5  [NUMBERS]
    input text   ${input_password_field}   ${password}
    go back
    page should contain element  ${Input_ConfPassword_field}
    click element  ${input_confpassword_field}
    input text  ${input_confpassword_field}  ${password}
    go back
    click element  ${register_button}
    Sleep   2s
    Page Should Contain Text    Successful
    go back
    set global variable  ${enter_emailid}  ${enter_emailid}
    set global variable  ${password}    ${password}
    [Return]    ${enter_emailid}  ${password}

SignIn into the Application
    [Arguments]     ${email_id}      ${password}
    page should contain element  ${SignIn_Email}
    click element  ${signin_email}
    input text  ${signin_email}  ${email_id}
    go back
    page should contain element  ${SignIn_Password}
    click element  ${SignIn_Password}
    input text  ${signin_password}  ${password}
    go back
    click element  ${Login_button}
    wait until page contains  ${email_id}   ${DEFAULT_DEALY}

Dashboard Validation
    page should contain text  ${enter_emailid}
    log to console  \n\r ==> Email: ${enter_emailid}
    page should contain text  ${password}
    log to console  \n\r ==> Password: ${password}
    sleep  ${default_dealy}

