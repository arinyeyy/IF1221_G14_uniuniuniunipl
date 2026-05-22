pemainAktif(P) :-
    allPemain(AllPemain),
    nomorGiliran(N),
    getElement(AllPemain, N, P).

nextPlayer(NextP, NextN) :-
    allPemain(AllPemain),
    nomorGiliran(N),
    listLength(AllPemain, Len),

    NextN is (N + 1) mod Len,
    getElement(AllPemain, NextN, NextP).

skipTurn :-
    allPemain(AllPemain),
    listLength(AllPemain, Len),
    nomorGiliran(N),

    NextN is (N + 1) mod Len,
    getElement(AllPemain, NextN, NextP),

    retractall(nomorGiliran(_)),
    asserta(nomorGiliran(NextN)),

    retractall(giliran(_)),
    asserta(giliran(NextP)).
