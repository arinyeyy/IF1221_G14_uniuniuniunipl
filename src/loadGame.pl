daftarkanPemain([]).
daftarkanPemain([Nama|T]) :-
    assertz(pemain(Nama)),
    daftarkanPemain(T).

loadUrutanPemain(S) :-
  read(S, urutan_pemain(Urutan)),
  retractall(allPemain(_)),
  retractall(pemain(_)),
  asserta(allPemain(Urutan)),
  daftarkanPemain(Urutan).

loadGiliran(S) :-
  read(S, giliran(PemainTerkini)),
  retractall(giliran(_)),
  asserta(giliran(PemainTerkini)),
  allPemain(Urutan),
  cariPosisi(Urutan, PemainTerkini, Idx),
  retractall(nomorGiliran(_)),
  asserta(nomorGiliran(Idx)).

loadDiscardPileTop(S) :-
  read(S, discard_top(W, J)),
  retractall(discardPileTop(_)),
  asserta(discardPileTop([kartu(W, J)])).

loadWarnaAktif(S) :-
  read(S, warna_aktif(Warna)),
  retractall(warnaWildTerpilih(_)),
  asserta(warnaWildTerpilih(Warna)).
loadWarnaAktif(_).

loadGame :-
  write('Masukkan nama file yang akan dimuat: '), read(NamaFile), nl,
  sambung_txt(NamaFile, FileNama),
  (   open(FileNama, read, S) ->
      loadUrutanPemain(S),
      loadGiliran(S),
      loadDiscardPileTop(S),
      loadWarnaAktif(S),
      close(S),
      format('Status permainan berhasil dimuat dari ~w.~n', [FileNama]),
      giliran(PemainTerkini),
      format('Melanjutkan giliran ~w.~n', [PemainTerkini])
  ;
      format('File ~w tidak ditemukan!~n', [FileNama])
  ).
