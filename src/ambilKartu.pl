ambilKartu :-
    giliran(Pemain),
    ambilBeberapaKartu(Pemain, 1),
    skipTurn.

ambilBeberapaKartu(Pemain, Count) :-
    ambilBeberapaKartuHelper(Pemain, Count, _).

ambilBeberapaKartuHelper(_, 0, []) :- !.
ambilBeberapaKartuHelper(Pemain, N, [K|Rest]) :- 
    N > 0,
    retract(tumpukanKartu([K|Sisa])),
    K = kartu(W, J),
    format('~w mengambil kartu: ~w-~w~n', [Pemain, W,J]),
    assertz(kartuPemain(Pemain, K)),
    retractall(tumpukanKartu(_)),
    asserta(tumpukanKartu(Sisa)),
    N1 is N - 1,
    ambilBeberapaKartuHelper(Pemain, N1, Rest).

ambilBeberapaKartuHelper(Pemain, N, Rest) :-
    tumpukanKartu(ListKartu),
    listLength(ListKartu, Len),
    N > Len,
    reshuffleTemp,
    ambilBeberapaKartuHelper(Pemain, N, Rest).

reshuffleTemp :-
    temp(Kartu),
    tumpukanKartu(ListLama),
    randomizeList(Kartu, KartuBaru),
    concatList(ListLama, KartuBaru, ListBaru),
    retractall(temp(_)),
    asserta(temp([])),
    retractall(tumpukanKartu(_)),
    asserta(tumpukanKartu(ListBaru)).