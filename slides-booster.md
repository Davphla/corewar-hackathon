---
title: Corewar
theme: neversink
cover: https://upload.wikimedia.org/wikipedia/commons/0/03/Corewar_Logo.svg
colorSchema: teal
highlight: dracula
highlighter: shiki
fonts:
  sans: Inter
  mono: Fira Code
layout: cover
---

# 🧠 Corewar  
## Création d'un interpreteur en C

<div class="text-sm op75 mt-2 text-teal-500">Construisez une machine virtuelle. Chargez des champions.</div>

---


# ⚔️ Qu’est-ce que le Corewar ?

- 🧬 Une simulation où des **programmes s’affrontent** en mémoire partagée  
- 🎯 Objectif : être le **dernier champion actif**  
- ⚙️ Vous codez la **machine virtuelle** qui les exécute

---

# 🛠️ Votre Mission

## Créer une **machine virtuelle** en C

- Exécutez les fichiers `.cor` compilés  
- Gérez les cycles, la mémoire, les processus et les instructions  
- Surveillez les appels à `live` pour déterminer le vainqueur  

<div class="mt-4 p-4 bg-yellow-50 border-l-4 border-yellow-400 rounded shadow">
⚠️ Vous devez supporter toutes les instructions définies dans <code>op.c</code> et <code>op.h</code>
</div>

---

# 📦 Exemple d’Instructions

| Opcode | Nom   | Description                        |
| ------ | ----- | ---------------------------------- |
| 0x01   | live  | Le joueur signale qu’il est vivant |
| 0x04   | add   | Additionne deux registres          |
| 0x09   | zjmp  | Saut conditionnel (si carry == 1)  |
| 0x0f   | lfork | Fork sans modulo                   |

> Voir `op.c` et `op.h` pour la liste complète

---

# 💾 Modèle de Mémoire

* 🧱 Arène partagée : `MEM_SIZE` octets
* 🔁 Chaque processus possède :

  * Registres (`REG_NUMBER`)
  * Un compteur de programme (PC)
  * Un flag Carry

> Les processus sont **planifiés par cycle**, selon leur ID

---

# 💻 Exemple de Lancement

```bash
./corewar -dump 100 champion1.cor champion2.cor
```

| Option    | Description                            |
| --------- | -------------------------------------- |
| `-dump N` | Affiche l’état mémoire au cycle N      |
| `-n`      | Définit un numéro de joueur spécifique |
| `-a`      | Définit l’adresse de chargement        |

---

# 🧠 Concepts Clés

| Concept   | Description                       |
| --------- | --------------------------------- |
| PC        | Position actuelle du code         |
| Carry     | Vaut 1 si le dernier résultat = 0 |
| Champion  | Programme joueur chargé dans l’arène |
| Processus | Instance en cours d’un champion   |
| Cycle     | Battement d’horloge de la VM      |


---
layout: top-title
color: blue-light
---
:: title ::
# Corewar : Architecture 
:: content ::

```mermaid
graph LR
  A[Main] --> B[Init]
  B --> C[Load Champions .cor]
  C --> D[Create Processes]
  D --> B
  B --> E([Start Execution Loop])
```

---
layout: top-title
color: blue-light
---
:: title ::
# Corewar : Architecture 
:: content ::


```mermaid
graph LR

E[Execution Loop] --> K
F --> E

subgraph Execution loop
    direction LR
    F[Execute processes]

    subgraph Check Process
        K[Check Live Calls]
        K --> L[Eliminate Dead Processes]
    end
        
    L --> M@{ shape: diamond, label: "Check Victory Conditions" }

  M -->|If Winner| N[Announce Winner & Exit]
  M -->|Else| F
end
```
---
layout: top-title
color: blue-light
---
:: title ::
# Corewar : Architecture 
:: content ::

# For each champion
<br/>
```mermaid
graph LR
    E --> C[Next Champion / Execution loop]
    I --> C
subgraph Scheduler 
direction LR
    W(If waiting == 0)
    F{Cycle N} --> W
    W -- then --> G
    W -- else --> J[Update State PC, Carry, etc.]
    J --> E[Execute instruction]
    G[Fetch Instruction] --> I[Decode & Validate Opcode]
  end
```

---
layout: top-title
color: blue-light
---
:: title ::
# Corewar : Architecture 
:: content ::


```mermaid
classDiagram
  %% Orientation LR
  direction LR

  %% Classes principales
  class Core {
    +run()
    +dumpMemory()
  }
  class Scheduler {
    +tick()
    +checkLives()
  }
  class Process {
    +fetchOpcode()
    +advancePC()
  }
  class Champion {
    +getCode()
  }
  class Operator {
    +execute()
  }
  class MemoryArena {
    +read()
    +write()
  }
  class Parser {
    +loadChampion()
  }
  class ErrorHandler {
    +error()
  }

  %% Sous-graphes pour regrouper
  %% (Mermaid n'a pas de syntaxe officielle, mais on simule avec des commentaires)
  %% Modules centraux
  Core --> Scheduler
  Core --> MemoryArena
  Core --> Parser
  Core --> ErrorHandler

  %% Gestion des processus
  Scheduler --> Process
  Process --> Champion
  Process --> Operator
  Operator <-- Parser  : uses op.c/h

  MemoryArena <-- Process : R/W

```

---
layout: top-title
color: blue-light
---
:: title ::
# Corewar : Architecture 
:: content ::


# Corewar Class Diagram – Partie 1

```mermaid
classDiagram
  direction TB

  class Core {
    - MemoryArena arena
    - Scheduler scheduler
    - Parser parser
    - ErrorHandler errorHandler
    + run()
    + dumpMemory(cycle)
  }
````

---
layout: top-title
color: blue-light
---

:: title ::
# Corewar : Architecture 
:: content ::


# Corewar Class Diagram – Partie 2

```mermaid
classDiagram
  direction TB

  class MemoryArena {
    - byte[] cells
    + read(addr, size) 
    + write(addr, data)
    + dump()
  }

  class Parser {
    + loadChampion(filePath) : Champion
    + parseHeader(bytes) : Header
  }

  class Champion {
    - int id
    - String name
    - byte[] code
    + getCode()
    + getSize()
  }
```

---
layout: top-title
color: blue-light
---

:: title ::
# Corewar : Architecture 
:: content ::


# Corewar Class Diagram – Partie 3

```mermaid
classDiagram
  direction TB

  class Process {
    - int pid
    - Champion &owner
    - int pc
    - int carry
    - int[] registers
    - int cycleDelay
    + fetchOpcode() : int
    + decodeArgs() : Argument[]
    + advancePC(offset)
  }

  class Scheduler {
    - List~Process~ processes
    - int cycle
    + tick()
    + addProcess(p: Process)
    + removeProcess(p: Process)
    + checkLives()
  }
```

---
layout: top-title
color: blue-light
---

:: title ::
# Corewar : Architecture 
:: content ::


# Corewar Class Diagram – Partie 4

```mermaid
classDiagram
  direction TB

  class OperatorTable {
    - Map~int, Operator~ opTab
    + getOperator(opcode) : Operator
  }

  class Operator {
    - int opcode
    - String name
    - int cycles
    + execute(p: Process, arena: MemoryArena)
  }

  class ErrorHandler {
    + error(message)
    + exit(code)
  }
```

