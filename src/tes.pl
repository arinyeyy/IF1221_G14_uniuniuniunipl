teswdf(Pemain) :- asserta(kartuPemain(Pemain, kartu(hitam, wild_draw_four))).
tesuni(Pemain) :- 
    findAllKartuPemain(Pemain, ListKartu),
    listLength(ListKartu, N),
    (
        N > 2 ->
        retract(kartuPemain(Pemain, _)),
        tesuni(Pemain)
        ;
        asserta(uniActivated(Pemain))
    ).
hapus(Pemain, Kartu) :-
    retract(kartuPemain(Pemain, Kartu)).