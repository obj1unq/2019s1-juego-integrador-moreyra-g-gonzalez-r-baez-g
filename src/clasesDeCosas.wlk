import wollok.game.*
import personajes.*
import mapas.*
import colisiones.*
import direcciones.*
import ataques.*
import gameOver.*
import clasesDeCosas.*
import cosas.*

class Agua{
	var property position
	method image()="agua.png"
	method esTraspasable()=  self.objetosEnAgua().size()==2
	method objetosEnAgua() = game.getObjectsIn(position)
	method serGolpeado() { /* No hace nada */}
	method chocar() {/* No hace nada */}
	method tenerInteraccion() {/* No hace nada */}
}

class ObjetoMovible {
	var property position
	
	method direccion()
	
	method moverse(direccion_){
		
			if (self.noHayObstaculoAdelante()){
				self.position(self.adelante())
			}
	}	
	
	method listaDeObjetosAdelante() = game.getObjectsIn(self.adelante())

	method adelante() = direccionRep.adelante(self.position(), self.direccion())
	
	method noHayObstaculoAdelante(){
		return  (self.listaDeObjetosAdelante().isEmpty() || self.objetosSonTraspasables(self.listaDeObjetosAdelante()))
	}
	
	method objetosSonTraspasables(listaDeObjetos){
		return listaDeObjetos.all{objeto => objeto.esTraspasable()}
	}
}

class Roca inherits ObjetoMovible{
	var property initial_position = position
		
	method image() = "Roca.png"
	method id() = 5
	method esTraspasable() = false
	method serGolpeado() { /* No hace nada */}
	method chocar() { /* No hace nada */}
	method tenerInteraccion() {
		if (self.haySueloRocaAdelante()){
			self.mover(self.direccion())
		}
	}
	
	method mover(direccion){
		if (initial_position == null) { initial_position = position }
		self.moverse(direccion)
	}
	
	override method direccion() = jugador.direccion()
	
	method direccion(algo) {/* No hace nada, sirve para la herencia de ObjetosMovibles */}	
	
	method haySueloRocaAdelante(){
		return (not self.listaDeObjetosAdelante().isEmpty()) && game.getObjectsIn(self.adelante()).any({ objeto => objeto.id() == id.sueloRoca() })
	}
}

class SueloRoca {
	var property position
	method image() = "Suelo_roca.png"
	method id() = 6
	method esTraspasable() = true
	method serGolpeado() {/* No hace nada */}
	method chocar() {/* No hace nada */}
	method tenerInteraccion() {/* No hace nada */}
}

class Palanca {
	var property position
	var property estaActivada = false
	var property salaActual
	
	method id() = 7
	method image() =  "Palanca_" + self.activadaRep() + ".png"
	method activadaRep() = if (estaActivada) { 1 } else { 0 }
	method serGolpeado() { /* No hace nada */}
	method chocar() { /* No hace nada */}
	method esTraspasable() = false
	method tenerInteraccion() { self.activar()
								estaActivada = not estaActivada
	}
	method activar()
}


class ColumnaBot{
		
	var property position 
	
	method id() = 14
	
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

class Caja {

	var property position

	method image() = "box.png"

	method esTraspasable() = false

	method id() = 12

	method chocar() {/* No hace nada */}


	

	method serGolpeado() {
		sala_1.removerObjeto(self)
	}

	method tenerInteraccion() { /* No hace nada */}

}

class Estatua{
	
	var property position
	
	method image()
	
	method id() = 13
	
	method esTraspasable() = false
	
	method chocar(){  }
	
	method serGolpeado() { /* No hace nada */}

	method tenerInteraccion() { /* No hace nada */}
	
}

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

	method id() = 8

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

	method id() = 9
	
	method chocar() {
		estaActivado = true
	}

	method serGolpeado() { /* No hace nada */
	}

	method tenerInteraccion() { /* No hace nada */
	}

}
