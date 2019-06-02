import wollok.game.*

object jugador {

	var property posicionXJugador = 0
	var property posicionYJugador = 0
	var property direccionPersonaje = 1
	
	method image() = "Jugador_posicion_" + direccionPersonaje + ".png"
	method position() = game.at(posicionXJugador,posicionYJugador)
	
	method moverEnX(direccion){
		self.cambiarImagenHorizontal(direccion)
		posicionXJugador += direccion
	}
		method moverEnY(direccion){
		self.cambiarImagenVertical(direccion)
		posicionYJugador += direccion
	}
	method cambiarImagenHorizontal(direccion){
		if (direccion == 1){
			self.direccionPersonaje(self.derecha())
		} else {
			self.direccionPersonaje(self.izquierda())
		}
	}
	method cambiarImagenVertical(direccion) {
		if (direccion == 1){
			self.direccionPersonaje(self.arriba())
		} else {
			self.direccionPersonaje(self.abajo())
		} 
	}
	method derecha() = 4
	method izquierda() = 2
	method arriba() = 3
	method abajo() = 1
}

