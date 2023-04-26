-- 1 NF, must divide abilities into atomic VALUES

CREATE TABLE IF NOT EXISTS temp_table AS 
	SELECT trim(value) AS split_value, *
	FROM imported_pokemon,
				  json_each('["' || replace (abilities, ',' , '","') || '"]')
	  WHERE split_value <> '';

UPDATE temp_table
	  SET split_value = REPLACE(REPLACE(REPLACE(REPLACE(split_value, '[', ''), ']', ''), '''', ''), ' ', '');
  
  CREATE TABLE IF NOT EXISTS Pokemon AS 
	SELECT split_value AS abilities, against_bug, against_dark, against_dragon, against_electric, against_fairy, against_fight, against_fire, against_flying, against_ghost, against_grass, against_ground, against_ice, against_normal, against_poison, against_psychic, against_rock, against_steel, against_water, attack, base_egg_steps, base_happiness, base_total,capture_rate, classfication, defense, experience_growth, height_m, hp, name, percentage_male, pokedex_number, sp_attack, sp_defense, speed, type1, type2, weight_kg, generation, is_legendary
	 FROM temp_table;
	 
 DROP TABLE temp_table;
 

