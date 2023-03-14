*** Settings ***
Library          AppiumLibrary
Library          Collections
Library          String
Library          OperatingSystem

Test Template
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


*** Variables ***
${REMOTE_URL}               http://localhost:4741/wd/hub
${PLATFORM_NAME}            Android
${PLATFORM_VERSION}         12
${DeviceName}               92MAY02E8L
${appPackage}               com.loginmodule.learning
${APP_ACTIVITY}             com.loginmodule.learning.activities.LoginActivity
${AUTOMATION_NAME}          uiautomator2
${default_dealy}            10s
${time}                     5
######################### Create Account ##################################
${Create_account_button}                com.loginmodule.learning:id/textViewLinkRegister
${Input_Name_field}                     com.loginmodule.learning:id/textInputEditTextName
${Input_Email_field}                    com.loginmodule.learning:id/textInputEditTextEmail
${Input_Password_field}                 com.loginmodule.learning:id/textInputEditTextPassword
${Input_ConfPassword_field}             com.loginmodule.learning:id/textInputEditTextConfirmPassword
${Register_button}                      com.loginmodule.learning:id/appCompatButtonRegister


####################### Create Account Labels ##############################
${Name_validation_message}              Enter Full Name
${Email_validation_message}             Enter Valid Email
${Password_validation_message}          Enter Password
${confirmpassword_validation_message}   Password Does Not Matches


####################### Sign In #############################################
${SignIn_Email}                         com.loginmodule.learning:id/textInputEditTextEmail
${SignIn_Password}                      com.loginmodule.learning:id/textInputEditTextPassword
${Login_button}                         com.loginmodule.learning:id/appCompatButtonLogin

${email}                                rajdeep+
*** Test Cases ***

#TC1: Open application > Create An Account > Sign IN > Dashboard Validation
#    ${email_id}  ${password}   Create An Account
#    SignIn into the Application     ${email_id}  ${password}
#    Dashboard Validation
#    close application

TC2:
    @{Success_list}=  create list
    @{Fail_list}=   create list

    FOR     ${index}  IN RANGE      ${loop_count}
        ${status}   Run Keyword and return status   Create An Account
        log to console  \n\r ${status}
        Run Keyword If     '${status}'=='True'   Run Keywords   AppiumLibrary.Background Application  seconds=${Time}
            ...  AND   launch application
            ...  AND   append to list  ${Success_list}   ${enter_emailid}
            ...  AND   log to console  ${enter_emailid}
            ...  AND   continue for loop
        run keyword if  '${status}'=='False'  run keywords  append to list    ${Fail_list}   ${enter_emailid}
        ...  AND   log to console  ${enter_emailid}
        ...   AND  continue for loop

    END

    log to console  \n\r Sucess attempt list: @{Success_list}
    log to console  \n\r Failure attempt list: @{Fail_list}
