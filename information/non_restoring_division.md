# Algoritmul Non-Restoring Division

Algoritmul Non-Restoring Division este utilizat pentru a efectua împărțirea în unitățile aritmetico-logice (UAL), optimizând operația complexă de împărțire prin reducerea acesteia la operații de deplasare a biților, adunare și scădere.

## Scopul algoritmului:
Calculăm împărțirea \( Q / M = R[3:0] \) unde \( R[3:0] \) este câtul și \( R[7:4] \) este restul.

- **Q** este deîmpărțitul
- **M** este împărțitorul

## Pași Algoritmici:

### 1. Inițializarea lui \( R \)
- **\( R \)** inițial: Biții cei mai nesemnificativi (din dreapta) ai lui \( R \) vor lua valoarea lui \( Q \), restul vor fi 0.

### 2. Determinarea valorilor auxiliare \( M- \) și \( M+ \)
- **\( M- \)**: Biții cei mai semnificativi (din stânga) vor lua valoarea lui \(-M\), iar restul vor fi 0.
- **\( M+ \)**: Biții cei mai semnificativi (din stânga) vor lua valoarea lui \( M \), iar restul vor fi 0.

### 3. Verificarea semnului lui \( R \)
- Verificăm primul bit al lui \( R \) (cel mai semnificativ bit):
  - Dacă este 0 ⇒ deplasăm aritmetic la stânga pe \( R \) cu o poziție și adăugăm \( M- \) la \( R \), \( R = R + M- \)
  - Dacă este 1 ⇒ deplasăm aritmetic la stânga pe \( R \) cu o poziție și adăugăm \( M+ \) la \( R \), \( R = R + M+ \)

### 4. Setarea bitului nesemnificativ
- Verificăm din nou primul bit al lui \( R \):
  - Dacă este 0 ⇒ setăm ultimul bit (cel mai nesemnificativ) al lui \( R \) pe 1.
  - Dacă este 1 ⇒ setăm ultimul bit (cel mai nesemnificativ) al lui \( R \) pe 0.

### 5. Repetarea pașilor 3 și 4
- Pașii 3 și 4 se repetă de \( n \) ori (unde \( n = 4 \), numărul de biți al lui \( R \)).

### 6. Verificarea finală a semnului lui \( R \)
- Verificăm primul bit al lui \( R \) o ultimă dată:
  - Dacă este 0 ⇒ nu modificăm nimic.
  - Dacă este 1 ⇒ adăugăm la \( R \) pe \( M+ \), \( R = R + M+ \).

### 7. Extragerea câtului și a restului din \( R \)
- **Câtul**: \( R[3:0] \)
- **Restul**: \( R[7:4] \)

Această metodologie permite împărțirea eficientă în UAL, reducând numărul de operații complicate necesare și utilizând operații mai simple de adunare, scădere și deplasare pentru a determina câtul și restul unei împărțiri.
