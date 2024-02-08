
/*
 1) Les titres et dates de sortie des films du plus récent au plus ancien

2) Les noms, prénoms et âges des acteurs/actrices de plus de 30 ans dans l'ordre alphabétique

3) La liste des acteurs/actrices principaux pour un film donné

4) La liste des films pour un acteur/actrice donné

5) Ajouter un film

6) Ajouter un acteur/actrice

7) Modifier un film

8) Supprimer un acteur/actrice

9) Afficher les 3 derniers acteurs/actrices ajouté(e)s

10) Afficher le film le plus ancien

11) Afficher l’acteur le plus jeune

12) Compter le nombre de films réalisés en 1990

13) Faire la somme de tous les acteurs ayant joué dans un film
 */


-- Les titres et dates de sortie des films du plus récent au plus ancien
SELECT film_titre, film_date_sortie
FROM film
ORDER BY film_date_sortie DESC;

-- Les noms, prénoms et âges des acteurs/actrices de plus de 30 ans dans l'ordre alphabétique
SELECT acteur_nom, acteur_prenom, extract(year from NOW()) - extract(year from acteur_date_naissance) as age
FROM acteur
WHERE extract(year from NOW()) - extract(year from acteur_date_naissance) > 30
ORDER BY (acteur_nom, acteur_prenom) ASC;

-- La liste des acteurs/actrices principaux pour un film donné

SELECT concat(a.acteur_nom,' ',a.acteur_prenom) as acteur, jd.role, f.film_titre
FROM joue_dans jd
JOIN acteur a on a.acteur_id = jd.acteur_id
JOIN film f on f.film_id = jd.film_id
WHERE jd.film_id = 1

-- La liste des films pour un acteur/actrice donné

SELECT f.film_titre
FROM joue_dans jd
JOIN acteur a on a.acteur_id = jd.acteur_id
JOIN film f on f.film_id = jd.film_id
WHERE jd.acteur_id = 2

-- Ajouter un film

INSERT INTO film (film_titre, film_synopsis, film_date_sortie, film_duree) VALUES (
    'test',
    'testtew',
    '2023-01-01',
    302
);

-- Ajouter un acteur

INSERT INTO acteur (acteur_nom, acteur_prenom, acteur_date_naissance) VALUES (
    'Durbec',
    'Lucas',
    '2003-11-29'
)

-- Modifier un film

UPDATE film
SET film_titre = 'Super titre'
WHERE film_id = 2;

-- Supprimer acteur

DELETE FROM acteur WHERE acteur_nom = 'Durbec';

-- Afficher les 3 derniers acteurs/actrices ajouté(e)s

SELECT acteur_nom, acteur_prenom
FROM acteur
ORDER BY acteur_id DESC
LIMIT 3;

-- Afficher le film le plus ancien

SELECT film_titre, film_date_sortie
FROM film
ORDER BY film_date_sortie
LIMIT 1;

-- Afficher l’acteur le plus jeune

SELECT acteur_nom, acteur_prenom, acteur_date_naissance
FROM acteur
ORDER BY acteur_date_naissance DESC
LIMIT 1;

-- Compter le nombre de films réalisés en 1990

SELECT count(*) as total
FROM film
WHERE extract(year from film_date_sortie) = 1990;

--  Faire la somme de tous les acteurs ayant joué dans un film

SELECT count(distinct jd.acteur_id)
FROM acteur
JOIN joue_dans jd on acteur.acteur_id = jd.acteur_id;



/*SELECT a.acteur_nom, a.acteur_prenom, count(*)
FROM joue_dans jd
JOIN acteur a on a.acteur_id = jd.acteur_id
GROUP BY a.acteur_nom, a.acteur_prenom*/
