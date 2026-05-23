% miscellaneous rules
:- use_module(library(random)).

isMember(H, [H|_]) :- !.
isMember(H, [_|T]) :- isMember(H, T).

listLength([], 0) :- !.
listLength([_|Tail], Length) :- listLength(Tail, TailLength), Length is TailLength + 1.

getElement([E|_], 0, E) :- !.
getElement([_|T], I, E) :- I > 0, NewI is I - 1, getElement(T, NewI, E).

getIndex([Element|_], Element, 0).
getIndex([_|Tail], Element, Index) :-
    getIndex(Tail, Element, TempIndex),
    Index is TempIndex + 1.

deleteElement([_|Tail], 0, Tail) :- !.
deleteElement([Head|Tail], Index, [Head|UpdatedTail]) :- Index > 0, NewIndex is Index - 1, deleteElement(Tail, NewIndex, UpdatedTail).

appendElement(List, Element, NewList) :- append(List, [Element], NewList), !.

concatList([], List2, List2).
concatList([Head|Tail], List2, [Head|Hasil]) :-
    concatList(Tail, List2, Hasil).

randomizeList([], []) :- !.
randomizeList(List, [El|T]) :-
    listLength(List, Length),
    random(0, Length, R),
    getElement(List, R, El),
    deleteElement(List, R, UpdatedList),
    randomizeList(UpdatedList, T).

balik(List, NewList) :- 
    balik(List, [], NewList).
balik([], Temp, Temp).
balik([H|T], Temp, NewList) :- 
    balik(T, [H|Temp], NewList).

writeList([H]) :- write(H), write('.'),!.
writeList([H|T]) :- listLength([H|T], N), N > 1, write(H), write(' - '), writeList(T).