import wollok.game.*
import jugador.*
import mapas.*
import colisiones.*

class Pared {
	const property position
	const direccion
	method image() = "Pared_"+ direccion +".png"
	method id() = 1

	method esTraspasable() = self.hayPuertaEn(position)
	method hayPuertaEn(posicion){
		return game.getObjectsIn(posicion).any({ objeto => objeto.id() == id.puerta() })
	}
	
}

class Puerta {
	const property position
	const property salaActual
	const property salaSiguiente
	const property transportarJugadorCoordenadaX
	const property transportarJugadorCoordenadaY
	
	method id() = 2
	method image() = "Puerta_1.png"
	method esTraspasable() = true
	method chocar() {
		salaActual.limpiarMapa()
		salaSiguiente.cargarMapa()
		self.moverJugador()
	}
	
	method moverJugador(){
		game.removeVisual(jugador)
		jugador.posicionXJugador(transportarJugadorCoordenadaX)	
		jugador.posicionYJugador(transportarJugadorCoordenadaY)	
		game.addVisual(jugador)
		agregarColisiones.jugador()
	}
}

object puerta_1_1 inherits Puerta	(position = game.at(7, 14), salaActual = sala_1, salaSiguiente = sala_2,
									 transportarJugadorCoordenadaX = 1, transportarJugadorCoordenadaY = 1
									){    }

object puerta_2_1 inherits Puerta	(position = game.at(7, 14), salaActual = sala_2, salaSiguiente = sala_3,
									 transportarJugadorCoordenadaX = 1, transportarJugadorCoordenadaY = 1
									){    }