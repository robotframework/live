*** Test Cases ***
Nesting WHILE
    ${x} =   Set Variable    10
    WHILE    ${x} > 0
        ${y} =   Set Variable    ${x}
        WHILE    ${y} > 0
            ${y} =    Evaluate    ${y} - 1
        END
        ${x} =    Evaluate    ${x} - 2
    END


