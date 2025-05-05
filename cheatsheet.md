# Redcode Corewar Cheatsheet
Réflexion durant quelques secondes


**1. Arena & Memory**

* Size: `MEM_SIZE` (e.g. 4096)
* Wraps: all addresses → `addr % MEM_SIZE`

**2. Instruction Format**

```
[label:] mnemonic arg1[, arg2[, arg3]]  
```

### **Arg types** (coded in the “coding byte”):  
  * `0b00` = No argument (0 B)  
  * `0b01` = **T_REG** (register): `r1`…`r16` — **1 byte**  
  * `0b10` = **T_DIR** (direct): `%123` or `%:label` — **4 bytes**  
    * _Exception_: for “IDX” instructions (`zjmp`, `ldi`, `sti`, `fork`, `lldi`, `lfork`), the direct field is **2 bytes** instead of 4.  
  * `0b11` = **T_IND** (indirect): `123` or `:label` — **2 bytes**

Labels (`%:label` or `:label`) are replaced by a relative offset (signed) from the **start** of their instruction.


### Coding Byte (absent for live, zjmp, fork, lfork)
```go
+--------------------------------------------------------------------------------+
|                          Coding Byte (1 byte = 8 bits)                         |
+--------------------------------------------------------------------------------+
| Bit Index:  7  6   5  4   3  2   1  0                                          |
| Field:     [ P1 ] [ P2 ] [ P3 ] [ P4 ]                                         |
| Encoding:  [ 01 ] [ 10 ] [ 10 ] [ 00 ]   ⇒ binary `01101000` ⇒ hex `0x68`    |
+--------------------------------------------------------------------------------+

+--------+   +-------------+   +---------+   +---------+   +---------+   +---------+
| OpCode |-->| Coding Byte |-->| Param 1 |-->| Param 2 |-->| Param 3 |-->| Param 4 |
+--------+   +-------------+   +---------+   +---------+   +---------+   +---------+
```

---

## 3. Real Opcodes Quick-Ref

| Code | Mnemonic | #Args | Effects / Notes                                                           |
| :--: | :------: | :---: | :------------------------------------------------------------------------ |
| 0x01 |  `live`  |   1   | Announce “‘I’m alive’”—keeps process alive; no coding byte                |
| 0x02 |   `ld`   |   2   | Load DIR/IND → REG; sets carry                                            |
| 0x03 |   `st`   |   2   | Store REG → IND/REG                                                       |
| 0x04 |   `add`  |   3   | REG + REG → REG; sets carry                                               |
| 0x05 |   `sub`  |   3   | REG – REG → REG; sets carry                                               |
| 0x06 |   `and`  |   3   | bitwise AND → REG; sets carry                                             |
| 0x07 |   `or`   |   3   | bitwise OR → REG; sets carry                                              |
| 0x08 |   `xor`  |   3   | bitwise XOR → REG; sets carry                                             |
| 0x09 |  `zjmp`  |   1   | PC ← PC + %X if carry=1; no coding byte                                   |
| 0x0a |   `ldi`  |   3   | Load IDX: read two args → sum S → read @ (S % IDX\_MOD) → REG; sets carry |
| 0x0b |   `sti`  |   3   | Store IDX: REG → @ (sum of args % IDX\_MOD)                               |
| 0x0c |  `fork`  |   1   | Clone process at PC + %X % IDX\_MOD; no coding byte                       |
| 0x0d |   `lld`  |   2   | Like `ld` but no % IDX\_MOD; sets carry                                   |
| 0x0e |  `lldi`  |   3   | Like `ldi` but no % IDX\_MOD; sets carry                                  |
| 0x0f |  `lfork` |   1   | Like `fork` but no % IDX\_MOD; no coding byte                             |
| 0x10 |   `aff`  |   1   | Print (reg\_value % 256) as char                                          |

---

# Strategies 

## 4. Simple Offense-Defense Template

```asm
; ------- Setup -------
        live   %1          ; ensure your process stays alive
        zjmp   %start      ; skip bombing code once live has fired
; ------- Bomb Loop (Dwarf style) -------
bomb:   sti    r1, %:bomb, %offset   ; small DAT bomb at relative spot
        add    %step, r2, r2         ; increment offset
        zjmp   %bomb if r2           ; repeat until wrap
; ------- Survival (Split) -------
start:  fork   %surv_loop     ; spawn backup processes
surv_loop:
        zjmp   %surv_loop if carry   ; idle loop to wait
```

* **Bombing**: `sti` lets you write a small `DAT` bomb (`r1` contains the bomb opcode/value).
* **Scanning**: use `ldi`/`sti` to probe memory and bomb only non-zero areas.
* **Splitting**: occasional `fork` to ensure at least one process remains.

---

## 5. Tuning Tips

* **Bomb Size**: keep bombs small (`DAT 1`) so coding byte + args fit in 3 bytes.
* **Step Size**: pick a prime (e.g. `#17`) to avoid lining up with opponents’ scans.
* **Split Rate**: \~1 split per 50 cycles; too many slows your bombing.
* **Label Offsets**: precompute all label positions, then on write do

  ```c
  offset = label_addr - inst_addr;
  ```
* **Test Extremes**: run with 2–4 opponents of varied strategies to balance offense vs. survivability.

---

Save this sheet to guide both your **assembler** output and your **champion’s** Redcode—now with the real Corewar opcodes! Good luck in the arena.
