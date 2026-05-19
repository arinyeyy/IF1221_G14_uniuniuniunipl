kartuSkip :-
    allPemain(List),
    listLength(List, Len),
    nomorGiliran(N),

    Next is (((N + 1) mod Len) + 1),
    getElement(List, Next, PemainBaru),

    retractall(giliran(_)),
    asserta(giliran(PemainBaru)),

    retractall(nomorGiliran(_)),
    asserta(nomorGiliran(Next)),

    write('Giliran diskip.'), nl,
    format('Sekarang giliran ~w.~n', [PemainBaru]).
