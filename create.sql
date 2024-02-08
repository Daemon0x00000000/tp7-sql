CREATE SCHEMA IF NOT EXISTS mystream;

CREATE TABLE IF NOT EXISTS film (
    film_id serial PRIMARY KEY,
    film_titre VARCHAR(100) NOT NULL ,
    film_synopsis TEXT NOT NULL,
    film_date_sortie DATE NOT NULL,
    film_duree SMALLINT NOT NULL,
    film_etiquettes JSONB NOT NULL DEFAULT '[]'
);

CREATE TABLE IF NOT EXISTS realisateur (
    real_id SERIAL PRIMARY KEY,
    real_nom VARCHAR(100) NOT NULL,
    real_prenom VARCHAR(100) NOT NULL,
    real_date_naissance DATE NOT NULL
);


CREATE TABLE IF NOT EXISTS realise_film (
    real_id INT REFERENCES realisateur ON DELETE CASCADE ,
    film_id INT REFERENCES film ON DELETE CASCADE ,
    PRIMARY KEY(real_id,film_id)
);

CREATE UNIQUE INDEX ON realise_film(film_id);
CREATE UNIQUE INDEX ON realise_film(real_id);

CREATE TABLE IF NOT EXISTS acteur (
    acteur_id SERIAL PRIMARY KEY,
    acteur_nom VARCHAR(100) NOT NULL,
    acteur_prenom VARCHAR(100) NOT NULL,
    acteur_date_naissance DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS joue_dans (
    acteur_id INT REFERENCES acteur ON DELETE CASCADE,
    film_id INT REFERENCES film ON DELETE CASCADE,
    role VARCHAR(100) NOT NULL,
    PRIMARY KEY(acteur_id,film_id,role)
);

CREATE TABLE IF NOT EXISTS utilisateur (
    user_id SERIAL PRIMARY KEY,
    user_nom VARCHAR(100) NOT NULL,
    user_prenom VARCHAR(100) NOT NULL,
    user_date_naissance DATE NOT NULL
);

-- INDEX implicite sur l'email en la mettant unique, permettant également de faciliter la recherche de compte par email
-- SHA 512
CREATE TABLE IF NOT EXISTS login (
    user_id INT REFERENCES utilisateur ON DELETE CASCADE PRIMARY KEY ,
    email VARCHAR(255) NOT NULL UNIQUE,
    pass CHAR(128) NOT NULL,
    last_updated TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS utilisateur_aime (
    user_id INT REFERENCES utilisateur ON DELETE CASCADE ,
    film_id INT REFERENCES film ON DELETE CASCADE ,
    PRIMARY KEY(user_id,film_id)
);

CREATE UNIQUE INDEX ON utilisateur_aime(user_id);
CREATE UNIQUE INDEX ON utilisateur_aime(film_id);

CREATE TABLE IF NOT EXISTS utilisateur_vote (
    user_id INT REFERENCES utilisateur,
    film_id INT REFERENCES film ON DELETE CASCADE,
    vote SMALLINT NOT NULL,
    PRIMARY KEY(user_id, film_id)
);

CREATE TABLE IF NOT EXISTS role (
    role_id VARCHAR(100) PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS possede_role (
    user_id INT REFERENCES utilisateur ON DELETE CASCADE,
    role_id VARCHAR(100) REFERENCES role ON DELETE CASCADE,
    PRIMARY KEY(user_id,role_id)
);
