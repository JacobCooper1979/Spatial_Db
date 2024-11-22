# PostgreSQL-PostGIS-Project

This project is based on my work with PostgreSQL 17 and the PostGIS 3.5.0 extension, which I used for spatial data processing and visualization. The goal was to create and manipulate geographic data, including intersections, unions, and visualizing the results on Google Earth.

## Technologies Used
- **PostgreSQL**: Version 17  
  PostgreSQL is used as the relational database management system for storing and managing the spatial data.
  
- **PostGIS**: Version 3.5.0  
  PostGIS is an extension for PostgreSQL that adds support for geographic objects, enabling spatial queries and operations like intersections, unions, and more.

## Project Structure


## Project Description
In this project, I used PostgreSQL 17 along with the PostGIS 3.5.0 extension to manage and process spatial data. The project involves creating geographic polygons for towns and cities, performing intersection and union operations on the polygons, and visualizing the results on Google Earth.

## Steps for Running the Project

### PostgreSQL Setup
1. **Install PostgreSQL**: Ensure PostgreSQL 17 is installed on your system. 
2. **Install PostGIS**: Install PostGIS 3.5.0, which adds spatial extensions to PostgreSQL.
3. **Create the Database**:  
   Run the `SQL_SCRIPT.sql` to create the necessary tables and insert data into the PostgreSQL database.
4. **Run Spatial Queries**:  
   Use the `SQL_SCRIPT.sql` file to execute SQL commands that perform spatial operations, including intersections and unions.

### KML Visualization
1. **Google Earth Setup**: Open Google Earth to visualize the data.
2. **Load KML Files**:  
   Load the `IoU.kml` and `Polygon_for_towns_and_cities.kml` files into Google Earth to view the spatial data, such as intersections and town/city polygons.


