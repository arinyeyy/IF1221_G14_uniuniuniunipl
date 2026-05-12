:- include('main.pl').
:- dynamic(giliranSekarang/1). /*Menyimpan indeks pemain yang sedang giliran (0..N-1)*/
:- dynamic(discardPile/1).     /*List kartu di discard pile, [Top|Rest]*/
:- dynamic(deck/1).            /*List kartu yang tersedia untuk diambil*/
:- dynamic(arahMain/1).        /*1 untuk normal, -1 untuk reverse*/

discardPile([merah-6,kuning-5,hijau-3,biru-1]).

cekInfo :-
    discardPile([Top|_]),
    format('Kartu discard top: ~w-~n', [Top]),
    nl,
    allPemain(Urutan),
    write('Urutan pemain: '),
    writeList(Urutan),
    write('-'), nl,
    nl,
    displayAllPlayersInfo(Urutan, 1),
    giliranSekarang(Idx),
    getElement(Urutan, Idx, NamaSekarang),
    format('Giliran: ~w.~n', [NamaSekarang]),
    !.

displayAllPlayersInfo([], _).
displayAllPlayersInfo([Nama|T], Index) :-
    findall(Kartu, kartuPemain(Nama, Kartu), Tangan),
    listLength(Tangan, Jumlah),
    format('Nama pemain ~w: ~w~n', [Index, Nama]),
    format('Jumlah kartu : ~w~n', [Jumlah]),
    nl,
    NextIndex is Index + 1,
    displayAllPlayersInfo(T, NextIndex).