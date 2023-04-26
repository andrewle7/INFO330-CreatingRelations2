-- 2NF

CREATE TABLE IF NOT EXISTS Pokemon_2NF (
	pokedex_number INT PRIMARY KEY,
	name TEXT not null,
	type1 TEXT not null,
	type2 TEXT,
	percentage_male INT not null,
	classfication not null,
	height_m INT not null,
	weight_kg INT not null,
	capture_rate INT not null,
	base_egg_steps INT not null,
	base_happiness INT not null,
	base_total INT not null,
	experience_growth INT not null,
	hp INT not null,
	attack INT not null,
	defense INT not null,
	sp_attack INT not null,
	sp_defense INT not null,
	speed INT not null,
	generation INT not null,
	is_legendary TEXT not null
);

INSERT INTO Pokemon_2NF (pokedex_number, name, type1, type2, percentage_male, classfication, height_m, weight_kg, capture_rate, base_egg_steps, base_happiness, base_total, experience_growth, hp, attack, defense, sp_attack, sp_defense, speed, generation, is_legendary)
SELECT DISTINCT pokedex_number, name, type1, type2, percentage_male, classfication, height_m, weight_kg, capture_rate, base_egg_steps, base_happiness, base_total, experience_growth, hp, attack, defense, sp_attack, sp_defense, speed, generation, is_legendary
FROM Pokemon;

--seperate abilities from table
CREATE TABLE IF NOT EXISTS Pokemon_Abilities (
	ability_id INTEGER PRIMARY KEY AUTOINCREMENT,
	ability_name TEXT not NULL
);

INSERT INTO Pokemon_Abilities (ability_name) 
SELECT DISTINCT abilities
FROM Pokemon;

CREATE TABLE IF NOT EXISTS Abilities_of_Pokemon (
	id INTEGER PRIMARY KEY,
	pokedex_number INT not null,
	ability_id INT not null,
	FOREIGN KEY (pokedex_number) REFERENCES Pokemon_2NF (pokedex_number),
	FOREIGN KEY (ability_id) REFERENCES Pokemon_Abilities (ability_id)
);

CREATE TABLE IF NOT EXISTS pokemon_abilities_temp AS
    SELECT pokedex_number, abilities AS ability_name
	FROM Pokemon;

INSERT INTO Abilities_of_Pokemon (pokedex_number, ability_id) 
SELECT Pokemon_2NF.pokedex_number, Pokemon_Abilities.ability_id
FROM Pokemon_2NF, Pokemon_Abilities, pokemon_abilities_temp
WHERE Pokemon_2NF.pokedex_number = pokemon_abilities_temp.pokedex_number AND Pokemon_Abilities.ability_name = pokemon_abilities_temp.ability_name;

-- seperate effectiveness types
CREATE TABLE IF NOT EXISTS Pokemon_Effective_Types (
	pokedex_number INT not null,
	against_bug INT not null,
	against_dark INT not null,
	against_dragon INT not null,
	against_electric INT not null,
	against_fairy INT not null,
	against_fight INT not null,
	against_fire INT not null,
	against_flying INT not null, 
	against_ghost INT not null,
	against_grass INT not null,
	against_ground INT not null,
	against_ice INT not null,
	against_normal INT not null,
	against_poison INT not null,
	against_psychic INT not null,
	against_rock INT not null,
	against_steel INT not null,
	against_water INT not null,
	FOREIGN KEY (pokedex_number) REFERENCES Pokemon_2NF (pokedex_number)
);

INSERT INTO Pokemon_Effective_Types
SELECT DISTINCT Pokemon_2NF.pokedex_number,
	against_bug,
	against_dark,
	against_dragon,
	against_electric,
	against_fairy,
	against_fight,
	against_fire,
	against_flying,
	against_ghost,
	against_grass,
	against_ground,
	against_ice,
	against_normal,
	against_poison,
	against_psychic,
	against_rock,
	against_steel,
	against_water
	FROM Pokemon, Pokemon_2NF WHERE
	Pokemon_2NF.pokedex_number = Pokemon.pokedex_number;
	
	DROP TABLE Pokemon;
	DROP TABLE pokemon_abilities_temp;

