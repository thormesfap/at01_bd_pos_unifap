WITH PartidasFrequentes AS (
    SELECT start_station_name,
        end_station_name,
        COUNT(*) AS num_viagens
    FROM `pos-banco-de-dados.at_sincrona_bd_pos_unifap_01.capstone_cyclist_data`
    WHERE start_station_name IS NOT NULL
        AND end_station_name IS NOT NULL
    GROUP BY start_station_name,
        end_station_name
),
DestinoFrequente AS (
    SELECT start_station_name,
        (
            ARRAY_AGG(
                STRUCT(end_station_name, num_viagens)
                ORDER BY num_viagens DESC
                LIMIT 1
            )
        ) [OFFSET(0)].end_station_name AS destino_mais_frequente
    FROM PartidasFrequentes
    GROUP BY start_station_name
),
ViagensComDuracao AS (
    SELECT t.start_station_name,
        t.end_station_name,
        TIMESTAMP_DIFF(ended_at, started_at, MINUTE) AS duracao_minutos
    FROM `pos-banco-de-dados.at_sincrona_bd_pos_unifap_01.capstone_cyclist_data` AS t
        INNER JOIN DestinoFrequente as df on t.start_station_name = df.start_station_name
        and t.end_station_name = df.destino_mais_frequente
),
Top5Inicio as (
    SELECT start_station_name as nome_inicio,
        count(1) as contagem
    FROM ViagensComDuracao
    GROUP BY start_station_name
    ORDER BY contagem DESC
    LIMIT 5
)
SELECT v.start_station_name,
    v.end_station_name,
    MIN(v.duracao_minutos) as tempo_minimo,
    AVG(v.duracao_minutos) as tempo_medio,
    MAX(v.duracao_minutos) as tempo_maximo
FROM ViagensComDuracao as v
    INNER JOIN Top5Inicio as top5 ON v.start_station_name = top5.nome_inicio
GROUP BY v.start_station_name,
    v.end_station_name
ORDER BY v.start_station_name