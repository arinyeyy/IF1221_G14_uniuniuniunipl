mainkanKartu(Index) :-
    (   gameStarted -> 
        (   giliran(Pemain), !,
            (   tantangActivated(_) ->
                write('Command mainkanKartu tidak valid saat ini!'), nl,
                write('Pilih tantang atau ambilKartu.'), nl, nl, fail
            ;   
                true
            ),
            findAllKartuPemain(Pemain, ListKartu),
            Indexriil is Index-1,
            getElement(ListKartu, Indexriil, Kartu),
            discardPileTop([KartuAtas|_]),
            (   valid(Kartu, KartuAtas) ->
                (   Kartu = kartu(W,J),
                    write(Pemain), format(' memainkan kartu: ~w-~w~n~n', [W, J]),
                    (   \+ aksiBeruntunValid(Kartu) ->
                        write('Kartu aksi tidak bisa dimainkan 2 kali berturut-turut!'), nl, nl, fail
                    ;
                        true
                    ),
                    retract(kartuPemain(Pemain, Kartu)), !,
                    temp(ListLama),
                    retractall(temp(_)),
                    asserta(temp([KartuAtas|ListLama])),
                    discardPileTop(KartuLama),          
                    retractall(prevDiscardPileTop(_)), 
                    asserta(prevDiscardPileTop(KartuLama)), 
                    retractall(discardPileTop(_)),
                    assertz(discardPileTop([Kartu])),
                    efek_kartu(Kartu)
                )
                ;
                write('Kartu tidak valid!'), nl, nl, fail
            )
        )
    ;
        write('Permainan belum dimulai!'), nl, nl, fail
    ).

efek_kartu(kartu(_, J)) :- integer(J), !,
                           updateGiliranMimic,
                           nomorGiliran(Num),
                           beriGiliranNormal(Num).

efek_kartu(kartu(W, reverse)) :- updateKartuAksi(W, reverse),
                                 allPemain(AllPemain),
                                 giliran(PemainTerkini),
                                 balik(AllPemain, NewList),
                                 retractall(allPemain(_)),
                                 asserta(allPemain(NewList)),
                                 getIndex(NewList, PemainTerkini, Num),
                                 pemainNext(Num, PemainSelanjutnya),
                                 getIndex(NewList, PemainSelanjutnya, Num1),
                                 retractall(nomorGiliran(_)),
                                 asserta(nomorGiliran(Num1)),
                                 retract(giliran(_)),
                                 asserta(giliran(PemainSelanjutnya)),
                                 arahMain(Arah),
                                 (Arah == kanan ->
                                    retractall(arahMain(_)),
                                    asserta(arahMain(kiri))
                                ;
                                    retractall(arahMain(_)),
                                    asserta(arahMain(kanan))),

                                 write('Arah permainan dibalik!'), nl,
                                 format('Giliran ~w.~n', [PemainSelanjutnya]).

efek_kartu(kartu(W, skip)) :- updateKartuAksi(W, skip),
                              nomorGiliran(Num),
                              beriGiliranSkip(Num).

efek_kartu(kartu(W, draw_two)):- updateKartuAksi(W, draw_two),
                                nomorGiliran(Num),
                                pemainNext(Num, PemainSelanjutnya),
                                ambilBeberapaKartu(PemainSelanjutnya, 2),
                                beriGiliranSkip(Num).

efek_kartu(kartu(W, wild)) :- updateKartuAksi(W, wild),
                              nomorGiliran(Num),
                              pilihWarna,
                              beriGiliranNormal(Num).

efek_kartu(kartu(W, wild_draw_four)) :- updateKartuAksi(W, wild_draw_four),
                                        nomorGiliran(Num),
                                        asserta(tantangActivated(true)),   
                                        pilihWarna,
                                        beriGiliranNormal(Num).           

efek_kartu(kartu(W, mimic)) :- updateGiliranMimic,
                               nomorGiliran(Num),
                               kartuMimic(Num).

valid(Kartu, KartuAtas) :- Kartu = kartu(W, J), 
                           KartuAtas = kartu(WAtas, JAtas),
                           (JAtas \== wild, JAtas \== wild_draw_four, JAtas \== mimic ->
                                ( WAtas \== W, J == draw_two -> fail
                                ; WAtas == W -> true
                                ; JAtas == J -> true
                                ; J == wild -> true
                                ; J == wild_draw_four -> true
                                ; J == mimic -> true
                                ; fail
                                )
                            ;
                                ( warnaWildTerpilih(Warna), 
                                  (Warna == W) -> true;
                                  fail
                                )
                           ).

aksiBeruntunValid(kartu(_, J)) :- integer(J), !.
aksiBeruntunValid(kartu(_, J)) :- discardPileTop([KartuAtas|_]),
                                  KartuAtas = kartu(_, JAtas),
                                  J \== JAtas.
                            
pilihWarna :- retractall(warnaWildTerpilih(_)),
              write('Pilih warna (merah/biru/kuning/hijau): '),
              read(Warna), nl,
              ( Warna == 'merah' -> asserta(warnaWildTerpilih(merah))
              ; Warna == 'biru' -> asserta(warnaWildTerpilih(biru))
              ; Warna == 'kuning' -> asserta(warnaWildTerpilih(kuning))
              ; Warna == 'hijau' -> asserta(warnaWildTerpilih(hijau))
              ; nl, write('Warna tidak tersedia!'), nl, pilihWarna
              ).