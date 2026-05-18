kartuReverse :-
    allPemain(List),
    pemainAktif(P),

    reverse(List, NewList),

    retractall(allPemain(_)),
    asserta(allPemain(NewList)),

    % cari posisi pemain di list baru
    getIndex(NewList, P, OldIndex),

    listLength(NewList, Len),

    NextIndex is (OldIndex mod Len) + 1,
    getElement(NewList, NextIndex, NextP),

    retractall(nomorGiliran(_)),
    asserta(nomorGiliran(NextIndex)),

    write('Arah permainan dibalik!'), nl,
    format('Giliran ~w.~n', [NextP]).
