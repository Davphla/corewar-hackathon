.name "Survive"
.comment "Live"

    sti r1, %:live, 1
live: live %1

# Should write a bomb in memory
createBomb:
