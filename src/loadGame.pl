daftarkanPemain([]).
daftarkanPemain([Nama|T]) :-
    assertz(pemain(Nama)),
    daftarkanPemain(T).

loadUrutanPemain(S) :-
    read_term(S, urutan_pemain:Urutan, []),
    retractall(allPemain(_)),
    retractall(pemain(_)),
    asserta(allPemain(Urutan)),
    daftarkanPemain(Urutan).

loadGiliran(S) :-
    read_term(S, giliran:PemainTerkini, []),
    retractall(giliran(_)),
    asserta(giliran(PemainTerkini)),
    allPemain(Urutan),
    cariPosisi(Urutan, PemainTerkini, Idx),
    retractall(nomorGiliran(_)),
    asserta(nomorGiliran(Idx)).

loadDiscardPileTop(S) :-
    read_term(S, discard_top:(W-J), []),
    retractall(discardPileTop(_)),
    asserta(discardPileTop([kartu(W,J)])).

loadWarnaAktif(S) :-
    read_term(S, warna_aktif:Warna, []),
    retractall(warnaWildTerpilih(_)),
    asserta(warnaWildTerpilih(Warna)).

loadArah(S) :-
    read(S, arah_permainan(Arah)),
    retractall(arahMain(_)),
    asserta(arahMain(Arah)).

loadStatusUNI(S) :-
    read(S, status_UNI(StatUni)),
    retractall(riwayatUNI(_)),
    asserta(riwayatUNI(StatUni)).

loadKartuPemain(S) :- allPemain(Urutan), listLength(Urutan, N), helperLoadKartuPemain(S, N).

helperLoadKartuPemain(_, 0) :- !.
helperLoadKartuPemain(S, N) :-
    read(S, Line),
    Line = kartu(Pemain, ListKartu),
    retractall(kartuPemain(Pemain,_)),
    daftarkanKartuSatuPemain(Pemain, ListKartu),
    N1 is N-1,
    helperLoadKartuPemain(S, N1).

daftarkanKartuSatuPemain(_, []) :- !.
daftarkanKartuSatuPemain(Pemain, [Kartu|Sisa]) :-
    asserta(kartuPemain(Pemain, Kartu)),
    daftarkanKartuSatuPemain(Pemain, Sisa).

loadMode(S) :-
    read_term(S, ' mode':Mode, []),
    retractall(mode(_)),
    (Mode == turnamen -> asserta(mode(2)) ; asserta(mode(1))).

loadTim(S) :-
    read_term(S, ' Tim'(1):Tim1, []),
    read_term(S, ' Tim'(2):Tim2, []),
    retractall(tim(_, _)),
    retractall(setim(_, _)),
    asserta(tim(1, Tim1)),
    asserta(tim(2, Tim2)),
    Tim1 = [T1P1, T1P2],
    Tim2 = [T2P1, T2P2],
    asserta(setim(T1P1, T1P2)),
    asserta(setim(T1P2, T1P1)),
    asserta(setim(T2P1, T2P2)),
    asserta(setim(T2P2, T2P1)).

loadGame :-
    \+gameStarted,
    write('Masukkan nama file yang akan dimuat: '), read(NamaFile), nl,
    sambung_txt(NamaFile, FileNama),
    (open(FileNama, read, S) ->
        loadUrutanPemain(S),
        loadGiliran(S),
        loadDiscardPileTop(S),
        loadWarnaAktif(S),
        loadArah(S),
        loadStatusUNI(S),
        loadKartuPemain(S),
        loadKartuAksiTerakhir(S),
        loadKartuTersembunyi(S),
        (mode(2) -> loadMode(S), loadTim(S) ; true),
        close(S),
        asserta(gameStarted),
        format('Status permainan berhasil dimuat dari ~w.~n', [FileNama]),
        giliran(PemainTerkini),
        format('Melanjutkan giliran ~w.~n', [PemainTerkini])
    ;
        format('File ~w tidak ditemukan!~n', [FileNama])
    ).
