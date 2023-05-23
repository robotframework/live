*** Test Cases ***
Capture error
    TRY
        Some Keyword
    EXCEPT    Error *    type=GLOB    AS   ${error}
        Log To Console    \nCatched ${error}
    END

Capture error 2
    TRY
        Some Keyword
    EXCEPT    AS    ${error}
        Log To Console    \nCatched ${error}
    END


*** Keywords ***

Some Keyword
    Fail    Error ${{random.randint(1, 3)}}