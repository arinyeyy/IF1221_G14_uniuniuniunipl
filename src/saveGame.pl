saveGame :- write('Masukkan nama file penyimpanan: '), 
            read(NamaFile), nl, 
            sambung_txt(NamaFile, FileNama), 
            createFile(FileNama),
            format('Status permainan berhasil disimpan ke ~w.~n', [FileNama]).

sambung_txt(NamaFile, FileNama):-name(NamaFile, HasilFile), 
                                 name('.txt', Txt), 
                                 concatList(HasilFile, Txt, Hasil), 
                                 name(FileNama, Hasil). 
      
createFile(FileNama):- 
  open(FileNama, write, S), 
  writeUrutanPemain(S),
  writeGiliran(S),
  writeDiscardPileTop(S),
  writeWarnaAktif(S),
  writeArah(S),
  writeStatusUNI(S),
  writeKartu(S),
  writeKartuAksiTerakhir(S),
  %writeKartuTersembunyi(S),
  close(S).
  

writeUrutanPemain(S) :- allPemain(Urutan),
                     format(S, 'urutan_pemain: ~w.~n', [Urutan]).

writeGiliran(S) :- giliran(PemainTerkini),
                format(S, 'giliran: ~w.~n', [PemainTerkini]).

writeDiscardPileTop(S) :- discardPileTop([kartu(W,J)]),
                       format(S, 'discard_top: ~w-~w.~n', [W,J]).

writeWarnaAktif(S) :- (warnaWildTerpilih(Warna) ->
                   format(S, 'warna_aktif: ~w.~n', [Warna])
                   ;
                   format(S, 'warna_aktif: [].~n', [])).

writeArah(S) :- arahMain(Arah), format(S, 'arah_permainan:~w.~n', [Arah]).

writeStatusUNI(S):- (riwayatUNI(Pemain) ->
                    format(S, 'status Unu:~w.~n', [Pemain])
                    ;
                    format(S, 'status Unu: [].~n', [])).

writeKartu(S) :- giliran(PemainTerkini),
              findAllKartuPemain(PemainTerkini, DaftarKartu),
              format(S, "kartu(~w): [~w].~n", [PemainTerkini, DaftarKartu]).

writeKartuAksiTerakhir(S) :- kartuAksiTerakhir(W, J), giliranAksiTerakhir(PemainAksi, Count) ->
                          (
                            format(S, "kartu_aksi_terakhir: ~w-~w (oleh ~w, ~w giliran lalu).~n", 
                            [W, J, PemainAksi, Count])
                          ;
                            write(S, "kartu_aksi_terakhir: tidak ada."), nl
                          ).
                          

/* writeKartuTersembunyi(S) :- giliran(PemainTerkini),
                         kartuTersembunyi(PemainTerkini, KartuYGTersembunyi),
                         format(S, "kartu_tersembunyi: ~w.").
                         
                         bingung cara nampilin kartu tersembunyi tiap pemain*/
