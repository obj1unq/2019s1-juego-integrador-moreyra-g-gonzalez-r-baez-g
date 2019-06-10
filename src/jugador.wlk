import wollok.game.*
import direcciones.*
import cosas.*
import ataques.*

object jugador {
	var property position = game.at(1,1)
	var property direccionPersonaje = direccion.abajo()
	var property direction = arriba
	var property tieneLlave = false
	var property estadoPj = self.normal()
	var tiempoDeAtaque = 0	
	
	method id() = 4
	method image() = "Jugador_posicion_" + direccionPersonaje + estadoPj + ".png"
	method agarrarLlave(){
		tieneLlave = true
	}

	method mover(direccion){
		direccionPersonaje = direccion
		if (self.noHayObstaculoAdelante()){
			self.position(self.adelante())
		}
	}
	
	method moverConCaja(direccion,caja){
		self.mover(direccion)
		caja.moverseConJugador()
	}
	
	
	method noHayObstaculoAdelante(){
		return  (self.listaDeObjetosAdelante().isEmpty() || self.objetosSonTraspasables(self.listaDeObjetosAdelante()))
	}

	method objetosSonTraspasables(listaDeObjetos){
		return listaDeObjetos.all{objeto => objeto.esTraspasable()}
	}

	method listaDeObjetosAdelante() = game.getObjectsIn(self.adelante())
	
	method atacar(){
		if (tiempoDeAtaque == 0){ 
			self.listaDeObjetosAdelante().forEach({ objeto => objeto.serGolpeado()})
			self.atacarPrima()

			
		}
	}
	

	method atacarPrima(){

		var posicionInicial = self.position()
		var direccionInicial = self.direccionPersonaje()
			
		espada.direccion(direccionPersonaje)
		espada.position(self.adelante())
		self.estadoPj(self.ataque())
		espada.agregarVisual()
		
		game.onTick(10, "ataque", {
			if (tiempoDeAtaque >= 10 || self.position() != posicionInicial || self.direccionPersonaje() != direccionInicial ){
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
	
	method interactuar(){
		self.listaDeObjetosAdelante().forEach({ objeto => objeto.tenerInteraccion()})
	}

	
//	method adelante() = direction.siguiente(self.position())
	
	method adelante() {
		if (direccionPersonaje == direccion.arriba() ){
			return self.position().up(1)
		} else if(direccionPersonaje == direccion.izquierda()) {
			return self.position().left(1)
		} else if(direccionPersonaje == direccion.abajo()) {
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
	method tenerInteraccion(){ game.say(self, "que querei?")}	
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

	method tenerInteraccion(){/* No hace nada */}	

}

