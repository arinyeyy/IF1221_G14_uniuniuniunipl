ambilKartu :-
    giliran(Pemain),
    ambilBeberapaKartu(Pemain, 1),
    nomorGiliran(Num),
    beriGiliranNormal(Num).

ambilBeberapaKartu(_, 0) :- !.
ambilBeberapaKartu(Pemain, Count) :-
    Count > 0,
    retract(tumpukanKartu([K|Sisa])),
    K = kartu(W, J),
    format('~w mengambil kartu: ~w-~w.~n~n', [Pemain, W,J]),
    assertz(kartuPemain(Pemain, K)),
    retractall(tumpukanKartu(_)),
    asserta(tumpukanKartu(Sisa)),
    Count1 is (Count - 1),
    ambilBeberapaKartu(Pemain, Count1).

ambilBeberapaKartu(Pemain, Count) :-
    tumpukanKartu(ListKartu),
    listLength(ListKartu, Len),
    Count > Len,
    reshuffleTemp,
    ambilBeberapaKartu(Pemain, Count).

reshuffleTemp :-
    temp(Kartu),
    tumpukanKartu(ListLama),
    randomizeList(Kartu, KartuBaru),
    concatList(ListLama, KartuBaru, ListBaru),
    retractall(temp(_)),
    asserta(temp([])),
    retractall(tumpukanKartu(_)),
    asserta(tumpukanKartu(ListBaru)).