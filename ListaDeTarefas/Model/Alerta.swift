//
//  Alerta.swift
//  ListaDeTarefas
//
//  Created by Felipe Yuiti on 17/04/22.
//

import Foundation
import  UIKit

class Alerta {
    let controller: UIViewController
    init(controller: UIViewController){
        self.controller = controller
    }
    func exibe(titulo:String = "Atencão", mesagem:String = "Erro ao atualizar a tabela"){
        let alerta = UIAlertController(title: titulo, message: mesagem, preferredStyle: .alert)
        let ok = UIAlertAction(title: "cancelar", style: .cancel, handler: nil)
        alerta.addAction(ok)
        controller.present(alerta, animated: true, completion: nil)
    }
}
