import wollok.game.*
import jugador.*
import mapas.*
import colisiones.*
import direcciones.*
import ataques.*

class Pared {
	const property position
	const property direccion
	method image() = "Pared_"+ direccion +".png"
	method id() = 1

	method esTraspasable() = self.hayPuertaEn(position)
	method hayPuertaEn(posicion){
		return game.getObjectsIn(posicion).any({ objeto => objeto.id() == id.puerta() })
	}
	method serGolpeado(){/* No hace nada */}	
	method tenerInteraccion(){/* No hace nada */}	
}
class ParedBoss {
	const property position
	method image() = "MuroBoss_1.png"
	method id() = 1

	method esTraspasable() = false
	method serGolpeado(){/* No hace nada */}	
	method tenerInteraccion(){/* No hace nada */}	
}

class Puerta {
	const property position
	const property salaActual
	const property salaSiguiente
	const property transportarJugadorCoordenadas
	const direccion
	
	method id() = 2
	method image() = "Puerta_"+ direccion +".png"
	method esTraspasable() = true
	method chocar() {
		salaActual.limpiarMapa()
		salaSiguiente.cargarMapa()
		self.moverJugador()

	}
	
	method moverJugador(){
		game.removeVisual(jugador)
		jugador.position(transportarJugadorCoordenadas)
		game.addVisual(jugador)
		agregarColisiones.jugador()
	}
	
	method serGolpeado(){/* No hace nada */}	
	method tenerInteraccion(){/* No hace nada */}	
	
	
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
	method serGolpeado(){/* No hace nada */}	
	method tenerInteraccion(){/* No hace nada */}			 
}

object nota{
	
	const property position = game.at(4,4)
	
	
	method image() = "nota.png"
	method esTraspasable()= true
	method chocar(){
		game.say(jugador,"Combinacion de botones a pisar")
	}
	method serGolpeado(){/* No hace nada */}	
	method tenerInteraccion(){/* No hace nada */}	
}


object llave{
	const property position = game.at(10,2)
	
	method image() = "secret_key_.png"
	method esTraspasable()= true
	
	method chocar(){
		
		jugador.agarrarLlave()
		sala_1.removerObjeto(self)
	}
	method serGolpeado(){/* No hace nada */}	
	method tenerInteraccion(){/* No hace nada */}	
}

class Caja{
	var   property position 
	
	
	method image() = "box.png"
	
	
	method esTraspasable() = false
	
	method chocar(){ }
	
	method moverseConJugador(){
		self.validarPosicion(jugador.direction())
		position = jugador.direction().siguiente(position)
	}
	
	method validarPosicion(direccion){
		const posicionSig = direccion.siguiente()
		var esLugarLibre = game.getObjectsIn(posicionSig)
		  if (not esLugarLibre.all({objeto => objeto.esTraspasable()})){
		        game.say(self,"No se puede mover")
		   }     
		        
		  else {}     
	}
	
	method serGolpeado(){/* No hace nada */}	
	method tenerInteraccion(){/* No hace nada */}	
	
			 		
}
object boton1 inherits Boton (position = game.at(5,10)) {  }
	
object caja1 inherits Caja (position = game. at (10,7)) {  }


object puerta_1_1 inherits Puerta	(position = game.at(7, 14), salaActual = sala_1, salaSiguiente = sala_2,
									 transportarJugadorCoordenadas = game.at(7, 1), direccion = 3
									){    }

object puerta_2_1 inherits Puerta	(position = game.at(1, 14), salaActual = sala_2, salaSiguiente = sala_3,
									 transportarJugadorCoordenadas = game.at(1, 1), direccion = 3
									){    }
									
object puerta_2_2 inherits Puerta	(position = game.at(7, 0), salaActual = sala_2, salaSiguiente = sala_1,
									 transportarJugadorCoordenadas = game.at(7, 13), direccion = 1
									){    }
									
object puerta_3_1 inherits Puerta	(position = game.at(1,0), salaActual = sala_3, salaSiguiente = sala_3,
									 transportarJugadorCoordenadas = game.at(1, 1), direccion = 1
									){
									override method esTraspasable() = false									
									}		
									
object espada {
	var property direccion = 1
	var property position = game.at(1,1)
	
	method image() = "Espada_posicion_"+ direccion +"_ataque.png"
	
	method esTraspasable() = true
	
	method agregarVisual(){
		game.addVisual(self)
	}
	
	method removerVisual(){
		game.removeVisual(self)
	}
	
	method serGolpeado(){/* No hace nada */}	
	method tenerInteraccion(){/* No hace nada */}	
}							