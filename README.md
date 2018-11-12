# UOC_CCC: GambleSpotter

Dataset para el análisis de mesas de poker en vivo

## Descripción

Esta práctica se ha realizado bajo el contexto de la asignatura Tipología y ciclo de vida de los datos, perteneciente al Máster en Ciencia de Datos de la Universitat Oberta de Catalunya. Se aplican técnicas de web scraping mediante el lenguaje de programación R para extraer así datos de la ocupación de mesas de poker en los casinos del grupo CCC, la variante de poker jugada y las ciegas empleadas.

## Contexto

La ciudad de Viena se está convirtiendo en un referente del poker europeo debido al gran trabajo del grupo de casinos [CCC](https://www.ccc.co.at/), que han decidido crear casinos especializados en poker, segregándolos de otros juegos de casino. Así, la ciudad de Viena dispone de tres casinos exclusivamente dedicados al poker:

- Montesino
- Simmering
- Lugner City

Además y en vista del éxito, CCC ha decidido seguir este modelo en las ciudades de:

- Insbruk
- Bregenz
- Salzburgo
- Klagenfurt
- Kufstein
- Gmunden
- Linz
- Reutte

## Inspiración

Para el jugador profesional conocer de antemanos las posibilidades de cada casino supone una ventaja en varios aspectos:

- Para aquéllos profesionales que hayan estudiados variantes no habituales ("Seven Card Stud", "2-7 Triple Draw", "Short Deck" ...) es interesante saber dónde se pueden jugar. Es posible que en Europa no haya más de 3 o 4 casinos que ofrezcan estas modalidades.
- Para aquéllos jugadores profesionales interesados en niveles altos es interesante saber dónde se forman estas mesas y cúal suele ser su duración.

Parece dificil predecir para un jugador foráneo la ocupación de mesas o la variante de juego en cada casino para acertar en su elección, por lo que este DataSet puede ser usado con técnicas de minería de datos para tener un conocimiento mejor. Además, el código incluido puede ser usado para generar más observaciones y extender el DataSet.

## Objetivo

Por tanto este DataSet pretende ilustrar un método de recoger los datos que CCC brinda a sus clientes sobre el estado de sus mesas en vivo mediante su portal web para su posterior análisis. 

## Miembros del equipo

Esta práctica ha sido realizada individualmente por aantonc.

## Ficheros

Se pueden encontrar los siguientes ficheros

* src/casinowebscrapping.r: Código en R que realiza web scrapping sobre las urls de los casinos.
* resources/CCC.csv: DataSet completo con 71683 observaciones.
* resources/CCC_weekend.csv: DataSet correspondientes a las observaciones del fin de semana. 62111 observaciones entre jueves 8 de Noviembre de 2018 y el domingo 12 de Noviembre de 2018 a las 23:09 (horas local de cada casino).
* resources/urls.csv: URLs del portal del grupo CCC que contienen la información de las mesas en vivo.

## Contenido del DataSet

El DataSet contiene las siguientes columnas:

1. Timestamp: Momento en el que la observación fue realizada en formato YYYY-MM-DD HH24:MM:SS
2. TimeZone: Huso horario en el que la observación fue realizada (debido al posible cambio de este durante las observaciones).
3. Grupo: Grupo al que pertenece el casino observado.
4. Casino: Casino al que pertenece el casino observado
5. Juego: Modalidad de juego observada. Se han observado las típicas modalidades "No Limit Hold'em" y "Pot-Limit Omaha", pero también se han observado "2-7 Triple Draw Stud", "Dealer's choice" y "Seven Card Stud".
6. Descripción: En ocasiones los casinos introducen variaciones dentro de una misma modalidad. Gracias a este campo podemos observar partidas de "No Limit Hold'em" jugadas con baraja corta ("Short Deck 6+"), horarios o limitaciones de entrada.
7. Ciegas: Tipo de ciegas empleadas en cada observación.
8. Mesas: Número de mesas abiertas de cada tipo. En ocasiones se han llegado a observar 5 mesas con la misma modalidad jugada.

## Consideraciones éticas

El fichero [robots.txt](https://www.ccc.co.at/robots.txt) no limita el número de queries. Pero con el objetivo de no sobrecargar el servidor se aconseja no ejecutar el programa con menos de 10s de intervalo.

## Ejecucion

Ejecución una vez:

```
./casinowebscrapping.r
```

Ejecución en intervalos de 120 segundos

```
watch -n 120 ./casinowebscrapping.r
```

## Agradecimientos

El propietario de estos datos es:

Montesino Entertainment Group GmbH
Europaring F16/103
2345 Brunn am Gebirge

## Licencia

Este código y el DataSet asociado están distribuidos con licencia [MIT](https://choosealicense.com/licenses/mit/).
