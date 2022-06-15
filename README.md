# Prepoznavanje-paterna-skokova-u-dalj-na-osnovu-EMG-signala-i-3D-kinematike

Studenti: Lazar Zlatić, Selena Bogojević, Iva Marković

Projekat iz predmeta Akvizicija elektrofizioloških signala na temu "Prepoznavanje paterna skokova u dalj na osnovu EMG signala i 3D  kinematike", 
pod mentorstvom prof.dr. Milice Janković. 

Sa ciljem ocene važnosti različitih parametara EMG signala dobijenih pomoću sistema
DuePro i signala dobijenih sa MTw Awinda senzora za procenu distance koju će posmatrani
subjekat preskočiti pri skoku u dalj iz mesta, i mogućnosti same procene vrednosti
preskočene distance na test podacima, u okviru ovog projekta izvršen je eksperiment
izvođenja skoka u dalj iz mesta na ispitanicima kojima su u toku izvođenja skokova merene
vremenske serije signala sa opisanih senzora. Od signala dobijenih sa senzora formirane su
tabele sa instancama podataka ekstrahovanjem urađenim u odgovarajućim softverskim
paketima koji prate hardverske sisteme (OT BioLab+ i MT Manager za DuePro i MTw Awinda
sistem redom).

Pomoću sistema DuePro mereni su EMG signali sa mišića vastus lateralis, vastus medialis,
semitendinosus, biceps femoris, kao i sa medijalne i lateralne glave mišića gastrocnemius obe
noge. Merenja su vršena bipolarno. Signali su mereni sa frekvencijom uzorkovanja od .
Pomoću sistema MTw Awinda mereni su podaci o ubrzanju, promeni orijentacije i o
ugaonoj brzini posmatrano iz referentnog sistema vezanog za senzor uređaja. Senzori su
postavljani (njih ukupno šest) na obe podlaktice, u blizini zgloba šake, na obe potkolenice,
iznad skočnog zgloba, kao i na obe butine.

Iz zabeležih signala vršena je ekstrakcija određenih parametara radi utvrđivanja veze
ekstrahovanih parametara i preskočene distance.

Kao rezultat procesa treniranja modela, utvrđeno je postojanje značajnog uticaja
parametara dobijenih pomoću MTw Awinda senzora. Ovaj uticaj bio je u velikoj meri u
skladu sa očekivanjima. Naime, velike vrednosti ubrzanja u smeru trostruke ekstenzije i
velike vrednosti ugaone brzine zamaha ruku povezane su sa velikim preskočenim
distancama. Takođe, manje vrednosti minimalnog ugla formiranog između natkolenice i
potkolenice pri iniciranju skoka povezane su sa većim vrednostima preskočene distance.
Specifičan je slučaj uticaja minimalnog ugla formiranog između natkolenice i potkolenice pri
doskoku na preskočenu distancu, koji pokazuje da najveće preskočene distance odgovaraju
manjim (po apsolutnoj vrednosti) negativnim vrednostima posmatranog ugla.
Uticaj EMG parametara nije moguće jasno utvrditi (mada određeni parametri pri nekim
podelama mogu imati značajan uticaj, koji se uglavnom slaže sa očekivanjima).
