*** Variables ***
${MATCH TYPE}     regexp

*** Test Cases ***
Glob pattern 1
    TRY
        Some Keyword
    EXCEPT    Error *    type=GLOB
        Log To Console    \nCatched!
    END

Glob pattern 2
    TRY
        Some Keyword
    EXCEPT    [Ee]rror ?    type=glob
        Log To Console    \nCatched again!
    END

Regular expression 1
    TRY
        Some Keyword
    EXCEPT    Error .*    type=${MATCH TYPE}
        Log To Console    \nCatched!
    END

Regular expression 2
    TRY
        Some Keyword
    EXCEPT    [Ee]rror \\d+     type=Regexp    # Backslash needs to be escaped.
        Log To Console    \nCatched!
    END

Match start
    TRY
        Some Keyword
    EXCEPT    Error    type=start
        Log To Console    \nCatched!
    END

Explicit exact match
    ${message}    Set Variable    Error 3
    TRY
        Some Keyword
    EXCEPT    Error 1    type=LITERAL
        Log To Console    \nError 1 got catched
    EXCEPT    Error 2    type=LITERAL
        Log To Console    \nError 2 got catched
    EXCEPT    ${message}    type=LITERAL
        Log To Console    \n${message} got catched
    END

*** Keywords ***

Some Keyword
    Fail    Error ${{random.randint(1, 3)}}