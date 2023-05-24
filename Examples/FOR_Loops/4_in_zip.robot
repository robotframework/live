*** Settings ***
Library    Collections

*** Variables ***
@{first_name}    Bruce     Steve     Peter
@{last_name}     Banner    Rogers    Parker

*** Test Cases ***
Combines two lists
    Log To Console   Full Names:
    FOR    ${first}    ${last}    IN ZIP    ${first_name}    ${last_name}
        Log To Console    ${first} ${last}
    END

Combines two lists of different lengths
    Append To List    ${first_name}    Wade
    Log To Console   Full Names:
    FOR    ${first}    ${last}    IN ZIP    ${first_name}    ${last_name}
        Log To Console    ${first} ${last}
    END
    
    Append To List    ${last_name}    Wilson
    Log To Console   Full Names:
    FOR    ${first}    ${last}    IN ZIP    ${first_name}    ${last_name}
        Log To Console    ${first} ${last}
    END