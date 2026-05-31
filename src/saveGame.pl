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
            format('Status permainan berhasil disimpan ke ~w.~n', [FileNama]),
            retractSemua. 

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
                        format(S, 'urutan_pemain:~w.~n', [Urutan]).

writeGiliran(S) :- giliran(PemainTerkini),
                   format(S, 'giliran:~w.~n', [PemainTerkini]).

writeDiscardPileTop(S) :- discardPileTop([kartu(W,J)]),
                          format(S, 'discard_top:~w-~w.~n', [W,J]).

writeWarnaAktif(S) :- (warnaWildTerpilih(Warna) ->
                       format(S, 'warna_aktif:~w.~n', [Warna])
                      ;
                       discardPileTop([kartu(W,J)]),
                       format(S, 'warna_aktif:~w.~n', [W])
                      ).

writeArah(S) :- arahMain(Arah), format(S, 'arah_permainan:~w.~n', [Arah]).

writeStatusUNI(S):- (riwayatUNI(Pemain) ->
                     format(S, 'status_uni:~w.~n', [Pemain])
                     ;
                     format(S, 'status_uni:[].~n', [])
                    ).

writeKartu(S) :- allPemain(Urutan),
                 kartuPemainSaatSave(Urutan, S).

kartuPemainSaatSave([], _).
kartuPemainSaatSave([Nama|T], S) :-
    findAllKartuPemain(Nama, DaftarKartu),
    format(S, 'kartu(~w):[', [Nama]),
    writeKartuSatuPemain(S, DaftarKartu),
    kartuPemainSaatSave(T, S).

writeKartuSatuPemain(_, []) :- !.
writeKartuSatuPemain(S, [H]) :- !,
    H = kartu(W, J),
    format(S, '~w-~w].~n', [W, J]).
writeKartuSatuPemain(S, [H|T]) :-
    H = kartu(W, J),
    format(S, '~w-~w,', [W, J]),
    writeKartuSatuPemain(S, T).
    

writeKartuAksiTerakhir(S) :- (kartuAksiTerakhir(W, J), giliranAksiTerakhir(PemainAksi, Count) ->
                              format(S, 'kartu_aksi_terakhir:~w-~w-~w-~w.~n', 
                              [W, J, PemainAksi, Count])
                              /* kartu(W, J), oleh PemainAksi Count lalu */
                             ;
                              write(S, 'kartu_aksi_terakhir:tidak_ada.'), nl(S)
                             ).
                          

writeKartuTersembunyi(S) :- allPemain(Urutan),
                            kartuTersembunyiSaatSave(Urutan, S).

writeTim(S):-
    tim(1, Tim1), tim(2, Tim2), 
    format(S, 'tim(~w):~w.~n', [1, Tim1]),
    format(S, 'tim(~w):~w.~n', [2, Tim2]).

/* writeMode(S):- (mode(1) -> 
            format(S, ' mode:~w.~n', [klasik])
            ;
            format(S, ' mode:~w.~n', [turnamen])). */
 
  
kartuTersembunyiSaatSave([], _).
kartuTersembunyiSaatSave([Nama|T], S) :-
    ( kartuTersembunyi(Nama, KartuYGTersembunyi) ->
        format(S, 'kartu_tersembunyi(~w):~w.~n', [Nama, KartuYGTersembunyi])
    ;
        format(S, 'kartu_tersembunyi(~w):[].~n', [Nama])
    ),
    kartuTersembunyiSaatSave(T, S).

retractSemua :-
    retractall(gameStarted),
    retractall(allPemain(_)),
    retractall(mode(_)),
    retractall(giliran(_)),
    retractall(discardPileTop(_)),
    retractall(warnaWildTerpilih(_)),
    retractall(kartuPemain(_,_)),
    retractall(kartuAksiTerakhir(_,_)),
    retractall(giliranAksiTerakhir(_,_)),
    retractall(kartuTersembunyi(_,_)),
    retractall(tim(_,_)).