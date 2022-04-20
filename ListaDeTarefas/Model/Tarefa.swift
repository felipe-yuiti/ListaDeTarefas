//
//  Tarefa.swift
//  ListaDeTarefas
//
//  Created by Felipe Yuiti on 17/04/22.
//


import Foundation

struct Tarefa: Codable {
    let createdAt: String
    var title: String
    let description: String
    let id: String

    enum CodingKeys: String, CodingKey {
        case createdAt
        case title
        case description
        case id
    }
}
