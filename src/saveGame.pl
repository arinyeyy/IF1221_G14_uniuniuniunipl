saveGame :- giliran(Pemain),
            (\+ tantangActivated(_) ->
             true
            ;
             write('Tidak dapat melakukan saveGame'), nl, 
             write('Pilih tantang atau ambilKartu terlebih dahulu.'), nl, nl, fail
            ),
            write('Masukkan nama file penyimpanan: '), 
            read(NamaFile), nl, 
            sambung_txt(NamaFile, FileNama), 
            createFile(FileNama),
            retractall(pemain(_)),
            retractall(kartuPemain(_,_)),
            retractall(allPemain(_)),,
            retractall(discardPileTop(_)),
            retractall(giliran(_)),
            retractall(mode(_)),
            retractall(arahMain(_)),
            exitGame,
            format('Status permainan berhasil disimpan ke ~w.~n', [FileNama]). 

sambung_txt(NamaFile, FileNama):-name(NamaFile, HasilFile), 
                                 name('.txt', Txt), 
                                 concatList(HasilFile, Txt, Hasil), 
                                 name(FileNama, Hasil). 
      
createFile(FileNama):- 
    open(FileNama, write, S), 
    writeMode(S),
    (mode(2)->writeTim(S);true),
    writeUrutanPemain(S),
    writeGiliran(S),
    writeDiscardPileTop(S),
    writeWarnaAktif(S),
    writeArah(S),
    writeStatusUNI(S),
    writeKartu(S),
    writeKartuAksiTerakhir(S),
    writeKartuTersembunyi(S),
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
                       discardPileTop([kartu(W,J)]),
                       format(S, 'warna_aktif: ~w.~n', [W])
                      ).

writeArah(S) :- arahMain(Arah), format(S, 'arah_permainan: ~w.~n', [Arah]).

writeStatusUNI(S):- (riwayatUNI(Pemain) ->
                     format(S, 'status Uni: ~w.~n', [Pemain])
                     ;
                     format(S, 'status Uni: [].~n', [])
                    ).

writeKartu(S) :- allPemain(Urutan),
                 kartuPemainSaatSave(Urutan, S).

writeKartuAksiTerakhir(S) :- (kartuAksiTerakhir(W, J), giliranAksiTerakhir(PemainAksi, Count) ->
                              format(S, 'kartu_aksi_terakhir: ~w-~w (oleh ~w, ~w giliran lalu).~n', 
                              [W, J, PemainAksi, Count])
                             ;
                              write(S, 'kartu_aksi_terakhir: tidak ada.'), nl(S)
                             ).
                          

writeKartuTersembunyi(S) :- allPemain(Urutan),
                            kartuTersembunyiSaatSave(Urutan, S).

kartuPemainSaatSave([], _).
kartuPemainSaatSave([Nama|T], S) :-
    findAllKartuPemain(Nama, DaftarKartu),
    format(S, 'kartu(~w): ~w.~n', [Nama, DaftarKartu]),
    kartuPemainSaatSave(T, S).

writeTim(S):-
    tim(1, Tim1), tim(2, Tim2), 
    format(S, ' Tim1: ~w.~n', [Tim1]),
    format(S, ' Tim2: ~w.~n', [Tim2]).

writeMode(S):- (mode(1) -> 
            format(S, ' mode: ~w.~n', [kalsik])
            ;
            format(S, ' mode: ~w.~n', [turnamen])).
 
  
kartuTersembunyiSaatSave([], _).
kartuTersembunyiSaatSave([Nama|T], S) :-
    ( kartuTersembunyi(Nama, KartuYGTersembunyi) ->
        format(S, 'kartu_tersembunyi ~w: ~w.~n', [Nama, KartuYGTersembunyi])
    ;
        format(S, 'kartu_tersembunyi ~w: [].~n', [Nama])
    ),
    kartuTersembunyiSaatSave(T, S).