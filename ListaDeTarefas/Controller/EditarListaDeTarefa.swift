//
//  EditarListaDeTarefa.swift
//  ListaDeTarefas
//
//  Created by Felipe Yuiti on 17/04/22.
//

import Foundation
import UIKit

class EditarListaDeTarefa: UIViewController {
    
    @IBOutlet weak var tituloTextField: UITextField!
    @IBOutlet weak var descricaoTextField: UITextField!
    
    
    
    @IBAction func alterarButton(_ sender: Any) {
//        if let refeicao = recuperaRefeicaoDoFormulario(){
//            delegate?.add(refeicao)
//            navigationController?.popViewController(animated: true)}
//        else{
//            Alerta(controller: self).exibe(mesagem: "Erro ao ler dados do formulário")}
        navigationController?.popViewController(animated: true)
    }
    
    }


