ambilKartu :-
    giliran(Pemain),
    efek_draw(Jumlah),
    (
        Jumlah > 0 ->
        ambil_banyak(Pemain, Jumlah),
        retract(efek_draw(_)),
        assertz(efek_draw(0))
        ;
        ambil1(Pemain)
    ).
