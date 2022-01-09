## IF expression

Robot Framework's native if expression syntax starts with `IF` (case-sensitive) and ends with `END` (case-sensitive). The `IF` marker requires exactly one value that is the condition to evaluate. Keywords to execute if the condition is true are on their own rows between the `IF` and `END` markers. Indenting keywords in the if block is highly recommended but not mandatory.

In the following example the keyword `Console` is only executed if ${random} is odd.

`IF` and `FOR` can be nested as you can see in the second example.
Like most other languages supporting conditional execution, Robot Framework `IF` syntax also supports `ELSE` branches that are executed if the `IF` condition is not true.
Robot Framework also supports `ELSE IF` branches that have their own condition that is evaluated if the initial condition is not true. There can be any number of `ELSE IF` branches and they are gone through in the order they are specified. If one of the `ELSE IF` conditions is true, the block following it is executed and remaining `ELSE IF` branches are ignored. An optional `ELSE` branch can follow `ELSE IF` branches and it is executed if all conditions are false.

`END` to end the `IF` expression is always mandatory!