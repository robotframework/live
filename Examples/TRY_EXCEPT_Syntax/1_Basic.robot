*** Test Cases ***
Error Catched
    TRY
        Fail    expected error
    EXCEPT  expected error    
        Log To Console    \nCatched!
    END
    Log To Console    I am also being executed

Error Not Catched
    TRY
        Fail    surprising error
    EXCEPT  expected error    
        Log To Console    \nCatched!
    END
    Log To Console    I am not being executed
    
Multiple EXCEPT branches
    ${message}    Set Variable    Error 3
    TRY
        Some Keyword
    EXCEPT    Error 1    # Try matching this first.
        Log To Console    \nError 1 got catched
    EXCEPT    Error 2    # Try this if above did not match.
        Log To Console    \nError 2 got catched
    EXCEPT    ${message}       # Last match attempt, this time using a variable.
        Log To Console    \n${message} got catched
    END

Multiple messages with one EXCEPT
    ${message}    Set Variable    Error 3
    TRY
        Some Keyword
    EXCEPT    Error 1    Error 2    ${message}    # Match any of these.
        Log To Console    Some Error has been catched!
    END

Match any error
    TRY
        Some Keyword
    EXCEPT               # Match any error.
        Log To Console    Something went wrong
    END

Match any after testing more specific errors
    TRY
        Some Keyword
    EXCEPT    Error 1    # Try matching this first
        Log To Console    Error 1 occurred
    EXCEPT                     # Match any that did not match the above.
        Log To Console    Something else went wrong
    END

*** Keywords ***

Some Keyword
    Fail    Error ${{random.randint(1, 3)}}