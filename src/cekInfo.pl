cekInfo :-
    gameStarted ->
        (
            discardPileTop([kartu(W, J)|_]),
            format('Kartu discard top: ~w-~w.~n', [W, J]),
            (mode(2)->displayTim;true),
            giliran(Pemain),
            format('Giliran saat ini: ~w.~n', [Pemain]),
            nl,
            allPemain(Urutan),
            write('Urutan pemain: '),
            writeList(Urutan),
            write('.'), nl,
            nl,
            displayAllPlayersInfo(Urutan, 1),
            !
        );
    write('Permainan belum dimulai!'), nl, nl, fail.

displayAllPlayersInfo([], _).
displayAllPlayersInfo([Nama|T], Index) :-
    findAllKartuPemain(Nama, Tangan),
    listLength(Tangan, Jumlah),
    (kartuTersembunyi(Nama, _)-> Jml is Jumlah-1; Jml is Jumlah),
    format('Nama pemain ~w: ~w~n', [Index, Nama]),
    format('Jumlah kartu : ~w~n', [Jml]),
    nl,
    NextIndex is Index + 1,
    displayAllPlayersInfo(T, NextIndex).

displayTim:-
    tim(1,[P1,P2]),
    tim(2,[P3,P4]),
    format('Tim 1: ~w, ~w', [P1,P2]),nl,
    format('Tim 1: ~w, ~w', [P3,P4]),nl.