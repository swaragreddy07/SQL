-- New Client with Wedding Date in June
INSERT INTO F23_S001_T7_CLIENT (CID, firstName, lastName, budget, housenumber, street, city, country, wedding_date) 
VALUES ('C060', 'Sophie', 'Turner', 16000, '5656', 'Ramanthapur', 'Hyderabad', 'USA', TO_DATE('2022-06-15', 'YYYY-MM-DD'));

-- Another New Client with Wedding Date in June
INSERT INTO F23_S001_T7_CLIENT (CID, firstName, lastName, budget, housenumber, street, city, country, wedding_date) 
VALUES ('C061', 'Mason', 'Thompson', 75000, '5757', 'Ramanthapur', 'Hyderabad', 'USA', TO_DATE('2021-06-28', 'YYYY-MM-DD'));

-- New Client with Wedding Date in June
INSERT INTO F23_S001_T7_CLIENT (CID, firstName, lastName, budget, housenumber, street, city, country, wedding_date) 
VALUES ('C062', 'Tom', 'John', 82000, '5656', 'Ramanthapur', 'Hyderabad', 'USA', TO_DATE('2022-06-15', 'YYYY-MM-DD'));

-- DELETING A VENDOR

DELETE FROM F23_S001_T7_ASSIGNED_TO WHERE VENDORID = 'VD057';
DELETE FROM F23_S001_T7_DUTY WHERE VENDORID ='VD057';
DELETE FROM F23_S001_T7_PROVIDES WHERE  VENDORID ='VD057';
DELETE FROM F23_S001_T7_VENDOR WHERE  VENDORID ='VD057';

-- UPDATING BUDGET OF A CLIENT

UPDATE F23_S001_T7_CLIENT
SET budget = 100000
WHERE CID = 'C014';

-- UPDATING COST OF AN ITEM

UPDATE F23_S001_T7_ITEM
SET cost = 1000
WHERE IID = 'I001';

UPDATE F23_S001_T7_ITEM
SET cost = 2000
WHERE IID = 'I002';

-- UPDATING THE RATING
UPDATE F23_S001_T7_VENDOR
SET Rating = '5.0'
WHERE VENDORID = 'VD048';

-- New CLIENT
INSERT INTO F23_S001_T7_CLIENT (CID, firstName, lastName, budget, housenumber, street, city, country, wedding_date) VALUES ('C059', 'Sathvik', 'Reddy', 50000, '1234', 'Ramanthapur', 'Hyderabad', 'India', TO_DATE('2010-05-7', 'YYYY-MM-DD'));
INSERT INTO F23_S001_T7_CLIENT_PHONENUMBER (CID, phone_number) VALUES ('C059', '1234554321');
INSERT INTO F23_S001_T7_CLIENT_EMAIL (CID, email) VALUES ('C059', 'sathvik@gmail.com');
 
-- WEDDING FOR THE NEW CLIENT

INSERT INTO F23_S001_T7_WEDDING (WID, final_budget, guest_count, CID) VALUES ('W059', 65000, 0, 'C059');

-- NEW VENUES

INSERT INTO F23_S001_T7_VENUE (VID, name, price_per_hour, street, city, country, availability, capacity) VALUES ('V083', 'Taj Falaknuma Palace', 1250, 'Ramanthapur', 'Hyderabad', 'USA', 'Yes', 200);
INSERT INTO F23_S001_T7_VENUE (VID, name, price_per_hour, street, city, country, availability, capacity) VALUES ('V084', 'Taj Krishna', 2500, 'Ramanthapur', 'Hyderabad', 'USA', 'Yes', 200);
INSERT INTO F23_S001_T7_VENUE (VID, name, price_per_hour, street, city, country, availability, capacity) VALUES ('V085', 'Golkonda Resorts', 2250, 'Ramanthapur', 'Hyderabad', 'USA', 'Yes', 200);

INSERT INTO F23_S001_T7_VENUE_PHONENUMBER (VID, phone_number) VALUES ('V083', '1098790432');
INSERT INTO F23_S001_T7_VENUE_PHONENUMBER (VID, phone_number) VALUES ('V084', '2398765432');
INSERT INTO F23_S001_T7_VENUE_PHONENUMBER (VID, phone_number) VALUES ('V085', '3456765432');

INSERT INTO F23_S001_T7_VENUE_EMAIL (VID, email) VALUES ('V083', 'sunil@gmail.com');
INSERT INTO F23_S001_T7_VENUE_EMAIL (VID, email) VALUES ('V084', 'thomas@gmail.com');
INSERT INTO F23_S001_T7_VENUE_EMAIL (VID, email) VALUES ('V085', 'vamshi@gmail.com');

INSERT INTO F23_S001_T7_INDOOR_VENUE (VID, decoration_type, air_conditioning, stage_availability) VALUES ('V084', 'Modern', 'No', 'Yes');
INSERT INTO F23_S001_T7_INDOOR_VENUE (VID, decoration_type, air_conditioning, stage_availability) VALUES ('V085', 'Beachy', 'Yes', 'No');

-- RENTING NEW VENUES

INSERT INTO F23_S001_T7_RENTS (CID, VID) VALUES ('C059', 'V083');
INSERT INTO F23_S001_T7_RENTS (CID, VID) VALUES ('C059', 'V084');
INSERT INTO F23_S001_T7_RENTS (CID, VID) VALUES ('C059', 'V085');

 
INSERT INTO F23_S001_T7_HAPPENS_AT (WID, VID) VALUES ('W059', 'V083');
INSERT INTO F23_S001_T7_HAPPENS_AT (WID, VID) VALUES ('W059', 'V084');
INSERT INTO F23_S001_T7_HAPPENS_AT (WID, VID) VALUES ('W059', 'V085');
