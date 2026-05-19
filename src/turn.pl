pemainAktif(P) :-
    allPemain(List),
    nomorGiliran(N),
    getElement(List, N, P). /* fix: hapus mod, N sudah valid index */

nextPlayer(NextP, NextN) :-
    allPemain(List),
    nomorGiliran(N),
    listLength(List, Len),

    NextN is (N mod Len) + 1,
    getElement(List, NextN, NextP).

skipTurn :-
    allPemain(List),
    listLength(List, Len),
    nomorGiliran(N),

    NextN is (N mod Len) + 1,
    getElement(List, NextN, NextP),

    retractall(nomorGiliran(_)),
    asserta(nomorGiliran(NextN)),

    retractall(giliran(_)),
    asserta(giliran(NextP)).
