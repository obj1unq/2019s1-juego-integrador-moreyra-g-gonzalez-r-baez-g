import wollok.game.*

object jugador {

	var property posicionXJugador = 0
	var property posicionYJugador = 0
	
	method image() = "Jugador_posicion_1.png"
	method position() = game.at(posicionXJugador,posicionYJugador)
	
	method moverEnX(direccion){
		if ((posicionXJugador + direccion) <= (game.width() - 1) && (posicionXJugador + direccion) >= 0)
		posicionXJugador += direccion
	}
		method moverEnY(direccion){
		if ((posicionYJugador + direccion) <= (game.height() - 1) && (posicionYJugador + direccion) >= 0)
		posicionYJugador += direccion
	}
}

