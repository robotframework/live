*** Settings ***
Library    XML
Library    String


*** Variables ***


*** Keywords ***
Open And Parse XML File
    [Arguments]    ${xml_file_path}
    ${parsedXML}=    Parse Xml    ${xml_file_path}    strip_namespaces=True
    Log    ${parsedXML}
    Set Suite Variable    ${XML}    ${parsedXML}

Get Library Name
    ${lib_name}=    Get Element Attribute    ${XML}    name    .
    [Return]    ${lib_name}

Get Library Version
    ${lib_version}=    Get Element Text    ${XML}    ./version
    [Return]    ${lib_version}

Verify Library Name
    [Arguments]    ${library_name}
    ${actual_name}=    Get Library Name
    Should Be Equal    ${library_name}    ${actual_name}
    ...   The library name is not correct!/nExpected: ${library_name}/nCurrent: ${actual_name}

Verify Library Version
    [Arguments]    ${library_version}
    ${actual_version}=    Get Library Version
    Should Be Equal    ${library_version}    ${actual_version}
    ...   The library version is not correct!/nExpected: ${library_version}/nCurrent: ${actual_version}

Get All Keywords
    ${all_keywords}=    Get Elements    ${XML}    keywords/kw
    [Return]    ${all_keywords}

Get All DataTypes
    ${all_data_types}=    Get Elements    ${XML}    datatypes/*/*
    [Return]    ${all_data_types}