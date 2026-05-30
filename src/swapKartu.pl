swapKartu(X,Y):- mode(2),  
                giliran(Pemain), 
                setim(Pemain, Teman), 
                findAllKartuPemain(Pemain, ListKartuPemain), 
                findAllKartuPemain(Teman, ListKartuTeman), 
                listLength(ListKartuPemain) > 1,
                listLength(ListKartuTeman) > 1,
                X1 is X-1, 
                Y1 is Y-1,
                getElement(ListKartuPemain,X1,KartuPemain),
                getElement(ListKartuTeman,Y1,KartuTeman),
                retract(kartuPemain(Pemain, KartuPemain)),
                retract(kartuPemain(Teman, KartuTeman)),
                assertz(kartuPemain(Pemain, KartuTeman)),
                assertz(kartuPemain(Teman, KartuPemain)).




