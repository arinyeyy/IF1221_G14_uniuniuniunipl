lihatCommand :-
    write('Aksi utama yang tersedia:'), nl,
    write('1. ambilKartu'), nl,
    write('2. tantang'), nl,
    nl,
    write('Aksi pendukung yang tersedia:'), nl,
    write('1. lihatCommand'), nl,
    write('2. lihatKartu'), nl,
    write('3. cekInfo'), nl.

lihatKartu :-
    allPemain([PemainAktif|_]),
    write('Berikut kartu yang anda miliki.'), nl,
    kartuPemain(PemainAktif, DaftarKartu),  %ini rulesnya belum ada btw, aku tebak dulu aja yah
    tampilkanKartu(DaftarKartu, 1).

tampilkanKartu([], _).

tampilkanKartu([H|T], N) :-
    kartuTersembunyi(H), !,
    format('~w. ~w (disembunyikan)~n', [N, H]),
    N1 is N + 1,
    tampilkanKartu(T, N1).

tampilkanKartu([H|T], N) :-
    format('~w. ~w~n', [N, H]),
    N1 is N + 1,
    tampilkanKartu(T, N1).