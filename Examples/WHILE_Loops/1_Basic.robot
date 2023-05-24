*** Variables ***
${fuel}     100
${max_drinks}    10


*** Test Cases ***
Rocket mission
    WHILE    ${fuel}
        Log To Console    🚀 Still going: ${fuel} / 100
        ${fuel}    Evaluate    ${fuel} -5
        Sleep    200ms
    END

    Log To Console    🪂 fuel empty

Lonkero hangover
    ${drinks}    Set Variable    0
    WHILE  ${drinks} < ${max_drinks}
        Log To Console    Another one! 🥫
        ${drinks}    Evaluate    ${drinks} + 1
        Sleep    200ms
    END
    
    Log To Console    Let's go home 🛌🏼🥴

Actual example
    ${rc}=   Set Variable    1
    WHILE    ${rc} != 0
        ${rc}=    Keyword that returns zero on success
    END

*** Keywords ***
Keyword that returns zero on success
    RETURN    ${{random.randint(0, 10)}}