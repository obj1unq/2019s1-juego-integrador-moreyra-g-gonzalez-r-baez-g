import wollok.game.*

object jugador {

	var property posicionXJugador = 1
	var property posicionYJugador = 1
	var property direccionPersonaje = 1
	
	method id() = 4
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
		return  (self.listaDeObjetosArriba().isEmpty() || self.objetosSonTraspasables(self.listaDeObjetosArriba()))
	}
	method noHayObjetoAbajo(){
		return  (self.listaDeObjetosAbajo().isEmpty() || self.objetosSonTraspasables(self.listaDeObjetosAbajo()))
	}
	method noHayObjetoDerecha(){
		return  (self.listaDeObjetosDerecha().isEmpty() || self.objetosSonTraspasables(self.listaDeObjetosDerecha()))
	}
	method noHayObjetoIzquierda(){
		return  (self.listaDeObjetosIzquierda().isEmpty() || self.objetosSonTraspasables(self.listaDeObjetosIzquierda()))
	}
	method objetosSonTraspasables(listaDeObjetos){
		return listaDeObjetos.all{objeto => objeto.esTraspasable()}
	}
	method listaDeObjetosArriba() = game.getObjectsIn(game.at(self.posicionXJugador(),self.posicionYJugador()+1))
	method listaDeObjetosAbajo() = game.getObjectsIn(game.at(self.posicionXJugador(),self.posicionYJugador()-1))
	method listaDeObjetosDerecha() = game.getObjectsIn(game.at(self.posicionXJugador()+1,self.posicionYJugador()))
	method listaDeObjetosIzquierda() = game.getObjectsIn(game.at(self.posicionXJugador()-1,self.posicionYJugador()))
}

object pepita{
	method position() = game.at(18,13)
	method image() = "pepita.png" 
	method esTraspasable() = false
	method id() = 3
}

object boss{
	method position() = game.at(11,10)
	method image() = "boss.png"
	method id() = 27
	method esTraspasable()= true
}

