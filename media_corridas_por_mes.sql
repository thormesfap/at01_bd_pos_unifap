SELECT AVG(contagem) as media_por_mes
FROM (
        SELECT FORMAT_DATE('%Y-%m', started_at) as por_mes,
            count(1) as contagem
        FROM `pos-banco-de-dados.at_sincrona_bd_pos_unifap_01.capstone_cyclist_data`
        GROUP BY FORMAT_DATE('%Y-%m', started_at)
    )