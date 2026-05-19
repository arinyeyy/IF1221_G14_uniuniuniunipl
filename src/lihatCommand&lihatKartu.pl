lihatCommand :-
    write('Aksi utama yang tersedia:'), nl,
    write('1. ambilKartu'), nl,
    write('2. tantang'), nl,
    nl,
    write('Aksi pendukung yang tersedia:'), nl,
    write('1. lihatCommand'), nl,
    write('2. lihatKartu'), nl,
    write('3. cekInfo'), nl.

/* lihatKartu :-
    allPemain([PemainAktif|_]),
    write('Berikut kartu yang anda miliki.'), nl,
    findall(kartu(W,J), kartuPemain(PemainAktif, kartu(W,J)), DaftarKartu),
    tampilkanKartu(DaftarKartu, 1). */

lihatKartu :-
    giliran(PemainAktif),
    write('Berikut kartu yang anda miliki.'), nl,
    findAllKartuPemain(PemainAktif, DaftarKartu),
    tampilkanKartu(DaftarKartu, 1).

tampilkanKartu([], _).

/* tampilkanKartu([kartu(W,J)|T], N) :-
    kartuTersembunyi(kartu(W,J)), !,
    format('~w. ~w-~w (disembunyikan)~n', [N, W, J]),
    N1 is N + 1,
    tampilkanKartu(T, N1). */
    
tampilkanKartu([kartu(W,J)|T], N) :-
    format('~w. ~w-~w~n', [N, W, J]),
    N1 is N + 1,
    tampilkanKartu(T, N1).
