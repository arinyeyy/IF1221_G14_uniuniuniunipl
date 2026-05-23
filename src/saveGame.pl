saveGame :- write(“Masukkan nama file penyimpanan: ”), 
            read(NamaFile), nl, 
            sambung_txt(NamaFile, FileNama), 
            createFile(FileNama).

sambung_txt(NamaFile, FileNama):-name(NamaFile, HasilFile), 
                                 name(‘.txt’, Txt), 
                                 concatList(HasilFile, Txt, Hasil), 
                                 name(FileNama, Hasil). 
      
createFile(FileNama):- open('FileNama', write, S), 

writeUrutanPemain :- allPemain(Urutan),
                     writeList(Urutan),
                     format(S, "urutan_pemain: [~w].~n", [Urutan]).

writeGiliran :- giliran(PemainTerkini),
                format(S, "giliran: ~w.~n", [PemainTerkini]).

writeDiscardPileTop :- discardPileTop([kartu(W,J)]),
                       format(S, "discard_top: ~w-~w.~n", [W,J]).

writeWarnaAktif :- warnaWildTerpilih(Warna),
                   format(S, "warna_aktif: ~w.~n", [Warna]).

arah_permainan:
write(S, ‘arah_permainan: ~w.’, [Arah]), nl,

status_UNI: [(siapa aja yg udh uni)]
write(S, ‘status_UNI: ~w.’, [Warna]), nl,

writeKartu :- giliran(PemainTerkini),
              findAllKartuPemain(PemainTerkini, DaftarKartu),
              format(S, "kartu(~w): [~w].~n", [Pemain, DaftarKartu]).

writeKartuAksiTerakhir :- kartuAksiTerakhir(W, J), giliranAksiTerakhir(PemainAksi, Count) ->
                          (
                            format(S, "kartu_aksi_terakhir: ~w-~w (oleh ~w, ~w giliran lalu).~n", 
                            [W, J, PemainAksi, Count])
                          ;
                            write(S, "kartu_aksi_terakhir: tidak ada."), nl
                          ).
                          

/* writeKartuTersembunyi :- giliran(PemainTerkini),
                         kartuTersembunyi(PemainTerkini, KartuYGTersembunyi),
                         format(S, "kartu_tersembunyi: ~w.").
                         
                         bingung cara nampilin kartu tersembunyi tiap pemain*/
