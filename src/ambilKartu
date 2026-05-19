:- include('turn.pl').

ambilKartu :-
    pemainAktif(P),
    discardPileTop([kartu(_, JenisTop)]),

    (   JenisTop == draw_two ->
        Count = 2
    ;   JenisTop == wild_draw_four ->
        Count = 4
    ;   Count = 1
    ),

    ambilBeberapaKartu(P, Count, KartuDiambil),

    maplist([kartu(W,J)]>>(format('~w mendapatkan kartu: ~w-~w.~n', [P, W, J])), KartuDiambil),

    skipTurn,
    giliran(Next),
    format('Giliran ~w~n', [Next]).

ambilBeberapaKartu(_, 0, []) :- !.
ambilBeberapaKartu(P, N, [K|Rest]) :- /* fix: tambah argumen list */
    N > 0,
    retract(tumpukanKartu([K|Sisa])),
    assertz(kartuPemain(P, K)),
    retractall(tumpukanKartu(_)),
    asserta(tumpukanKartu(Sisa)),
    N1 is N - 1,
    ambilBeberapaKartu(P, N1, Rest).
