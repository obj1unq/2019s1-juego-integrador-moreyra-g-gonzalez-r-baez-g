import wollok.game.*
import direcciones.*
import cosas.*
import ataques.*
import gameOver.*
import clasesDeCosas.*
import colisiones.*

object jugador inherits ObjetoMovible (position = game.at(10,2)){

	var property direccion = direccionRep.abajo()
	var property tieneLlave = false
	var property estadoPj = self.normal()
	var tiempoDeAtaque = 0
	var property estaVivo = true
		
	method muerto(){
		self.estaVivo(false)
		gameOver.finDelJuego()
	}
	method id() = id.jugador()
	method image() = if (estaVivo){ 
						"Jugador_posicion_" + direccion + estadoPj + ".png"
						} else {
							"Lapida.png"
						}
	method agarrarLlave(){
		tieneLlave = true
	}

	method mover(direccion_){
		if(estaVivo){ 
			direccion = direccion_
			self.moverse(direccion_)
		}
	}
	
	method atacar(){
		if (estaVivo && tiempoDeAtaque == 0){ 
			self.listaDeObjetosAdelante().forEach({ objeto => objeto.serGolpeado()})
			self.atacarPrima()

			
		}
	}

	method atacarPrima(){

		var posicionInicial = self.position()
		var direccionInicial = self.direccion()
			
		espada.direccion(direccion)
		espada.position(self.adelante())
		self.estadoPj(self.ataque())
		espada.agregarVisual()
		
		game.onTick(10, "ataque", {
			if (tiempoDeAtaque >= 10 || self.position() != posicionInicial || self.direccion() != direccionInicial ){
				espada.removerVisual()
				game.removeTickEvent("ataque")
				self.estadoPj(self.normal())
				tiempoDeAtaque = 0
			} else {
				tiempoDeAtaque ++
			}
		})
		
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

	
	
	method normal() = ""
	method ataque() = "_ataque"
	method defensa() = "_defensa"
	
}

object pepita{
	method position() = game.at(18,13)
	method image() = "pepita.png" 
	method esTraspasable() = false
	method id() = id.pepita()
	
	method serGolpeado(){ game.say(self, "Gracias!") }	
	method tenerInteraccion(){ game.say(self, "hola, sacame de aqui")}
	method pedirAyuda(){game.say(self, "AYUDA!")}	
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
	method id() = id.boss()
	method esTraspasable()= not self.estaVivo()
	method estaVivo(){
		return vida>0
	}
	
	
	method atacar(sala){
		if(self.estaVivo()&&jugador.estaVivo()){
		self.atacarP(sala)
		game.onTick(8500,"se puede atacar boss",{self.sePuedeAtacar(true) game.removeTickEvent("se puede atacar boss")})
		game.onTick(12000,"recursion",{self.atacar(sala) game.removeTickEvent("recursion")})
		}	
	}
	
	method atacarP(sala){
		game.say(self, "MUEREEEE!")
		self.rondaDeAtaque(sala)
		
	}
	method serGolpeado(){
		if(self.estaVivo() && sePuedeAtacar){
			vida-=1
			sePuedeAtacar = false
		}
	}

	method rondaDeAtaque(sala){	
		[1,3,5,7,9,11,13,15].forEach{numero=> game.onTick(500*numero,""+numero,{new RondaDeAtaques (ataques = self.ataqueFila(numero)).lanzarAtaque(sala) game.removeTickEvent(""+numero) self.sePuedeAtacar(false)})}
		[2,4,6,8,10,12,14,16].forEach{numero=> game.onTick(500*numero,""+numero,{new RondaDeAtaques (ataques = self.ataqueFilaEscape(numero)).lanzarAtaque(sala) game.removeTickEvent(""+numero)})}	
	}
	
	method ataqueFila(n){
				return	[1,2,3,4,5,6,7,8,9,10,11,12,13].map{numero=> new Ataque(position = game.at(n,numero),tiempo =500,numeroDeAtaque =n*100+numero)}								  								  								  										  							  								  									  									  									  		
	}
	method ataqueFilaEscape(n){
		return [1,2,3,4,5,6,8,9,10,11,12,13].map{numero=> new Ataque(position = game.at(n,numero),tiempo =500,numeroDeAtaque =n*200+numero)}	
	}

	method tenerInteraccion(){/* No hace nada */}
	method chocar()={/* No hace nada */}
	method regenerar(){vida = 3}	

}

