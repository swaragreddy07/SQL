CREATE TABLE F23_S001_T7_ZIP(
       street            varchar(40)    not null,
       city              varchar(40)    not null,
       zipcode           varchar(40)    not null,
       primary key(street, city)
);

CREATE TABLE F23_S001_T7_CLIENT(
	CID	         char(4) 	not null,
	firstName	 varchar(25) 	not null,
	lastName	 varchar(25) 	not null,
	budget	         int     not null,
	housenumber   	 varchar(25),
	street	         varchar(20),
	city	           varchar(20),
	country          varchar(30),
	wedding_date     date           not null,
        primary key(CID),
        foreign key(street, city) references F23_S001_T7_ZIP(street, city) 
);

CREATE TABLE F23_S001_T7_CLIENT_PHONENUMBER(
       CID              char(4)         not null,
       phone_number     char(10)        not null,
       primary key(CID, phone_number),
       foreign key(CID) references  F23_S001_T7_CLIENT(CID)     
);

CREATE TABLE F23_S001_T7_CLIENT_EMAIL(
       CID              char(4)         not null,
       email            varchar(100)    not null,
       primary key(CID, email),
       foreign key(CID) references  F23_S001_T7_CLIENT(CID)  
);

CREATE TABLE F23_S001_T7_PAYMENT(
       PID              char(6)         not null,
       amount           int             not null,
       payment_type     varchar(25)     not null,
       paymet_date      date            not null,
       CID              char(4)         not null,     
       primary key(PID),
       foreign key(CID) references  F23_S001_T7_CLIENT(CID)    
);

CREATE TABLE F23_S001_T7_GUEST(
       GUESTNUMBER      int             not null,
       CID              char(4)         not null,
       RSVP             varchar(3),
       first_name       varchar(25)     not null,
       last_name        varchar(25)     not null,
       primary key(GUESTNUMBER, CID),
       foreign key(CID) references  F23_S001_T7_CLIENT(CID) 
);

CREATE TABLE F23_S001_T7_WEDDING(
       WID            char(4)           not null,
       final_budget   int               not null,
       guest_count    int               not null,
       CID            char(4)           not null,
       primary key(WID),
       foreign key(CID) references  F23_S001_T7_CLIENT(CID) 
);

CREATE TABLE F23_S001_T7_VENUE(
        VID            char(4)           not null,
        name           varchar(50)       not null,
        price_per_hour int               not null,
        street         varchar(50)       not null,
        city           varchar(50)       not null,
        country        varchar(50)       not null,
        availability   varchar(3)        not null,
        capacity       int               not null,
        primary key(VID),
        foreign key(street, city) references F23_S001_T7_ZIP(street, city) 
);

CREATE TABLE F23_S001_T7_VENUE_PHONENUMBER(
       VID             char(4)           not null,
       phone_number    char(10)          not null,
       primary key(VID),
       foreign key(VID) references  F23_S001_T7_VENUE(VID) 
);

CREATE TABLE F23_S001_T7_VENUE_EMAIL(
       VID             char(4)           not null,
       email           varchar(50)       not null,
       primary key(VID),
       foreign key(VID) references  F23_S001_T7_VENUE(VID) 
);

CREATE TABLE F23_S001_T7_INDOOR_VENUE(
       VID                char(4)           not null,
       decoration_type    varchar(40)       not null,
       air_conditioning   varchar(3)        not null,
       stage_availability varchar(3)        not null,
       primary key(VID),
       foreign key(VID) references  F23_S001_T7_VENUE(VID) 
);

CREATE TABLE F23_S001_T7_OUTDOOR_VENUE(
       VID                char(4)           not null,
       natural_features   varchar(40)       not null,
       lighting           varchar(3)        not null,
       permit_requirement varchar(3)        not null,
       primary key(VID),
       foreign key(VID) references  F23_S001_T7_VENUE(VID) 
);

CREATE TABLE F23_S001_T7_RENTS(
       CID                char(4)           not null,
       VID                char(4)           not null,
       primary key(CID, VID),
       foreign key(CID) references  F23_S001_T7_CLIENT(CID), 
       foreign key(VID) references  F23_S001_T7_VENUE(VID)  
);

