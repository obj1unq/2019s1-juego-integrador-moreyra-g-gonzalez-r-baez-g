import wollok.game.*

object jugador {

	var property posicionXJugador = 0
	var property posicionYJugador = 0
	var property direccionPersonaje = 1
	
	method image() = "Jugador_posicion_" + direccionPersonaje + ".png"
	method position() = game.at(posicionXJugador,posicionYJugador)
	

	method moverEnX(direccion){
		if (direccion == 1 && self.noHayObjetoDerecha()){
			self.direccionPersonaje(self.derecha())
			posicionXJugador += direccion
		} else if (direccion == -1 && self.noHayObjetoIzquierda()){
			self.direccionPersonaje(self.izquierda())
			posicionXJugador += direccion
		}
	}
	method moverEnY(direccion) {
		if (direccion == 1 && self.noHayObjetoArriba()){
			self.direccionPersonaje(self.arriba())
			posicionYJugador += direccion
		} else if (direccion == -1 && self.noHayObjetoAbajo()){
			self.direccionPersonaje(self.abajo())
			posicionYJugador += direccion
		} 
	}
	method derecha() = 4
	method izquierda() = 2
	method arriba() = 3
	method abajo() = 1
	
	method noHayObjetoArriba(){
		return  (game.getObjectsIn(game.at(self.posicionXJugador(),self.posicionYJugador()+1)).isEmpty())
	}
	method noHayObjetoAbajo(){
		return  (game.getObjectsIn(game.at(self.posicionXJugador(),self.posicionYJugador()-1)).isEmpty())
	}
	method noHayObjetoDerecha(){
		return  (game.getObjectsIn(game.at(self.posicionXJugador()+1,self.posicionYJugador())).isEmpty())
	}
	method noHayObjetoIzquierda(){
		return  (game.getObjectsIn(game.at(self.posicionXJugador()-1,self.posicionYJugador())).isEmpty())
	}
}

object pepita{
	method position() = game.at(9,9)
	method image() = "pepita.png" 
}

