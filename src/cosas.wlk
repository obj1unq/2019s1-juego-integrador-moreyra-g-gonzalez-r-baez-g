import wollok.game.*
import jugador.*
import mapas.*
import colisiones.*
import direcciones.*
import ataques.*

class Pared {

	const property position
	const property direccion

	method image() = "Pared_" + direccion + ".png"

	method id() = 1

	method esTraspasable() = self.hayPuertaEn(position)

	method hayPuertaEn(posicion) {
		return game.getObjectsIn(posicion).any({ objeto => objeto.id() == id.puerta() })
	}

	method serGolpeado() { /* No hace nada */
	}

	method tenerInteraccion() { /* No hace nada */
	}

}

class ParedBoss {

	const property position

	method image() = "MuroBoss_1.png"

	method id() = 1

	method esTraspasable() = false

	method serGolpeado() { /* No hace nada */
	}

	method tenerInteraccion() { /* No hace nada */
	}

}

class BushBoss{
	const property position
	var perspectiva

	method image() = "bush"+perspectiva+".png"

	method id() = 1

	method esTraspasable() = false

	method serGolpeado() { /* No hace nada */
	}

	method tenerInteraccion() { /* No hace nada */
	}
	
}

class Puerta {

	const property position
	const property salaActual
	const property salaSiguiente
	const property transportarJugadorCoordenadas
	const direccion

	method id() = 2

	method image() = "Puerta_" + direccion + ".png"

	method esTraspasable() = jugador.tieneLlave()
    

    
	method chocar() {
	   if(self.esTraspasable()){
	   	    self.avanzarASigSala()
	   }	
		else{
			game.say(jugador ,"La puerta esta cerrada con llave")
		}
		  

	}
    
    method avanzarASigSala(){
    	 salaActual.limpiarMapa()
		 salaSiguiente.cargarMapa()
		 self.moverJugador()
    }
    
	method moverJugador() {
		jugador.position(transportarJugadorCoordenadas)
		agregarColisiones.jugador()
	}

	method serGolpeado() { /* No hace nada */
	}

	method tenerInteraccion() { /* No hace nada */
	}

}

class Boton {

	const property position
	const property direccion
	var property estaActivado = false

	method image()

	method esTraspasable() = true

	method chocar() {
		estaActivado = true
	}

	method serGolpeado() { /* No hace nada */
	}

	method tenerInteraccion() { /* No hace nada */
	}

}

object nota {

	const property position = game.at(18, 1)

	method image() = "nota.png"

	method esTraspasable() = true

	method chocar() {
		game.say(jugador, "Violeta, Azul, Amarillo")
	}

	method serGolpeado() { /* No hace nada */
	}

	method tenerInteraccion() { /* No hace nada */
	}

}

object llave {

	const property position = game.at(10, 2)

	method image() = "skeleton_key.png"

	method esTraspasable() = true

	method chocar() {
		jugador.agarrarLlave()
		sala_1.removerObjeto(self)			
	}


	method serGolpeado() { /* No hace nada */}

	method tenerInteraccion() { /* No hace nada */}

}

class Caja {

	var property position

	method image() = "box.png"

	method esTraspasable() = false


	method chocar() {/* No hace nada */}


	

	method serGolpeado() {
		sala_1.removerObjeto(self)
	}

	method tenerInteraccion() { /* No hace nada */}

}

class Spike {
	var property position
	
	method image()= "spikes.png"
	
	method esTraspasable() = true
	
	method serGolpeado(){  }
	
	method tenerInteraccion() {  }
	
	method chocar(){ /*jugador.muerto()*/}
	
}


object spikes{
	method spikesFila(n){
				return	[1,2,3,4,5,6,7,8,9,10,11,12,13].map{numero=>new Spike(position=game.at(n,numero))}								  								  								  										  							  								  									  									  									  		
	}
	
}





class Estatua{
	
	var property position
	
	method image()
	
	method esTraspasable() = false
	
	method chocar(){  }
	
	method serGolpeado() { /* No hace nada */}

	method tenerInteraccion() { /* No hace nada */}
	
}


object boton1 inherits Boton (position = game.at(18, 13)) {

	override method image() {
		if (self.estaActivado()) {
			return "Magic_button_green.png"
		} else return "Magic_button_blue.png"
	}

	override method chocar() {
		if (boton2.estaActivado()) {
			estaActivado = true
		} else boton2.estaActivado(false)
	}

}

object boton2 inherits Boton (position = game.at(1,  13)) {

	override method image() {
		if (self.estaActivado()) {
			return "Magic_button_green.png"
		} else return "Magic_button_purple.png"
	}

}

object boton3 inherits Boton (position = game.at(1, 1)) {

	override method image() {
		if (self.estaActivado()) {
			return "Magic_button_green.png"
		} else return "Magic_button_yellow.png"
	}

	override method chocar() {
		if (not estaActivado and boton1.estaActivado()) {
			game.addVisual(llave)
			estaActivado = true
		} else {
			boton1.estaActivado(false)
			boton2.estaActivado(false)
		}
	}

}

class ColumnaBot{
		
	var property position 
	
	method image() = "colBot.png"
	
