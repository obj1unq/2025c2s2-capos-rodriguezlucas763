object rolando {
    var property poderBase = 5 

    var property territorio = erethia
    var property casa = castilloDePiedra

    var property mochila = #{} 
    var property espacioLimite = 2
    var property historiaDeArtefactos = []

    method validarEncontrarArtefacto(artefacto) {
        if (mochila.size() == espacioLimite) {
            self.error("La mochila está llena")
        }
    }
    method encontrarArtefacto(artefacto) {
        historiaDeArtefactos.add(artefacto)
        self.validarEncontrarArtefacto(artefacto)
        mochila.add(artefacto)
    }
    method volverAlCastillo() {
        casa.almacenarArtefactos(mochila)
        mochila.clear()
    }
    method verPosesiones() {
        return mochila + casa.coleccion()
    }
    method tengoElArtefacto(artefacto) {
        return self.verPosesiones().contains(artefacto)
      
    }
    method poderDePelea() {
        return poderBase + mochila.sum({artefacto => artefacto.poder(self)})
    }
    method pelearBatalla() {
        mochila.forEach({artefacto => artefacto.fueUsado()})
        poderBase += 1
    }
    method enemigosPichi(tierra) {
        return tierra.enemigos().filter({enemigo => self.puedeVencerA(enemigo)})
    }
    method puedeVencerA(enemigo) {
        return enemigo.poderDePelea() < self.poderDePelea()
    }
    method moradasConquistables(tierra) {
      return self.enemigosPichi(tierra).map({enemigo => enemigo.casa()})
    }
    method esPoderoso(tierra) {
      return self.enemigosPichi(tierra) == tierra.enemigos()
    }
}

object erethia {
    var property enemigos = #{}
    
}

object caterina {
    var property casa = fortalezaDeAcero

    method poderDePelea() {
        return 28
    }
}

object archibaldo {
    var property casa = palacioDeMarmol

    method poderDePelea() {
        return 16
    }
}

object astra {
    var property casa = torreDeMarfil

    method poderDePelea() {
        return 14
    }
}

object castilloDePiedra {
    var property coleccion = #{}

    method almacenarArtefactos(artefactos) {
      coleccion.addAll(artefactos)
    }
    method artefactoOp(portador) {
      return coleccion.max({coleccion => coleccion.poder(portador)})
    }
}

object fortalezaDeAcero {
  
}

object palacioDeMarmol {
  
}

object torreDeMarfil {
  
}

object espadaDelDestino {
    var fueUsada = false

    method poder(portador) {
        if (fueUsada) {
            return portador.poderBase() * 0.5
        }
        else {
            return portador.poderBase()
        }
    }
    method fueUsado() {
        fueUsada = true
    }
}

object libroDeHechizos {
    var property hechizos = []

    method poder(portador) {
        if (hechizos == []) {
            return 0
        }
        else {
            return hechizos.first().poder(portador)
        }
    }
    method fueUsado() {
        if (hechizos != []) {
            hechizos.remove(hechizos.first())
        }
    } 
}

object collarDivino {
    var property vecesUsado = 0 
    const poderBasico = 3

    method poder(portador) {
        if (portador.poderBase() > 6) {
            return poderBasico + vecesUsado
        }
        else {
            return poderBasico
        }
    }
    method fueUsado() {
        vecesUsado += 1
    }
}

object armaduraDeAceroValyrio{

    method poder(portador) {
        return 6
    }
    method fueUsado() {

    }
}

object bendicion {

  method poder(portador) {
    return 4
  }
}

object invisibilidad {
  
  method poder(portador) {
    return portador.poderBase()
  }
}

object invocacion {
  
  method poder(portador) {
    return portador.casa().artefactoOp(portador).poder(portador)
  }
}
