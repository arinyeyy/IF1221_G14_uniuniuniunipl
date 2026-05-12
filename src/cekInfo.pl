cekInfo :-
    discardPileTop([kartu(W, J)|_]),
    format('Kartu discard top: ~w-~w.~n', [W, J]),
    nl,
    allPemain(Urutan),
    write('Urutan pemain: '),
    writeList(Urutan),
    write('.'), nl,
    nl,
    displayAllPlayersInfo(Urutan, 1),
    !.

displayAllPlayersInfo([], _).
displayAllPlayersInfo([Nama|T], Index) :-
    findall(kartu(W, J), kartuPemain(Nama, kartu(W, J)), Tangan),
    listLength(Tangan, Jumlah),
    format('Nama pemain ~w: ~w~n', [Index, Nama]),
    format('Jumlah kartu : ~w~n', [Jumlah]),
    nl,
    NextIndex is Index + 1,
    displayAllPlayersInfo(T, NextIndex).