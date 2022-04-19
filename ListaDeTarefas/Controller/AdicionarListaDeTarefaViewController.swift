//
//  AdicionarListaDeTarefaViewController.swift
//  ListaDeTarefas
//
//  Created by Felipe Yuiti on 17/04/22.
//

import UIKit

protocol AdicionaTarefaDelegate {
    func add(_ tarefa: Tarefa)
}

class AdicionarListaDeTarefaViewController: UIViewController {
    
    @IBOutlet weak var titleTextLabel: UITextField!
    @IBOutlet weak var descriptionTextLabel: UITextField!
    
    var delegate: AdicionaTarefaDelegate?
    
    init (delegate: AdicionaTarefaDelegate){
        super.init(nibName: "AdicionarListaDeTarefaViewController", bundle: nil)
        self.delegate = delegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func adicionarTarefa(_ sender: Any) {
        //criar o objeto da tarefa
        guard let titulo = titleTextLabel.text, let descricao = descriptionTextLabel.text else {return}
    
        let tarefa = Tarefa(createdAt: "", title: titulo, descricao: descricao, id:"" )
        delegate?.add(tarefa)
        navigationController?.popViewController(animated: true)
    }
    
}
