*** Settings ***
Documentation     This is a resource file, that can contain variables and keywords.
...               Keywords defined here can be used where this Keywords.resource in loaded.
Library           CustomLibrary.py


*** Variables ***
${FULLNAME}     Administrator    #FULLNAME is a scalar variable containing the string 'Administrator'
@{ALL USERS}    admin    hulk    dr.strange    captain    ironman    #List variable with 5 values.
&{ADMIN}        login=admin    pwd=@RBTFRMWRK@    #Dictionary variable


*** Keywords ***
Login Admin
    [Documentation]    'Login Admin' is a Keyword.
    ...                It calls 'Login User' from 'CustomLibrary.py'
    Login User    ${ADMIN}[login]    ${ADMIN}[pwd]

Verify User Details
    [Documentation]    Keyword that fetches user details based on a login
    ...                and verifies them against expected arguments.
    [Arguments]   ${login}   ${exp_name}   ${exp_right}=user   ${exp_active}=True
    ${user_id}=    Get User Id    ${login}
    ${user_details}=    Get User Details    ${user_id}
    Should Be Equal               ${user_details}[login]    ${login}
    Should Be Equal               ${user_details}[name]     ${exp_name}
    Should Be Equal               ${user_details}[right]    ${exp_right}
    Should Be Equal As Strings    ${user_details}[active]   ${exp_active}

Print All Users
    ${users}=    Get All Users
    FOR    ${user}    IN    @{users}
        Log    ${user}
    END

Get User Details By Name
    [Arguments]    ${login}=${None}
    IF    $login
        ${user_id}=    Get User Id    ${login}
    ELSE
        ${user_id}=    Set Variable    ${NONE}
    END
    ${user_details}=    Get User Details    ${user_id}
    Log    ${user_details}
    [Return]    ${user_details}