	method esTraspasable() = false
	
	method chocar(){  }
	
	method serGolpeado() { /* No hace nada */}

	method tenerInteraccion() { /* No hace nada */}
	
}

class ColumnaTop{
	var property position 
	
	method image() = "colTop.png"
	
	method esTraspasable() = true
	
	method chocar(){  }
	
	method serGolpeado() { /* No hace nada */}

	method tenerInteraccion() { /* No hace nada */}
}

object columna1 inherits ColumnaBot(position = game.at(14,10)){  }
object columna1Top inherits ColumnaTop(position = game.at(14,11)){  }
object columna2 inherits ColumnaBot(position = game.at(14,3)){  }
object columna2Top inherits ColumnaTop(position = game.at(14,4)){  }
object columna3 inherits ColumnaBot(position = game.at(5,10)){  }
object columna3Top inherits ColumnaTop(position = game.at(5,11)){  }
object columna4 inherits ColumnaBot(position = game.at(5,3)){  }
object columna4Top inherits ColumnaTop(position = game.at(5,4)){  }

object estatua1 inherits Estatua(position = game.at (9,13)){
	override method image() = "sprite_fujin.png"
}

object estatua2 inherits Estatua(position = game.at (5,13)){
	override method image() = "sprite_fujin.png"
}

object caja1 inherits Caja (position = game.at(18, 1)) {

}

object caja2 inherits Caja (position = game.at(17, 1)){
	
}

object caja3 inherits Caja (position = game.at(16, 1)){
	
}

object puerta_1_1 inherits Puerta	(position = game.at(7, 14), salaActual = sala_1, salaSiguiente = sala_2, transportarJugadorCoordenadas = game.at(7, 1), direccion = 3) {

}

object puerta_2_1 inherits Puerta	(position = game.at(1, 14), salaActual = sala_2, salaSiguiente = sala_3, transportarJugadorCoordenadas = game.at(1, 1), direccion = 3) {

}

object puerta_2_2 inherits Puerta	(position = game.at(7, 0), salaActual = sala_2, salaSiguiente = sala_1, transportarJugadorCoordenadas = game.at(7, 13), direccion = 1) {

}

object puerta_3_1 inherits Puerta	(position = game.at(1, 0), salaActual = sala_3, salaSiguiente = sala_3, transportarJugadorCoordenadas = game.at(1, 1), direccion = 1) {

	override method esTraspasable() = false

}

object alfombra{
	const property position = game.at(7,7)
	
	method image() = "rug.png"
	
	method esTraspasable() = true
	
	method chocar(){  }
	
	method serGolpeado() { /* No hace nada */}

	method tenerInteraccion() { /* No hace nada */}
	
}

object spawn {
	const property position = game.at(8,1)
	
	method image() = "spawn.png"
	
	method esTraspasable() = true
	
	method chocar(){  }
	
	method serGolpeado() { /* No hace nada */}

	method tenerInteraccion() { /* No hace nada */}
	
}

object espada {

	var property direccion = 1
	var property position = game.at(1, 1)

	method image() = "Espada_posicion_" + direccion + "_ataque.png"

	method esTraspasable() = true

	method agregarVisual() {
		game.addVisual(self)
	}

	method removerVisual() {
		game.removeVisual(self)
	}

	
	method serGolpeado(){/* No hace nada */}	
	method tenerInteraccion(){/* No hace nada */}	
	method chocar(){ /* No hace nada */}
	method id()=3000000
}

object jaula{
	var property position=game.at(18,13)
	method image()="jaula.png"
	method serGolpeado(){game.removeVisual(self)}
}
object mascaraPiso{
	const property position = game.at(7,7)
	method image()="mascara.png"
	method esTraspasable()= false
	method serGolpeado() { /* No hace nada */}
}							

object puenteParte1{
	var property position = game.at(15,4)
	method image()="P1.png"
	method esTraspasable()=  false
	method serGolpeado() { /* No hace nada */}
	method chocar()={/* No hace nada */}
}

object puenteParte2{
	var property position = game.at(15,3)
	method image()="P2.png"
	method esTraspasable()=  true
	method serGolpeado() { /* No hace nada */}
	method chocar()={/* No hace nada */}
}

object puenteParte2_2{
	var property position = game.at(16,3)
	method image()="P2.png"
	method esTraspasable()=  true
	method serGolpeado() { /* No hace nada */}
	method chocar()={/* No hace nada */}
}

object puenteParte3{
	var property position = game.at(15,2)
	method image()="P3.png"
	method esTraspasable()=  false
	method serGolpeado() { /* No hace nada */}
	method chocar()={/* No hace nada */}
}
object lagunita{
	method aguaEnFila(n){
				return	[1,2,3,4,5,6,7,8,9,10,11,12,13].map{numero=>new Agua(position=game.at(n,numero))}								  								  								  										  							  								  									  									  									  		
	}
	
}
class Agua{
	var property position
	method image()="agua.png"
	method esTraspasable()=  self.objetosEnAgua().size()==2
	method objetosEnAgua() = game.getObjectsIn(position)
	method serGolpeado() { /* No hace nada */}
	method chocar()={/* No hace nada */}
}

