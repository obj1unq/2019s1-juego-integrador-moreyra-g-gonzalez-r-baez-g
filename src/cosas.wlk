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
class ParedBoss {
	const property position
	method image() = "MuroBoss_1.png"
	method id() = 1

	method esTraspasable() = false
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


class Boton{
	const property position
	const property direccion	
	var estaActivado = false
	
	
	method image(){ return
		   if (estaActivado){
			     "boton_activado.png"
		}
		
		   else  "boton_desactivado.png"
	}
	method esTraspasable() = true
	method chocar(){
		estaActivado = true	
		
	}
	
			 
}

class Caja{
	const property position
	const property direccion	
	
	
	
	method image() = "box.png"
	
	method esTraspasable() = false
	method chocar(){	}
	
			 		
}
object boton1 inherits Boton (position = game.at(5,10)) {  }
	
object caja1 inherits Caja (position = game. at (10,7)) {  }


object puerta_1_1 inherits Puerta	(position = game.at(7, 14), salaActual = sala_1, salaSiguiente = sala_2,
									 transportarJugadorCoordenadaX = 1, transportarJugadorCoordenadaY = 1
									){    }

object puerta_2_1 inherits Puerta	(position = game.at(7, 14), salaActual = sala_2, salaSiguiente = sala_3,
									 transportarJugadorCoordenadaX = 1, transportarJugadorCoordenadaY = 1
									){    }