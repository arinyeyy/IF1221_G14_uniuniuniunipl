saveGame :- write(“Masukkan nama file penyimpanan : ~w”), 
            read(NamaFile), nl, 
            sambung_txt(NamaFile, FileNama), 
            createFile(FileNama).

sambung_txt(NamaFile, FileNama):-name(NamaFile, HasilFile), 
                                 name(‘.txt’, Txt), 
                                 concatList(HasilFile,  Txt, Hasil), 
                                 name(FileNama, Hasil). 
      
createFile(FileNama):- open('FileNama', write, S), 


urutan Pemain: [‘..’, ‘..’].

writeGiliran: -giliran(PemainTerkini),
write(S, ‘giliran: ~w.’, [PemainTerkini]), nl,

discardPileTop([kartu(W,J)])
write(S, ‘discard_top: w-w.’, [W,J]), nl,

warna_aktif: 
warnaWildTerpilih(Warna),
write(S, ‘warna_aktif: ~w.’, [Warna]), nl,

arah_permainan:
write(S, ‘arah_permainan: ~w.’, [Arah]), nl,

status_UNI: [(siapa aja yg udh uni)]
write(S, ‘status_UNI: ~w.’, [Warna]), nl,

kartu(‘..’): 
write(S, ‘kartu(~w): ~w.’, [Pemain, kartuPemain]), nl,
