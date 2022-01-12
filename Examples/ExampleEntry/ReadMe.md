## Simple Example

This example contains a single test case in that test a users login.

### Test Object

We are testing here a backend api for user management. Users must authenticate before interaction.
Depending on the authorizations, different actions can be carried out:

- **Administrators** can create users, alter user data and fetch details about existing users.
- **Normal users** can just fetch their own information and only alter their own details.
- **Guest users** can login but not modify anything.

### Test Suite

This test suite (*test.robot*) contains a single test case "*Login User with Password*".
This test case calls keywords from the resource file *keywords.resource*.

### Resource File

*keywords.resource* contains keyword definitions as well as examples of variables, Return-Values, IF/ELSE and FOR-Loops.
The keywords in this resource file are implemented by keywords from a python library which you will find impleneted in *CustomLibrary.py*.