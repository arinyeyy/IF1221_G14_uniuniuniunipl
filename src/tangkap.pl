tangkap(Pemain) :-
    findAllKartuPemain(Pemain, Kartu),
    listLength(Kartu, N),
    giliran(PemainTangkap),
    (   N == 1 ->
        (   uniActivated(Pemain) ->
            write(Pemain), write(' tertangkap tidak menyerukan UNI.'), nl,
            write(Pemain), write(' mendapatkan 2 kartu pinalti'), nl,
            ambilBeberapaKartu(Pemain, 2), retract(uniActivated(Pemain))
        ;   
            write('Perintah tidak valid! '), write(Pemain), write(' telah menyerukan UNI.'), nl,
            ambilBeberapaKartu(PemainTangkap, 1)
        )
    ;
        (kartuTersembunyi(Pemain,_) -> 
            write('Terdapat kartu yang disembunyikan '), write(Pemain),nl,nl,
            write('Perintah tangkap tidak valid! '), write(PemainTangkap), write('mendapat 1 kartu penalti'),nl
        ;
            write('Perintah tidak valid! Kartu '), write(Pemain), write(' tidak berjumlah satu.'), nl),
        ambilBeberapaKartu(PemainTangkap, 1)
    ),nomorGiliran(Num), beriGiliranNormal(Num).