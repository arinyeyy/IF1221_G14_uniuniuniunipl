pemainAktif(P) :-
    allPemain(AllPemain),
    nomorGiliran(N),
    getElement(AllPemain, N, P).

pemainNext(NumPemainTerkini, PemainSelanjutnya) :-
    allPemain(AllPemain),
    listLength(AllPemain, Len),
    Num1 is (NumPemainTerkini + 1) mod Len,
    getElement(AllPemain, Num1, PemainSelanjutnya).

pemainPrev(NumPemainTerkini, PemainSebelum) :-
    allPemain(AllPemain),
    listLength(AllPemain, Len),
    Num2 is (NumPemainTerkini - 1 + Len) mod Len,
    getElement(AllPemain, Num2, PemainSebelum).

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
