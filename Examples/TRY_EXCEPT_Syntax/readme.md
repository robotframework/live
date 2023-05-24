## TRY / EXCEPT Syntax

When a keyword fails, Robot Framework's default behavior is to stop the current test and executes its possible teardown. There can, however, be needs to handle these failures during execution as well. Robot Framework 5.0 introduces native **TRY/EXCEPT** syntax for this purpose, but there also other ways to handle errors.

Robot Framework's **TRY/EXCEPT** syntax is inspired by Python's exception handling syntax. It has same **TRY**, **EXCEPT**, **ELSE** and ****FINALLY**** branches as Python and they also mostly work the same way. A difference is that Python uses lower case try, except, etc. but with Robot Framework all this kind of syntax must use upper case letters. A bigger difference is that with Python exceptions are objects and with Robot Framework you are dealing with error messages as strings.

### Matching errors using patterns

By default matching an error using **EXCEPT** requires an exact match. That can be changed using a configuration option type= as an argument to the except clause. Valid values for the option are **GLOB**, **REGEXP** or **START** (case-insensitive) to make the match a [glob pattern match](https://en.wikipedia.org/wiki/Glob_(programming)), a [regular expression match](https://en.wikipedia.org/wiki/Regular_expression), or to match only the beginning of the error, respectively. Using value **LITERAL** has the same effect as the default behavior. If an **EXCEPT** has multiple messages, this option applies to all of them. The value of the option can be defined with a variable as well.

### Capturing error message

When matching errors using patterns and when using **EXCEPT** without any messages to match any error, it is often useful to know the actual error that occurred. Robot Framework supports that by making it possible to capture the error message into a variable by adding AS  ${var} at the end of the **EXCEPT** statement.

### Using ELSE to execute keywords when there are no errors
Optional **ELSE** branches make it possible to execute keywords if there is no error. There can be only one **ELSE** branch and it is allowed only after one or more EXCEPT branches:

### Using FINALLY to execute keywords regardless are there errors or not
Optional **FINALLY** branches make it possible to execute keywords both when there is an error and when there is not. They are thus suitable for cleaning up after a keyword execution somewhat similarly as teardowns. There can be only one **FINALLY** branch and it must always be last. They can be used in combination with **EXCEPT** and **ELSE** branches and having also **TRY/FINALLY** structure is possible.