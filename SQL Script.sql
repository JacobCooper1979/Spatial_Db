/*  A spatial database was created in PostgreSQL using the Postgis extension for my second uni assessment. 
The task is to create a spatial database with 10 ruff town polygon approximations and 100 Points. 
I've chosen to use my general area to try and find different types of IT businesses in my local area. 
This will help me identify what field of IT I should specialise in and what IT jobs are available in my general area.
Created by Jacob Cooper. JacobCooper_SpatialDb_ID:30466032.
*/



DROP DATABASE IF EXISTS "JacobCooper_SpatialDb_ID:30466032";


BEGIN TRANSACTION;
/* Creating the database */
CREATE DATABASE "JacobCooper_SpatialDb_ID:30466032"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LOCALE_PROVIDER = 'libc'
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

COMMENT ON DATABASE "JacobCooper_SpatialDb_ID:30466032"
    IS 'Database for my assessment 2 for ITECH2004 Data Modeling creating a Spatial Database to identify the local IT businesses and their types.';

COMMIT;


-- after creating the new database these drop commands will ensure that these tables and types do not exist in the database.
BEGIN TRANSACTION;

DROP TYPE IF EXISTS BUSINESS_TYPE CASCADE;
DROP TYPE IF EXISTS TOWN_TYPE CASCADE;
DROP TABLE IF EXISTS buis_location_point CASCADE;
DROP TABLE IF EXISTS ruff_town_Locations CASCADE;

COMMIT;

BEGIN TRANSACTION;
-- Adding the extension postgis to make this database a spatial database. 
CREATE EXTENSION postgis;
COMMIT;

BEGIN TRANSACTION;
/* Setting the town_type as Enums differentiates between my home town, local towns, and cities. SArea is for the surrounding areas. */
CREATE TYPE TOWN_TYPE AS ENUM (
	'Home Town',
	'Town',
	'City',
	'SArea'
);

/* Creating Tables for Polygon locations. */
CREATE TABLE ruff_town_Locations (
    id SERIAL PRIMARY KEY,
    town_name VARCHAR(100),
	town_type TOWN_TYPE,
    boundary GEOMETRY(Polygon, 4326) 
);

/*Enums to class each type of buissness some buissness coverlaped with their services so i had to catagorise them
 in what they mainly specialise in. Most of these buissness offer multiple services so iv picked the type that that the buissness mainly focus on.*/

CREATE TYPE BUSINESS_TYPE AS ENUM (
    'Website Development Business',          
    'Hosting Business',                      
    'Software Development Business',         
    'Device Repair Business',                
    'General IT Consultation & Services',    
    'Digital Marketing & SEO',               
    'Telecommunications Business'            
);
	

/* Creating points Table For the Location of the IT businesses in my area.*/
CREATE TABLE buis_location_point (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    description TEXT,
	business_type BUSINESS_TYPE,
    location GEOMETRY(Point, 4326)
);
COMMIT;


/* Inserting data into ruff_town_Locations table for the towns i have selected */
BEGIN TRANSACTION;

INSERT INTO ruff_town_Locations (town_name, town_type, boundary)
VALUES (
    'Newee Creek',
    'Home Town',
    ST_SetSRID(
        ST_MakePolygon(
            ST_MakeLine(ARRAY[
                ST_MakePoint(-30.60168896515074, 152.8889615145505),
                ST_MakePoint(-30.62594600449782, 152.8846026674029),
                ST_MakePoint(-30.62714952314303, 152.8897099979226),
                ST_MakePoint(-30.62377432384356, 152.9036980539334),
                ST_MakePoint(-30.63390792983415, 152.9170335555359),
                ST_MakePoint(-30.66005496155552, 152.9119597453911),
                ST_MakePoint(-30.65842758133529, 152.9527792510253),
                ST_MakePoint(-30.62468874872213, 152.9755281502089),
                ST_MakePoint(-30.61791816037461, 152.936834634779),
                ST_MakePoint(-30.60168896515074, 152.8889615145505)
            ])
        ), 4326
    )
);

INSERT INTO ruff_town_Locations (town_name, town_type, boundary)
VALUES (
    'Nambucca Heads',
    'Town',
    ST_SetSRID(
        ST_MakePolygon(
            ST_MakeLine(ARRAY[
                ST_MakePoint(-30.6752973445753, 152.9481868184284),
                ST_MakePoint(-30.68208168235731, 152.9755641379236),
                ST_MakePoint(-30.6619477727596, 152.9891519430172),
                ST_MakePoint(-30.64991745020664, 153.0025968838241),
                ST_MakePoint(-30.64945060581284, 153.0203410422929),
                ST_MakePoint(-30.61706884573531, 153.0110629531627),
                ST_MakePoint(-30.61394850461807, 152.9868710044668),
                ST_MakePoint(-30.60793799498238, 152.9841864040857),
                ST_MakePoint(-30.64870250115364, 152.9526697977662),
                ST_MakePoint(-30.6752973445753, 152.9481868184284)
            ])
        ), 4326
    )
);

INSERT INTO ruff_town_Locations (town_name, town_type, boundary)
VALUES (
    'Coffs Harbour',
    'City',
    ST_SetSRID(
        ST_MakePolygon(
            ST_MakeLine(ARRAY[
                ST_MakePoint(-30.25774854991886,153.0857285330422),
                ST_MakePoint(-30.27370397706979, 153.0727667251945),
                ST_MakePoint(-30.29609761729046, 153.061276878063),
                ST_MakePoint(-30.29789419992937,153.1059534402395),
                ST_MakePoint(-30.31918259160555, 153.0865868814191),
                ST_MakePoint(-30.32660062035747,153.0831611584401),
                ST_MakePoint(-30.35385615026143, 153.0831611584401),
                ST_MakePoint(-30.31287456914184, 153.1413698215669),
                ST_MakePoint(-30.26385090100258, 153.1396435298638),
                ST_MakePoint(-30.25774854991886, 153.0857285330422)
            ])
        ), 4326
    )
);

