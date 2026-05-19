:- dynamic(aksiYangDapatDilakukan/2).

adaKartuValid(Pemain) :-
    findAllKartuPemain(Pemain, ListKartu),
    discardPileTop([KartuAtas|_]),
    adaYangValid(ListKartu, KartuAtas).

adaYangValid([H|_], KartuAtas) :-
    valid(H, KartuAtas), !.
adaYangValid([_|T], KartuAtas) :-
    adaYangValid(T, KartuAtas).

kenaEfekDraw :-
    discardPileTop([kartu(_, JenisTop)]),
    (JenisTop == draw_two ; JenisTop == wild_draw_four).

tentukanAksi(Pemain) :-
    retractall(aksiYangDapatDilakukan(_, _)),

    % selalu bisa
    assertz(aksiYangDapatDilakukan(Pemain, tangkap)),
    assertz(aksiYangDapatDilakukan(Pemain, lihatCommand)),
    assertz(aksiYangDapatDilakukan(Pemain, lihatKartu)),
    assertz(aksiYangDapatDilakukan(Pemain, cekInfo)),
    assertz(aksiYangDapatDilakukan(Pemain, ambilKartu)),

    /*
    ambilKartu -> selalu
    mainkanKartu -> kalau ada kartu valid di tangan, gak kena efek draw
    tantang -> kalau pemain sebelumnya ngasih wild-draw-four
    uni -> kalau ada kartu valid, sisa kartu 2, gak knea efek draw
    */

    (tantangActivated(_) ->
        assertz(aksiYangDapatDilakukan(Pemain, tantang))
    ; true),

    (\+kenaEfekDraw, adaKartuValid(Pemain) ->
        assertz(aksiYangDapatDilakukan(Pemain, mainkanKartu))
    ; true),

    (\+kenaEfekDraw, findAllKartuPemain(Pemain, ListKartu), listLength(ListKartu, 2), adaKartuValid(Pemain) ->
        assertz(aksiYangDapatDilakukan(Pemain, uni))
    ; true).

lihatCommand :-
    giliran(Pemain),
    write('Aksi utama yang tersedia:'), nl,
    tulisAksiUtama(Pemain, 1, [mainkanKartu, ambilKartu, tantang, uni]),
    nl,
    write('Aksi pendukung yang tersedia:'), nl,
    write('1. tangkap'), nl,
    write('2. lihatCommand'), nl,
    write('3. lihatKartu'), nl,
    write('4. cekInfo'), nl.

tulisAksiUtama(_, _, []).
tulisAksiUtama(Pemain, N, [Aksi|T]) :-
    (aksiYangDapatDilakukan(Pemain, Aksi) ->
        format('~w. ~w~n', [N, Aksi]),
        N1 is N + 1,
        tulisAksiUtama(Pemain, N1, T)
    ;
        tulisAksiUtama(Pemain, N, T)
    ).
