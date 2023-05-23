*** Test Cases ***

Limit as iteration count
    WHILE    True    limit=100
        Log    This is run 100 times.
    END

Limit as time
    WHILE    True    limit=10 seconds
        Log    This is run 10 seconds.
    END