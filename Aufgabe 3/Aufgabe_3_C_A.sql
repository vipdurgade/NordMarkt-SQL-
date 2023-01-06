/* AAnalyse der jährlichen Umsätz bei einem Nettopreis von 1,09 Euro */
SELECT Monat,
	   kennzahlen.produkt_ID,
       Produktname,
       ROUND(SUM(kennzahlen.Menge),2) AS Menge,
       Nettopreis,
       ROUND(SUM((Menge*Nettopreis)),2) AS Umsaetz 
FROM nordmarkt.kennzahlen 
	INNER JOIN nordmarkt.bestelldatum 
			ON nordmarkt.kennzahlen.bestelldatum_ID = nordmarkt.bestelldatum.bestelldatum_ID
	INNER JOIN nordmarkt.produkt 
			ON nordmarkt.kennzahlen.produkt_ID = nordmarkt.produkt.produkt_ID
    WHERE kennzahlen.produkt_ID= 718
 GROUP BY Monat;
 
 /* Analyse der jährlichen Umsätz bei einem Nettopreis von 1,09 Euro */
 
 SELECT Jahr,
	   kennzahlen.produkt_ID,
       Produktname,
       SUM(kennzahlen.Menge) AS Menge,
       Nettopreis,
       SUM((Menge*Nettopreis)) AS Umsaetz 
FROM nordmarkt.kennzahlen 
	INNER JOIN nordmarkt.bestelldatum 
			ON nordmarkt.kennzahlen.bestelldatum_ID = nordmarkt.bestelldatum.bestelldatum_ID
	INNER JOIN nordmarkt.produkt 
			ON nordmarkt.kennzahlen.produkt_ID = nordmarkt.produkt.produkt_ID
    WHERE kennzahlen.produkt_ID= 718
 GROUP BY Jahr;