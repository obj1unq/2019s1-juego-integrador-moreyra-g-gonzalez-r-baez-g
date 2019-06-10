import wollok.game.*
import direcciones.*
import cosas.*
import ataques.*

object jugador {

	var property posicionXJugador = 1
	var property posicionYJugador = 1
	var property direccionPersonaje = 1
	var property direction = arriba
	var property tieneLlave = false
	var property estadoPj = self.normal()
	var tiempoDeAtaque = 0	
	
	method id() = 4
	method image() = "Jugador_posicion_" + direccionPersonaje + estadoPj + ".png"
	method position() = game.at(posicionXJugador,posicionYJugador)
	method agarrarLlave(){
		tieneLlave = true
	}

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
	
	
	method moverEnXConCaja(direccion,caja){
		self.moverEnX(direccion)
		caja.moverseConJugador()
	}
	
	method moverEnYConCaja(direccion,caja){
		self.moverEnX(direccion)
		caja.moverseConJugador()
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
	
	
	method atacar(){
		if (tiempoDeAtaque == 0){ 
			self.listaDeObjetosAdelante().forEach({ objeto => objeto.serGolpeado()})
			self.atacarPrima()

			
		}
	}
	
	method listaDeObjetosAdelante() = game.getObjectsIn(self.adelante())
	
	method atacarPrima(){

		var posicionInicial = self.position()
			
		espada.direccion(direccionPersonaje)
		espada.position(self.adelante())
		self.estadoPj(self.ataque())
		espada.agregarVisual()
		
		game.onTick(10, "ataque", {
			if (tiempoDeAtaque >= 10 || self.position() != posicionInicial ){
				espada.removerVisual()
				game.removeTickEvent("ataque")
				self.estadoPj(self.normal())
				tiempoDeAtaque = 0
			} else {
				tiempoDeAtaque ++
			}
		})
//		game.onTick(300, "ataque", {espada.removerVisual() 
//									self.estadoPj(self.normal())
//									game.removeTickEvent("ataque")
//		})

		
	}
	method defender(){
		self.estadoPj(self.defensa())
		game.onTick(300, "defensa", {self.estadoPj(self.normal())
									 game.removeTickEvent("defensa")
		})
	}
	
//	method adelante() = direction.siguiente(self.position())
	
	method adelante() {
		if (direccionPersonaje == self.arriba() ){
			return self.position().up(1)
		} else if(direccionPersonaje == self.izquierda()) {
			return self.position().left(1)
		} else if(direccionPersonaje == self.abajo()) {
			return self.position().down(1)
		} else {
			return self.position().right(1)
		}
	}
	
	method normal() = ""
	method ataque() = "_ataque"
	method defensa() = "_defensa"
	
}

object pepita{
	method position() = game.at(18,13)
	method image() = "pepita.png" 
	method esTraspasable() = false
	method id() = 3
	
	method serGolpeado(){ game.say(self, "ay") }	
}

object boss{
	method position() = game.at(17,3)
	method image() = "boss.png"
	method id() = 27
	method esTraspasable()= true
	
	method atacar(sala){
		[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16].forEach{numero=> game.onTick(500*numero,""+numero,{new RondaDeAtaques (ataques = self.ataqueFila(numero)).lanzarAtaque(sala) game.removeTickEvent(""+numero)})}
	
	}
	
	
	method ataqueFila(n){
				return	[1,2,3,4,5,6,7,8,9,10,11,12,13].map{numero=> new Ataque(position = game.at(n,numero),tiempo =500,numeroDeAtaque =n*100+numero)}								  								  								  										  							  								  									  									  									  		
	}
	
	method serGolpeado(){ /* No hace nada */}
}

