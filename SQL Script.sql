/*  A spatial database was created in PostgreSQL using the Postgis extension for my second uni assessment. 
The task is to create a spatial database with 10 ruff town polygon approximations and 100 Points. 
I've chosen to use my general area to try and find different types of IT businesses in my local area. 
This will help me identify what field of IT I should specialise in and what IT jobs are available in my general area.
Created by Jacob Cooper. JacobCooper_SpatialDb_ID:30466032.
*/
-----------------------------------------------------------------------------------------------------------------------------------------------------------
--Create Database, tables, drop statements and insert statements 
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

BEGIN TRANSACTION;
-- Adding the extension postgis to make this database a spatial database. 
CREATE EXTENSION postgis;
COMMIT;

-- after creating the new database these drop commands will ensure that these tables and types do not exist in the database.
BEGIN TRANSACTION;

DROP TYPE IF EXISTS BUSINESS_TYPE CASCADE;
DROP TYPE IF EXISTS TOWN_TYPE CASCADE;
DROP TABLE IF EXISTS buis_location_point CASCADE;
DROP TABLE IF EXISTS ruff_town_Locations CASCADE;

COMMIT;



BEGIN TRANSACTION;
/* Setting the town_type as Enums differentiates between my home town, local towns, and cities. SArea is for the surrounding areas. */
CREATE TYPE TOWN_TYPE AS ENUM (
	'Home Town',
	'Town',
	'City'
);

--Creating Tables for Polygon locations. 
CREATE TABLE ruff_town_Locations (
    id SERIAL PRIMARY KEY,
    town_name VARCHAR(100),
	town_type TOWN_TYPE,
    boundary GEOMETRY(Polygon, 4326) 
);


/* 
Type Enum Explanation.
Type Enum Explanation.
Most IT businesses deliver various services, but I selected the main focus for the IT business and categorised them into type enums. 
These businesses are versatile and can adapt to various needs, offering a wide range of services beyond the ones listed.

Website Development Business: Creates and maintains websites, including design, Development, and integration of features.

Hosting Business: This business type mainly focuses on providing cloud-orientated solutions for business, which can include server migration data backups, 
server space, and domain management, among other cloud services. It may also provide other IT services.

Software Development Business: This business Type focuses on the Development of custom software, including mobile and desktop applications. 
They can also provide advice on software solutions for businesses. However, they are not limited to only software solutions; they can offer other IT services.

Device Repair Business: This business type mainly focuses on the repairs and maintenance of electronic devices like smartphones and computers. 
It can offer other IT services but mainly provides the repair of devices.

General IT Consultation & Services: This business type mainly focuses on providing IT advice and solutions for businesses, which can include infrastructure management, 
cybersecurity management and other IT consulting services. It may also provide other IT services.

Digital Marketing & SEO: This business type mainly focuses on the promotion of businesses, mainly focused on online advertisements through SEO(Search Engine Optimisation), 
PPC(Pay Per Click), and social media marketing services, but it can also offer other types of IT services.

Telecommunications Business: This business type mainly focuses on offering a service to help connect businesses to NBN services.
And other communication services such as phone systems and internet connectivity.
 */

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
                ST_MakePoint(152.8889615145505, -30.60168896515074),
                ST_MakePoint(152.8846026674029, -30.62594600449782),
                ST_MakePoint(152.8897099979226, -30.62714952314303),
                ST_MakePoint(152.9036980539334, -30.62377432384356),
                ST_MakePoint(152.9170335555359, -30.63390792983415),
                ST_MakePoint(152.9119597453911, -30.66005496155552),
                ST_MakePoint(152.9527792510253, -30.65842758133529),
                ST_MakePoint(152.9755281502089, -30.62468874872213),
                ST_MakePoint(152.936834634779, -30.61791816037461),
                ST_MakePoint(152.8889615145505, -30.60168896515074)
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
                ST_MakePoint(152.9481868184284, -30.6752973445753),
                ST_MakePoint(152.9755641379236, -30.68208168235731),
                ST_MakePoint(152.9891519430172, -30.6619477727596),
                ST_MakePoint(153.0025968838241, -30.64991745020664),
                ST_MakePoint(153.0203410422929, -30.64945060581284),
                ST_MakePoint(153.0110629531627, -30.61706884573531),
                ST_MakePoint(152.9868710044668, -30.61394850461807),
                ST_MakePoint(152.9841864040857, -30.60793799498238),
                ST_MakePoint(152.9526697977662, -30.64870250115364),
                ST_MakePoint(152.9481868184284, -30.6752973445753)
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
                ST_MakePoint(153.0857285330422, -30.25774854991886),
                ST_MakePoint(153.0727667251945, -30.27370397706979),
                ST_MakePoint(153.061276878063, -30.29609761729046),
                ST_MakePoint(153.1059534402395, -30.29789419992937),
                ST_MakePoint(153.0865868814191, -30.31918259160555),
                ST_MakePoint(153.0831611584401, -30.32660062035747),
                ST_MakePoint(153.0831611584401, -30.35385615026143),
                ST_MakePoint(153.1413698215669, -30.31287456914184),
                ST_MakePoint(153.1396435298638, -30.26385090100258),
                ST_MakePoint(153.0857285330422, -30.25774854991886)
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
                ST_MakePoint(152.9264563808705, -27.26917375601498),
                ST_MakePoint(152.926547923819, -27.56002188561154),
                ST_MakePoint(152.6993862218506, -27.56585077719934),
                ST_MakePoint(152.7440902552386, -27.68512560705349),
                ST_MakePoint(153.1689286900472, -27.7470639777979),
                ST_MakePoint(153.3264211263274, -27.64394402811963),
                ST_MakePoint(153.1277892401511, -27.21238732217516),
                ST_MakePoint(153.0360328959027, -27.02237719850948),
                ST_MakePoint(152.8702791964748, -27.02264480650679),
                ST_MakePoint(152.9264563808705, -27.26917375601498)
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
                ST_MakePoint(150.7002996241683, -33.69825184125364),
                ST_MakePoint(150.6343822564199, -33.79143826279454),
                ST_MakePoint(150.780703415144, -33.82780958412496),
                ST_MakePoint(150.7516180124271, -34.00311667464096),
                ST_MakePoint(150.6796328146695, -34.07703847150586),
                ST_MakePoint(150.8013355124104, -34.1150056050299),
                ST_MakePoint(150.8830140472682, -34.01953686227969),
                ST_MakePoint(151.2550820175664, -34.00419054546921),
                ST_MakePoint(151.333594330304, -33.58040156991302),
                ST_MakePoint(150.7002996241683, -33.69825184125364)
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
                ST_MakePoint(151.5610189042137, -30.47728648864042),
                ST_MakePoint(151.5805214311637, -30.50201103431821),
                ST_MakePoint(151.5920234755963, -30.56410855697053),
                ST_MakePoint(151.7260220310348, -30.58674885880528),
                ST_MakePoint(151.7329843325045, -30.56650777938144),
                ST_MakePoint(151.7553356834135, -30.57287908297139),
                ST_MakePoint(151.7739776577108, -30.44642003005968),
                ST_MakePoint(151.5696175441736, -30.41759396528954),
                ST_MakePoint(151.6618019156936, -30.5018741224408),
                ST_MakePoint(151.5610189042137, -30.47728648864042)
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
                ST_MakePoint(153.0161104701058, -30.88128496197086),
                ST_MakePoint(153.0171923150962, -30.89059036548084),
                ST_MakePoint(153.0142208961338, -30.90028629691997),
                ST_MakePoint(153.0239810549658, -30.91272529146871),
                ST_MakePoint(153.0435023620057, -30.91692787744369),
                ST_MakePoint(153.0563242614173, -30.90883234367111),
                ST_MakePoint(153.0671566422564, -30.8914808135604),
                ST_MakePoint(153.0436724624838, -30.8816325991569),
                ST_MakePoint(153.0285524249655, -30.87222756271986),
                ST_MakePoint(153.0161104701058, -30.88128496197086)
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
                ST_MakePoint(152.8513213585385, -31.44615370478358),
                ST_MakePoint(152.8526505402297, -31.47259881946696),
                ST_MakePoint(152.8701760416933, -31.51562957891595),
                ST_MakePoint(152.8893792090233, -31.47377375754053),
                ST_MakePoint(152.9067756924079, -31.49534777365),
                ST_MakePoint(152.9377827445558, -31.47587292235615),
                ST_MakePoint(152.9229605118939, -31.4295828147071),
                ST_MakePoint(152.9046039581526, -31.4060138313455),
                ST_MakePoint(152.8692375053263, -31.4205063290417),
                ST_MakePoint(152.8513213585385, -31.44615370478358)
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
                ST_MakePoint(152.9204735416508, -29.68211405000834),
                ST_MakePoint(152.9039958904257, -29.67213650438728),
                ST_MakePoint(152.9321783218444, -29.69802359971372),
                ST_MakePoint(152.9489985365729, -29.69632620965669),
                ST_MakePoint(152.9566882192948, -29.67353568952852),
                ST_MakePoint(152.9421633507096, -29.66357117083475),
                ST_MakePoint(152.9377461033578, -29.662973094809),
                ST_MakePoint(152.9360251022934, -29.66810768376496),
                ST_MakePoint(152.9164050198144, -29.66481564741286),
                ST_MakePoint(152.9204735416508, -29.68211405000834)
            ])
        ), 4326
    )
);

