//
//  Atributos.swift
//  MonitoriasProjeto
//
//  Created by Turma02-22 on 28/02/25.
//

import Foundation
import SwiftUI

var minhaCor : Color = Color.pretoCinza
var azul : Color = Color.azulBonito

struct DiaDaSemana : Identifiable {
    var id = UUID()
    var dia: String
    var data: String
    var cafeDaManha: String
    var almoco: String
    var jantar: String
}

var arrayData = [
    DiaDaSemana(dia: "Segunda-feira", data: "11/03",
                cafeDaManha: "Café da manhã às 7h30 — Ingredientes: pão francês, café preto, queijo minas.",
                almoco: "Almoço às 12h30 — Ingredientes: arroz branco, feijão carioca, carne assada, batata cozida, salada de alface e tomate.",
                jantar: "Jantar às 19h00 — Ingredientes: sopa de legumes com frango, torradas integrais, chá de ervas."),
    
    DiaDaSemana(dia: "Terça-feira", data: "12/03",
                cafeDaManha: "Café da manhã às 7h30 — Ingredientes: omelete de queijo, pão integral, suco de laranja.",
                almoco: "Almoço às 12h30 — Ingredientes: macarrão ao molho de tomate, frango grelhado, brócolis cozido, salada de pepino e rúcula.",
                jantar: "Jantar às 19h00 — Ingredientes: salada com frango desfiado, mix de folhas verdes, croutons integrais, azeite de oliva."),
    
    DiaDaSemana(dia: "Quarta-feira", data: "13/03",
                cafeDaManha: "Café da manhã às 7h30 — Ingredientes: iogurte natural com granola, banana, mel.",
                almoco: "Almoço às 12h30 — Ingredientes: peixe grelhado, arroz integral, purê de abóbora, salada de repolho com cenoura.",
                jantar: "Jantar às 19h00 — Ingredientes: omelete de espinafre, pão integral, chá de camomila."),
    
    DiaDaSemana(dia: "Quinta-feira", data: "14/03",
                cafeDaManha: "Café da manhã às 7h30 — Ingredientes: panquecas de aveia, café com leite, morangos.",
                almoco: "Almoço às 12h30 — Ingredientes: arroz, feijão preto, carne de porco assada, couve refogada, farofa de mandioca.",
                jantar: "Jantar às 19h00 — Ingredientes: sopa de feijão, queijo branco, pão integral."),
    
    DiaDaSemana(dia: "Sexta-feira", data: "15/03",
                cafeDaManha: "Café da manhã às 7h30 — Ingredientes: torradas com requeijão, chá verde, maçã.",
                almoco: "Almoço às 12h30 — Ingredientes: estrogonofe de frango, arroz branco, batata palha, salada de alface e tomate.",
                jantar: "Jantar às 19h00 — Ingredientes: macarrão ao molho branco, frango desfiado, queijo parmesão ralado."),
    
    DiaDaSemana(dia: "Sábado", data: "16/03",
                cafeDaManha: "Café da manhã às 8h00 — Ingredientes: bolo de cenoura com cobertura de chocolate, café preto.",
                almoco: "Almoço às 13h00 — Ingredientes: feijoada completa, arroz branco, couve refogada, laranja.",
                jantar: "Jantar às 19h30 — Ingredientes: pão francês com queijo quente, leite com chocolate."),
    
    DiaDaSemana(dia: "Domingo", data: "17/03",
                cafeDaManha: "Café da manhã às 8h00 — Ingredientes: pão de queijo, café com leite, suco de laranja.",
                almoco: "Almoço às 13h00 — Ingredientes: churrasco variado, arroz, vinagrete, maionese de batata.",
                jantar: "Jantar às 19h30 — Ingredientes: sopa de mandioca com carne seca, torradas integrais.")
]

struct dados: Codable, Hashable {
    var dia: Int?
    var agua: Bool?
    
    var horasAcordou: Int?
    var horasDeitou: Int
    
    var InicioCardio: Int?
    var FimCardio: Int?
    var valor: Int?
    
    var peso: Double?
    
    var horarioCafe: Int?
    var ingredientesCafe: String?
    
    var horarioAlmo: Int?
    var ingredientesAlmo: String?
    
    var horarioJantar: Int?
    var ingredientesJantar: String?
    
    var horarioTreino: Int?
    var descricaoTreino: String?
}

struct pessoa: Codable, Hashable {
    var _id: String?
    var _rev: String?
    var pesoMes: Double?
    var aguaTotal: Int?
    var dadosTotais: [dados]?
}
