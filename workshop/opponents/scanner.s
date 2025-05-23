.name "Scanner"
.comment ""

# Register directory
# r1 : ID
# r2 : Position
# r3 : Attack pad
# r4 : Memory size (Const)
# r5 : Original pos (Const)
# r6 : /
# r7 : /
# r8 : /
# r9 : trash

init: 
    sti r1, %:live, %1
    ld %5, r3 # Pad 
    ld %512, r4 # memory size
    ld %10, r5 # original pos
    ld r5, r2 # Position
    fork %:target

# live loop
live: live %1
    zjmp %:live

target:
    add r2, r3, r2
    

    lld r2, r9 # set carry
    zjmp %:target  # if nothing go further
# else attack
attack:
    lfork r2
    st %-1, r5


