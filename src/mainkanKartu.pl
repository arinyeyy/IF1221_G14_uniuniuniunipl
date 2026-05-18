mainkanKartu(Index) :-
    giliran(Pemain),
    kartuPemain(Pemain, ListKartu),
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
                        (J == wild, pilihWarna, beriGiliranNormal(Num));
                        (J == wild-draw-four, asserta(tantangActivated), pilihWarna, beriGiliranNormal(Num)).
                     ).

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