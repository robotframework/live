## WHILE loops

**WHILE** loops combine features of FOR loops and IF/ELSE structures. They specify a condition and repeat the loop body as long as the condition remains true. This can be utilised, for example, to repeat a nondeterministic sequence until the desired outcome happens, or in some cases they can be used as an alternative to FOR loops.

### WHILE condition

The **WHILE** loop condition is evaluated in Python so that Python builtins like len() are available and modules are imported automatically to support usages like math.pi * math.pow(${radius}, 2) < 10. Normal variables like ${rc} in the above example are replaced before evaluation, but variables are also available in the evaluation namespace using the special $rc syntax. The latter approach is handy when the string representation of the variable cannot be used in the condition directly. For example, strings require quoting and multiline strings and string themselves containing quotes cause additional problems. See the Evaluating expressions appendix for more information and examples related to the evaluation syntax

### Limiting WHILE loop iterations

With **WHILE** loops, there is always a possibility to achieve an infinite loop, either by intention or by mistake. This happens when the loop condition never becomes false. While infinite loops have some utility in application programming, in automation an infinite loop is rarely a desired outcome. If such a loop occurs with Robot Framework, the execution must be forcefully stopped and no log or report can be created. For this reason, **WHILE** loops in Robot Framework have a default limit of 10 000 iterations. If the limit is exceeded, the loop fails.

The limit can be changed with the limit configuration parameter. Valid values are positive integers denoting iteration count and time strings like 10s or 1 hour 10 minutes denoting maximum iteration time. The limit can also be disabled altogether by using NONE (case-insensitive). All these options are illustrated by the examples below.

Keywords in a loop are not forcefully stopped if the limit is exceeded. Instead the loop is exited similarly as if the loop condition would have become false. A major difference is that the loop status will be FAIL in this case

### Nesting WHILE loops

**WHILE** loops can be nested and also combined with other control structures

### Removing unnecessary keywords from outputs

**WHILE** loops with multiple iterations often create lots of output and considerably increase the size of the generated output and log files. It is possible to remove or flatten unnecessary keywords using --removekeywords and --flattenkeywords command line options