/* Hinzufügen der neuen Spalten nettopreis und datum zur Tabelle kennzahlen */
ALTER TABLE nordmarkt.kennzahlen 
 ADD COLUMN Datum DATE  
      AFTER bestelldatum_ID,
 ADD COLUMN Nettopreis DOUBLE 
	  AFTER Einkaufspreis_netto;
      
/* Hinzufügen der entsprechenden Daten in die Tabelle "Nettopreis" und "Kennzahlen" */     
UPDATE kennzahlen
   SET kennzahlen.Nettopreis = (SELECT Nettopreis 
								  FROM produkt 
								 WHERE kennzahlen.produkt_ID= produkt.produkt_ID),
	   kennzahlen.Datum      = (SELECT Datum 
							      FROM bestelldatum 
								 WHERE kennzahlen.bestelldatum_ID= bestelldatum.bestelldatum_ID);

/* Änderung des Nettopreises von 1,09 auf 1,29 nach 1.2.2022 */                                
UPDATE kennzahlen
   SET Nettopreis = (CASE WHEN (produkt_ID = 718 AND Datum >='2022-02-01') 
						  THEN 1.29 
                          ELSE Nettopreis 
                          END);
                          
/* Visualisierung der durch die obige "Abfrage" vorgenommenen Änderungen */
SELECT Datum,produkt_ID,Nettopreis 
  FROM kennzahlen 
 WHERE produkt_ID =718
 ORDER BY Datum;
 
 /* Jährliche Analyse des Umsatzes */
SELECT Jahr,
	   kennzahlen.produkt_ID,
       Produktname,
       ROUND(SUM(kennzahlen.Menge),2) AS Menge,
       ROUND(SUM((kennzahlen.Menge*kennzahlen.Nettopreis)),2) AS Umsaetz 
FROM nordmarkt.kennzahlen 
	INNER JOIN nordmarkt.bestelldatum 
			ON nordmarkt.kennzahlen.bestelldatum_ID = nordmarkt.bestelldatum.bestelldatum_ID
	INNER JOIN nordmarkt.produkt 
			ON nordmarkt.kennzahlen.produkt_ID = nordmarkt.produkt.produkt_ID
    WHERE kennzahlen.produkt_ID= 718
 GROUP BY Jahr;
 
 /* Monatliche Analyse von umsatz */
 SELECT Monat,
	   kennzahlen.produkt_ID,
       Produktname,
       ROUND(SUM(kennzahlen.Menge),2) AS Menge,
       ROUND(SUM((kennzahlen.Menge*kennzahlen.Nettopreis)),2) AS Umsaetz 
FROM nordmarkt.kennzahlen 
	INNER JOIN nordmarkt.bestelldatum 
			ON nordmarkt.kennzahlen.bestelldatum_ID = nordmarkt.bestelldatum.bestelldatum_ID
	INNER JOIN nordmarkt.produkt 
			ON nordmarkt.kennzahlen.produkt_ID = nordmarkt.produkt.produkt_ID
    WHERE kennzahlen.produkt_ID= 718
 GROUP BY Monat;
