tangkap(Pemain) :-
    kartuPemain(Pemain, Kartu),
    listLength(Kartu, N),
    (   N == 1 ->
        (   uniActivated(Pemain) ->
            write(Pemain), write(' tertangkap tidak menyerukan UNI.'), nl,
            write(Pemain), write(' mendapatkan 2 kartu pinalti'), nl,
            ambil(Pemain, 2), retract(uniActivated(Pemain)), !
        ;   
            write('Perintah tidak valid! '), write(Pemain), write(' sudah menyerukan UNI.'), nl,
            giliran(PemainTantang), ambil(PemainTantang, 1),!
        )
    ;
        write('Perintah tidak valid! Kartu '), write(Pemain), write(' tidak berjumlah satu.'), nl,
        giliran(PemainTantang), ambil(PemainTantang, 1),!
    ),