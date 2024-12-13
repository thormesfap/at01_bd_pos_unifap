SELECT DATE(started_at) as por_dia,
    count(1) as contagem
FROM `pos-banco-de-dados.at_sincrona_bd_pos_unifap_01.capstone_cyclist_data`
GROUP BY DATE(started_at)
ORDER BY contagem ASC
LIMIT 10