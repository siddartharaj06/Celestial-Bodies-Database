CREATE DATABASE universe;

\c universe

CREATE TABLE galaxy_type (
    galaxy_type_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT NOT NULL,
    is_active BOOLEAN NOT NULL
);

CREATE TABLE galaxy (
    galaxy_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    galaxy_type_id INT NOT NULL REFERENCES galaxy_type(galaxy_type_id),
    age_in_millions_of_years INT NOT NULL,
    description TEXT NOT NULL,
    is_spherical BOOLEAN NOT NULL
);

CREATE TABLE star (
    star_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    galaxy_id INT NOT NULL REFERENCES galaxy(galaxy_id),
    mass NUMERIC(12, 4) NOT NULL,
    temperature_in_kelvin INT NOT NULL,
    is_spherical BOOLEAN NOT NULL,
    description TEXT NOT NULL
);

CREATE TABLE planet (
    planet_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    star_id INT NOT NULL REFERENCES star(star_id),
    radius NUMERIC(12, 2) NOT NULL,
    distance_from_earth INT NOT NULL,
    has_life BOOLEAN NOT NULL,
    is_spherical BOOLEAN NOT NULL,
    description TEXT NOT NULL
);

CREATE TABLE moon (
    moon_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    planet_id INT NOT NULL REFERENCES planet(planet_id),
    radius NUMERIC(12, 2) NOT NULL,
    distance_from_planet INT NOT NULL,
    has_atmosphere BOOLEAN NOT NULL,
    is_spherical BOOLEAN NOT NULL,
    description TEXT NOT NULL
);

INSERT INTO galaxy_type (name, description, is_active)
VALUES
    ('Spiral', 'A galaxy with curved arms extending from its center.', TRUE),
    ('Elliptical', 'A rounded galaxy containing mostly older stars.', TRUE),
    ('Irregular', 'A galaxy without a regular geometric shape.', TRUE);

INSERT INTO galaxy
    (name, galaxy_type_id, age_in_millions_of_years, description, is_spherical)
VALUES
    ('Milky Way', 1, 13600, 'The galaxy containing Earth and the Solar System.', FALSE),
    ('Andromeda', 1, 10000, 'The nearest major galaxy to the Milky Way.', FALSE),
    ('Triangulum', 1, 13000, 'A spiral galaxy in the Local Group.', FALSE),
    ('Large Magellanic Cloud', 3, 13000, 'An irregular satellite galaxy of the Milky Way.', FALSE),
    ('Small Magellanic Cloud', 3, 7000, 'A dwarf irregular galaxy near the Milky Way.', FALSE),
    ('Messier 87', 2, 13000, 'A large elliptical galaxy in the Virgo Cluster.', TRUE);

INSERT INTO star
    (name, galaxy_id, mass, temperature_in_kelvin, is_spherical, description)
VALUES
    ('Sun', 1, 1.0000, 5778, TRUE, 'The star at the center of the Solar System.'),
    ('Sirius', 1, 2.0200, 9940, TRUE, 'The brightest star in the night sky.'),
    ('Betelgeuse', 1, 16.5000, 3500, TRUE, 'A red supergiant star in Orion.'),
    ('Proxima Centauri', 1, 0.1221, 3042, TRUE, 'The closest known star to the Sun.'),
    ('Vega', 1, 2.1350, 9602, TRUE, 'A bright star in the constellation Lyra.'),
    ('Polaris', 1, 5.4000, 6015, TRUE, 'The current North Star.');

INSERT INTO planet
    (name, star_id, radius, distance_from_earth, has_life, is_spherical, description)
VALUES
    ('Mercury', 1, 2439.70, 77000000, FALSE, TRUE, 'The smallest planet in the Solar System.'),
    ('Venus', 1, 6051.80, 41000000, FALSE, TRUE, 'The second planet from the Sun.'),
    ('Earth', 1, 6371.00, 0, TRUE, TRUE, 'The only known planet with life.'),
    ('Mars', 1, 3389.50, 78000000, FALSE, TRUE, 'A rocky planet known as the Red Planet.'),
    ('Jupiter', 1, 69911.00, 628000000, FALSE, TRUE, 'The largest planet in the Solar System.'),
    ('Saturn', 1, 58232.00, 1270000000, FALSE, TRUE, 'A gas giant known for its rings.'),
    ('Uranus', 1, 25362.00, 2000000000, FALSE, TRUE, 'An ice giant with a tilted rotation axis.'),
    ('Neptune', 1, 24622.00, 2100000000, FALSE, TRUE, 'The farthest major planet from the Sun.'),
    ('Kepler-22b', 2, 14900.00, 600000000, FALSE, TRUE, 'An exoplanet in the habitable zone of its star.'),
    ('Kepler-62f', 2, 8500.00, 1200000000, FALSE, TRUE, 'A potentially habitable exoplanet.'),
    ('TRAPPIST-1e', 3, 5800.00, 390000000, FALSE, TRUE, 'A rocky exoplanet orbiting a cool dwarf star.'),
    ('Proxima b', 4, 7000.00, 400000000, FALSE, TRUE, 'An exoplanet orbiting Proxima Centauri.');

INSERT INTO moon
    (name, planet_id, radius, distance_from_planet, has_atmosphere, is_spherical, description)
VALUES
    ('Moon', 3, 1737.40, 384400, FALSE, TRUE, 'Earth''s natural satellite.'),
    ('Phobos', 4, 11.27, 9376, FALSE, FALSE, 'The larger moon of Mars.'),
    ('Deimos', 4, 6.20, 23463, FALSE, FALSE, 'The smaller moon of Mars.'),
    ('Io', 5, 1821.60, 421700, FALSE, TRUE, 'A volcanically active moon of Jupiter.'),
    ('Europa', 5, 1560.80, 671100, FALSE, TRUE, 'An icy moon with a subsurface ocean.'),
    ('Ganymede', 5, 2634.10, 1070400, FALSE, TRUE, 'The largest moon in the Solar System.'),
    ('Callisto', 5, 2410.30, 1882700, FALSE, TRUE, 'A heavily cratered moon of Jupiter.'),
    ('Titan', 6, 2574.70, 1221870, TRUE, TRUE, 'Saturn''s largest moon.'),
    ('Rhea', 6, 763.80, 527040, FALSE, TRUE, 'An icy moon of Saturn.'),
    ('Iapetus', 6, 734.50, 3561300, FALSE, TRUE, 'A moon of Saturn with contrasting hemispheres.'),
    ('Dione', 6, 561.40, 377400, FALSE, TRUE, 'An icy moon of Saturn.'),
    ('Tethys', 6, 531.10, 294670, FALSE, TRUE, 'A moon with a large impact crater.'),
    ('Enceladus', 6, 252.10, 237950, FALSE, TRUE, 'An icy moon with water vapor plumes.'),
    ('Mimas', 6, 198.20, 185520, FALSE, TRUE, 'A moon known for its large Herschel crater.'),
    ('Miranda', 7, 235.80, 129900, FALSE, TRUE, 'A small moon of Uranus.'),
    ('Ariel', 7, 578.90, 190900, FALSE, TRUE, 'One of the major moons of Uranus.'),
    ('Umbriel', 7, 584.70, 266000, FALSE, TRUE, 'A dark moon of Uranus.'),
    ('Titania', 7, 788.90, 436300, FALSE, TRUE, 'The largest moon of Uranus.'),
    ('Oberon', 7, 761.40, 583500, FALSE, TRUE, 'The outermost major moon of Uranus.'),
    ('Triton', 8, 1353.40, 354800, TRUE, TRUE, 'The largest moon of Neptune.');
