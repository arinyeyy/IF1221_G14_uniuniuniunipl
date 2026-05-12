:- use_module(library(random)).
:- dynamic(gameStarted/0).
:- dynamic(jumlahPemain/1).
:- dynamic(pemain/1).
:- dynamic(kartuPemain/2).
:- dynamic(allPemain/1).
:- dynamic(allKartu/1).
:- dynamic(tumpukanKartu/1).
:- dynamic(discardPileTop/1).

/*Fakta Kartu*/
kartu(merah, 0). 
kartu(merah, 1). 
kartu(merah, 2). 
kartu(merah, 3). 
kartu(merah, 4).
kartu(merah, 5). 
kartu(merah, 6). 
kartu(merah, 7). 
kartu(merah, 8). 
kartu(merah, 9).
kartu(hijau, 0). 
kartu(hijau, 1). 
kartu(hijau, 2). 
kartu(hijau, 3). 
kartu(hijau, 4).
kartu(hijau, 5). 
kartu(hijau, 6). 
kartu(hijau, 7). 
kartu(hijau, 8). 
kartu(hijau, 9).
kartu(biru, 0). 
kartu(biru, 1). 
kartu(biru, 2). 
kartu(biru, 3). 
kartu(biru, 4).
kartu(biru, 5). 
kartu(biru, 6). 
kartu(biru, 7). 
kartu(biru, 8). 
kartu(biru, 9).
kartu(kuning, 0). 
kartu(kuning, 1). 
kartu(kuning, 2). 
kartu(kuning, 3). 
kartu(kuning, 4).
kartu(kuning, 5). 
kartu(kuning, 6). 
kartu(kuning, 7). 
kartu(kuning, 8). 
kartu(kuning, 9).
kartu(merah, skip). 
kartu(hijau, skip). 
kartu(biru, skip). 
kartu(kuning, skip).
kartu(merah, reverse). 
kartu(hijau, reverse). 
kartu(biru, reverse). 
kartu(kuning, reverse).
kartu(merah, draw_two). 
kartu(hijau, draw_two). 
kartu(biru, draw_two). 
kartu(kuning, draw_two).
kartu(hitam, wild). 
kartu(hitam, wild_draw_four). 
kartu(hitam, mimic).

startGame :- inputJumlahPemain.
inputJumlahPemain :- write('Masukkan jumlah pemain: '), read(Jml),
                     ((Jml > 1, Jml < 5) -> (asserta(jumlahPemain(Jml)), nl, tambahPemain(Jml));
                     (write('Jumlah pemain harus di antara 2 sampai 4!'), nl, inputJumlahPemain)).

helpTambahPemain(_,0) :- randomizeUrutan. 

helpTambahPemain(X,N) :- N > 0, format('Masukkan nama pemain ~w: ', [X]), read(Nama),
                   (\+pemain(Nama) -> assertz(pemain(Nama)),
                    N1 is N - 1, X1 is X + 1, helpTambahPemain(X1, N1);
                   (pemain(Nama), sudahAdaPemain(X, N))).

sudahAdaPemain(X, N) :- N > 0, write('Pemain sudah ada! Masukkan nama lain: '), read(Nama),
                        (\+pemain(Nama) -> assertz(pemain(Nama)), X1 is X + 1, N1 is N - 1, helpTambahPemain(X1, N1);
                        pemain(Nama), sudahAdaPemain(X, N)).

tambahPemain(N) :- N > 0, X is 1, helpTambahPemain(X,N).

kocokKartu:-
    findall(kartu(W, J), kartu(W, J), AllCards),
    randomizeList(AllCards, Kocok),
    retractall(tumpukanKartu(_)),
    asserta(tumpukanKartu(Kocok)).

bagiKartu([]).
bagiKartu([Nama|Sisa]) :-
    ambilTujuh(Nama, 7),
    bagiKartu(Sisa).
 
ambilTujuh(_, 0) :- !.
ambilTujuh(Nama, N) :-
    retract(tumpukanKartu([KartuTeratas|Sisa])),
    assertz(kartuPemain(Nama, KartuTeratas)),
    asserta(tumpukanKartu(Sisa)),
    N1 is N - 1,
    ambilTujuh(Nama, N1).

discardPile :-
    retract(tumpukanKartu([kartu(W, J) | Sisa])),
    (number(J) -> 
    asserta(discardPileTop([kartu(W, J)])),asserta(tumpukanKartu(Sisa));
    append(Sisa, [kartu(W, J)],Baru),asserta(tumpukanKartu(Baru)),discardPile
    ).

randomizeUrutan :- findall(Nama, pemain(Nama), Daftar),
                   randomizeList(Daftar, RandomizedDaftar),
                   asserta(allPemain(RandomizedDaftar)), nl,
                   kocokKartu,
                   bagiKartu(RandomizedDaftar),
                   write('Urutan Pemain: '),
                   writeList(RandomizedDaftar),
                   nl,
                   write('Setiap pemain mendapatkan 7 kartu acak.'),
                   nl,
                   discardPile,
                   writeDiscardTop,!.

writeDiscardTop :- discardPileTop([kartu(W,J)]),
                   format('Kartu Discard Top: ~w-~w~n', [W, J]).
       
            
% miscellaneous rules

listLength([], 0) :- !.
listLength([_|Tail], Length) :- listLength(Tail, TailLength), Length is TailLength + 1.

getElement([E|_], 0, E) :- !.
getElement([_|T], I, E) :- I > 0, NewI is I - 1, getElement(T, NewI, E).

deleteElement([_|Tail], 0, Tail) :- !.
deleteElement([Head|Tail], Index, [Head|UpdatedTail]) :- Index > 0, NewIndex is Index - 1, deleteElement(Tail, NewIndex, UpdatedTail).

appendElement(List, Element, NewList) :- append(List, [Element], NewList), !.

randomizeList([], []) :- !.
randomizeList(List, [El|T]) :-
    listLength(List, Length),
    random(0, Length, R),
    getElement(List, R, El),
    deleteElement(List, R, UpdatedList),
    randomizeList(UpdatedList, T).

writeList([H]) :- write(H), write('.'),!.
writeList([H|T]) :- listLength([H|T], N), N > 1, write(H), write(' - '), writeList(T).