CREATE TABLE F23_S001_T7_HAPPENS_AT (
    WID char(4) not null,
    VID char(4) not null,
    primary key (WID, VID),
    foreign key (WID) references F23_S001_T7_WEDDING(WID),
    foreign key (VID) references F23_S001_T7_VENUE(VID)
);


CREATE TABLE F23_S001_T7_VENDOR(
	VENDORID    char(5) 	not null,
	Service     varchar(250) not null,
	Rating      varchar(4) not null,
	CostPerHour varchar(6)  not null,
	FName       varchar(90)	not null,
	LName       varchar(90) not null,
	Email       varchar(30),
	PhNumber    char(10),
	primary     key(VENDORID)
);

CREATE TABLE F23_S001_T7_DUTY(
       WID          char(4)                 not null,
       VENDORID     char(5)                 not null,
       DUTY_NUMBER  char(4)                 not null,
       status       varchar(100)            not null,
       description  varchar(300)            not null,
       primary key(DUTY_NUMBER, WID), 
       foreign key(WID) references  F23_S001_T7_WEDDING(WID), 
       foreign key(VENDORID) references  F23_S001_T7_VENDOR(VENDORID) 
);

CREATE TABLE F23_S001_T7_ASSIGNED_TO(
	WID	 char(4) 	not null,
	VENDORID char(5) 	not null,
	primary key(WID, VENDORID),
	foreign key(WID) references F23_S001_T7_WEDDING(WID) ,
	foreign key(VENDORID) references F23_S001_T7_VENDOR(VENDORID) 
);
CREATE TABLE F23_S001_T7_ITEM(
	IID	 char(4) 	not null,
	Cost     int     	not null,
	primary key(IID)
);
CREATE TABLE F23_S001_T7_ENTERTAINMENT(
	IID	     char(4) 	not null,
	MAGICIAN     varchar(3) not null,
	SOUND_SYSTEM varchar(3) not null,
	DJ           varchar(3) not null,
	LIVE_BAND    varchar(3) not null,
	primary key(IID),
	foreign key(IID) references F23_S001_T7_Item(IID)  
);
CREATE TABLE F23_S001_T7_PHOTOGRAPHY(
	IID	               char(4) 	not null,
	ENGAGEMENT_PHOTOGRAPHY varchar(3) not null,
	DRONE_PHOTOGRAPHY      varchar(3) not null,
	PHOTOGRAPHY_STYLE      varchar(30) not null,
	primary key(IID),
	foreign key(IID) references F23_S001_T7_Item(IID) 
);
CREATE TABLE F23_S001_T7_DECORATION(
	IID	           char(4) 	not null,
	THEME              varchar(300) not null,
	MATERIALS_USED     varchar(300) not null,
	primary key(IID),
	foreign key(IID) references F23_S001_T7_ITEM(IID) 
);
CREATE TABLE F23_S001_T7_FOOD_CATERING(
	IID	          char(4)    not null,
	MEAT_PREFERENCE   varchar(30) not null,
	DESSERT           varchar(300) not null,
	MAIN_COURSE       varchar(390) not null,
        APPETIZER         varchar(343) not null,
	primary key(IID),
	foreign key(IID) references F23_S001_T7_ITEM(IID) 
);
CREATE TABLE F23_S001_T7_PROVIDES(
	VENDORID	  char(5)    not null,
	IID	       char(4)    not null,
	primary key(VENDORID, IID),
	foreign key(VENDORID) references F23_S001_T7_VENDOR(VENDORID),
	foreign key(IID)      references F23_S001_T7_ITEM(IID) 
);

CREATE TABLE F23_S001_T7_INCLUDES(
	WID	  char(4)    not null,
	IID	  char(4)    not null,
	primary key(WID, IID),
	foreign key(WID) references F23_S001_T7_WEDDING(WID),
	foreign key(IID) references F23_S001_T7_ITEM(IID)
);






