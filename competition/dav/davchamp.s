.name "Survivor"
.comment "Live"


xor r2, r2, r2
mine: zjmp %:start
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0
zjmp %0

xor r2, r2, r2
xor r3, r3, r3
xor r4, r4, r4
xor r5, r5, r5
xor r6, r6, r6
xor r7, r7, r7
xor r8, r8, r8
xor r9, r9, r9
xor r10, r10, r10

start:
ld %:trap, r2
sti r2, %:mine, %0
add r4, r1, r5


xor r9, r9, r9
fork %:living

sti r1, %:a, %1
a: live %1

fork %:live1
ld %:trap, r2
sti r2, %:mine, %0
xor r9, r9, r9

live1: live %1
live2: live %1
live3: live %1
live4: live %1
live5: live %1
live6: live %1
live7: live %1
live8: live %1
live9: live %1
live10: live %1
live11: live %1
live12: live %1
live13: live %1
live14: live %1
live15: live %1
    zjmp %:live1

living:
    sti r1, %:live1, %1
    sti r1, %:live2, %1
    sti r1, %:live3, %1
    sti r1, %:live4, %1
    sti r1, %:live5, %1
    sti r1, %:live6, %1
    sti r1, %:live7, %1
    sti r1, %:live8, %1
    sti r1, %:live9, %1
    sti r1, %:live10, %1
    sti r1, %:live11, %1
    sti r1, %:live12, %1
    sti r1, %:live13, %1
    sti r1, %:live14, %1
    sti r1, %:live15, %1
    fork %:live1
    fork %:live1
    fork %:live1
    fork %:living
    fork %:living
    xor r9, r9, r9
    zjmp %:living

trap: zjmp %0

live_res: live %1

end:
xor r2, r2, r2
xor r3, r3, r3
xor r4, r4, r4
xor r5, r5, r5
xor r6, r6, r6
xor r7, r7, r7
xor r8, r8, r8
xor r9, r9, r9
xor r10, r10, r10
zjmp %0
zjmp %:end
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
zjmp %-4
