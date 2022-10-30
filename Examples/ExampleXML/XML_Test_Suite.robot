*** Settings ***
Resource          XML_Keywords.resource


*** Test Cases ***
Verify LibDoc Library Name and Version
    Open And Parse XML File    libdoc.xml
    Verify Library Name    DataTypesLibrary
    Verify Library Version    1.0.2

Check keywords
    ${keywords}=    Get All Keywords
    FOR    ${keyword}    IN    @{keywords}
        Log Element    ${keyword}
    END

Check all DataTypes
    ${datatypes}=    Get All DataTypes
    FOR    ${datatype}    IN    @{datatypes}
        IF    $datatype.tag == enum
            Log To Console    Enum Found
        ELSE IF    $datatype.tag == "typeddict"
            Log To Console    Typeddict Found
        END
        Log Element    ${datatype}
    END
