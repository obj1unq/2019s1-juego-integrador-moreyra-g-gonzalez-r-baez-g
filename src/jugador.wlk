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
	
	method id() = 4
	method image() = "Jugador_posicion_" + direccionPersonaje + ".png"
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
	

}

object pepita{
	method position() = game.at(18,13)
	method image() = "pepita.png" 
	method esTraspasable() = false
	method id() = 3
}

object boss{
	var tiempoDeAtaque
	var property vida = 3
	method position() = game.at(17,3)
	method image() = "boss.png"
	method id() = 27
	method esTraspasable()= true
	
	method atacar(sala){
		self.atacarP(sala)
		game.onTick(tiempoDeAtaque,"asdasdasd",{self.atacarP(sala) /*game.removeTickEvent("asdasdasd")*/})	
	}
	
	method atacarP(sala){
		self.rondaDeAtaque1(sala)
		self.rondaDeAtaque2(sala)
	}
	method serGolpeado(){
		if(vida>0){
			vida-=1
		}
	}
	method rondaDeAtaque1(sala){
		if(self.vida()==3){
		tiempoDeAtaque = 20000
		[1,3,5,7,9,11,13,15].forEach{numero=> game.onTick(1000*numero,""+numero,{new RondaDeAtaques (ataques = self.ataqueFila(numero)).lanzarAtaque(sala) game.removeTickEvent(""+numero)})}
		[2,4,6,8,10,12,14,16].forEach{numero=> game.onTick(1000*numero,""+numero,{new RondaDeAtaques (ataques = self.ataqueFilaEscape(numero)).lanzarAtaque(sala) game.removeTickEvent(""+numero)})}
		
		}

	}
	method rondaDeAtaque2(sala){
		if(self.vida()==2){
		tiempoDeAtaque = 1000	
		[1,3,5,7,9,11,13,15].forEach{numero=> game.onTick(500*numero,""+numero,{new RondaDeAtaques (ataques = self.ataqueFila(numero)).lanzarAtaque(sala) game.removeTickEvent(""+numero)})}
		[2,4,6,8,10,12,14,16].forEach{numero=> game.onTick(500*numero,""+numero,{new RondaDeAtaques (ataques = self.ataqueFilaEscape(numero)).lanzarAtaque(sala) game.removeTickEvent(""+numero)})}
		
		}
//		game.onTick(15000,"asdasdasd",{self.atacar(sala) game.removeTickEvent("asdasdasd")})	
	}
	
	method ataqueFila(n){
				return	[1,2,3,4,5,6,7,8,9,10,11,12,13].map{numero=> new Ataque(position = game.at(n,numero),tiempo =500,numeroDeAtaque =n*100+numero)}								  								  								  										  							  								  									  									  									  		
	}
	method ataqueFilaEscape(n){
		return [1,2,3,4,5,6,8,9,10,11,12,13].map{numero=> new Ataque(position = game.at(n,numero),tiempo =500,numeroDeAtaque =n*200+numero)}	
	}
}

