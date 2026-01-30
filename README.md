# Movfuscator - x86 Assembly
&emsp;  Acest proiect reprezintă o implementare a unui **Movfuscator**, un program care transformă cod Assembly x86 (sintaxa AT&T, 32-bit) într-un cod echivalent funcțional, dar care înlocuiește instrucțiunile aritmetice și de control clasice cu secvențe complexe bazate preponderent pe instrucțiunea MOV, manipularea memoriei și tabele de căutare **(Look-Up Tables)**. 

&emsp;  Proiectul demonstrează conceptul de **"One Instruction Set Computer" (OISC)**, ilustrând faptul că instrucțiunea de mutare a datelor (împreună cu mecanisme minime de adresare și control) este suficientă pentru a efectua calcule Turing-complete. 

&emsp;  Programul este scris în **Python** și funcționează ca un transpilator. Acesta parsează un fișier intrare .s (Assembly x86), identifică instrucțiunile standard (add, sub, mul, div, and, or, xor, jmp, loop etc.) și le înlocuiește cu blocuri de cod expandate care simulează comportamentul original folosind o logică bazată pe memorie. Scopul este de a elimina dependența de Unitatea Aritmetică și Logică standard a procesorului pentru operațiile matematice și de a înlocui instrucțiunile clasice de salt cu manipulări ale stivei. 

&emsp;  Menționăm faptul că implementarea realizată nu este un movfuscator complet bazat exclusiv pe instrucțiuni MOV, deoarece anumite instrucțiuni fundamentale precum shl, shr, cmp și ret au fost necesare pentru funcționarea corectă a algoritmilor implementați. 
Instrucțiunile de tip shift (shl/shr) sunt indispensabile pentru extragerea și reconstruirea biților în cadrul operațiilor aritmetice, cmp este necesară pentru realizarea comparațiilor și a controlului condițional, iar ret este utilizată ca mecanism principal pentru implementarea salturilor indirecte prin manipularea stivei. 
În cadrul proiectului nu am identificat o metodă practică și generală de eliminare completă a acestor instrucțiuni fără a compromite corectitudinea sau fără a introduce o complexitate excesivă. 

## Detalii Tehnice de Implementare
### Eliminarea Operațiilor Logice Standard prin Look-Up Tables 
&emsp; În loc să utilizeze instrucțiunile native ale procesorului (AND, OR, XOR), programul generează în secțiunea .data tabele masive de date precalculate: 
-	**Tabelele table_and și table_or**: Sunt generate matrice de 256x256 de octeți. Operațiile logice pe 32 de biți sunt sparte în 4 operații pe câte 8 biți. Programul folosește valorile operanzilor ca indecși (offset-uri) în aceste tabele pentru a "căuta" rezultatul în memorie, în loc să-l calculeze. 
Această tehnică permite eliminarea completă a operațiilor logice native și înlocuirea lor cu acces indirect în memorie, ceea ce contribuie semnificativ la obfuscarea codului. 
- **Simulare XOR și NOT: Pentru XOR**: se utilizează o descompunere la nivel de bit și tabele de adevăr binare (table_xor), reconstruind rezultatul bit cu bit pentru a permite implementarea ulterioară a sumatorului complet.

### Emularea Aritmeticii  

&emsp; Transpilatorul tratează fiecare instrucțiune aritmetică (add, sub, mul, div) modular, implementând funcții dedicate în Python (ex: functions.add(src, dest)) care primesc ca parametri regiștrii sursă și destinație (sau valori imediate) extrași din codul original. Aceste funcții traduc instrucțiunea astfel: 
### **Adunarea (ADD)**
#### Funcția primește parametrii src (sursă) și dest (destinație), care pot fi registre sau valori imediate. 
&emsp; **Algoritm**: 
-	Se salvează toți regiștrii generali în buffere de memorie (copy_add_reg) pentru a proteja contextul execuției (acest pas este esențial pentru a preveni coruperea registrelor în timpul simulării operației). 
-	Se extrag biții individuali ai operanzilor src și dest și se stochează în vectori de memorie temporari. 
-	Se inițializează variabila carry (transport) cu 0. 
-	Se iterează prin toți cei 32 de biți: 
-	Se calculează suma parțială folosind tabela XOR (bit_sum = bit_A ^ bit_B). 
-	Se calculează noul carry folosind tabelele AND și OR, pe baza formulei hardware: Cout = (A & B) | (Cin & (A ^ B)). 
-	Se determină bitul final de rezultat prin XOR între suma parțială și old_carry, salvând rezultatul în buffer-ul destinație. 
-	Se reconstruiește valoarea finală pe 32 de biți din vectorul de biți rezultat și se mută în registrul dest. 
-	Se restaurează regiștrii salvați inițial.
  
 ### **Scăderea (SUB)**
 #### Funcția primește parametrii src (sursă) și dest (destinație), care pot fi registre sau valori imediate.
 &emsp; **Algoritm**: 
 -	Se salvează temporar registrul %ebp în memorie (copy_sub_ebp) pentru a fi folosit ca spațiu de lucru. 
