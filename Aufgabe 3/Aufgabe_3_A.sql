SELECT 	Monat,
		Bundesland,
        Kategorie,
        CONCAT('€ ', CAST(CAST(sum(Umsatz) AS DECIMAL(18,2)) AS CHAR(55)))AS "Umsatzsumme",
        CONCAT('€ ', CAST(CAST(avg(Umsatz) AS DECIMAL(18,2)) AS CHAR(55))) AS "Umsatzavg"
		  FROM nordmarkt.kennzahlen 
	INNER JOIN nordmarkt.bestelldatum 
			ON nordmarkt.kennzahlen.bestelldatum_ID = nordmarkt.bestelldatum.bestelldatum_ID
	INNER JOIN nordmarkt.kunde 
			ON nordmarkt.kennzahlen.kunde_ID = nordmarkt.kunde.kunde_ID 
	INNER JOIN nordmarkt.produkt 
			ON nordmarkt.kennzahlen.produkt_ID = nordmarkt.produkt.produkt_ID
	WHERE nordmarkt.bestelldatum.Jahr = 2022 AND kunde.Land ="Deutschland"
 GROUP BY nordmarkt.bestelldatum.Monat,nordmarkt.kunde.Bundesland,nordmarkt.produkt.kategorie
 ORDER BY nordmarkt.bestelldatum.Monat,SUM(kennzahlen.Umsatz) DESC;