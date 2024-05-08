-- Find the months in which the most weddings occur
SELECT 
  EXTRACT(
    MONTH 
    FROM 
      wedding_date
  ) AS wedding_month, 
  COUNT(*) AS total_weddings 
FROM 
  F23_S001_T7_CLIENT 
GROUP BY 
  EXTRACT(
    MONTH 
    FROM 
      wedding_date
  ) 
HAVING 
  COUNT(*) = (
    SELECT 
      COUNT(*) AS total_weddings 
    FROM 
      F23_S001_T7_CLIENT 
    GROUP BY 
      EXTRACT(
        MONTH 
        FROM 
          wedding_date
      ) 
    ORDER BY 
      total_weddings DESC FETCH FIRST 1 ROW ONLY
  );

--OUTPUT

--  WEDDING_MONTH TOTAL_WEDDINGS
    ------------- --------------
 --           7              7
 --          11              7
 --           4              7

--Find the VendorID, first name, and last name of vendors, and count the number of weddings for which the vendors have provided their services, provided that the count is more than one and the vendor offers Photography services.

WITH NEW AS (
  SELECT 
    VENDORID, 
    COUNT(WID) AS NUMBER_OF_WEDDINGS 
  FROM 
    F23_S001_T7_ASSIGNED_TO 
  GROUP BY 
    VENDORID 
  HAVING 
    COUNT(WID)> 1
) 
SELECT 
  v.VENDORID, 
  FName, 
  Lname, 
  NUMBER_OF_WEDDINGS 
FROM 
  F23_S001_T7_VENDOR v, 
  NEW n 
WHERE 
  v.VENDORID = n.VENDORID 
  AND SERVICE LIKE '%Photography%';

--OUTPUT

-- VENDORID  FNAME         LNAME          NUMBER_OF_WEDDINGS
------------------------------------------------------------
-- VD035     Wyatt         Taylor         2
-- VD055     Mia           Taylor         2
-- VD056     Logan         Moore          2
-- VD057     Lily          Johnson        2

-- Select the names of cities in which the clients are living, the average budget of clients, and the number of venues in the city where clients are living, where the average budget is highest.

WITH CITY AS(
  SELECT 
    city, 
    AVG(budget) AS AVERAGE_BUDGET 
  FROM 
    F23_S001_T7_CLIENT 
  GROUP BY 
    city 
  HAVING 
    AVG(budget) >= (
      SELECT 
        AVG(budget) 
      FROM 
        F23_S001_T7_CLIENT 
      GROUP BY 
        city 
      ORDER BY 
        AVG(budget) DESC FETCH FIRST 1 ROWS ONLY
    )
), 
VENUE AS(
  SELECT 
    c.CITY, 
    COUNT(c.CITY) AS NUMBER_OF_VENUES 
  FROM 
    CITY c, 
    F23_S001_T7_VENUE v 
  where 
    c.city = v.city 
  Group by 
    c.CITY
) 
SELECT 
  c.CITY, 
  AVERAGE_BUDGET, 
  NUMBER_OF_VENUES 
FROM 
  CITY c, 
  VENUE v 
WHERE 
  c.city = v.city;


--OUTPUT

-- CITY                 AVERAGE_BUDGET NUMBER_OF_VENUES
   -------------------- -------------- ----------------
-- Oceanview                     95000                1
-- Clearwater                    95000                3

--Provide the total amount of money spent on all items for each wedding, including the cost of each item within the wedding, and also present the individual cost for every item.
SELECT 
  W.WID, 
  I.IID, 
  SUM(COST) AS TotalCost 
FROM 
  F23_S001_T7_WEDDING W, 
  F23_S001_T7_INCLUDES I, 
  F23_S001_T7_PROVIDES P, 
  F23_S001_T7_ITEM IT 
WHERE 
  W.WID = I.WID 
  AND I.IID = P.IID 
  AND I.IID = IT.IID 
GROUP BY 
  CUBE(W.WID, I.IID);