-	Valoarea sursă (src) este mutată în %ebp. 
-	Se apelează funcția not_op pe %ebp pentru a inversa toți biții (Complementul față de 1). 
-	Se apelează funcția add pentru a adăuga valoarea imediată $1 la %ebp, obținând astfel Complementul față de 2 (negativul valorii sursă). 
-	Se apelează funcția add între %ebp (care conține -src) și dest, realizând efectiv operația dest = dest + (-src). 
-	La final, se restaurează valoarea originală a registrului %ebp. 

### Înmulțirea (MUL)
#### Emulează comportamentul instrucțiunii hardware mul (înmulțire fără semn) printr-o implementare software a algoritmului "Shift-and-Add". Primește doar operandul sursă (src), deoarece în arhitectura x86 înmulțirea se face implicit cu registrul %eax, iar rezultatul este stocat în perechea %edx:%eax  
 &emsp; **Algoritm**:
- Salvează starea registrelor curente pentru a nu corupe datele în timpul calculului. 

- Inițializează un acumulator (%ecx) cu 0. 

- Iterează prin toți cei 32 de biți ai multiplicatorului (valoarea originală din %eax): 

- Verifică fiecare bit al multiplicatorului. 

- Folosește o structură de salt condiționat simulat (cmp și funcția j) pentru a decide dacă execută adunarea. 

- Dacă bitul curent este 1, adună valoarea multiplicandului (src), shiftată corespunzător la stânga (după poziția bitului curent), la acumulator. 

- Rezultatul final acumulat în %ecx este mutat în registrul %eax. 

- Restaurează registrele salvate inițial. 
### Împărțirea (DIV) 
#### Emulează instrucțiunea de împărțire fără semn, implementând algoritmul "Restoring Division" (sau o variantă de Shift-and-Subtract) bit cu bit. Funcția primește un singur parametru src (împărțitorul). Deîmpărțitul este implicit în %eax, iar la final câtul va fi în %eax și restul în %edx. 
 &emsp; **Algoritm**:
- Se salvează toți regiștrii generali (copy_div_reg). 

- Se inițializează: %esi cu deîmpărțitul (%eax), %edi cu împărțitorul (src), %ecx (câtul) cu 0 și %edx (restul partial) cu 0. 

- Se execută o buclă descrescătoare de la bitul 31 la 0: 

- Se shiftează restul curent (%edx) la stânga cu 1 bit. 

- Se extrage bitul i din deîmpărțitul %esi și se adaugă în LSB-ul restului (%edx) folosind operații logice. 

- Se compară restul (%edx) cu împărțitorul (%edi). 

- Se folosește un salt condiționat simulat (j) pentru a decide pasul următor: 

- Dacă restul este mai mare sau egal cu împărțitorul, se scade împărțitorul din rest (apelând sub) și se setează bitul i din cât (%ecx) la 1. 

- La final, câtul din %ecx este mutat în %eax. 

- Se restaurează regiștrii salvați, păstrând rezultatele în %eax și %edx.
  ## Control Flow prin Manipularea Stivei
 &emsp;  Proiectul elimină instrucțiunile de salt direct (jmp) și salt condiționat (je, jne, jg, etc.) printr-un mecanism de manipulare a registrului EIP: 
 - **JMP**: Este tradus prin push adresa_destinatie urmat de ret. Astfel, procesorul este păcălit să "revină" direct la adresa dorită. 

- **Salturi Condiționate**: Folosesc instrucțiunea cmov (Conditional Move). Se încarcă două adrese posibile (adresa de salt și adresa instrucțiunii următoare), iar cmov selectează una dintre ele în funcție de flag-uri. Rezultatul selectat este pus pe stivă și apelat prin ret, eliminând astfel branching-ul clasic la nivel de cod sursă vizibil.

- **Bucle (LOOP)**: Sunt descompuse în decrementări și verificări explicite ale registrului %ecx, folosind același mecanism de push/ret pentru a decide dacă se reia iterația sau se continuă execuția.
## Managementul Memoriei 
 &emsp; Transpilatorul alocă automat spațiu în .bss pentru salvarea temporară a registrelor (copy_eax, copy_ebx, etc.) în timpul emulării instrucțiunilor complexe, asigurând că starea procesorului este consistentă între blocurile de cod obfuscat. Această strategie este necesară deoarece fiecare instrucțiune obfuscată poate utiliza registre auxiliare, iar salvarea/restaurarea lor garantează păstrarea semanticii programului original. 

 ## Echipa
-Dănoiu Antonie - Grupa 141 

-Bădoi Raluca-Maria - Grupa 141 

-Lepădatu Denisa-Gabriela - Grupa 141 

-Tudorache Dumitru Robert - Grupa 141 
