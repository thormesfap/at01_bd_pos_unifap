SELECT end_station_name,
    count(1) as contagem
FROM `pos-banco-de-dados.at_sincrona_bd_pos_unifap_01.capstone_cyclist_data`
WHERE end_station_name IS NOT NULL
GROUP BY end_station_name
ORDER BY contagem DESC
LIMIT 5