-- OUTPUT

/*
-- WID  IID   TOTALCOST
-- ---- ---- ----------
               96150
     I001        100
     I004        400
     I005        500
     I010       1000
     I015       1500
     I020       2000
     I024       2400
     I025        100
     I030        600
     I032        800
     I033        100
     I035        300
     I040        800
     I041        900
     I042       1000
     I043       1100
     I044       1200
     I045       1300
     I046       1400
     I047       1500
     I048       1600
     I049       1700
     I050       1800
     I051       1900
     I052       2000
     I053       2100
     I054       2200
     I058        200
     I081       1950
     I082       2050
     I083       1600
     I084       1900
     I085       2250
     I086       1700
     I087       1800
     I088       2150
     I089       2400
     I090       1750
     I091       2000
     I092       1950
     I093       1700
     I094       2250
     I095       2050
     I099       1650
     I121       1950
     I122       2300
     I123       1950
     I124       2050
     I125       1600
     I126       3800
     I127       2250
     I128       1700
     I129       1800
     I131       4800
     I132       1750
     I136       2250
     I138       2200
     I140       2100
W001            2500
W001 I001        100
W001 I131       2400
W002            3300
W002 I041        900
W002 I131       2400
W003            2250
W003 I094       2250
W004            1950
W004 I081       1950
W005            2050
W005 I082       2050
W006            1000
W006 I042       1000
W007             200
W007 I058        200
W008            1100
W008 I043       1100
W009            1950
W009 I121       1950
W010            1200
W010 I044       1200
W011            1600
W011 I083       1600
W012            1000
W012 I010       1000
W013            2000
W013 I020       2000
W014             600
W014 I030        600
W015            2200
W015 I054       2200
W016            1300
W016 I045       1300
W017            1700
W017 I128       1700
W018            1900
W018 I084       1900
W019            2050
W019 I095       2050
W020            2250
W020 I085       2250
W021             800
W021 I040        800
W022            2300
W022 I122       2300
W023            2200
W023 I138       2200
W024            1400
W024 I046       1400
W025            1500
W025 I047       1500
W026             500
W026 I005        500
W027             800
W027 I032        800
W028            1700
W028 I086       1700
W029            1800
W029 I050       1800
W030            2250
W030 I136       2250
W031            1950
W031 I123       1950
W032            1800
W032 I087       1800
W033            1500
W033 I015       1500
W034            2150
W034 I088       2150
W035            2050
W035 I124       2050
W036            1600
W036 I125       1600
W037            1900
W037 I126       1900
W038            1600
W038 I048       1600
W039            2250
W039 I127       2250
W040            1800
W040 I129       1800
W041             100
W041 I025        100
W042             300
W042 I035        300
W043            2400
W043 I089       2400
W044            1700
W044 I049       1700
W045            2400
W045 I024       2400
W046            1900
W046 I051       1900
W047             100
W047 I033        100
W048             400
W048 I004        400
W049            1750
W049 I090       1750
W050            1750
W050 I132       1750
W051            2100
W051 I140       2100
W052            2000
W052 I091       2000
W053            1950
W053 I092       1950
W054            1650
W054 I099       1650
W055            1700
W055 I093       1700
W056            2000
W056 I052       2000
W057            2100
W057 I053       2100
W058            1900
W058 I126       1900
177 rows selected.
*/

-- Provide the vendor ID, item ID, and cost of each item provided by a vendor, along with the total cost of all the items provided by the vendor.
SELECT 
  V.VENDORID AS VENID, 
  I.IID, 
  SUM(I.Cost) AS TotalCost 
FROM 
  F23_S001_T7_VENDOR V, 
  F23_S001_T7_ITEM I, 
  F23_S001_T7_PROVIDES P 
WHERE 
  V.VENDORID = P.VENDORID 
  AND I.IID = P.IID 
GROUP BY 
  ROLLUP(V.VENDORID, I.IID);


