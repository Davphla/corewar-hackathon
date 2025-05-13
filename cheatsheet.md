# Redcode Corewar Cheatsheet

## 1. Arena & Memory

* Size: `MEM_SIZE` (e.g. 4096)
* Rotative memory → `addr % MEM_SIZE`

## 2. Instruction Format

```
[label:] mnemonic arg1[, arg2[, arg3]]  
```

### **Arg types** (coded in the “coding byte”):  
  * `0b00` = No argument (**0 byte**)  
  * `0b01` = **T_REG** (register): `r1`…`r16` — **1 byte**  
  * `0b10` = **T_DIR** (direct): `%123` or `%:label` — **4 bytes**  
    * _Exception_: for “IDX” instructions (`live`, `zjmp`, `fork`, `lfork`. `ldi`, `sti`, `lldi`), the direct field is **2 bytes** instead of 4.  
  * `0b11` = **T_IND** (indirect): `123` or `:label` — **2 bytes**

Labels (`%:label` or `:label`) are replaced by a relative offset (signed) from the **start** of their instruction.


### Memory structures
/!\ The coding byte is omitted for the instructions `live`, `zjmp`, `fork`, `lfork`, since they only have one IDX param.

```go
+--------+   +-------------+   +---------+   +---------+   +---------+   +---------+
| OpCode |-->| Coding Byte |-->| Param 1 |-->| Param 2 |-->| Param 3 |-->| Param 4 |
+--------+   +-------------+   +---------+   +---------+   +---------+   +---------+

+-----------------------------------------------------------------------------------------+
|                        Full Instruction (variable size in bytes)                        |
+-----------------------------------------------------------------------------------------+
| Field:   | OpCode | Coding Byte | Param 1         | Param 2          | Param 3          |
| Bytes:   | 1 byte | 1 byte      | (1–4 byte)      | (1–4 byte)       | (1–4 byte)       |
| Example: | 0x06   | 0x68        | r1  (0x01)      | %20 (0x00000014) | %42 (0x0000002A) |
+-----------------------------------------------------------------------------------------+

+--------------------------------------------+
|              Opcode Byte (1 byte)          |
+--------------------------------------------+
| Value:     0   0   0   0   0   1   1   0   |
| Hex:                                  0x06 |
| Mnemonic:                            `and` |
+--------------------------------------------+

+--------------------------------------------------------------------------------+
|                          Coding Byte (1 byte = 8 bits)                         |
+--------------------------------------------------------------------------------+
| Bit Index:  7  6   5  4   3  2   1  0                                          |
| Field:     [ P1 ] [ P2 ] [ P3 ] [ P4 ]                                         |
| Encoding:  [ 01 ] [ 10 ] [ 10 ] [ 00 ]   ⇒ binary `01101000` ⇒ hex `0x68`    |
+--------------------------------------------------------------------------------+

+-------------------------------------------+
|                Param Types                |
+-----------+-------------------------------+
| T_REG     | Register                      |
+-----------+-------------------------------+
| Syntax    | r3                            |
| Binary    | 0b01                          |
| Size      | 1 byte                        |
| Memory    | [ 0x03 ]                      |
| Meaning   | Register 3                    |
+-----------+-------------------------------+
| T_DIR     | Direct                        |
+-----------+-------------------------------+
| Syntax    | %123                          |
| Binary    | 0b10                          |
| Size      | 4 bytes                       |
| Memory    | [ 0x00 0x00 0x00 0x7B ]       |
| Meaning   | Value 123 (0x7B)              |
+-----------+-------------------------------+
| T_IND     | Indirect                      |
+-----------+-------------------------------+
| Syntax    | 123                           |
| Binary    | 0b11                          |
| Size      | 2 bytes                       |
| Memory    | [ 0x00 0x7B ]                 |
| Meaning   | Address 123 (relative)        |
+-----------+-------------------------------+
| T_DIR IDX | Direct (IDX instructions)     |
+-----------+-------------------------------+
| Syntax    | %:label or %42                |
| Binary    | 0b10                          |
| Size      | 2 bytes                       |
| Memory    | [ 0x00 0x2A ]                 |
| Meaning   | Relative offset 42 (0x2A)     |
+-----------+-------------------------------+
```

---

## 3. Real Opcodes Quick-Ref

