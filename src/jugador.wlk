import wollok.game.*
import direcciones.*
import cosas.*
import ataques.*

object jugador {
	var property position = game.at(10,2)
	var property direccionPersonaje = direccion.abajo()
	var property tieneLlave = false
	var property estadoPj = self.normal()
	var tiempoDeAtaque = 0
	var property estaVivo = true
		
	method muerto(){
		self.estaVivo(false)
	}
	method id() = 4
	method image() = "Jugador_posicion_" + direccionPersonaje + estadoPj + ".png"
	method agarrarLlave(){
		tieneLlave = true
	}

	method mover(direccion){
		if(estaVivo){
			direccionPersonaje = direccion
			if (self.noHayObstaculoAdelante()){
				self.position(self.adelante())
			}
		}
	}
	method noHayObstaculoAdelante(){
		return  (self.listaDeObjetosAdelante().isEmpty() || self.objetosSonTraspasables(self.listaDeObjetosAdelante()))
	}

	method objetosSonTraspasables(listaDeObjetos){
		return listaDeObjetos.all{objeto => objeto.esTraspasable()}
	}

	method listaDeObjetosAdelante() = game.getObjectsIn(self.adelante())
	
	method atacar(){
		if (estaVivo && tiempoDeAtaque == 0){ 
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
		if(estaVivo){
			self.estadoPj(self.defensa())
			game.onTick(300, "defensa", {self.estadoPj(self.normal())
									 game.removeTickEvent("defensa")
			})
		}
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
	
	var property vida = 3
	var property sePuedeAtacar = false
	method position() = game.at(17,3)
	method image() = if(not self.estaVivo()){
							"bossMuerto.png"
						}else if(sePuedeAtacar){
							"bossIndefenso.png"
						}else{
							"bossDefensivo.png"
						}
	method id() = 27
	method esTraspasable()= not self.estaVivo()
	method estaVivo(){
		return vida>0
	}
	
	
	method atacar(sala){
		if(self.estaVivo()){
		self.atacarP(sala)
		game.onTick(8500,"se puede atacar vos",{self.sePuedeAtacar(true) game.removeTickEvent("se puede atacar vos")})
		game.onTick(12000,"recursion",{self.atacar(sala) game.removeTickEvent("recursion")})
		}	
	}
	
	method atacarP(sala){
		self.rondaDeAtaque(sala)
		
	}
	method serGolpeado(){
		if(self.estaVivo() && sePuedeAtacar){
			vida-=1
			sePuedeAtacar = false
		}
	}
	/*method rondaDeAtaque1(sala){
		if(self.vida()==3){
		tiempoDeAtaque = 20000
		[1,3,5,7,9,11,13,15].forEach{numero=> game.onTick(1000*numero,""+numero,{new RondaDeAtaques (ataques = self.ataqueFila(numero)).lanzarAtaque(sala) game.removeTickEvent(""+numero)})}
		[2,4,6,8,10,12,14,16].forEach{numero=> game.onTick(1000*numero,""+numero,{new RondaDeAtaques (ataques = self.ataqueFilaEscape(numero)).lanzarAtaque(sala) game.removeTickEvent(""+numero)})}
		
		}

	}*/
	method rondaDeAtaque(sala){	
		[1,3,5,7,9,11,13,15].forEach{numero=> game.onTick(500*numero,""+numero,{new RondaDeAtaques (ataques = self.ataqueFila(numero)).lanzarAtaque(sala) game.removeTickEvent(""+numero) self.sePuedeAtacar(false)})}
		[2,4,6,8,10,12,14,16].forEach{numero=> game.onTick(500*numero,""+numero,{new RondaDeAtaques (ataques = self.ataqueFilaEscape(numero)).lanzarAtaque(sala) game.removeTickEvent(""+numero)})}
//		game.onTick(15000,"asdasdasd",{self.atacar(sala) game.removeTickEvent("asdasdasd")})	
	}
	
	method ataqueFila(n){
				return	[1,2,3,4,5,6,7,8,9,10,11,12,13].map{numero=> new Ataque(position = game.at(n,numero),tiempo =500,numeroDeAtaque =n*100+numero)}								  								  								  										  							  								  									  									  									  		
	}
	method ataqueFilaEscape(n){
		return [1,2,3,4,5,6,8,9,10,11,12,13].map{numero=> new Ataque(position = game.at(n,numero),tiempo =500,numeroDeAtaque =n*200+numero)}	
	}

	method tenerInteraccion(){/* No hace nada */}
	method chocar()={/* No hace nada */}	

}

