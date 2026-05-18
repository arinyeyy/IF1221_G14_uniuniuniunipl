mainkanKartu(Index) :-
    giliran(Pemain),
    tangan(Pemain, ListKartu),
    ambil_idx(Index, ListKartu, Kartu),
    discardPileTop(KartuAtas),
    (
        valid(Kartu, KartuAtas) ->
        writeln(Pemain), write(' memainkan kartu: '), writeln(Kartu),
        deleteElement(ListKartu, Index, SisaKartu),
        retract(tangan(Pemain, ListKartu)),
        assertz(tangan(Pemain, SisaKartu)),
        retract(discardPileTop(_)),
        assertz(discardPileTop(Kartu)),
        efek_kartu(Kartu)
        ;
        writeln('Kartu tidak valid!'),
        fail
    ).

efek_kartu(Kartu) :- Kartu = kartu(W, J), nomorGiliran(Num),
                     (
                        (J == 1, beriGiliranNormal(Num));
                        (J == 2, beriGiliranNormal(Num));
                        (J == 3, beriGiliranNormal(Num));
                        (J == 4, beriGiliranNormal(Num));
                        (J == 5, beriGiliranNormal(Num));
                        (J == 6, beriGiliranNormal(Num));
                        (J == 7, beriGiliranNormal(Num));
                        (J == 8, beriGiliranNormal(Num));
                        (J == 9, beriGiliranNormal(Num));
                        (J == 0, beriGiliranNormal(Num));
                        (J == skip, ...);
                        (J == reverse, ...);
                        (J == draw-two, ...);
                        (J == wild, beriGiliranNormal(Num));
                        (J == wild-draw-four, asserta(tantangActivated), beriGiliranNormal(Num)).
                     ).

valid(Kartu, KartuAtas) :- Kartu = kartu(W, J), KartuAtas = kartu(WAtas, JAtas),
                            (
                                ((WAtas \== W, J == draw-two) -> fail);
                                ((JAtas == wild, J == wild) -> fail);
                                ((JAtas == wild-draw-four, J == wild) -> fail);
                                ((JAtas == wild, J == wild-draw-four) -> fail);
                                ((JAtas == wild-draw-four, J == wild) -> fail);
                                ((JAtas == J, JAtas \== wild, J \== wild, JAtas \== wild-draw-four, J \== wild-draw-four) -> true);
                                ((WAtas == W, WAtas \== hitam, W \== hitam) -> true);
                                ((WAtas == hitam, W \== hitam) -> true);
                                ((WAtas \== hitam, W == hitam) -> true)
                            ).