extends CoreComponent


"""
La idea de este escript es la de aumentar las estadísticas de los enemigos (de manera individual) dependiendo de cosas como:
	-la oleada actual de la partida
	-si es minijefe / jefe

creo que será algo como:
	var stats : Diccionary { estadisticas... }
	stats = stats + stats * oleada / 100

	se suma todo por (0.01 * oleada) en cada estat y ya, las estadísticas base de cada enemigo se modifican desde su escena

	y si es jefe todo multiplicado por 2 o 1.5 y ya
"""