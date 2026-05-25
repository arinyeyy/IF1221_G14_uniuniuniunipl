saveGame :- 
    write(“Masukkan nama file penyimpanan : ~w”), read(NamaFile), nl, 
    sambung_txt(NamaFile, FileNama), createFile(FileNama),

sambung_txt(NamaFile, FileNama):- 
    name(NamaFile, HasilFile), name('.txt', Txt), 
    concatList(HasilFile,  Txt, Hasil), name(FileNama, Hasil). 

createFile(FileNama):- 
    open('FileNama', write, S), 
    writeUrutanPemain(S),
    writeRiwayatUni(S), 
    writeArahMain(S).

writeRiwayatUni(S):- 
    riwayatUNI(DaftarPemainUNI), 
    write(S,'Status UNI: ~w', [DaftarPemainUNI]),nl.

writeArahMain(S):-
    arahMain(Arah),
    write(S, 'arah_permainan:~w', [Arah]),nl.

writeUrutanPemain(S):-
    allPemain(AllPemain),
    write(S, 'urutan_pemain: ~w', [AllPemain]),nl.