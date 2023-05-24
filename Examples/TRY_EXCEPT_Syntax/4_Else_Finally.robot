*** Test Cases ***
Handle everything
    TRY
        Some Keyword
    EXCEPT    AS    ${err}
        Log To Console    Error occurred: ${err}
    ELSE
        Log To Console    No error occurred!
    END

TRY/EXCEPT/ELSE/FINALLY
    TRY
        Some keyword
    EXCEPT  AS    ${err}
        Log To Console    \nError occurred: ${err}
    ELSE
        Log To Console    \nNo error occurred.
    FINALLY
        Log To Console    \nAlways executed.
    END

TRY/FINALLY
    Log To Console    \nOpen Connection
    TRY
        Log To Console    \nUse Connection
        Fail    Connection lost
    FINALLY
        Log To Console    \nClose Connection
    END

*** Keywords ***
Some Keyword
    ${rc}    Set Variable    ${{random.randint(0, 1)}}
    IF  ${rc} == 0
        RETURN    ${rc}
    ELSE
        Fail    Error ${rc}    
    END