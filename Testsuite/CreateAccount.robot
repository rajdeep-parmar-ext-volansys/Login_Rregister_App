*** Settings ***
Library          AppiumLibrary
Library          Collections
Library          String
Library          OperatingSystem

Resource        ../Resource/keyword.robot
Resource        ../Resource/locators.robot

*** Test Cases ***
TC1: Open application > Create An Account > Sign IN > Dashboard Validation
    ${email_id}  ${password}   Create An Account
    SignIn into the Application     ${email_id}  ${password}
    Dashboard Validation
    close application

TC2: Verify multiple email address for sign up
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
