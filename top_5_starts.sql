SELECT start_station_name,
    count(1) as contagem
FROM `pos-banco-de-dados.at_sincrona_bd_pos_unifap_01.capstone_cyclist_data`
WHERE start_station_name IS NOT NULL
GROUP BY start_station_name
ORDER BY contagem DESC
LIMIT 5