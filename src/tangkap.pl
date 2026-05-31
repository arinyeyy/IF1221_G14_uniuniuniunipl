tangkap(Pemain) :-
    findAllKartuPemain(Pemain, Kartu),
    listLength(Kartu, N),
    (   N == 1 ->
        (   uniActivated(Pemain) ->
            write(Pemain), write(' tertangkap tidak menyerukan UNI.'), nl,
            write(Pemain), write(' mendapatkan 2 kartu pinalti'), nl,
            ambilBeberapaKartu(Pemain, 2), retract(uniActivated(Pemain)), !
        ;   
            write('Perintah tidak valid! '), write(Pemain), write(' telah menyerukan UNI.'), nl,
            giliran(PemainTangkap), ambilBeberapaKartu(PemainTangkap, 1), !
        )
    ;
        write('Perintah tidak valid! Kartu '), write(Pemain), write(' tidak berjumlah satu.'), nl,
        giliran(PemainTantang), ambilBeberapaKartu(PemainTantang, 1), !
    ),skipTurn.