INSERT INTO ruff_town_Locations (town_name, town_type, boundary)
VALUES (
    'Brisbane',
    'City',
    ST_SetSRID(
        ST_MakePolygon(
            ST_MakeLine(ARRAY[
                ST_MakePoint(-27.26917375601498, 152.9264563808705),
                ST_MakePoint(-27.56002188561154, 152.926547923819),
                ST_MakePoint(-27.56585077719934, 152.6993862218506),
                ST_MakePoint(-27.68512560705349, 152.7440902552386),
                ST_MakePoint(-27.7470639777979, 153.1689286900472),
                ST_MakePoint(-27.64394402811963, 153.3264211263274),
                ST_MakePoint(-27.21238732217516, 153.1277892401511),
                ST_MakePoint(-27.02237719850948, 153.0360328959027),
                ST_MakePoint(-27.02264480650679, 152.8702791964748),
                ST_MakePoint(-27.26917375601498, 152.9264563808705)
            ])
        ), 4326
    )
);

INSERT INTO ruff_town_Locations (town_name, town_type, boundary)
VALUES (
    'Sydney',
    'City',
    ST_SetSRID(
        ST_MakePolygon(
            ST_MakeLine(ARRAY[
                ST_MakePoint(-33.69825184125364, 150.7002996241683),
                ST_MakePoint(-33.79143826279454, 150.6343822564199),
                ST_MakePoint(-33.82780958412496, 150.780703415144),
                ST_MakePoint(-34.00311667464096, 150.7516180124271),
                ST_MakePoint(-34.07703847150586, 150.6796328146695),
                ST_MakePoint(-34.1150056050299, 150.8013355124104),
                ST_MakePoint(-34.01953686227969, 150.8830140472682),
                ST_MakePoint(-34.00419054546921, 151.2550820175664),
                ST_MakePoint(-33.58040156991302, 151.333594330304),
                ST_MakePoint(-33.69825184125364, 150.7002996241683)
            ])
        ), 4326
    )
);

INSERT INTO ruff_town_Locations (town_name, town_type, boundary)
VALUES (
    'Armidale',
    'City',
    ST_SetSRID(
        ST_MakePolygon(
            ST_MakeLine(ARRAY[
                ST_MakePoint(-30.47728648864042, 151.5610189042137),
                ST_MakePoint(-30.50201103431821, 151.5805214311637),
                ST_MakePoint(-30.56410855697053, 151.5920234755963),
                ST_MakePoint(-30.58674885880528, 151.7260220310348),
                ST_MakePoint(-30.56650777938144, 151.7329843325045),
                ST_MakePoint(-30.57287908297139, 151.7553356834135),
                ST_MakePoint(-30.44642003005968, 151.7739776577108),
                ST_MakePoint(-30.41759396528954, 151.5696175441736),
                ST_MakePoint(-30.5018741224408, 151.6618019156936),
                ST_MakePoint(-30.47728648864042, 151.5610189042137)
            ])
        ), 4326
    )
);

INSERT INTO ruff_town_Locations (town_name, town_type, boundary)
VALUES (
    'South West Rocks',
    'Town',
    ST_SetSRID(
        ST_MakePolygon(
            ST_MakeLine(ARRAY[
                ST_MakePoint(-30.88128496197086, 153.0161104701058),
                ST_MakePoint(-30.89059036548084, 153.0171923150962),
                ST_MakePoint(-30.90028629691997, 153.0142208961338),
                ST_MakePoint(-30.91272529146871, 153.0239810549658),
                ST_MakePoint(-30.91692787744369, 153.0435023620057),
                ST_MakePoint(-30.90883234367111, 153.0563242614173),
                ST_MakePoint(-30.8914808135604, 153.0671566422564),
                ST_MakePoint(-30.8816325991569, 153.0436724624838),
                ST_MakePoint(-30.87222756271986, 153.0285524249655),
                ST_MakePoint(-30.88128496197086, 153.0161104701058)
            ])
        ), 4326
    )
);

INSERT INTO ruff_town_Locations (town_name, town_type, boundary)
VALUES (
    'Port Macquarie',
    'City',
    ST_SetSRID(
        ST_MakePolygon(
            ST_MakeLine(ARRAY[
                ST_MakePoint(-31.44615370478358, 152.8513213585385),
                ST_MakePoint(-31.47259881946696, 152.8526505402297),
                ST_MakePoint(-31.51562957891595, 152.8701760416933),
                ST_MakePoint(-31.47377375754053, 152.8893792090233),
                ST_MakePoint(-31.49534777365, 152.9067756924079),
                ST_MakePoint(-31.47587292235615, 152.9377827445558),
                ST_MakePoint(-31.4295828147071, 152.9229605118939),
                ST_MakePoint(-31.4060138313455, 152.9046039581526),
                ST_MakePoint(-31.4205063290417, 152.8692375053263),
                ST_MakePoint(-31.44615370478358, 152.8513213585385)
            ])
        ), 4326
    )
);

INSERT INTO ruff_town_Locations (town_name, town_type, boundary)
VALUES (
    'Grafton',
    'City',
    ST_SetSRID(
        ST_MakePolygon(
            ST_MakeLine(ARRAY[
                ST_MakePoint(-29.68211405000834, 152.9204735416508),
                ST_MakePoint(-29.67213650438728, 152.9039958904257),
                ST_MakePoint(-29.69802359971372, 152.9321783218444),
                ST_MakePoint(-29.69632620965669, 152.9489985365729),
                ST_MakePoint(-29.67353568952852, 152.9566882192948),
                ST_MakePoint(-29.66357117083475, 152.9421633507096),
                ST_MakePoint(-29.662973094809, 152.9377461033578),
                ST_MakePoint(-29.66810768376496, 152.9360251022934),
                ST_MakePoint(-29.66481564741286, 152.9164050198144),
                ST_MakePoint(-29.68211405000834, 152.9204735416508)
            ])
        ), 4326
    )
);

