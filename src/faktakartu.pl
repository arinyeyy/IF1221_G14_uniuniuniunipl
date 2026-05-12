% Fakta Kartu
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

initDeck :-
    findall(kartu(W, J), kartu(W, J), AllCards),
    randomizeList(AllCards, Kocok),
    retractall(deck(_)),
    asserta(deck(Kocok)).

bagiKartu([]).
bagiKartu([Nama|Sisa]) :-
    ambilTujuh(Nama, 7),
    bagiKartu(Sisa).

ambilTujuh(_, 0) :- !.
ambilTujuh(Nama, N) :-
    retract(deck([KartuTeratas|SisaDeck])),
    assertz(kartuPemain(Nama, KartuTeratas)),
    asserta(deck(SisaDeck)),
    N1 is N - 1,
    ambilTujuh(Nama, N1).

initDiscardPile :-
    retract(deck([kartu(W, J) | Sisa])),
    (   number(J) -> 
        asserta(discardPile([kartu(W, J)])),asserta(deck(Sisa));
        append(Sisa, [kartu(W, J)], DeckBaru),asserta(deck(DeckBaru)),initDiscardPile
    ).