------------------change to byron bay to make kml union over intersection easier.
/*INSERT INTO ruff_town_Locations (town_name, town_type, boundary)
VALUES (
    'Surrounding Areas',
    'SArea',
    ST_SetSRID(
        ST_MakePolygon(
            ST_MakeLine(ARRAY[
                ST_MakePoint(152.5138013840269, -32.39551617517989),
                ST_MakePoint(153.0895396188487, -31.10488689704723),
                ST_MakePoint(153.3065602260517, -29.77571911745998),
                ST_MakePoint(153.681073471285, -28.2836107361294),
                ST_MakePoint(153.483640228017, -27.00135284397611),
                ST_MakePoint(151.9392067174224, -26.73277906517035),
                ST_MakePoint(151.3239822036268, -30.36473866409712),
                ST_MakePoint(150.3409504638375, -33.97013761384776),
                ST_MakePoint(151.005430690718, -34.25581144197075),
                ST_MakePoint(152.5138013840269, -32.39551617517989)
            ])
        ), 4326
    )
);
*/
INSERT INTO ruff_town_Locations (town_name, town_type, boundary)
VALUES (
    'Byron Bay',
    'Town',
    ST_SetSRID(
        ST_MakePolygon(
            ST_MakeLine(ARRAY[
                ST_MakePoint(153.5647622180038, -28.6382074892897),
                ST_MakePoint(153.5879525097829, -28.64447525019588),
                ST_MakePoint(153.6010544371459, -28.65028773692908),
                ST_MakePoint(153.6045454333024, -28.66276174895024),
                ST_MakePoint(153.6220221564998, -28.66911187603853),
                ST_MakePoint(153.6379878459655, -28.63332567699932),
                ST_MakePoint(153.6267360673042, -28.64055139326609),
                ST_MakePoint(153.6127352989279, -28.64055488591457),
                ST_MakePoint(153.5885013034424, -28.62218429193834),
                ST_MakePoint(153.5647622180038, -28.6382074892897)
            ])
        ), 4326
    )
);