INSERT INTO ruff_town_Locations (town_name, town_type, boundary)
VALUES (
    'Surrounding Areas',
    'SArea',
    ST_SetSRID(
        ST_MakePolygon(
            ST_MakeLine(ARRAY[
                ST_MakePoint(-32.39551617517989, 152.5138013840269),
                ST_MakePoint(-31.10488689704723, 153.0895396188487),
                ST_MakePoint(-29.77571911745998, 153.3065602260517),
                ST_MakePoint(-28.2836107361294, 153.681073471285),
                ST_MakePoint(-27.00135284397611, 153.483640228017),
                ST_MakePoint(-26.73277906517035, 151.9392067174224),
                ST_MakePoint(-30.36473866409712, 151.3239822036268),
                ST_MakePoint(-33.97013761384776, 150.3409504638375),
                ST_MakePoint(-34.25581144197075, 151.005430690718),
                ST_MakePoint(-32.39551617517989, 152.5138013840269)
            ])
        ), 4326
    )
);

COMMIT;



/* Displaying all Data to ensure it was added correctly was entered correctly. */
SELECT * FROM ruff_town_Locations;



BEGIN TRANSACTION;

/* Inserting data into the buis_location_point table for each buissness that i have found in an area id potentally want to live in and work in. */
INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Nambucca Social Space',
    'Website designer specialising in Web Design & Local SEO.',
	'Website Development Business',
    ST_SetSRID(ST_MakePoint(153.00430931820358, -30.63869655040028), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Social Space - Web Design & Local SEO',
    'A website development company that will create, migrate and maintain a website for a subscription fee.',
	'Website Development Business',
    ST_SetSRID(ST_MakePoint(-30.63869655040028, 153.00430931820358), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Webworx International Pty Ltd',
    'This business offers Digital marketing and various cloud-based shared and DNS hosting services, cyber security training, anti-spam services, cloud-based backups, and domain creation and transfer. ',
	'Hosting Business',
    ST_SetSRID(ST_MakePoint(-30.641588835840352, 153.0044391690513), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Nambucca Technology Business',
    'This business does not have a location, so I made one up, but it services the Nambucca Valley area. They specialise in website computer repairs, testing and tagging, and cloud and data security.',
	'General IT Consultation & Services',
    ST_SetSRID(ST_MakePoint(-30.641185904179782, 153.00027840274691), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Bellingen Techno Wizards',
    'Local computer repair store.',
	'Device Repair Business',
    ST_SetSRID(ST_MakePoint(-30.453443506182648, 152.8964471267183), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'jwfcomputing',
    'This Business focuses on local computer support and repair services.',
	'General IT Consultation & Services',
    ST_SetSRID(ST_MakePoint(-30.356741534396793, 153.0865983960275), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'East GVS computers',
    'This Business focuses on local computer repair services.',
	'Device Repair Business',
    ST_SetSRID(ST_MakePoint(-30.35826330513633, 153.07440272671576), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'The Computer Technician',
    'This business focuses on Local Device repairs, data recovery networks, and internet services and offers remote support repairs, apple devices, and virus removal.',
	'General IT Consultation & Services',
    ST_SetSRID(ST_MakePoint(-30.35125801633924, 153.10010774384173), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Bonville computers',
    'This business offers computer repairs, networking issues, virus removal and protection, complete business solutions, data recovery and migrations, and the sales.',
	'General IT Consultation & Services',
    ST_SetSRID(ST_MakePoint(-30.379052771361646, 153.00122534020824), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Tech Addicts',
    'This business specialises in IT repairs and sales for gamers and Small to medium businesses.',
	'General IT Consultation & Services',
    ST_SetSRID(ST_MakePoint(-30.311356756119423, 153.1010239536983), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Craigs Computers',
    'This business focuses on custom-built services that are specifically designed to suit the any time of customer, along with repairing computers, data backup solutions.',
	'General IT Consultation & Services',
    ST_SetSRID(ST_MakePoint(-30.300537921921723, 153.0980661843863), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Haisi Creative',
    'This business focuses on setting up remote working environments, improving office environments and home devices. document creation design outputs for community consultation, creating infographics, providing print press services.',
	'General IT Consultation & Services',
    ST_SetSRID(ST_MakePoint(-30.29627033045548, 153.1032582158019), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Solitary Technology',
    'This service connects people from small and medium-sized businesses to the NBN and provides secure cloud backups and computer repair and support services.',
	'Telecommunications Business',
    ST_SetSRID(ST_MakePoint(-30.298012296831626, 153.11521017089441), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Coffs Computers ',
    'Apple Authorised Service Provider and Repairer, along with the sales of Apple devices.',
	'Device Repair Business',
    ST_SetSRID(ST_MakePoint(-30.298176226651353, 153.11662685555035), 4326)
 );
 
INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'A1Outreach',
    'A company that focuses on software development for businesses including but not limited to medical and health human resource business and products and services management consulting financial services manufacturing and distribution along with marketing for business, they also utilise their software B2b lead generation and appointment setting to provide a multichannel technique that optimises voice, email, social media, webinars, instant messaging to reach the targeted customer quicker.',
	'Software Development Business',
    ST_SetSRID(ST_MakePoint(-30.375418768068617, 153.04757735921493), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Boambee Rocky Mountains Trust',
    'I couldn’t find much information about them, but they are a software development company based in Sawtel area.',
	'Software Development Business',
    ST_SetSRID(ST_MakePoint(-30.36786268057889, 153.09829707955734), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Core Estimator',
    'A software development business that has created software to make it easy and fast for construction companies to come up with an estimated price for their construction plans.',
	'Software Development Business',
    ST_SetSRID(ST_MakePoint(-30.361316907438834, 153.09720463324675), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Wichsport',
    'This business focuses on creating websites and its club management software to help companies analyse the results of their business record and manage registrations, points of sale, and awards systems.',
	'Software Development Business',
    ST_SetSRID(ST_MakePoint(-30.32597109255687, 153.0541892465059), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'XBert',
    'This business has developed AI-powered work inelegance software to help safeguard and empower bookkeepers and accounting teams, improving their effectiveness and ensuring they meet government regulations.',
	'Software Development Business',
    ST_SetSRID(ST_MakePoint(-30.302309669583938, 153.13743091839655), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Bespoke Business',
    'This business has created two software programs: BBSCloud for accounting and business management solutions and HROTCloud, software designed for housing contractors property maintenance and service job management. They also provide IT support monitoring and maintenance, cyber security and compliance backup, disaster recovery hosting, and strategic planning services.',
	'Software Development Business',
    ST_SetSRID(ST_MakePoint(-30.298789662246183, 153.11571575426754), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'capital office business solutions',
    'This business focuses on helping you plan what you need for your business to become successful, providing IT consultation services, analysing your business and plans to help grow your business, and offering advice on different types of software that can be used.',
	'General IT Consultation & Services',
    ST_SetSRID(ST_MakePoint(-30.297849125848003, 153.11503835369805), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Chameleon Software Pty Ltd',
    'This business has created Chameleon software as an all-in-one client database case management tool and billing system.',
	'Software Development Business',
    ST_SetSRID(ST_MakePoint(-30.297937430942458, 153.10927845264825), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'CoffsWebolution',
    'I couldn’t find much information, but they focus on website solutions for business.',
	'Website Development Business',
    ST_SetSRID(ST_MakePoint(-30.29008173253421, 153.11498619339332), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'BrainStack Pty Ltd',
    'This business focuses on graphics design, computer repairs, IT consulting services, Website Development and Mobile App Development.',
	'General IT Consultation & Services',
    ST_SetSRID(ST_MakePoint(-30.29052641153611, 153.1151578548217), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'AusScan',
    'couldn’t find any information about this business other than a phone number.',
	'Software Development Business',
    ST_SetSRID(ST_MakePoint(-30.79945932534402, 152.8690636028428), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Hutchinson Software Pty lte',
    'This business focuses on mobile apps, desktop apps and web and UX development for small and medium-sized enterprises.',
	'Software Development Business',
    ST_SetSRID(ST_MakePoint(-30.444838609008308, 152.90136205013076), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Engageable Australia Pty Ltd',
    'This business has created software that is called engageable, which is focused on healthcare support with auditing tools, reports, questionnaires, forms surveys and also for higher education, providing tools for certificates and regards tags actions and rules built-in webpages user onboarding/creation of account roles and permissions consent forms and locations and team management tasks monitoring.',
	'Software Development Business',
    ST_SetSRID(ST_MakePoint(-30.44511861238583, 152.89602112097688), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Lighthouse Beach IT – Port Macquarie',
    'This business provides business and home support along with remote IT support with Windows upgrades, maintenance check-ups, cybersecurity, and setting up new devices. The same is true for Apple computers and data recovery services.',
	'General IT Consultation & Services',
    ST_SetSRID(ST_MakePoint(-31.47433522076906, 152.92724844187785), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Integer IT PTY',
    'This business focuses on IT support and management cybersecurity management cloud migrations data backup and disaster recovery phone hosted solutions on NBN data circuits multi-site office integrations, relocation IT projects reviews, strategic planning reporting, lifecycle management, and onsite installation services.',
	'General IT Consultation & Services',
    ST_SetSRID(ST_MakePoint(-31.46986974516655, 152.90673490738448), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'The Website Factory Co',
    'This business focuses on website design, marketing webpages, managing cyber security, and making responsive designs.',
	'Website Development Business',
    ST_SetSRID(ST_MakePoint(-31.464086271645133, 152.90888067459085), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Port Macquarie Web Designs',
    'This business focuses on the design creation and hosting of responsive websites along with logo design and provides social media advice and online marketing for small businesses.',
	'Website Development Business',
    ST_SetSRID(ST_MakePoint(-31.458082794674894, 152.8986668226883), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Island I.T. Private I.T. Support',
    'This business provides small to medium-sized businesses with onsite support for their IT systems. Website designs offer Zuludesk and jamf school mobile device management and support from their partners jamF to allow schools to centrally manage all of their IOS devices from a single central dashboard and provide training.',
	'General IT Consultation & Services',
    ST_SetSRID(ST_MakePoint(-31.45881494661945, 152.89231535175728), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Advantage IT',
    'This business provides a helpdesk that helps businesses manage their services, web services, cloud services, backup and recovery solutions, and IT constancy and auditing services.',
	'General IT Consultation & Services',
    ST_SetSRID(ST_MakePoint(-31.45141994894867, 152.88682218770884), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Port Macquarie Computing Solutions',
    'This business focuses on computer repairs and maintenance of IT computer systems along with sales of IT devices, network maintenance, virus removal, data restoration, and migration. It provides remote access solutions, auditing services, website and email hosting, internet diagnostic services, wireless network solutions, and network camera systems for security phone system installations and repairs.',
	'Device Repair Business',
    ST_SetSRID(ST_MakePoint(-31.44409759389679, 152.87386175378205), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Engage ICT',
    'I couldn’t find much information about this business other than a phone number.',
	'General IT Consultation & Services',
    ST_SetSRID(ST_MakePoint(-31.42901173897745, 152.88622137289104), 4326)
 );
 
INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'SteveIT',
    'This business provides small to medium-sized businesses with IT support for Office 365 Google Workspace and practice IT management and cyber security solutions.General IT Consultation & Services',
	'General IT Consultation & Services',
    ST_SetSRID(ST_MakePoint(-31.429670880446793, 152.89034124592737), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Cloud Concepts',
    'This business focuses on creating and hosting websites in the cloud for small and large companies. It offers custom software solutions for small businesses to fit their needs, including booking and payment systems.',
	'Website Development Business',
    ST_SetSRID(ST_MakePoint(-31.43102576770772, 152.9072713491836), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Web studio',
    'This business focuses on website design and digital marketing and provides IT consultation to develop a business plan and maintain the website.',
	'Digital Marketing & SEO',
    ST_SetSRID(ST_MakePoint(-31.42993236856941, 152.90716406054497), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'PD Digital',
    'This business focuses on building and designing web pages and hosting them. It also provides a customised and managed CRM system and marketing services.',
	'Digital Marketing & SEO',
    ST_SetSRID(ST_MakePoint(-31.430911914738306, 152.90890213198216), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Bookinglayer',
    'This business has created an all-in-one booking software for sports camps, making it an easy solution for managing bookings communication and scheduling the bookings.',
	'Software Development Business',
    ST_SetSRID(ST_MakePoint(-28.68712289867433, 153.6114046464161), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Benn Web Design Port Macquarie',
    'This business focuses on website maintenance, hosting, and search optimisation, as well as the design and marketing of the website.',
	'Website Development Business',
    ST_SetSRID(ST_MakePoint(-31.43069220433842, 152.9091059798668), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Joyer',
    'This business creates websites and mobile applications, hosts them, and provides marketing and graphics design services.',
	'Website Development Business',
    ST_SetSRID(ST_MakePoint(-31.43072882277416, 152.90906306452266), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Cruisin Along',
    'I couldn’t find much information other than a phone number.',
	'Website Development Business',
    ST_SetSRID(ST_MakePoint(-31.43214777616035, 152.9127323264555), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Pancake Web Studio',
    'This business focuses on creating and designing websites and marketing, along with helping small businesses with their branding.',
	'Website Development Business',
    ST_SetSRID(ST_MakePoint(-31.4362488884127, 152.9216694468752), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'deprogram',
    'This is a software development business focused on the creation of specialised software that is cross-platform, which includes website mobile and desktop applications, and provides hosting services for their applications.',
	'Software Development Business',
    ST_SetSRID(ST_MakePoint(-28.551364531707073, 153.49964692596484), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'minibossmarketing',
    'I couldn’t find much information other than a phone number but says they are a website designer.',
	'Website Development Business',
    ST_SetSRID(ST_MakePoint(-31.454895728013195, 152.9147117550751), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'High-End Design',
    'This business has created a platform for anyone to design, build, and host a website, along with free software upgrades. It ensures its compatible with mobiles and tablets and allows you to edit your website anywhere. It provides search optimisation and advertisements. No technical skills are required.',
	'Software Development Business',
    ST_SetSRID(ST_MakePoint(-31.469372303721396, 152.9197745690736), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'No Stress Websites - Small Business Web Design',
    'I couldn’t find anything but a phone number, but it states they are a website designing business.',
	'Website Development Business',
    ST_SetSRID(ST_MakePoint(-31.45409324442619, 152.92939908881252), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Spin 360-3D',
    'This business focuses on website design creation and upgrades, logo designs and hosting, 3D animations 3D brochures and provides marketing solutions, IT consultation advice, and search engine optimisation.',
	'Website Development Business',
    ST_SetSRID(ST_MakePoint(-31.46826374173515, 152.90976119267964), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Design4u Creations',
    'They say they are a website designer, but their website doesn’t even open, and all I can find is their phone number.',
	'Website Development Business',
    ST_SetSRID(ST_MakePoint(-31.447597072581065, 152.88509533033525), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'KC Web Design Port Macquarie',
    'This business focuses on creating professional websites, providing targeted advertising campaigns, and hosting and managing the website.',
	'Website Development Business',
    ST_SetSRID(ST_MakePoint(-31.42977471119284, 152.88831998041238), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Orchiddigital Media',
    'This business focuses on creating, designing, and maintaining websites and mobile applications for small businesses, as well as marketing.',
	'Software Development Business',
    ST_SetSRID(ST_MakePoint(-31.07783589952646, 152.8413450634787), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Kempsey FYTEC Computers',
    'This business is a computer and mobile phone repair store.',
	'Device Repair Business',
    ST_SetSRID(ST_MakePoint(-31.080243205543812, 152.8411372533198), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'aura systems',
    'This business focuses on IT consultation services and computer repairs.',
	'General IT Consultation & Services',
    ST_SetSRID(ST_MakePoint(-30.886238193582294, 153.02439769581076), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Armidale Computers',
    'This business focuses on computer repairs, data recovery, onsite visits, provides an internet café.',
	'Device Repair Business',
    ST_SetSRID(ST_MakePoint(-30.505918571656856, 151.67150102884423), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Ozziewebs Digital Business Services',
    'This business focuses on website and digital service business but doesn’t even have a website, only a phone number.',
	'Digital Marketing & SEO',
    ST_SetSRID(ST_MakePoint(-30.51331487857547, 151.67104263996413), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Omelia Technologies',
    'I couldn’t find much information other than a phone number, and it says they are a software company.',
	'Software Development Business',
    ST_SetSRID(ST_MakePoint(-30.522342110227093, 151.65316331155836), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'ICT International',
    'Provides high-tech equipment for agricultural use.',
	'General IT Consultation & Services',
    ST_SetSRID(ST_MakePoint(-30.516274979929786, 151.65127500795288), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Armidale Practical Systems',
    'A software development business that has created bookkeeping software to make it faster and more productive for bookkeepers to do their jobs. ',
	'Software Development Business',
    ST_SetSRID(ST_MakePoint(-30.513153337810923, 151.66071652598026), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'New England Business Technology',
    'This business focuses on IT and communication solutions, including selling new devices, networking equipment management backup solutions, business phones and IT support.',
	'General IT Consultation & Services',
    ST_SetSRID(ST_MakePoint(-30.511727367149852, 151.66368762452774), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'FarmLab',
    'This business has created a FarmLab application that allows the collection and analysis of farming data to be easier, faster, and more cost-effective. It also provides farming advice by assessing the land.',
	'Software Development Business',
    ST_SetSRID(ST_MakePoint(-30.513833307633707, 151.66104862738192), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'FX Media',
    'I couldn’t find much information about this business besides a phone number and an address.',
	'Website Development Business',
    ST_SetSRID(ST_MakePoint(-30.51535772266314, 151.67006026202526), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Morelly',
    'This business provides IT consultation and advice for creating and growing your business.',
	'Digital Marketing & SEO',
    ST_SetSRID(ST_MakePoint(-30.513666285836564, 151.66785148062553), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'The Website Builders',
    'This business focuses on website development for small and medium-sized enterprises, hosting websites, providing backup services and cybersecurity measures, and domain names.',
	'Website Development Business',
    ST_SetSRID(ST_MakePoint(-30.512548713215978, 151.66651919978128), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Armidale Online',
    'This business is focused on IT consultations to find the best solution and applications to fit the needs of a small or medium-sized business.',
	'General IT Consultation & Services',
    ST_SetSRID(ST_MakePoint(-30.5090136374537, 151.6531345372182), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Failte Studio',
    'This business is focused on the websites design, helping with branding, and ensuring the website is optimised for mobile devices domain connection. It offers 30-day launch support but also uses Squarespace to create web pages.',
	'Website Development Business',
    ST_SetSRID(ST_MakePoint(-30.506835013094, 151.64837463076213), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Mobile Management',
    'This business is focused on IT consultations to find the right software for your small to medium-sized business.',
	'General IT Consultation & Services',
    ST_SetSRID(ST_MakePoint(-30.378573180257046, 152.64800869789897), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Web Design Domain web services',
    'This business is focused on creating, designing, and hosting website search engine optimisations and web marketing.',
	'Website Development Business',
    ST_SetSRID(ST_MakePoint(-30.344622446255574, 152.7110379994716), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Bellingen IT',
    'This business is focused on computer sales service and repairs, remote and onsite support IT solutions for small and medium-sized enterprises and connection to NBN services.',
	'General IT Consultation & Services',
    ST_SetSRID(ST_MakePoint(-30.449950139529783, 152.89872959772467), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'zaaton',
    'This business focuses on PC laptops, printer repairs, and website design for small businesses.',
	'General IT Consultation & Services',
    ST_SetSRID(ST_MakePoint(-29.690335562333644, 152.93450579629186), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Grafton PortaSafeStocks',
    'All I could find was that they are a software company, and they don’t have a website.',
	'Website Development Business',
    ST_SetSRID(ST_MakePoint(-29.698983559639917, 152.96239962572906), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Simons Signal & I.T. Services',
    'This business focuses on computer and mobile devices and other electrical device repairs.',
	'Device Repair Business',
    ST_SetSRID(ST_MakePoint(-29.67945148292502, 152.94093927576895), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Computer Troubleshooters Grafton',
    'This business is focused on device reapirs and providing cloud services, site IT support, remote support services hosting emails, computer repairs, data backup and recovery services, and software and hardware sales. These services are provided for home small businesses and medium-sized businesses.',
	'Device Repair Business',
    ST_SetSRID(ST_MakePoint(-29.687877421056484, 152.93615840582393), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'I Tech You Computers',
    'I couldn’t find much information as they don’t have a website, but they are an IT consulting business that helps businesses with IT solutions.',
	'General IT Consultation & Services',
    ST_SetSRID(ST_MakePoint(-29.687334301634117, 152.93257318073518), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Grafton Phone Care - iPhone & iPad Repairs - Grafton NSW',
    'This business focuses on phone repairs for Apple devices.',
	'Device Repair Business',
    ST_SetSRID(ST_MakePoint(-29.691318141096588, 152.9360676552842), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Byron Bay',
    'This business focuses on Microsoft products planning deployment and maintenance of hardware and software networking solutions, cyber security solutions, power protection, mobile technology cameras, and internet solutions point of sale terminals.',
	'General IT Consultation & Services',
    ST_SetSRID(ST_MakePoint(-28.68743629425876, 153.5769048291918), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'ITRiver',
    'This business focuses on IT consulting, supporting the business with IT device level agreements, Microsoft sales and maintenance of pcs data backup services, Sophos UTM sales and installation data network management, along with website domain and registrations.',
	'General IT Consultation & Services',
    ST_SetSRID(ST_MakePoint(-29.689485226257368, 152.93555393072128), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Byron Bay Web Hosting',
    'This business focuses on IT support and consultations, including legal agreements, HP server sales and maintenance, HP computer sales and maintenance, data backup services, data network management, website hosting and website domain registration, virus removal and testing, and tagging electronic equipment.',
	'Website Development Business',
    ST_SetSRID(ST_MakePoint(-28.63227377151867, 153.57934596477324), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Panorama Marketing',
    'This business focuses on marketing solutions for websites or products, brand development and photography.',
	'Website Development Business',
    ST_SetSRID(ST_MakePoint(-28.634711735800693, 153.57791998293496), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Migaloo Digital',
    'This business focuses on web design development, UI design automation, web performance, and cloud hosting.',
	'Website Development Business',
    ST_SetSRID(ST_MakePoint(-28.632002810078042, 153.58079688914526), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Agency Eight | Web Design Agency Byron Bay',
    'This business focuses on the design and creation of websites and activation, along with ensuring high web performance and cloud hosting.',
	'Website Development Business',
    ST_SetSRID(ST_MakePoint(-28.640312575360927, 153.60835081281851), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'East Point Digital',
    'The website couldn’t be found, so either close their business or the website is down, but the company focuses on website design creation and hosting.',
	'Website Development Business',
    ST_SetSRID(ST_MakePoint(-28.656217465738816, 153.6219839611944), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Byron Design',
    'This business focuses on website design creation and maintenance and provides services to create brochures, flyers, direct mail, illustrations, online banner ads and animations.',
	'Website Development Business',
    ST_SetSRID(ST_MakePoint(-28.658709451358195, 153.61900385930588), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Accelerate Tech Pty Ltd',
    'This development business focuses on creating software for business at any time of business need, utilising Azure cloud hosting services and Azure DevOps.',
	'Software Development Business',
    ST_SetSRID(ST_MakePoint(-28.63106114460927, 153.580973591795), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'etc. technology',
    'This business is focused on IT consultations, and they do not give much information about themselves on their website, but they provide computer support ',
	'General IT Consultation & Services',
    ST_SetSRID(ST_MakePoint(-28.63463688606967, 153.57930429625378), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'DevPro',
    'This business is focused on providing custom software and application solutions for businesses, which include desktop, web, and mobile applications. It also provides systems integration along with a SharePoint resource.',
	'Software Development Business',
    ST_SetSRID(ST_MakePoint(-28.63527518847816, 153.58037603613798), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Byron Bay Hello Again',
    'This business focuses on creating web desktop and mobile applications for small and medium-sized companies and on UI design e-commerce integration architecture software.',
	'Software Development Business',
    ST_SetSRID(ST_MakePoint(-28.636977309251915, 153.58656405808833), 4326)
 );
 
 
INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Noorix - Custom Software Development & Mobile App Developers Sydney',
    'This Buissness focuses on software development including web, mobile app development.',
	'Software Development Business',
    ST_SetSRID(ST_MakePoint(-33.859632974281645, 151.20392611280846), 4326)
 );
 
INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Solentive',
    'This buissness focuses on utilising AI along with app and software development.',
	'Software Development Business',
    ST_SetSRID(ST_MakePoint(-33.87722597082955, 151.21393460957535), 4326)
 );


INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Mobile App Developers Sydney, App Development & Design Sydney, Web App Development Sydney',
    'This buissness focuses on mobile and web application development.',
	'Software Development Business',
    ST_SetSRID(ST_MakePoint(-33.83858444584772, 151.20996304390445), 4326)
 );


INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Software Co - Software & App Developer Sydney',
    'This buissness focuses on all aspects of software development inculding Web, Mobile and Desktop applications.',
	'Software Development Business',
    ST_SetSRID(ST_MakePoint(-33.864983916356096, 151.20213058471293), 4326)
 );


INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Phocas Business Intelligence Software | Sydney',
    'this bussiness focuses on IT consultations while providing their software that they have created along with providing custom made software.',
	'General IT Consultation & Services',
    ST_SetSRID(ST_MakePoint(-33.86764133428424, 151.20168837477257), 4326)
 );


INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Thoughtworks Brisbane',
    'This buissness focuses on AI data analytics, Cloud Hosting, software-defined Vehicles, Customer Experience and Products, Moderniszation and Software Engineering.',
	'Software Development Business',
    ST_SetSRID(ST_MakePoint(-27.456177628650316, 153.04070204320888), 4326)
 );


INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Tech Sprints',
    'This Buissness focuses on utilising agile software development methodologies while also providing DevOps options and the creation of software applications.',
	'Software Development Business',
    ST_SetSRID(ST_MakePoint(-27.46501279634651, 153.02850115547713), 4326)
 );


INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'ISH Technologies - Custom Software & App Developers in Brisbane',
    'This buissness focuses on all aspects of software development and mobile development including database development and management utilising a dedicated agile team and web portal development.',
	'Software Development Business',
    ST_SetSRID(ST_MakePoint(-27.465821614348524, 153.02779995503275), 4326)
 );


INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'SAP Australia Pty Ltd - Brisbane',
    'This buissness focuses on IT consultation but offers their own software along with software development services.',
	'Software Development Business',
    ST_SetSRID(ST_MakePoint(-27.46553882442668, 153.02763742582962), 4326)
 );


INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'App Gurus',
    'This buissness focuses on all aspects of mobile application development offering multiple types and languages to ensure they make the correct application for their customers needs.',
	'Software Development Business',
    ST_SetSRID(ST_MakePoint(-27.456757274943595, 153.0367962186042), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Advanced Technology',
    'This business focuses on sales of devices and IT consultations  solutions. Cyber security provides 3CX phone systems that offer business NBN connections supports IT systems.',
	'General IT Consultation & Services',
    ST_SetSRID(ST_MakePoint(-30.315291615745032, 153.08693014020648), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Kempsey SOS Phone Repairs & Accessories',
    'This business focuses on mobile phone, tablet and PC repairs.',
	'Device Repair Business',
    ST_SetSRID(ST_MakePoint(-31.079698511657934, 152.842191724883), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Dynatek Services Pty Ltd – Armidale',
    'This business focuses on general PC maintenance repairs upgrades, provides services to home and small companies, data recovery and backup solutions, network setup and troubleshooting cloud backup solutions, domain management and email hosting, redundant power supply services, and maintenance IT consultations remote support POS systems and maintenance virus and spyware removal and cybersecurity. ',
	'General IT Consultation & Services',
    ST_SetSRID(ST_MakePoint(-30.50535891353899, 151.65064253532086), 4326)
 );

COMMIT;



/* Ensuring all of the data was inserted correctly. */
SELECT * FROM buis_location_point


-- SQL Queries Tasks.



/*
Write SQL statements to explain the difference between an inner join and an outer join. Explain the purpose of your query for your database solution.
*/

/* Inner joins are used to combine two tables based on specific conditions that only have matching fields and will display where the joins meet. If a row does not match, it will be excluded from the results.
Outer Joins join two tables together and have three types: 
left outer, right outer and full outer joins. 
Left outer joins include all rows from the left table and match them to rows on the right from the other table rows from the right table. 
Any fields that do not match will be null. The same applies to right outer joins. The right outer joins include all rows from the right table and match them to the left table. 
Any fields that do not have matching data will be null. The full outer join includes all rows from both tables Left and Right, 
creating a full outer join. Any rows without matching data will be null.*/

/* 
Inner Join: 
This inner join finds the jobs inside the coffs harbour boundary but only returns the rows when there is a  match found between buis_location_point and ruff_townLocations tables. 
This is defined by the ST_Within condition for the spatial database that stores the gemoetric locations this ensures that it only returns results that are within the Coffs Harbour boundry.
The purpose of this query is to Clearly show me how many IT buissness there are in coffs harbour and provides me with a of all of its data from both of the two tables that match,
the buissness name location town name buissness type and buisness location. 
*/
SELECT buis_loc.name AS business_name, buis_loc.description, town.town_name, buis_loc.business_type, buis_loc.location
FROM   buis_location_point buis_loc
INNER JOIN ruff_town_Locations town ON ST_Within(buis_loc.location, town.boundary)
WHERE town.town_name = 'Coffs Harbour';

/* 
Full Outer Join:
the purpose of this query is to show that as this is a spatial database, 
i cannot do a full outter join as you get an error message like this ERROR:  FULL JOIN is only supported with merge-joinable or hash-joinable join conditions SQL state: 0A000.
This is becuse im using a ST_Within function for geometric computations and it is to complex for the full outer join to work.
The purpose of this query was to prove i am getting an error creating a full outer join.
*/
SELECT buis_loc.name AS business_name, buis_loc.description, town.town_name, buis_loc.business_type, buis_loc.location
FROM buis_location_point buis_loc
FULL OUTER JOIN ruff_town_Locations town  ON ST_Within(buis_loc.location, town.boundary)
WHERE town.town_name = 'Coffs Harbour' OR buis_loc.name IS NOT NULL;

/* 
The purpose of this query is to simulated a full outer join by creating a left outer join and a right outer join and using the UNION function.
This creates a union between the two joins and merges them together. 
*/
-- Left Outer Join 
SELECT buis_loc.name AS business_name, buis_loc.description, town.town_name, buis_loc.business_type, buis_loc.location
FROM buis_location_point  buis_loc 
LEFT OUTER JOIN ruff_town_Locations town ON ST_Within(buis_loc.location, town.boundary)
WHERE  town.town_name = 'Coffs Harbour' OR town.town_name IS NULL

-- unified the two queries together creating a full outer join.
UNION

-- Right Outer Join 
SELECT buis_loc.name AS business_name, buis_loc.description, town.town_name,  buis_loc.business_type,buis_loc.location
FROM ruff_town_Locations town 
RIGHT OUTER JOIN buis_location_point buis_loc ON ST_Within(buis_loc.location, town.boundary)
WHERE  town.town_name = 'Coffs Harbour' OR buis_loc.name IS NOT NULL;


/*
Write an SQL statement that correctly uses the ‘GROUP BY’ and ‘HAVING’ operators to select an aggregation of data (e.g. SUM, AVG, COUNT). 
Explain the purpose of your query for your database solution.
*/

/*
This query uses the GROUP BY, HAVING, COUNT, AVG statements, and using the aggregated data from buisiness_type,
allows for the calculation of the number of business types by using count while also using the AVG  amount of buissness_types and displaying them in descending order. 
This query allows me to find how many types of IT businesses are in my general location and shows them in descending order to find what type of IT work is around in my area.
Clearly showing me there are not many dedicated web only hosting buissness but a lot of software development buissness and general IT consultation & services buissness.
*/
SELECT  business_type, COUNT(*) AS busis_count,  AVG(COUNT(*)) OVER () AS avg_busi_type  
FROM  buis_location_point GROUP BY  business_type
HAVING  COUNT(*) > 2  ORDER BY busis_count DESC;  


-- Write an SQL statement that uses an inner SQL query (SELECT). Explain the purpose of your query for your database solution.


/*
The purpose of a inner select query is to help simplify more complicated queries using the IN statement.
thie purpose of this query is to find software development buissness located in coffs harbour.
This is done by selecting the buissness type from the buis_location_point table to find only the software development,
buissness using and AND LOCATION IN statement to selection the location from ruff_town_Locations that only have the coffs harbour boundries.
*/
SELECT name,business_type, location
FROM buis_location_point
WHERE business_type = 'Software Development Business'
AND location IN (
    SELECT location  FROM  ruff_town_Locations
    WHERE town_name = 'Coffs Harbour'
    AND ST_Within(buis_location_point.location,ruff_town_Locations.boundary)
);



-- Spatial Database Tasks.
/*
You will need to be able to query your database as follows:
• Given a specific point (set of x,y coordinates), you are to find all polygons within which this Point is contained.
• Retrieve the nearest polygon if the Point does not lie within a specific polygon.
*/

/*
Trying to find this exact buissness the name of the buisness is SAP Australia Pty Ltd - Brisbane location and in what polygon area the buissness is stored in.
By selecting the id, town name and boundry from the contained poloygons in the spatial database. from the table ruff_town_locations.
Using the exact cordinates that are -27.46553882442668, 153.02763742582962
*/ 
WITH contained_polygons AS  (
    SELECT  id, town_name,town_type, boundary
    FROM  ruff_town_Locations
    WHERE ST_Contains(boundary,ST_SetSRID(ST_MakePoint(-27.46553882442668, 153.02763742582962), 4326))
)

--This statement is used to show the data if it is found within a polygon
SELECT *
FROM  contained_polygons