| Code | Mnemonic | #Args | Argument Types                                            | Effects / Notes                                          |
| :--: | :------: | :---: | :-------------------------------------------------------- | :------------------------------------------------------- |
| 0x01 |  `live`  |   1   | **DIR**                                                   | Announce "I'm alive"—keeps process alive; no coding byte |
| 0x02 |   `ld`   |   2   | **DIR**/**IND**, **REG**                                  | Load DIR/IND → REG; sets carry                           |
| 0x03 |   `st`   |   2   | **REG**, **REG**/**IND**                                  | Store REG → IND/REG                                      |
| 0x04 |   `add`  |   3   | **REG**, **REG**, **REG**                                 | REG + REG → REG; sets carry                              |
| 0x05 |   `sub`  |   3   | **REG**, **REG**, **REG**                                 | REG – REG → REG; sets carry                              |
| 0x06 |   `and`  |   3   | **REG**/**DIR**/**IND**, **REG**/**DIR**/**IND**, **REG** | Bitwise AND → REG; sets carry                            |
| 0x07 |   `or`   |   3   | **REG**/**DIR**/**IND**, **REG**/**DIR**/**IND**, **REG** | Bitwise OR → REG; sets carry                             |
| 0x08 |   `xor`  |   3   | **REG**/**DIR**/**IND**, **REG**/**DIR**/**IND**, **REG** | Bitwise XOR → REG; sets carry                            |
| 0x09 |  `zjmp`  |   1   | **IDX**                                                   | PC ← PC + %X if carry=1; no coding byte                  |
| 0x0a |   `ldi`  |   3   | **REG**/**IDX**/**IND**, **REG**/**IDX**, **REG**         | Load from (arg1 + arg2) → REG; sets carry                |
| 0x0b |   `sti`  |   3   | **REG**, **REG**/**IDX**/**IND**, **REG**/**IDX**         | Store REG → (arg2 + arg3)                                |
| 0x0c |  `fork`  |   1   | **IDX**                                                   | Clone process at PC + %X; no coding byte                 |
| 0x0d |   `lld`  |   2   | **DIR**/**IND**, **REG**                                  | Like `ld` but without truncation; sets carry             |
| 0x0e |  `lldi`  |   3   | **REG**/**DIR**/**IND**, **REG**/**DIR**, **REG**         | Like `ldi` but full address; sets carry                  |
| 0x0f |  `lfork` |   1   | **DIR**                                                   | Like `fork` but without truncation; no coding byte       |
| 0x10 |   `aff`  |   1   | **REG**                                                   | Print (reg\_value % 256) as ASCII char                   |


---

# Strategies 

https://en.wikipedia.org/wiki/Core_War

## 4. Simple Offense-Defense 

```asm
.name "endless-live"
.comment "A champion that never dies: keeps calling LIVE."

        sti   r1, %:live, %1  ; write my player-ID (r1) into the cell at (live+1)
live:  live  %1               ; repeat “I’m alive” each cycle
        zjmp  %live           ; loop back unconditionally

```

```asm
.name "Balance"
.comment  "Balanced offense & survival"

; ------- Setup -------
        sti   r1, %:live, %1   ; (1) write my player-ID (r1) into the cell at (live+1)
        fork  %:attack         ; (2) spawn a secondary process starting at label “ok”
        ld    %100, r4         ; (3) initialize r4 = 100 (our bombing offset seed)
        ld    %2,   r5         ; (4) initialize r5 = 2   (our step size)

; ------- Survive -------
live:   live  %1               ; (5) declare “I’m still alive” (keeps us from dying)
        
; ------- Attack -------
attack: sti   r5, r4, r1       ; (6) bomb: store r5 into memory at address (PC + (r4 % IDX_MOD)) + r1
        add   r4, r5, r4       ; (7) r4 += r5  — advance our bombing offset
        ld    %0,   r8         ; (8) load zero into r8 (reset carry = 1, so next jump always taken)
        zjmp  %:live           ; (9) jump back to “live” to repeat the cycle
```

---

## 5. Common Strategies

### 🧨 Bombing
- **Blind Bombing**: Use `sti` or `st` to drop "DAT" bombs at calculated intervals (e.g. `sti r1, r2, r3`).
- **Spiral Bombing**: Increment bomb offset each round (`add rX, rY, rX`) to hit more of memory.
- **Cluster Bombing**: Drop multiple bombs in a small area to overwhelm opponents.

### 🕵️ Scanning
- **Probe First**: Use `ldi` to read memory; if non-zero, it might be code → bomb it.
- **Selective Bombing**: Bomb only suspicious (non-zero) areas to avoid wasting effort.
- **Parity Scan**: Only check even/odd addresses to cover more area faster.

### 🧬 Splitting
- **Persistent Forking**: Use `fork` or `lfork` regularly so at least one process survives.
- **Dual Roles**: Fork once — one process attacks, one runs `live` in a safe loop.

### 🌀 Imp Ring
- **Imp**: A simple `mov 0, 1` (or `st r1, 1`) loop that keeps moving forward and writing itself.
- **Imp Spiral**: Multiple imps running in staggered cycles to cover more memory.

### 🛡️ Survival
- **Dedicated Live Loop**: A forked process that only does `live %id`, `zjmp -1`.
- **Anti-Scan Cloak**: Write 0s around code to confuse scanners.
- **Reset Carry Trick**: Use `ld %0, rX` to force `zjmp` to always jump (sets carry=1).

---

## 6. Tuning Tips

* **Bomb Size**: keep bombs small (`DAT 1`) so coding byte + args fit in 3 bytes.
* **Step Size**: pick a prime (e.g. `#17`) to avoid lining up with opponents’ scans.
* **Split Rate**: ~1 split per 50 cycles; too many slows your bombing.
* **Label Offsets**: precompute all label positions, then on write do

  ```c
  offset = label_addr - inst_addr;
  ```
* **Test Extremes**: run with 2–4 opponents of varied strategies to balance offense vs. survivability.

---

Save this sheet to guide both your **assembler** output and your **champion’s** Redcode—now with the real Corewar opcodes! Good luck in the arena.
