efek_kartu(kartu(_,draw_two)):-
    nomorGiliran(Num),
    beriGiliranNormal(Num),
    ambilKartu, skipTurn.