% miscellaneous rules
:- use_module(library(random)).

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