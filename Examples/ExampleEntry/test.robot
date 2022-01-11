*** Settings ***
Documentation     A test suite for valid login.
...
...               Keywords are imported from the resource file
Resource          keywords.resource

*** Test Cases ***
Login User with Password
    [Documentation]    Tests if all users can log in.
    [Setup]    Connect to Server
    Login User    ironman    1234567890
    Verify Valid Login    Tony Stark
    [Teardown]    Close Server Connection