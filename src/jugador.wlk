import wollok.game.*

object jugador {

	var property posicionXJugador = 1
	var property posicionYJugador = 1
	var property direccionPersonaje = 1
	
	method image() = "Jugador_posicion_" + direccionPersonaje + ".png"
	method position() = game.at(posicionXJugador,posicionYJugador)
	

	method moverEnX(direccion){
		self.cambiarImagenHorizontal(direccion)
		if (direccion == 1 && self.noHayObjetoDerecha()){
			posicionXJugador += direccion
		} else if (direccion == -1 && self.noHayObjetoIzquierda()){
			posicionXJugador += direccion
		}
	}
	method moverEnY(direccion) {
		self.cambiarImagenVertical(direccion)
		if (direccion == 1 && self.noHayObjetoArriba()){
			
			posicionYJugador += direccion
		} else if (direccion == -1 && self.noHayObjetoAbajo()){
	
			posicionYJugador += direccion
		} 
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

