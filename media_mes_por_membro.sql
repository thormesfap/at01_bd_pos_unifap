SELECT FORMAT_DATE('%Y-%m', started_at) as mes,
    member_casual,
    AVG(TIMESTAMP_DIFF(ended_at, started_at, MINUTE)) AS tempo_medio
FROM `pos-banco-de-dados.at_sincrona_bd_pos_unifap_01.capstone_cyclist_data`
GROUP BY FORMAT_DATE('%Y-%m', started_at),
    member_casual