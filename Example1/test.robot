*** Settings ***
Library           CustomLibrary.py
Resource          keywords.resource
Force Tags        INCL

*** Test Cases ***
Test Keyword
    Hello Keyword
    IF    True
        Log To Console    Test
    END
    FOR    ${Test}    IN    1    2    4
        Log To Console    ${Test}
    END

Log Python Keywords
    ${ret}=    My Keyword    WORLD
    Log To Console    ${ret}
