
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