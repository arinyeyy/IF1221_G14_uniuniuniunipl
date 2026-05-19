:- include('kartuReverse.pl').
:- include('kartuSkip.pl').

mainkanKartu(Index) :-
    giliran(Pemain),
    findall(kartu(W,J),
        kartuPemain(Pemain, kartu(W,J)),
        DaftarKartu),

    getElement(DaftarKartu, Index, kartu(Warna, Jenis)),
    discardPileTop([kartu(WarnaTop, JenisTop)]),

    (
        Warna == WarnaTop ;
        Jenis == JenisTop ;
        Warna == hitam
    ),

    retract(kartuPemain(Pemain, kartu(Warna, Jenis))),
    retractall(discardPileTop(_)),
    asserta(discardPileTop([kartu(Warna, Jenis)])),

    format('~w memainkan kartu ~w-~w.~n',
        [Pemain, Warna, Jenis]),

    efekKartu(kartu(Warna, Jenis)).

efekKartu(kartu(_, reverse)) :-
    kartuReverse, !.

efekKartu(kartu(_, skip)) :-
    kartuSkip, !.

/* efekKartu(kartu(_, draw_two)) :-
    skipKartu, !.

efekKartu(kartu(_, wild)) :-
    skipKartu, !. 
    
efekKartu(kartu(_, wild_draw_four)) :-
    skipKartu, !. */

efekKartu(_) :-
    nomorGiliran(N),        % ambil N di sini
    beriGiliranNormal(N).   % lalu pass
