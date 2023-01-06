ALTER TABLE nordmarkt.kennzahlen
 ADD COLUMN Einkaufspreis_netto DOUBLE;
/* Erweiterung der Tabelle "Kennzahlen" um die Spalte "Einkaufspreis_netto"*/

UPDATE kennzahlen
  SET  kennzahlen.Einkaufspreis_netto = (SELECT Einkaufspreis_netto 
										   FROM nordmarkt 
										  WHERE kennzahlen.kennzahl_ID= nordmarkt.kennzahl_ID);

SELECT * 
  FROM nordmarkt.kennzahlen;
