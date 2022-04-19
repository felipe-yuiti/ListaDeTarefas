//
//  ListaTarefaService.swift
//  ListaDeTarefas
//
//  Created by Felipe Yuiti on 17/04/22.
//

import Foundation

class ListaTarefaService {
    
    let session = URLSession.shared
    let baseUrl = "https://625c420b50128c57020cacfd.mockapi.io/api/v1"
    
    func getAllTarefas(completion: @escaping ([Tarefa]) -> Void) {
        guard let url = URL(string: baseUrl + "/tarefas") else {
            print("formato de url inválido")
            return
        }
        
        session.dataTask(with: url) { data, response, error in
            if let data = data {
                if let tarefas = try? JSONDecoder().decode([Tarefa].self, from: data){
                    completion(tarefas)
                }
            }
        }.resume()
    }
    
    func createTarefa(tarefa: Tarefa, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: baseUrl + "/tarefas/\(tarefa.id)") else {
            print("formato de url inválido")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(false)
            } else {
                completion(true)
            }
        }.resume()
    }
    
    func deleteTarefa(tarefa: Tarefa, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: baseUrl + "/tarefas/\(tarefa.id)") else {
            print("formato de url inválido")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(false)
            } else {
                completion(true)
            }
        }.resume()
    }
    
    func updateTarefa(tarefa: Tarefa, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: baseUrl + "/tarefas/\(tarefa.id)") else {
            print("formato de url inválido")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        
        session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(false)
            } else {
                completion(true)
            }
        }.resume()
    }
    
}
