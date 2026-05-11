:- use_module(library(random)).
:- dynamic(gameStarted/0).
:- dynamic(jumlahPemain/1).
:- dynamic(pemain/1).
:- dynamic(kartuPemain/2).
:- dynamic(allPemain/1).
:- dynamic(allKartu/1).

startGame :- inputJumlahPemain.
inputJumlahPemain :- write('Masukkan jumlah pemain: '), read(Jml),
                     ((Jml > 1, Jml < 5, asserta(jumlahPemain(Jml)), nl, tambahPemain(Jml));
                     ((Jml < 2; Jml > 4), write('Jumlah pemain harus di antara 2 sampai 4!'), nl, inputJumlahPemain)).

helpTambahPemain(_,0) :- randomizeUrutan. 

helpTambahPemain(X,N) :- format('Masukkan nama pemain ~w: ', [X]), read(Nama),
                   ((\+pemain(Nama), assertz(pemain(Nama)),
                    N1 is N - 1, X1 is X + 1, helpTambahPemain(X1, N1));
                   (pemain(Nama), sudahAdaPemain(X, N))).

sudahAdaPemain(X, N) :- write('Pemain sudah ada! Masukkan nama lain: '), read(Nama),
                        ((\+pemain(Nama), assertz(pemain(Nama)), X1 is X + 1, N1 is N - 1, helpTambahPemain(X1, N1));
                        pemain(Nama), sudahAdaPemain(X, N)).

tambahPemain(N) :- X is 1, helpTambahPemain(X,N).

randomizeUrutan :- findall(Nama, pemain(Nama), Daftar),
                   randomizeList(Daftar, RandomizedDaftar),
                   asserta(allPemain(RandomizedDaftar)), nl,
                   write('Urutan Pemain: '),
                   writeList(RandomizedDaftar).

writeList([H]) :- write(H), !.
writeList([H|T]) :- listLength([H|T], N), N > 1, write(H), write(' - '), writeList(T).





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