-- OUTPUT
/*
VENID IID   TOTALCOST
----- ---- ----------
VD001 I001        100
VD001 I161       2000
VD001            2100
VD002 I044       1200
VD002 I162       1234
VD002            2434
VD003 I163       5678
VD003 I164       2000
VD003 I165       2000
VD003            9678
VD006 I053       2100
VD006 I164       2000
VD006            4100
VD007 I091       2000
VD007            2000
VD008 I128       1700
VD008            1700
VD009 I035        300
VD009             300
VD010 I002        200
VD010 I050       1800
VD010 I130       2150
VD010            4150
VD011 I012       1200
VD011 I094       2250
VD011 I131       2400
VD011            5850
VD012 I022       2200
VD012 I132       1750
VD012            3950
VD013 I032        800
VD013 I133       2000
VD013            2800
VD014 I003        300
VD014 I054       2200
VD014 I134       1950
VD014            4450
VD015 I013       1300
VD015 I055       2300
VD015 I095       2050
VD015 I135       1700
VD015            7350
VD016 I023       2300
VD016 I056       2400
VD016 I096       2200
VD016 I136       2250
VD016            9150
VD017 I033        100
VD017 I057        100
VD017 I097       1850
VD017            2050
VD018 I058        200
VD018 I098       2100
VD018            2300
VD019 I014       1400
VD019 I059        300
VD019 I099       1650
VD019 I139       1850
VD019            5200
VD020 I060        400
VD020 I100       1950
VD020 I138       2200
VD020            4550
VD021 I020       2000
VD021            2000
VD022 I047       1500
VD022            1500
VD023 I083       1600
VD023            1600
VD024 I124       2050
VD024            2050
VD025 I040        800
VD025             800
VD026 I049       1700
VD026            1700
VD027 I082       2050
VD027            2050
VD028 I127       2250
VD028            2250
VD029 I015       1500
VD029            1500
VD030 I041        900
VD030             900
VD031 I089       2400
VD031            2400
VD032 I123       1950
VD032            1950
VD033 I024       2400
VD033            2400
VD034 I046       1400
VD034            1400
VD035 I090       1750
VD035 I092       1950
VD035            3700
VD036 I121       1950
VD036            1950
VD037 I030        600
VD037             600
VD038 I051       1900
VD038            1900
VD039 I093       1700
VD039            1700
VD040 I125       1600
VD040            1600
VD042 I025        100
VD042             100
VD043 I043       1100
VD043            1100
VD044 I084       1900
VD044            1900
VD045 I140       2100
VD045            2100
VD046 I005        500
VD046             500
VD048 I081       1950
VD048            1950
VD049 I122       2300
VD049            2300
VD050 I010       1000
VD050            1000
VD051 I052       2000
VD051            2000
VD052 I087       1800
VD052            1800
VD053 I129       1800
VD053            1800
VD055 I042       1000
VD055 I048       1600
VD055            2600
VD056 I085       2250
VD056 I088       2150
VD056            4400
VD057 I126       1900
VD057 I137       2050
VD057            3950
VD058 I004        400
VD058             400
VD059 I045       1300
VD059            1300
VD060 I086       1700
VD060            1700
               138962

141 rows selected.
*/
-- Find clients who have rented all available venues for their weddings in their city

SELECT 
  C.CID, 
  C.firstName, 
  C.lastName 
FROM 
  F23_S001_T7_CLIENT C 
WHERE 
  NOT EXISTS (
    SELECT 
      V.VID 
    FROM 
      F23_S001_T7_VENUE V 
    WHERE 
      V.city = C.city MINUS (
        SELECT 
          R.VID 
        FROM 
          F23_S001_T7_RENTS R 
        WHERE 
          R.CID = C.CID
      )
  );

--OUTPUT
/*

CID  FIRSTNAME                 LASTNAME
---- ------------------------- -------------------------
C051 Nova                      Barnes
C052 Oliver                    Hayes
C053 Aria                      Owens
C054 Liam                      Hudson

*/
-- Provide the first name, last name, vendor ID, rating, rank, and all the services provided by a vendor. Additionally, include Wedding id and budget of the weddings in which the vendors participated.

