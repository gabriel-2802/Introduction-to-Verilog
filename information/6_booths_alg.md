### 4.2 Prezentarea Algoritmului lui Booth

Scopul algoritmului lui Booth este de a calcula produsul \( P = M * R \), unde \( M \) și \( R \) sunt numere cu semn reprezentate pe \( n \) biți, iar \( P \) este un număr cu semn reprezentat pe \( 2n \) biți. Algoritmul folosește un set de pași optimizați pentru a realiza înmulțirea, iar mai jos sunt prezentate detaliat acești pași împreună cu un exemplu:

#### 1. Formarea lui \( P \)


**Structura inițială a lui \( P \)**:
- \( n \) biți de zero
- \( n \) biți din \( R \)
- Bitul Z (setat pe '0')
- `P = 0...0 R Z`

#### 2. Determinarea valorilor auxiliare \( M+ \) și \( M- \)

Valori auxiliare \( M+ \) și \( M- \) sunt create pentru a fi adăugate la \( P \) în cadrul algoritmului:

- **\( M+ \)**: \( M \) este plasat în cei mai semnificativi \( n \) biți, urmați de \( n \) biți plus bitul Z setați pe zero.
- `M+ = M 0...0 Z`
- **\( M- \)**: \(-M\) (negativul lui \( M \), calculat ca complement la doi) este plasat în cei mai semnificativi \( n \) biți, urmați de \( n \) biți plus bitul Z setați pe zero.
- `M- = -M 0...0 Z`

#### 3. Verificarea primilor 2 biți ai lui \( P \)

Primii doi biți verificați sunt \( Q_0 \) și bitul Z. Deciziile sunt luate astfel:
- Dacă biții sunt 01 ⇒ \( P = P + M+ \) (ignorând overflow)
- Dacă biții sunt 10 ⇒ \( P = P + M- \) (ignorând overflow)
- Dacă biții sunt 00 sau 11 ⇒ nu se modifică \( P \)

#### 4. Deplasarea aritmetică la dreapta

După fiecare adunare sau verificare, toți biții lui \( P \) sunt deplasați aritmetic la dreapta cu o poziție. Deplasarea aritmetică menține semnul numărului (adică bitul cel mai semnificativ rămâne neschimbat).

#### 5. Repetarea pașilor 3 și 4 de \( n \) ori

#### 6. Indepărtarea bitului Z din \( P \)




## Exemplu 

## Valori inițiale:
- \( M = 00010 \)
- \( -M = 11110 \) (negativul lui M, calculat prin complementarea și adăugarea unei unități)
- \( R = 10011 \) (reprezentarea lui -13 în complement la doi)

## Pasul 1: Construirea lui \( P \)

Concatenăm un număr de biți setați pe zero (numărul de biți egal cu n), valoarea lui \( R \) și un bit \( Z \) setat pe zero:

- **\( P \)**: 00000 10011 0

## Pasul 2: Formarea lui \( M+ \) și \( M- \)

- **\( M+ \)**: 00010 00000 0
- **\( M- \)**: 11110 00000 0

## Pașii 3 și 4: Execuția algoritmului de \( n = 5 \) ori

### Iterația 1:
- **\( P \)**: 00000 10011 0
- Ultimii 2 biți sunt '10' - se adaugă \( M- \)
- **\( P \) = P + M-**: 00000 10011 0 + 11110 00000 0 = 11110 10011 0
- Deplasare aritmetică la dreapta pe \( P \) ⇒ **\( P \)**: 11111 01001 1

### Iterația 2:
- **\( P \)**: 11111 01001 1
- Ultimii 2 biți sunt '11' - nu se modifică \( P \)
- Deplasare aritmetică la dreapta pe \( P \) ⇒ **\( P \)**: 11111 10100 1

### Iterația 3:
- **\( P \)**: 11111 10100 1
- Ultimii 2 biți sunt '01' - se adaugă \( M+ \)
- **\( P \) = P + M+**: 11111 10100 1 + 00010 00000 0 = 00001 10100 1
- Deplasare aritmetică la dreapta pe \( P \) ⇒ **\( P \)**: 00000 11010 0

### Iterația 4:
- **\( P \)**: 00000 11010 0
- Ultimii 2 biți sunt '00' - nu se modifică \( P \)
- Deplasare aritmetică la dreapta pe \( P \) ⇒ **\( P \)**: 00000 01101 0

### Iterația 5:
- **\( P \)**: 00000 01101 0
- Ultimii 2 biți sunt '10' - se adaugă \( M- \)
- **\( P \) = P + M-**: 00000 01101 0 + 11110 00000 0 = 11110 01101 0
- Deplasare aritmetică la dreapta pe \( P \) ⇒ **\( P \)**: 11111 00110 1

## Pasul 5: Finalizarea

- Eliminăm bitul \( Z \), rezultând \( P = 11111 00110 \) care este \( -26 \), rezultatul corect al înmulțirii \( M * R \).
