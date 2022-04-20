//
//  RemoveListaDeTarefa.swift
//  ListaDeTarefas
//
//  Created by Felipe Yuiti on 17/04/22.
//

import Foundation
import UIKit

class RemoveListaDeTarefaViewController{
    
    let controller: UIViewController
    
    init(controller: UIViewController){
        self.controller = controller
    }
    
    func exibe(_ listaDeTarefa: Tarefa, handler: @escaping (UIAlertAction) -> Void){
        let alerta = UIAlertController(title: listaDeTarefa.title, message: "\(listaDeTarefa.description)", preferredStyle: .alert)
        let botaoCancelar = UIAlertAction(title: "Cancelar", style: .cancel,handler: nil)
        alerta.addAction(botaoCancelar)
        
        let botaoEditar = UIAlertAction(title: "Editar", style: .default, handler: handler)
        alerta.addAction(botaoEditar)
        
        controller.present(alerta, animated: true, completion: nil)
    }
}