WITH VendorRanking AS (
    SELECT
        V.VENDORID,
        V.FName,
        V.LName,
        V.Service,
        V.Rating,
        RANK() OVER (ORDER BY V.Rating DESC) AS vendor_rank
    FROM
        F23_S001_T7_VENDOR V
)
SELECT
    A.WID,
    W.final_budget AS BUDGET,
    VR.VENDORID AS VENID,
    FName,
    LName,
    Service,
    Rating,
    vendor_rank AS VRANK
FROM
    VendorRanking VR, F23_S001_T7_ASSIGNED_TO A, F23_S001_T7_WEDDING W
WHERE 
     A.VENDORID = VR.VENDORID AND W.WID = A.WID
ORDER BY VRANK, WID ;

--OUTPUT
/*
WID     BUDGET  VENID   FNAME   LNAME                  SERVICE                                RATING   VRANK
-----------------------------------------------------------------------------------------------------------
W004	80000	VD048	Wyatt	Moore	Entertainment,Photography,Decoration,Food Catering	4.9	1
W011	58000	VD023	Landon	Smith	Entertainment,Photography,Decoration,Food Catering	4.9	1
W017	69000	VD008	Olivia	Moore	Entertainment,Photography,Decoration,Food Catering	4.9	1
W020	59000	VD056	Logan	Moore	Entertainment,Photography,Decoration,Food Catering	4.9	1
W026	71000	VD046	Owen	Moore	Entertainment,Photography,Decoration,Food Catering	4.9	1
W034	73000	VD056	Logan	Moore	Entertainment,Photography,Decoration,Food Catering	4.9	1
W043	89000	VD031	Logan	Taylor	Entertainment,Photography,Decoration,Food Catering	4.9	1
W047	83000	VD017	Jackson	Wilson	Entertainment,Photography,Decoration,Food Catering	4.9	1
W055	79000	VD039	Gabriel	Taylor	Entertainment,Photography,Decoration,Food Catering	4.9	1
W003	60000	VD011	Noah	Brown	Entertainment,Photography,Decoration,Food Catering	4.8	9
W013	62000	VD021	Grayson	Moore	Entertainment,Photography,Decoration,Food Catering	4.8	9
W014	95000	VD037	Henry	Johnson	Entertainment,Photography,Decoration,Food Catering	4.8	9
W018	87000	VD044	Logan	Johnson	Entertainment,Photography,Decoration,Food Catering	4.8	9
W033	86000	VD029	Elijah	Johnson	Entertainment,Photography,Decoration,Food Catering	4.8	9
W005	70000	VD027	Connor	Taylor	Entertainment,Photography,Decoration,Food Catering	4.7	16
W027	89000	VD013	Liam	Johnson	Entertainment,Photography,Decoration,Food Catering	4.7	16
W028	62000	VD060	Wyatt	Moore	Entertainment,Photography,Decoration,Food Catering	4.7	16
W032	70000	VD052	Gabriel	Moore	Entertainment,Photography,Decoration,Food Catering	4.7	16
W041	81000	VD042	Elijah	Taylor	Entertainment,Photography,Decoration,Food Catering	4.7	16
W049	90000	VD035	Wyatt	Taylor	Entertainment,Photography,Decoration,Food Catering	4.7	16
W053	86000	VD035	Wyatt	Taylor	Entertainment,Photography,Decoration,Food Catering	4.7	16
W054	72000	VD019	Carter	Miller	Entertainment,Photography,Decoration,Food Catering	4.7	16
W057	82000	VD006	Sophia	Wilson	Entertainment,Photography,Decoration,Food Catering	4.7	16
W012	77000	VD050	Henry	Smith	Entertainment,Photography,Decoration,Food Catering	4.6	25
W019	73000	VD015	Mason	Moore	Entertainment,Photography,Decoration,Food Catering	4.6	25
W021	78000	VD025	Caleb	Brown	Entertainment,Photography,Decoration,Food Catering	4.6	25
W029	79000	VD010	Ava	Smith	Entertainment,Photography,Decoration,Food Catering	4.6	25
W045	78000	VD033	Owen	Johnson	Entertainment,Photography,Decoration,Food Catering	4.6	25
W048	66000	VD058	Owen	Smith	Entertainment,Photography,Decoration,Food Catering	4.6	25
W001	50000	VD001	John	Smith	Entertainment,Photography,Decoration,Food Catering	4.5	32
W002	75000	VD030	Mia	Smith	Entertainment,Photography,Decoration,Food Catering	4.5	32
W006	90000	VD055	Mia	Taylor	Entertainment,Photography,Decoration,Food Catering	4.5	32
W025	83000	VD022	Ella	Johnson	Entertainment,Photography,Decoration,Food Catering	4.5	32
W030	65000	VD016	Sophie	Smith	Entertainment,Photography,Decoration,Food Catering	4.5	32
W038	88000	VD055	Mia	Taylor	Entertainment,Photography,Decoration,Food Catering	4.5	32
W046	59000	VD038	Peyton	Smith	Entertainment,Photography,Decoration,Food Catering	4.5	32
W052	70000	VD007	Daniel	Taylor	Entertainment,Photography,Decoration,Food Catering	4.5	32
W009	68000	VD036	Leah	Moore	Entertainment,Photography,Decoration,Food Catering	4.4	41
W023	94000	VD020	Aria	Taylor	Entertainment,Photography,Decoration,Food Catering	4.4	41
W039	95000	VD028	Stella	Moore	Entertainment,Photography,Decoration,Food Catering	4.4	41
W040	62000	VD053	Sofia	Johnson	Entertainment,Photography,Decoration,Food Catering	4.4	41
W050	67000	VD012	Emma	Miller	Entertainment,Photography,Decoration,Food Catering	4.4	41
W051	94000	VD045	Lily	Smith	Entertainment,Photography,Decoration,Food Catering	4.4	41
W007	55000	VD018	Avery	Brown	Entertainment,Photography,Decoration,Food Catering	4.3	48
W008	72000	VD043	Mia	Moore	Entertainment,Photography,Decoration,Food Catering	4.3	48
W016	81000	VD059	Aubrey	Taylor	Entertainment,Photography,Decoration,Food Catering	4.3	48
W024	66000	VD034	Aubrey	Smith	Entertainment,Photography,Decoration,Food Catering	4.3	48
W042	68000	VD009	Ethan	Johnson	Entertainment,Photography,Decoration,Food Catering	4.3	48
W044	71000	VD026	Hazel	Miller	Entertainment,Photography,Decoration,Food Catering	4.3	48
W056	58000	VD051	Peyton	Taylor	Entertainment,Photography,Decoration,Food Catering	4.3	48
W010	85000	VD002	Alice	Johnson	Entertainment,Photography,Decoration,Food Catering	4.2	55
W015	64000	VD014  Isabella Taylor	Entertainment,Photography,Decoration,Food Catering	4.2	55
W022	67000	VD049	Leah	Johnson	Entertainment,Photography,Decoration,Food Catering	4.2	55
W031	92000	VD032	Lily	Moore	Entertainment,Photography,Decoration,Food Catering	4.2	55
W035	94000	VD024  Scarlett Taylor	Entertainment,Photography,Decoration,Food Catering	4.2	55
W036	67000	VD040	Sofia	Moore	Entertainment,Photography,Decoration,Food Catering	4.2	55
W037	81000	VD057	Lily	Johnson	Entertainment,Photography,Decoration,Food Catering	4.2	55
W058	65000	VD057	Lily	Johnson	Entertainment,Photography,Decoration,Food Catering	4.2	55

58 rows selected.

*/
