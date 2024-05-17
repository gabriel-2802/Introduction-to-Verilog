# Unitatea Aritmetico-Logică (UAL)

UAL permite executarea unei varietăți de operații asupra datelor, care sunt esențiale în procesarea instrucțiunilor într-un sistem de calcul.

## Operații Permise în UAL

### Operații Logice
- **AND**
- **OR**
- **NOT**
- **XOR**
- **NOR**
- **NAND**

### Operații de Shift
- Shift stânga
- Shift dreapta
- Shift circular

### Operații Aritmetice
- **Adunare**
- **Scădere**
- Înmulțire (implementată parțial)
- Împărțire (implementată parțial)

## Mod de Proiectare al Execuției unei Instrucțiuni

- **Într-un singur ciclu de ceas**: Execuție rapidă, dar necesită un circuit complex.
- **În mai mulți pași**: Execuție mai lentă, circuit mai ușor de proiectat.
- **Implementare în software**: Bază pe operațiile deja existente în UAL.

## Registre de Stare

### x86
- **FLAGS**: 16 biți
- **EFLAGS**: Extensie de 32 de biți

### Atmega324 (microcontroler)
- **SREG**: 8 biți

### Flags Utilizate de UAL
- **CF** (Carry Flag): Setat pe `1` când operația generează un carry (iese din numărul de biți alocați).
- **ZF** (Zero Flag): Setat pe `1` când rezultatul este zero (toți biții sunt 0).
- **N** (Negative Flag): Setat pe `1` când rezultatul este un număr negativ (primul bit este 1).
- **OF/V** (Overflow Flag): Setat pe `1` când rezultatul are overflow:
  - Adunare între două numere pozitive rezultă într-un număr negativ.
  - Adunare între două numere negative rezultă într-un număr pozitiv.
