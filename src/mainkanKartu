mainkanKartu(Index) :-
    giliran(Pemain),
    tangan(Pemain, ListKartu),
    ambil_idx(Index, ListKartu, Kartu),
    discard(KartuAtas),
    (
        valid(Kartu, KartuAtas) ->
        writeln(Pemain), write(' memainkan kartu: '), writeln(Kartu),
        hapus_idx(Index, ListKartu, SisaKartu),
        retract(tangan(Pemain, ListKartu)),
        assertz(tangan(Pemain, SisaKartu)),
        retract(discard(_)),
        assertz(discard(Kartu)),
        efek_kartu(Kartu)
        ;
        writeln('Kartu tidak valid!'),
        fail
    ).
