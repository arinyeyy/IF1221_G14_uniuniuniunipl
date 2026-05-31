lihatKartu :-
    giliran(PemainAktif),
    format('Berikut kartu yang ~w miliki:~n', [PemainAktif]),
    findAllKartuPemain(PemainAktif, DaftarKartu),
    tampilkanKartu(PemainAktif, DaftarKartu, 1),
    (mode(2) ->
        setim(PemainAktif, Teman),
        nl,
        format('Berikut kartu yang teman satu tim anda miliki (~w).~n', [Teman]),
        findAllKartuPemain(Teman, KartuTeman),
        tampilkanKartu(Teman, KartuTeman, 1)
    ; true).

tampilkanKartu(_, [], _).
tampilkanKartu(Pemain, [kartu(W,J)|T], N) :-
    kartuTersembunyi(Pemain, kartu(W,J)), !,
    format('~w. ~w-~w (disembunyikan)~n', [N, W, J]),
    N1 is N + 1,
    tampilkanKartu(Pemain, T, N1).
tampilkanKartu(Pemain, [kartu(W,J)|T], N) :-
    format('~w. ~w-~w~n', [N, W, J]),
    N1 is N + 1,
    tampilkanKartu(Pemain, T, N1).
