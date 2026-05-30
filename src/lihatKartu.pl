lihatKartu :-
    giliran(PemainAktif),
    format('Berikut kartu yang ~w miliki:~n', [PemainAktif]),
    findAllKartuPemain(PemainAktif, DaftarKartu),
    tampilkanKartu(DaftarKartu, 1), !.

tampilkanKartu([], _) :- !.

/* tampilkanKartu([kartu(W,J)|T], N) :-
    kartuTersembunyi(kartu(W,J)), !,
    format('~w. ~w-~w (disembunyikan)~n', [N, W, J]),
    N1 is N + 1,
    tampilkanKartu(T, N1). */
    
tampilkanKartu([kartu(W,J)|T], N) :-
    format('~w. ~w-~w~n', [N, W, J]),
    N1 is N + 1,
    tampilkanKartu(T, N1).