COMMIT;

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
    ST_SetSRID(ST_MakePoint(153.00430931820358, -30.63869655040028), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Webworx International Pty Ltd',
    'This business offers Digital marketing and various cloud-based shared and DNS hosting services, cyber security training, anti-spam services, cloud-based backups, and domain creation and transfer.',
    'Hosting Business',
    ST_SetSRID(ST_MakePoint(153.0044391690513, -30.641588835840352), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Nambucca Technology Business',
    'This business does not have a location, so I made one up, but it services the Nambucca Valley area. They specialise in website computer repairs, testing and tagging, and cloud and data security.',
    'General IT Consultation & Services',
    ST_SetSRID(ST_MakePoint(153.00027840274691, -30.641185904179782), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Bellingen Techno Wizards',
    'Local computer repair store.',
    'Device Repair Business',
    ST_SetSRID(ST_MakePoint(152.8964471267183, -30.453443506182648), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'jwfcomputing',
    'This Business focuses on local computer support and repair services.',
    'General IT Consultation & Services',
    ST_SetSRID(ST_MakePoint(153.0865983960275, -30.356741534396793), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'East GVS computers',
    'This Business focuses on local computer repair services.',
    'Device Repair Business',
    ST_SetSRID(ST_MakePoint(153.07440272671576, -30.35826330513633), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'The Computer Technician',
    'This business focuses on Local Device repairs, data recovery networks, and internet services and offers remote support repairs, apple devices, and virus removal.',
    'General IT Consultation & Services',
    ST_SetSRID(ST_MakePoint(153.10010774384173, -30.35125801633924), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Bonville computers',
    'This business offers computer repairs, networking issues, virus removal and protection, complete business solutions, data recovery and migrations, and the sales.',
    'General IT Consultation & Services',
    ST_SetSRID(ST_MakePoint(153.00122534020824, -30.379052771361646), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Tech Addicts',
    'This business specialises in IT repairs and sales for gamers and Small to medium businesses.',
    'General IT Consultation & Services',
    ST_SetSRID(ST_MakePoint(153.1010239536983, -30.311356756119423), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Craigs Computers',
    'This business focuses on custom-built services that are specifically designed to suit any type of customer, along with repairing computers, data backup solutions.',
    'General IT Consultation & Services',
    ST_SetSRID(ST_MakePoint(153.0980661843863, -30.300537921921723), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Haisi Creative',
    'This business focuses on setting up remote working environments, improving office environments and home devices. Document creation design outputs for community consultation, creating infographics, providing print press services.',
    'General IT Consultation & Services',
    ST_SetSRID(ST_MakePoint(153.1032582158019, -30.29627033045548), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Solitary Technology',
    'This service connects people from small and medium-sized businesses to the NBN and provides secure cloud backups and computer repair and support services.',
    'Telecommunications Business',
    ST_SetSRID(ST_MakePoint(153.11521017089441, -30.298012296831626), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Coffs Computers',
    'Apple Authorised Service Provider and Repairer, along with the sales of Apple devices.',
    'Device Repair Business',
    ST_SetSRID(ST_MakePoint(153.11662685555035, -30.298176226651353), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'A1Outreach',
    'A company that focuses on software development for businesses including but not limited to medical and health human resource business and products and services management consulting financial services manufacturing and distribution along with marketing for business, they also utilise their software B2b lead generation and appointment setting to provide a multichannel technique that optimises voice, email, social media, webinars, instant messaging to reach the targeted customer quicker.',
    'Software Development Business',
    ST_SetSRID(ST_MakePoint(153.04757735921493, -30.375418768068617), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Boambee Rocky Mountains Trust',
    'I couldn’t find much information about them, but they are a software development company based in Sawtel area.',
    'Software Development Business',
    ST_SetSRID(ST_MakePoint(153.09829707955734, -30.36786268057889), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Core Estimator',
    'A software development business that has created software to make it easy and fast for construction companies to come up with an estimated price for their construction plans.',
    'Software Development Business',
    ST_SetSRID(ST_MakePoint(153.09720463324675, -30.361316907438834), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Wichsport',
    'This business focuses on creating websites and its club management software to help companies analyse the results of their business record and manage registrations, points of sale, and awards systems.',
    'Software Development Business',
    ST_SetSRID(ST_MakePoint(153.0541892465059, -30.32597109255687), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'XBert',
    'This business has developed AI-powered work inelegance software to help safeguard and empower bookkeepers and accounting teams, improving their effectiveness and ensuring they meet government regulations.',
    'Software Development Business',
    ST_SetSRID(ST_MakePoint(153.13743091839655, -30.302309669583938), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Bespoke Business',
    'This business has created two software programs: BBSCloud for accounting and business management solutions and HROTCloud, software designed for housing contractors property maintenance and service job management. They also provide IT support monitoring and maintenance, cyber security and compliance backup, disaster recovery hosting, and strategic planning services.',
    'Software Development Business',
    ST_SetSRID(ST_MakePoint(153.11571575426754, -30.298789662246183), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'capital office business solutions',
    'This business focuses on helping you plan what you need for your business to become successful, providing IT consultation services, analysing your business and plans to help grow your business, and offering advice on different types of software that can be used.',
    'General IT Consultation & Services',
    ST_SetSRID(ST_MakePoint(153.11503835369805, -30.297849125848003), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Chameleon Software Pty Ltd',
    'This business has created Chameleon software as an all-in-one client database case management tool and billing system.',
    'Software Development Business',
    ST_SetSRID(ST_MakePoint(153.10927845264825, -30.297937430942458), 4326)
);

-
INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'CoffsWebolution',
    'I couldn’t find much information, but they focus on website solutions for business.',
    'Website Development Business',
    ST_SetSRID(ST_MakePoint(153.11498619339332, -30.29008173253421), 4326)
);

--------------------------------------------------------------------------------
-- accidently created a double find one more buissness
INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'BrainStack Pty Ltd',
    'This business focuses on graphics design, computer repairs, IT consulting services, Website Development and Mobile App Development.',
	'General IT Consultation & Services',
    ST_SetSRID(ST_MakePoint(-30.29052641153611, 153.1151578548217), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'BrainStack Pty Ltd',
    'This business focuses on graphics design, computer repairs, IT consulting services, Website Development and Mobile App Development.',
    'General IT Consultation & Services',
    ST_SetSRID(ST_MakePoint(153.1151578548217, -30.29052641153611), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Hutchinson Software Pty lte',
    'This business focuses on mobile apps, desktop apps and web and UX development for small and medium-sized enterprises.',
    'Software Development Business',
    ST_SetSRID(ST_MakePoint(152.90136205013076, -30.444838609008308), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Engageable Australia Pty Ltd',
    'This business has created software that is called engageable, which is focused on healthcare support with auditing tools, reports, questionnaires, forms surveys and also for higher education, providing tools for certificates and regards tags actions and rules built-in webpages user onboarding/creation of account roles and permissions consent forms and locations and team management tasks monitoring.',
    'Software Development Business',
    ST_SetSRID(ST_MakePoint(152.89602112097688, -30.44511861238583), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Lighthouse Beach IT – Port Macquarie',
    'This business provides business and home support along with remote IT support with Windows upgrades, maintenance check-ups, cybersecurity, and setting up new devices. The same is true for Apple computers and data recovery services.',
    'General IT Consultation & Services',
    ST_SetSRID(ST_MakePoint(152.92724844187785, -31.47433522076906), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Integer IT PTY',
    'This business focuses on IT support and management cybersecurity management cloud migrations data backup and disaster recovery phone hosted solutions on NBN data circuits multi-site office integrations, relocation IT projects reviews, strategic planning reporting, lifecycle management, and onsite installation services.',
    'General IT Consultation & Services',
    ST_SetSRID(ST_MakePoint(152.90673490738448, -31.46986974516655), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'The Website Factory Co',
    'This business focuses on website design, marketing webpages, managing cyber security, and making responsive designs.',
    'Website Development Business',
    ST_SetSRID(ST_MakePoint(152.90888067459085, -31.464086271645133), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Port Macquarie Web Designs',
    'This business focuses on the design creation and hosting of responsive websites along with logo design and provides social media advice and online marketing for small businesses.',
    'Website Development Business',
    ST_SetSRID(ST_MakePoint(152.8986668226883, -31.458082794674894), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Island I.T. Private I.T. Support',
    'This business provides small to medium-sized businesses with onsite support for their IT systems. Website designs offer Zuludesk and jamf school mobile device management and support from their partners jamF to allow schools to centrally manage all of their IOS devices from a single central dashboard and provide training.',
    'General IT Consultation & Services',
    ST_SetSRID(ST_MakePoint(152.89231535175728, -31.45881494661945), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Advantage IT',
    'This business provides a helpdesk that helps businesses manage their services, web services, cloud services, backup and recovery solutions, and IT constancy and auditing services.',
    'General IT Consultation & Services',
    ST_SetSRID(ST_MakePoint(152.88682218770884, -31.45141994894867), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Port Macquarie Computing Solutions',
    'This business focuses on computer repairs and maintenance of IT computer systems along with sales of IT devices, network maintenance, virus removal, data restoration, and migration. It provides remote access solutions, auditing services, website and email hosting, internet diagnostic services, wireless network solutions, and network camera systems for security phone system installations and repairs.',
    'Device Repair Business',
    ST_SetSRID(ST_MakePoint(152.87386175378205, -31.44409759389679), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Engage ICT',
    'I couldn’t find much information about this business other than a phone number.',
    'General IT Consultation & Services',
    ST_SetSRID(ST_MakePoint(152.88622137289104, -31.42901173897745), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'SteveIT',
    'This business provides small to medium-sized businesses with IT support for Office 365, Google Workspace, and practice IT management and cyber security solutions. General IT Consultation & Services',
    'General IT Consultation & Services',
    ST_SetSRID(ST_MakePoint(152.89034124592737, -31.429670880446793), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Cloud Concepts',
    'This business focuses on creating and hosting websites in the cloud for small and large companies. It offers custom software solutions for small businesses to fit their needs, including booking and payment systems.',
    'Website Development Business',
    ST_SetSRID(ST_MakePoint(152.9072713491836, -31.43102576770772), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Web studio',
    'This business focuses on website design and digital marketing and provides IT consultation to develop a business plan and maintain the website.',
    'Digital Marketing & SEO',
    ST_SetSRID(ST_MakePoint(152.90716406054497, -31.42993236856941), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'PD Digital',
    'This business focuses on building and designing web pages and hosting them. It also provides a customised and managed CRM system and marketing services.',
    'Digital Marketing & SEO',
    ST_SetSRID(ST_MakePoint(152.90890213198216, -31.430911914738306), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Bookinglayer',
    'This business has created an all-in-one booking software for sports camps, making it an easy solution for managing bookings, communication, and scheduling the bookings.',
    'Software Development Business',
    ST_SetSRID(ST_MakePoint(153.6114046464161, -28.68712289867433), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Benn Web Design Port Macquarie',
    'This business focuses on website maintenance, hosting, and search optimisation, as well as the design and marketing of the website.',
    'Website Development Business',
    ST_SetSRID(ST_MakePoint(152.9091059798668, -31.43069220433842), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Joyer',
    'This business creates websites and mobile applications, hosts them, and provides marketing and graphics design services.',
    'Website Development Business',
    ST_SetSRID(ST_MakePoint(152.90906306452266, -31.43072882277416), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Cruisin Along',
    'I couldn’t find much information other than a phone number.',
    'Website Development Business',
    ST_SetSRID(ST_MakePoint(152.9127323264555, -31.43214777616035), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Pancake Web Studio',
    'This business focuses on creating and designing websites and marketing, along with helping small businesses with their branding.',
    'Website Development Business',
    ST_SetSRID(ST_MakePoint(152.9216694468752, -31.4362488884127), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'deprogram',
    'This is a software development business focused on the creation of specialised software that is cross-platform, which includes website mobile and desktop applications, and provides hosting services for their applications.',
    'Software Development Business',
    ST_SetSRID(ST_MakePoint(153.49964692596484, -28.551364531707073), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'minibossmarketing',
    'I couldn’t find much information other than a phone number but says they are a website designer.',
    'Website Development Business',
    ST_SetSRID(ST_MakePoint(152.9147117550751, -31.454895728013195), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'High-End Design',
    'This business has created a platform for anyone to design, build, and host a website, along with free software upgrades. It ensures its compatible with mobiles and tablets and allows you to edit your website anywhere. It provides search optimisation and advertisements. No technical skills are required.',
    'Software Development Business',
    ST_SetSRID(ST_MakePoint(152.9197745690736, -31.469372303721396), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'No Stress Websites - Small Business Web Design',
    'I couldn’t find anything but a phone number, but it states they are a website designing business.',
    'Website Development Business',
    ST_SetSRID(ST_MakePoint(152.92939908881252, -31.45409324442619), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Spin 360-3D',
    'This business focuses on website design creation and upgrades, logo designs and hosting, 3D animations, 3D brochures and provides marketing solutions, IT consultation advice, and search engine optimisation.',
    'Website Development Business',
    ST_SetSRID(ST_MakePoint(152.90976119267964, -31.46826374173515), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Design4u Creations',
    'They say they are a website designer, but their website doesn’t even open, and all I can find is their phone number.',
    'Website Development Business',
    ST_SetSRID(ST_MakePoint(152.88509533033525, -31.447597072581065), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'KC Web Design Port Macquarie',
    'This business focuses on creating professional websites, providing targeted advertising campaigns, and hosting and managing the website.',
    'Website Development Business',
    ST_SetSRID(ST_MakePoint(152.88831998041238, -31.42977471119284), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Orchiddigital Media',
    'This business focuses on creating, designing, and maintaining websites and mobile applications for small businesses, as well as marketing.',
    'Software Development Business',
    ST_SetSRID(ST_MakePoint(152.8413450634787, -31.07783589952646), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Kempsey FYTEC Computers',
    'This business is a computer and mobile phone repair store.',
    'Device Repair Business',
    ST_SetSRID(ST_MakePoint(152.8411372533198, -31.080243205543812), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'aura systems',
    'This business focuses on IT consultation services and computer repairs.',
    'General IT Consultation & Services',
    ST_SetSRID(ST_MakePoint(153.02439769581076, -30.886238193582294), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Armidale Computers',
    'This business focuses on computer repairs, data recovery, onsite visits, provides an internet café.',
    'Device Repair Business',
    ST_SetSRID(ST_MakePoint(151.67150102884423, -30.505918571656856), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Ozziewebs Digital Business Services',
    'This business focuses on website and digital service business but doesn’t even have a website, only a phone number.',
    'Digital Marketing & SEO',
    ST_SetSRID(ST_MakePoint(151.67104263996413, -30.51331487857547), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Omelia Technologies',
    'I couldn’t find much information other than a phone number, and it says they are a software company.',
    'Software Development Business',
    ST_SetSRID(ST_MakePoint(151.65316331155836, -30.522342110227093), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'ICT International',
    'Provides high-tech equipment for agricultural use.',
    'General IT Consultation & Services',
    ST_SetSRID(ST_MakePoint(151.65127500795288, -30.516274979929786), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Armidale Practical Systems',
    'A software development business that has created bookkeeping software to make it faster and more productive for bookkeepers to do their jobs.',
    'Software Development Business',
    ST_SetSRID(ST_MakePoint(151.66071652598026, -30.513153337810923), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'New England Business Technology',
    'This business focuses on IT and communication solutions, including selling new devices, networking equipment management backup solutions, business phones and IT support.',
    'General IT Consultation & Services',
    ST_SetSRID(ST_MakePoint(151.66368762452774, -30.511727367149852), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'FarmLab',
    'This business has created a FarmLab application that allows the collection and analysis of farming data to be easier, faster, and more cost-effective. It also provides farming advice by assessing the land.',
    'Software Development Business',
    ST_SetSRID(ST_MakePoint(151.66104862738192, -30.513833307633707), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'FX Media',
    'I couldn’t find much information about this business besides a phone number and an address.',
    'Website Development Business',
    ST_SetSRID(ST_MakePoint(151.67006026202526, -30.51535772266314), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Morelly',
    'This business provides IT consultation and advice for creating and growing your business.',
    'Digital Marketing & SEO',
    ST_SetSRID(ST_MakePoint(151.66785148062553, -30.513666285836564), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'The Website Builders',
    'This business focuses on website development for small and medium-sized enterprises, hosting websites, providing backup services and cybersecurity measures, and domain names.',
	'Website Development Business',
    ST_SetSRID(ST_MakePoint(151.66651919978128, -30.512548713215978), 4326)
 );

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Armidale Online',
    'This business is focused on IT consultations to find the best solution and applications to fit the needs of a small or medium-sized business.',
    'General IT Consultation & Services',
    ST_SetSRID(ST_MakePoint(151.6531345372182, -30.5090136374537), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Failte Studio',
    'This business is focused on the websites design, helping with branding, and ensuring the website is optimised for mobile devices domain connection. It offers 30-day launch support but also uses Squarespace to create web pages.',
    'Website Development Business',
    ST_SetSRID(ST_MakePoint(151.64837463076213, -30.506835013094), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Mobile Management',
    'This business is focused on IT consultations to find the right software for your small to medium-sized business.',
    'General IT Consultation & Services',
    ST_SetSRID(ST_MakePoint(152.64800869789897, -30.378573180257046), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Web Design Domain web services',
    'This business is focused on creating, designing, and hosting website search engine optimisations and web marketing.',
    'Website Development Business',
    ST_SetSRID(ST_MakePoint(152.7110379994716, -30.344622446255574), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Bellingen IT',
    'This business is focused on computer sales service and repairs, remote and onsite support IT solutions for small and medium-sized enterprises and connection to NBN services.',
    'General IT Consultation & Services',
    ST_SetSRID(ST_MakePoint(152.89872959772467, -30.449950139529783), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'zaaton',
    'This business focuses on PC laptops, printer repairs, and website design for small businesses.',
    'General IT Consultation & Services',
    ST_SetSRID(ST_MakePoint(152.93450579629186, -29.690335562333644), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Grafton PortaSafeStocks',
    'All I could find was that they are a software company, and they don’t have a website.',
    'Website Development Business',
    ST_SetSRID(ST_MakePoint(152.96239962572906, -29.698983559639917), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Simons Signal & I.T. Services',
    'This business focuses on computer and mobile devices and other electrical device repairs.',
    'Device Repair Business',
    ST_SetSRID(ST_MakePoint(152.94093927576895, -29.67945148292502), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Computer Troubleshooters Grafton',
    'This business is focused on device repairs and providing cloud services, site IT support, remote support services, hosting emails, computer repairs, data backup and recovery services, and software and hardware sales. These services are provided for home small businesses and medium-sized businesses.',
    'Device Repair Business',
    ST_SetSRID(ST_MakePoint(152.93615840582393, -29.687877421056484), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'I Tech You Computers',
    'I couldn’t find much information as they don’t have a website, but they are an IT consulting business that helps businesses with IT solutions.',
    'General IT Consultation & Services',
    ST_SetSRID(ST_MakePoint(152.93257318073518, -29.687334301634117), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Grafton Phone Care - iPhone & iPad Repairs - Grafton NSW',
    'This business focuses on phone repairs for Apple devices.',
    'Device Repair Business',
    ST_SetSRID(ST_MakePoint(152.9360676552842, -29.691318141096588), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Byron Bay',
    'This business focuses on Microsoft products planning deployment and maintenance of hardware and software networking solutions, cyber security solutions, power protection, mobile technology cameras, and internet solutions point of sale terminals.',
    'General IT Consultation & Services',
    ST_SetSRID(ST_MakePoint(153.5769048291918, -28.68743629425876), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'ITRiver',
    'This business focuses on IT consulting, supporting the business with IT device level agreements, Microsoft sales and maintenance of PCs, data backup services, Sophos UTM sales and installation, data network management, along with website domain and registrations.',
    'General IT Consultation & Services',
    ST_SetSRID(ST_MakePoint(152.93555393072128, -29.689485226257368), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Byron Bay Web Hosting',
    'This business focuses on IT support and consultations, including legal agreements, HP server sales and maintenance, HP computer sales and maintenance, data backup services, data network management, website hosting and website domain registration, virus removal and testing, and tagging electronic equipment.',
    'Website Development Business',
    ST_SetSRID(ST_MakePoint(153.57934596477324, -28.63227377151867), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Panorama Marketing',
    'This business focuses on marketing solutions for websites or products, brand development and photography.',
    'Website Development Business',
    ST_SetSRID(ST_MakePoint(153.57791998293496, -28.634711735800693), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Migaloo Digital',
    'This business focuses on web design development, UI design automation, web performance, and cloud hosting.',
    'Website Development Business',
    ST_SetSRID(ST_MakePoint(153.58079688914526, -28.632002810078042), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Agency Eight | Web Design Agency Byron Bay',
    'This business focuses on the design and creation of websites and activation, along with ensuring high web performance and cloud hosting.',
    'Website Development Business',
    ST_SetSRID(ST_MakePoint(153.60835081281851, -28.640312575360927), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'East Point Digital',
    'The website couldn’t be found, so either close their business or the website is down, but the company focuses on website design creation and hosting.',
    'Website Development Business',
    ST_SetSRID(ST_MakePoint(153.6219839611944, -28.656217465738816), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Byron Design',
    'This business focuses on website design creation and maintenance and provides services to create brochures, flyers, direct mail, illustrations, online banner ads and animations.',
    'Website Development Business',
    ST_SetSRID(ST_MakePoint(153.61900385930588, -28.658709451358195), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Accelerate Tech Pty Ltd',
    'This development business focuses on creating software for business at any time of business need, utilising Azure cloud hosting services and Azure DevOps.',
    'Software Development Business',
    ST_SetSRID(ST_MakePoint(153.580973591795, -28.63106114460927), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'etc. technology',
    'This business is focused on IT consultations, and they do not give much information about themselves on their website, but they provide computer support.',
    'General IT Consultation & Services',
    ST_SetSRID(ST_MakePoint(153.57930429625378, -28.63463688606967), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'DevPro',
    'This business is focused on providing custom software and application solutions for businesses, which include desktop, web, and mobile applications. It also provides systems integration along with a SharePoint resource.',
    'Software Development Business',
    ST_SetSRID(ST_MakePoint(153.58037603613798, -28.63527518847816), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Byron Bay Hello Again',
    'This business focuses on creating web desktop and mobile applications for small and medium-sized companies and on UI design e-commerce integration architecture software.',
    'Software Development Business',
    ST_SetSRID(ST_MakePoint(153.58656405808833, -28.636977309251915), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Noorix - Custom Software Development & Mobile App Developers Sydney',
    'This business focuses on software development including web, mobile app development.',
    'Software Development Business',
    ST_SetSRID(ST_MakePoint(151.20392611280846, -33.859632974281645), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Solentive',
    'This business focuses on utilising AI along with app and software development.',
    'Software Development Business',
    ST_SetSRID(ST_MakePoint(151.21393460957535, -33.87722597082955), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Mobile App Developers Sydney, App Development & Design Sydney, Web App Development Sydney',
    'This business focuses on mobile and web application development.',
    'Software Development Business',
    ST_SetSRID(ST_MakePoint(151.20996304390445, -33.83858444584772), 4326)
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
    'This business focuses on IT consultations while providing their custom software solutions along with custom-made software.',
    'General IT Consultation & Services',
    ST_SetSRID(ST_MakePoint(151.20168837477257, -33.86764133428424), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Thoughtworks Brisbane',
    'This business focuses on AI data analytics, cloud hosting, software-defined vehicles, customer experience and products, modernization, and software engineering.',
    'Software Development Business',
    ST_SetSRID(ST_MakePoint(153.04070204320888, -27.456177628650316), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Tech Sprints',
    'This business focuses on utilizing agile software development methodologies while also providing DevOps options and creating software applications.',
    'Software Development Business',
    ST_SetSRID(ST_MakePoint(153.02850115547713, -27.46501279634651), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'ISH Technologies - Custom Software & App Developers in Brisbane',
    'This business focuses on all aspects of software and mobile development, including database development and management, utilizing a dedicated agile team and web portal development.',
    'Software Development Business',
    ST_SetSRID(ST_MakePoint(153.02779995503275, -27.465821614348524), 4326)
);


INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'SAP Australia Pty Ltd - Brisbane',
    'This business focuses on IT consultation but offers its own software along with software development services.',
    'Software Development Business',
    ST_SetSRID(ST_MakePoint(153.02763742582962, -27.46553882442668), 4326)
);


INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'App Gurus',
    'This business focuses on all aspects of mobile application development, offering multiple types and languages to ensure they make the correct application for their customers',
    'Software Development Business',
    ST_SetSRID(ST_MakePoint(153.0367962186042, -27.456757274943595), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Advanced Technology',
    'This business focuses on sales of devices and IT consultation solutions. It also provides cybersecurity, 3CX phone systems, business NBN connections, and IT support services.',
    'General IT Consultation & Services',
    ST_SetSRID(ST_MakePoint(153.08693014020648, -30.315291615745032), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Kempsey SOS Phone Repairs & Accessories',
    'This business focuses on mobile phone, tablet, and PC repairs.',
    'Device Repair Business',
    ST_SetSRID(ST_MakePoint(152.842191724883, -31.079698511657934), 4326)
);

INSERT INTO buis_location_point (name, description, business_type, location)
VALUES (
    'Dynatek Services Pty Ltd – Armidale',
    'This business focuses on general PC maintenance repairs upgrades, provides services to home and small companies, data recovery and backup solutions, network setup and troubleshooting cloud backup solutions, domain management and email hosting, redundant power supply services, and maintenance IT consultations remote support POS systems and maintenance virus and spyware removal and cybersecurity.',
    'General IT Consultation & Services',
    ST_SetSRID(ST_MakePoint(151.65064253532086, -30.50535891353899), 4326)
);


COMMIT;

/* Displaying all Data to ensure it was added correctly was entered correctly. */
SELECT * FROM ruff_town_Locations;
/* Ensuring all of the data was inserted correctly. */
SELECT * FROM buis_location_point;


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--SQL Queries Tasks.

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


SELECT buis_loc.name AS business_name, buis_loc.description, town.town_name, buis_loc.business_type, buis_loc.location
FROM   buis_location_point buis_loc
INNER JOIN ruff_town_Locations town ON ST_Within(buis_loc.location, town.boundary)
WHERE town.town_name IN ('Nambucca Heads', 'Coffs Harbour');


WITH necee_creek_location AS (
    SELECT ST_SetSRID(ST_MakePoint(153.02763742582962, -27.46553882442668), 4326) AS necee_creek_point
)
SELECT 
    buis_loc.name AS business_name,
    buis_loc.description,
    town.town_name,
    buis_loc.business_type,
    buis_loc.location
FROM 
    buis_location_point buis_loc
INNER JOIN 
    ruff_town_Locations town 
    ON ST_Within(buis_loc.location, town.boundary)
CROSS JOIN 
    necee_creek_location
WHERE 
    town.town_name IN ('Nambucca Heads', 'Coffs Harbour')
    AND ST_Distance(buis_loc.location, necee_creek_location.necee_creek_point) <= 50000;


/* 
Full Outer Join:
the purpose of this query is to show that as this is a spatial database, 
i cannot do a full outter join as you get an error message like this ERROR:  FULL JOIN is only supported with merge-joinable or hash-joinable join conditions SQL state: 0A000.
This is becuse im using a ST_Within function for geometric computations and it is to complex for the full outer join to work.
The purpose of this query was to prove i am getting an error creating a full outer join.
*/
SELECT buis_loc.name AS  business_name, buis_loc.description, town.town_name,  buis_loc.business_type, buis_loc.location
FROM  buis_location_point buis_loc
FULL OUTER JOIN ruff_town_Locations town  ON ST_Within(buis_loc.location, town.boundary)
WHERE town.town_name = 'Coffs Harbour' OR buis_loc.name IS NOT NULL;

/* 
The purpose of this query is to simulated a full outer join by creating a left outer join and a right outer join and using the UNION function.
This creates a union between the two joins and merges them together. 
*/
-- Left Outer Join 
SELECT buis_loc.name AS business_name, buis_loc.description, town.town_name, buis_loc.business_type,  buis_loc.location
FROM  buis_location_point  buis_loc 
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
FROM  buis_location_point
WHERE business_type = 'Software Development Business'
AND location IN (
    SELECT location  FROM  ruff_town_Locations
    WHERE town_name = 'Coffs Harbour'
    AND  ST_Within(buis_location_point.location,ruff_town_Locations.boundary)
);



--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Spatial Database Tasks.
/*
You will need to be able to query your database as follows:
• Given a specific point (set of x,y coordinates), you are to find all polygons within which this Point is contained.
• Retrieve the nearest polygon if the Point does not lie within a specific polygon.
*/

/*
Trying to find this exact buissness the name of the buisness is SAP Australia Pty Ltd - Brisbane location and in what polygon area the buissness is stored in.
By selecting the id, town name and boundry from the contained poloygons in the spatial database. from the table ruff_town_locations.
Using the exact cordinates that are  153.02763742582962, -27.46553882442668,
*/ 
WITH contained_polygons AS (
    SELECT id, town_name, town_type, boundary
    FROM ruff_town_Locations
    WHERE ST_Contains(boundary,ST_SetSRID(ST_MakePoint(153.02763742582962, -27.46553882442668), 4326)
    )
)
SELECT * FROM contained_polygons;


--The purpose of this query is to identify buissness within 50KM from my homes polygon which is newee creek.
WITH home_location AS (
    SELECT boundary
    FROM ruff_town_Locations
    WHERE town_name = 'Newee Creek'
)
SELECT buis_loc.name AS business_name,  buis_loc.description,buis_loc.business_type,buis_loc.location, town.town_name
FROM  buis_location_point buis_loc
INNER JOIN  ruff_town_Locations town  ON ST_Within(buis_loc.location, town.boundary)
CROSS JOIN  home_location
WHERE  ST_DWithin(buis_loc.location, home_location.boundary, 50000);  


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Write a PL/SQL block(s) demonstrating the programming constructs of sequence, selection, and iteration.
Write a Stored Procedure and call it from your PL/SQL block.
Write an ‘After Insert’ Trigger to determine whether the addition of a new spatial point is within a pre-determined bounding box. */




/* -- Explination of my PL/SQL code 
My PL/SQL code begins by creating a sequence called location_id_seq, which is then checked to see if it exists before being created. If the sequence does not exist, it will be created, 
The next part ensures that the sequence starts from the max id from the buis_location_point table plus 1, ensuring that new entries have the correct ID.

The find_bounding_box function is designed to identify if a business that is being inserted into the buis_location_point table already exists within a bounding box, 
which is the pre-defined polygon locations within the ruff_town_Locations table. If it does not exist within a predefined bounding box, 
the function will loop through all town polygons stored in the ruff_town_Locations table and check if the business point is within any bounding box inside. 
If the business is inside a polygon, the function will return the name of that polygon as the area. If not, it calculates the distance to the nearest polygon and returns the results by displaying a notice saying the name of the nearest area. 
If no nearby area is found, it will display a message saying it is nowhere near any bounding boxes.

The insert_business procedure validates the inputs for a new business entry before the data is inserted into the buis_location_point table while also performing validation checks to ensure that the business name, 
description, type and geographic coordinates (latitude and longitude) are correctly formatted and are not null. 
This procedure creates a point using the business's latitude and longitude and checks if it is a valid geographic point before entering the data. 
It then calls the find_bounding_box function to determine the business's location, determine if it is within any town polygons, and determine if it is near or nowhere near any predefined polygon location.
 Before inserting the business into the buis_location_point table, it also performs checks for duplicate entries of businesses that are stored within the buis_location_points tab and has the same name and location to prevent redundancy.
 If everything is valid, the business is inserted, and the new business ID is displayed as a notice.

The trigger function, trg_check_within_bounding_box, is used to perform checks to ensure whether a business falls within a bounding box after being inserted. 
This trigger ensures that after a business is added, the system verifies its geographic location and raises appropriate notices depending on whether the business is inside, close to or outside a known area.  
The trigger function, trg_check_for_duplicates, is utilised to prevent duplicate entries. 
It checks if a business with the same name and a location within close proximity of all business locations stored within buis_point_Locations already exists before allowing a new insertion or update.

The trg_enforce_bounding_box trigger ensures that every time a business is inserted or updated, 
its bounding box location is checked. The trg_check_for_duplicates and its associated triggers are responsible for verifying that no duplicate businesses are inserted or updated. 
The main point of the PL/SQL code is to create these procedures, functions, and triggers or manage business locations, 
preventing duplicates and ensuring geographic accuracy while also performing validation checks to ensure data is entered correctly.
 */


-- Enums became to difficult to attempt as there was some issue with casting and i decided to drop it and set them to VARCHAR(100) instead.

--Altering table to remove type enum and replacing it with varhcar(100).
ALTER TABLE buis_location_point
    ALTER COLUMN business_type TYPE VARCHAR(100);
-- Dropping the Type Enum. 
DROP TYPE IF EXISTS BUSINESS_TYPE;

-- Dropping PL/SQL code for testing.
BEGIN TRANSACTION;
-- Drop triggers.
DROP TRIGGER IF EXISTS trg_enforce_bounding_box ON buis_location_point;
DROP TRIGGER IF EXISTS trg_check_for_duplicates ON buis_location_point;
DROP TRIGGER IF EXISTS trg_check_for_duplicates_update ON buis_location_point;

-- Drop trigger functions.
DROP FUNCTION IF EXISTS trg_check_within_bounding_box();
DROP FUNCTION IF EXISTS trg_check_for_duplicates();

-- Drop the sequence.
DROP SEQUENCE IF EXISTS location_id_seq;

-- Drop procedures and functions.
DROP PROCEDURE IF EXISTS insert_business;
DROP FUNCTION IF EXISTS find_bounding_box;
COMMIT;



-- Creating the sequence and ensuring the max ID gets set correctly.
BEGIN TRANSACTION;

DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_class WHERE relname = 'location_id_seq') 
    THEN
        
        EXECUTE 'CREATE SEQUENCE location_id_seq START WITH 1 INCREMENT BY 1';
    END IF;
END $$;

-- This ensures the correct ID is set correctly for the sequence.
DO $$
BEGIN
    PERFORM setval('location_id_seq',  COALESCE((SELECT MAX(id) FROM buis_location_point), 0) + 1,  false);
END $$;

COMMIT;

-- Creating the function to find if a point is in a bounding box determining if a buissness is in or near a bounding box.
BEGIN TRANSACTION;

CREATE OR REPLACE FUNCTION find_bounding_box(business_point GEOMETRY(Point, 4326)) 
RETURNS TEXT AS $$
DECLARE
    -- Decalring variables for this function and setting the distance to 50km.
    bounding_box GEOMETRY(Polygon, 4326);
    bounding_box_name TEXT;
    nearest_box_name TEXT;
    min_distance DOUBLE PRECISION := 50000;
BEGIN
    FOR bounding_box, bounding_box_name IN
        SELECT boundary, town_name FROM ruff_town_Locations
    --Creating a loop to loop through andsee if if a buissness is within a distance 100km to the closest bounding box.
    LOOP
        IF ST_Contains(bounding_box, business_point) 
        THEN  RETURN bounding_box_name;
        ELSE
            -- Find the nearest bounding box if the point is outside all known areas
            IF ST_Distance(bounding_box, business_point) < min_distance 
            THEN min_distance := ST_Distance(bounding_box, business_point);
                nearest_box_name := bounding_box_name;
            END IF;
        END IF;
    END LOOP;

    -- Return the nearest bounding box name if the point is outside of all known areas
    IF nearest_box_name IS NOT NULL 
    THEN  RETURN 'near the area of ' || nearest_box_name;
    ELSE
        RETURN 'No nearby areas found';
    END IF;
END;
$$ LANGUAGE plpgsql;

COMMIT;


-- Creating the procedure to insert business into the buis_location_point table with exeption handling that ensures entries are not null 
BEGIN TRANSACTION;
CREATE OR REPLACE PROCEDURE insert_business(
    business_name VARCHAR(100),
    business_description TEXT,
    business_type VARCHAR(100),
    business_latitude DOUBLE PRECISION,
    business_longitude DOUBLE PRECISION
) AS $$
DECLARE
    --Declaring variables.
    business_point GEOMETRY(Point, 4326);
    bounding_box_name TEXT;
    business_exists BOOLEAN;
    new_business_id INTEGER;
BEGIN
    -- Exception handling to ensure all entries are not null using TRIM to remove any white spaces to make it look nicer if the data was entered with any spaces and ensuring that name and type are no longer than 100 characters.
    IF business_name IS NULL OR LENGTH(TRIM(business_name)) = 0 
    THEN RAISE EXCEPTION 'You must enter a business name';
    ELSIF LENGTH(TRIM(business_name)) > 100 THEN
        RAISE EXCEPTION 'Business name cannot be longer than 100 characters';
    ELSIF business_description IS NULL OR LENGTH(TRIM(business_description)) = 0 
    THEN RAISE EXCEPTION 'You must enter a business description';
    ELSIF business_type IS NULL OR LENGTH(TRIM(business_type)) = 0 
    THEN  RAISE EXCEPTION 'You must enter a business type';
    ELSIF LENGTH(TRIM(business_type)) > 100 
    THEN  RAISE EXCEPTION 'Business type cannot be longer than 100 characters';
    ELSIF business_latitude IS NULL 
    THEN RAISE EXCEPTION 'You must enter a business latitude';
    ELSIF business_longitude IS NULL 
    THEN  RAISE EXCEPTION 'You must enter a business longitude';
    END IF;

    -- Validating the business latitude and longitude are correctly formatted.
    BEGIN
        PERFORM business_latitude::DOUBLE PRECISION;
        PERFORM business_longitude::DOUBLE PRECISION;
    EXCEPTION
        WHEN invalid_text_representation 
        THEN RAISE EXCEPTION 'Latitude and longitude must be correctly formatted as double precision';
    END;

    BEGIN
        -- Using the ST_SetSRID function that also uses the ST_MakePoint function to create the business point for its location.
        -- Latitude is first and then longitude.
        business_point := ST_SetSRID(ST_MakePoint(business_latitude, business_longitude), 4326);
        -- Using validation checks to ensure the point is valid before proceeding.
        IF business_point IS NULL 
        THEN  RAISE EXCEPTION 'The business point is invalid; it could be an issue with the latitude or longitude';
        END IF;

        -- Searching to see if there is a bounding box that the business_point falls into.
        bounding_box_name := find_bounding_box(business_point);

        IF bounding_box_name IS NOT NULL 
        THEN  RAISE NOTICE 'The business is located within: %', bounding_box_name;
        ELSE
            RAISE NOTICE 'Business is in an unknown area';
        END IF;

        -- Ensuring the business doesn’t already exist as an entry into the table.
        SELECT EXISTS (
            SELECT 1 FROM buis_location_point
            -- By making all characters not capitals and looking at business points that already exist helps to determine if the business already exists and is just renamed slightly differently due to human error.
            WHERE LOWER(name) = LOWER(business_name)
            AND ST_DWithin(location, business_point, 0.0001)
        ) INTO business_exists;
        -- Raising a notice to say the business already exists and the table that it exists in.
        IF business_exists 
        THEN  RAISE NOTICE 'Business already exists in buis_location_point';
            RETURN;
        END IF;
        -- Insert the new business and creating the new ID.
        INSERT INTO buis_location_point (name, description, business_type, location)
        VALUES ( business_name,business_description, business_type,  business_point)
        RETURNING id INTO new_business_id;
        RAISE NOTICE 'The business has been successfully inserted with the ID of: %', new_business_id;

    EXCEPTION
        WHEN unique_violation 
        THEN RAISE NOTICE 'Could not insert this business as it already exists.';
        WHEN data_exception 
        THEN RAISE NOTICE 'Data exception: %', SQLERRM;
        WHEN invalid_text_representation 
        THEN  RAISE NOTICE 'Invalid data type provided for one of the fields.';
        WHEN OTHERS 
        THEN  RAISE NOTICE 'There was an error during the business insertion process: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;
COMMIT;

BEGIN TRANSACTION;
-- Trigger function to check if the buissness belongs to a bounding box after inserting into the table.
CREATE OR  REPLACE 
FUNCTION trg_check_within_bounding_box() 
RETURNS  TRIGGER AS $$
DECLARE bounding_box_name  TEXT;
BEGIN
    BEGIN
        -- Checking if the buissness is located within a bounding box.
        bounding_box_name := find_bounding_box(NEW.location);

            -- Creating a notice if the buissness is located within a bounding box.
        IF bounding_box_name IS  NOT NULL 
        THEN  RAISE NOTICE 'The buissness is located within this Area: %', bounding_box_name;
        ELSE
            -- Creating a notice if the buissenss is outsoide of any bounding box.
            RAISE NOTICE 'The buissness is located ourside of all known areas.';
        END IF;

    EXCEPTION
        WHEN OTHERS THEN
            -- Rassing an exeption if an error occurs for testing.
            RAISE NOTICE 'Error during bounding box check: %', SQLERRM;
    END;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger to enforce bounding box check before inserting or updating a business.
CREATE TRIGGER  trg_enforce_bounding_box
BEFORE INSERT OR UPDATE ON buis_location_point
FOR  EACH ROW
EXECUTE FUNCTION trg_check_within_bounding_box();
COMMIT;

BEGIN TRANSACTION;
-- Trigger function to check for duplicates before inserting a new business.
CREATE OR  REPLACE FUNCTION  trg_check_for_duplicates() 
RETURNS TRIGGER  AS $$
DECLARE business_exists BOOLEAN;
BEGIN
    -- Checking to see if any business with the same name and location already exists.
    SELECT EXISTS (
        SELECT 1 FROM buis_location_point
        WHERE LOWER(name) = LOWER(NEW.name)
        -- Allowing for small precision differences to ensure a similar position isnt considered as a duplicate.
        AND ST_DWithin(location, NEW.location, 0.0001) 
         -- Ensure its not comparing with is own ID as i was having errors with that.
        AND id <> NEW.id  
    ) INTO business_exists;

    -- If a duplicate buissness is found a notice will be raised and the insert processs will be stopped.
    IF business_exists 
    THEN
        -- Notice to Skip the insert.
        RAISE NOTICE 'Duplicate found: Business "%", located at the same place, already exists.', NEW.name;
        RETURN NULL; 
    ELSE
        -- Notice that the insertion has been completed.
        RAISE NOTICE 'No duplicates found for Business "%". Proceeding with insert.', NEW.name;
        RETURN NEW; 
    END IF;
END;
$$ LANGUAGE plpgsql;

-- Trigger to check for duplicates before inserting a new business.
CREATE TRIGGER trg_check_for_duplicates
BEFORE  INSERT ON buis_location_point
FOR EACH  ROw  EXECUTE FUNCTION trg_check_for_duplicates();

-- Trigger to check for duplicates before updating a business
CREATE TRIGGER trg_check_for_duplicates_update
BEFORE  UPDATE  ON buis_location_point
FOR EACH  ROW  EXECUTE FUNCTION trg_check_for_duplicates();

COMMIT;

-- Testing to ensure this is working by using the function.
CALL insert_business(
    'Tes1',
    'This is A Test',
    'Web Development Buisness',
    -74.00601347,
    40.71287853  
      
);

-- Testing to ensure this is working by using the function.
CALL insert_business(
    'Dynatek Services Pty Ltd – Armidale',
    'This business focuses on general PC maintenance repairs upgrades, provides services to home and small companies, data recovery and backup solutions, network setup and troubleshooting cloud backup solutions, domain management and email hosting, redundant power supply services, and maintenance IT consultations remote support POS systems and maintenance virus and spyware removal and cybersecurity.',
    'General IT Consultation & Services',
    151.65064253532086,
    -30.50535891353899  
      
);




--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--KML Task 
--Creating KML data for polygon locations 
-- Select polygon locations as KML
SELECT id,  town_name,town_type, ST_AsKML(boundary) 
AS kml_boundary
FROM  ruff_town_Locations;

---- Saved as csv and manually editing KML files to represent this data as the function would not work to just export it.

-- This query calculates the Intersection over Union (IoU) for all pairs of polygons in the database.
WITH polygon_intersections AS (
    -- Selecting all polygons from ruff_town_locations table and comparing them to calculate their intersection over union.
    SELECT poly1.town_name AS town1,  poly2.town_name AS town2,  ST_Intersection(poly1.boundary, poly2.boundary) 
    AS intersection,  ST_Union(poly1.boundary, poly2.boundary) AS boundary_union 
    FROM  ruff_town_Locations AS poly1
    JOIN ruff_town_Locations  AS poly2  ON poly1.town_name != poly2.town_name
    WHERE ST_Intersects(poly1.boundary,  poly2.boundary)
)
-- Selecting the results from the intersection over union calculation and creating a KML representations.
SELECT town1, town2,  ST_Area(intersection) / ST_Area(boundary_union) 
AS iou, ST_AsKML(intersection)  AS intersection_kml, ST_AsKML(boundary_union) AS boundary_union_kml 
FROM polygon_intersections;

---- Saved results as csv file and manually created a KML files to represent this data as the function would not work to export it.






