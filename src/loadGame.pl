daftarkanPemain([]).
daftarkanPemain([Nama|T]) :-
  assertz(pemain(Nama)),
  daftarkanPemain(T).

loadMode(S) :-
  read(S, mode:Mode),
  retractall(mode(_)),
  (
    Mode == turnamen ->
    asserta(mode(2))
    ;
    asserta(mode(1))
  ).

loadUrutanPemain(S) :-
  read(S, urutan_pemain:Urutan),
  retractall(allPemain(_)),
  retractall(pemain(_)),
  asserta(allPemain(Urutan)),
  daftarkanPemain(Urutan).

loadGiliran(S) :-
  read(S, giliran:PemainTerkini),
  retractall(giliran(_)),
  asserta(giliran(PemainTerkini)),
  allPemain(Urutan),
  cariPosisi(Urutan, PemainTerkini, Idx),
  retractall(nomorGiliran(_)),
  asserta(nomorGiliran(Idx)).

loadDiscardPileTop(S) :-
  read(S, discard_top:Term),
  Term = W-J,
  retractall(discardPileTop(_)),
  asserta(discardPileTop([kartu(W, J)])).

loadWarnaAktif(S) :-
  read(S, warna_aktif:Warna),
  retractall(warnaWildTerpilih(_)),
  asserta(warnaWildTerpilih(Warna)), !.
loadWarnaAktif(_).

loadArah(S) :-
  read(S, arah_permainan:Arah),
  retractall(arahMain(_)),
  asserta(arahMain(Arah)).

loadStatusUNI(S) :-
  read(S, status_uni:StatUni),
  retractall(riwayatUNI(_)),
  asserta(riwayatUNI(StatUni)).

loadKartuPemain(S) :-
  allPemain(Urutan),
  listLength(Urutan, N),
  helperLoadKartuPemain(S, N).

helperLoadKartuPemain(_, 0) :- !.
helperLoadKartuPemain(S, N) :-
    read(S, Line),
    Line = kartu(Pemain): ListKartu,
    retractall(kartuPemain(Pemain,_)),
    daftarkanKartuSatuPemain(Pemain, ListKartu),
    N1 is N-1,
    helperLoadKartuPemain(S, N1).

daftarkanKartuSatuPemain(_, []) :- !.
daftarkanKartuSatuPemain(Pemain, [Kartu|Sisa]) :-
    asserta(kartuPemain(Pemain, Kartu)),
    daftarkanKartuSatuPemain(Pemain, Sisa).

/* loadMode(S) :-
    read_term(S, 'mode':Mode, []),
    retractall(mode(_)),
    (Mode == turnamen -> asserta(mode(2)) ; asserta(mode(1))). */

loadKartuAksiTerakhir(S) :-
  read(S, kartu_aksi_terakhir:Term),
  (
    Term == tidak_ada ->
    retractall(kartuAksiTerakhir(_,_)),
    retractall(giliranAksiTerakhir(_,_))
  ;
    Term = ((W-J)-Pemain)-Count,
    retractall(kartuAksiTerakhir(_,_)),
    asserta(kartuAksiTerakhir(W, J)),
    retractall(giliranAksiTerakhir(_,_)),
    asserta(giliranAksiTerakhir(Pemain,Count))
  ).

loadKartuTersembunyi(S) :-
  allPemain(Urutan),
  listLength(Urutan, N),
  helperLoadKartuTersembunyi(S, N).

helperLoadKartuTersembunyi(_, 0) :- !.
helperLoadKartuTersembunyi(S, N) :-
  read(S, kartu_tersembunyi(Pemain):ListKartuTersembunyi),
  retractall(kartuTersembunyi(Pemain, _)),
  daftarkan1PemainKT(Pemain, ListKartuTersembunyi),
  N1 is N - 1,
  helperLoadKartuTersembunyi(S, N1).

daftarkan1PemainKT(_, []) :- !.
daftarkan1PemainKT(Pemain, [H|T]) :-
  asserta(kartuTersembunyi(Pemain, H)),
  daftarkan1PemainKT(Pemain, T).

loadTim(S) :-
  read(S, tim(1):Tim1),
  read(S, tim(2):Tim2),
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
  (
    \+gameStarted ->
    write('Masukkan nama file yang akan dimuat: '), read(NamaFile), nl,
    sambung_txt(NamaFile, FileNama),
    ( open(FileNama, read, S) ->
      asserta(gameStarted),
      loadMode(S),
      loadUrutanPemain(S),
      loadGiliran(S),
      loadDiscardPileTop(S),
      loadWarnaAktif(S),
      loadArah(S),
      loadStatusUNI(S),
      loadKartuPemain(S),
      loadKartuAksiTerakhir(S),
      loadKartuTersembunyi(S),
      (mode(2) -> loadTim(S) ; true),
      close(S),
      format('Status permainan berhasil dimuat dari ~w.~n', [FileNama]),
      giliran(PemainTerkini),
      format('Melanjutkan giliran ~w.~n', [PemainTerkini])
    ;
      format('File ~w tidak ditemukan!~n', [FileNama])
    )
    ;
    format('Permainan sudah dimulai!~n', [])
  ).
