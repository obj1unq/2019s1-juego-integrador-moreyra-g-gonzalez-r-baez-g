import wollok.game.*
import jugador.*
import mapas.*
import colisiones.*

class Pared {
	const property position
	const direccion
	method image() = "Pared_"+ direccion +".png"
	method id() = 1

<<<<<<< HEAD
	method esTraspasable() = self.hayPuertaEn(position)
	method hayPuertaEn(posicion){
		return game.getObjectsIn(posicion).any({ objeto => objeto.id() == id.puerta() })
	}
	
=======
	method hayPuerta(){
		
	}
>>>>>>> branch 'master' of https://github.com/obj1unq/2019s1-juego-integrador-moreyra-g-gonzalez-r-baez-g.git
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

<<<<<<< HEAD
object puerta_1_1 inherits Puerta	(position = game.at(7, 14), salaActual = sala_1, salaSiguiente = sala_2,
=======

class Boton{
	const property position
	const property direccion
	var estaActivado = false
	
	method image(){ return
		   if (estaActivado){
			     "botonPresionado"
		}
		
		   else  "botonSinPresionar"
	}
	method esTraspasable() = false
	method chocar(){
		estaActivado = true
		
	}
	
	
	 
}


object puerta_1_1 inherits Puerta	(position = game.at(7, 13), salaActual = sala_1, salaSiguiente = sala_2,
>>>>>>> branch 'master' of https://github.com/obj1unq/2019s1-juego-integrador-moreyra-g-gonzalez-r-baez-g.git
									 transportarJugadorCoordenadaX = 1, transportarJugadorCoordenadaY = 1
									){    }

object puerta_2_1 inherits Puerta	(position = game.at(7, 14), salaActual = sala_2, salaSiguiente = sala_3,
									 transportarJugadorCoordenadaX = 1, transportarJugadorCoordenadaY = 1
									){    }