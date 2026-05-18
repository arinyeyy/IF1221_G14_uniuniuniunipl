mainkanKartu(Index) :-
    gameStarted -> (
        giliran(Pemain), !,
        findAllKartuPemain(Pemain, ListKartu),
        Indexriil is Index-1,
        getElement(ListKartu, Indexriil, Kartu),
        discardPileTop([KartuAtas|_]), 
        (
            valid(Kartu, KartuAtas) ->
            (write(Pemain), write(' memainkan kartu: '), write(Kartu), nl, nl,
            deleteElement(ListKartu, Indexriil, SisaKartu),
            retract(kartuPemain(Pemain, Kartu)), !,
            retractall(discardPileTop(_)),
            assertz(discardPileTop([Kartu])),
            efek_kartu(Kartu))
            ;
            write('Kartu tidak valid!'), nl, nl, fail
        )
    );
    write('Permainan belum dimulai!'), nl, nl, fail.

efek_kartu(kartu(_, J)) :- integer(J), !,
                           nomorGiliran(Num),
                           beriGiliranNormal(Num).

efek_kartu(kartu(_, wild)) :- nomorGiliran(Num),
                              pilihWarna,
                              beriGiliranNormal(Num).

efek_kartu(kartu(_, wild-draw-four)) :- nomorGiliran(Num),
                                        asserta(activateTantang),
                                        pilihWarna,
                                        beriGiliranNormal(Num).

valid(Kartu, KartuAtas) :- Kartu = kartu(W, J), KartuAtas = kartu(WAtas, JAtas),
                            (JAtas \== wild, JAtas \== wild-draw-four) ->
                            (
                                (WAtas \== W, J == draw-two) -> fail;
                                (WAtas == W) -> true;
                                (JAtas == J) -> true;
                                (J == wild) -> true;
                                (J == wild-draw-four) -> true;
                                fail
                            );
                            (
                                warnaWildTerpilih(Warna),
                                (Warna == W) -> true;
                                fail
                            ).
                            
pilihWarna :- retractall(warnaWildTerpilih(_)),
              write('Pilih warna: '),
              read(Warna),
              (Warna == 'merah') -> asserta(warnaWildTerpilih(merah));
              (Warna == 'biru') -> asserta(warnaWildTerpilih(biru));
              (Warna == 'kuning') -> asserta(warnaWildTerpilih(kuning));
              (Warna == 'hijau') -> asserta(warnaWildTerpilih(hijau));
              nl, write('Warna tidak tersedia!'), nl, pilihWarna.