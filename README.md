# VisitBosnia

Aplikacija namijenjena turistima koji žele da posjete Bosnu i Hercegovinu, kao i turističkim agencijama koje pružaju usluge turistima. Turisti tj. korisnici imaju pregled atrakcija i događaja u gradovima Bosne i Hercegovine, kao i mogućnost kupovine karata, te forum za sva željena pitanja.

* Desktop dio aplikacije: namjenjen za administraciju i članove agencija za upravljanje sadržajem. 
* Mobilni dio aplikacije: namjenjen za turiste i članove agencija.

Kredencijali za prijavu

* ADMIN
desktop -> username: admin;
           password: test
           
* AGENCY (član agencije)
desktop i mobilna -> username: agency;
                     password: test
                     
* USER
mobilna -> username: userA; username: userB; username: userC;
           password (za sve): test

Pokretanje aplikacija:

1. git clone https://github.com/NudzejmaDedovic/VisitBosnia

2. Pokrenuti API i DB (docker-compose build, docker-compose up)

3. Otvoriti mobilnu aplikaciju u Visual Studio Code i nakon preuzimanja dependency-a (flutter pub get), kroz terminal pokrenuti:
   - flutter run --dart-define=baseUrl=http://IPv4_adresa:5223 (mobilni uređaj)
   - flutter run (emulator)

4. Otvoriti solution u Visual Studiu i pokrenuti VisitBosnia.WinUI projekat 
           
Napomena: za pokretanje aplikacije potrebno je više vremena zbog izvršavanja SQL skripte za import podataka


        
