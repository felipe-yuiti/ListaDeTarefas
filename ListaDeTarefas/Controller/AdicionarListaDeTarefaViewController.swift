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

protocol EditarTarefaDelegate {
    func edit(_ tarefa: Tarefa)
}

class AdicionarListaDeTarefaViewController: UIViewController {
    
    @IBOutlet weak var titleTextLabel: UITextField!
    @IBOutlet weak var descriptionTextLabel: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    
    var addDelegate: AdicionaTarefaDelegate?
    var editDelegate: EditarTarefaDelegate?
    var tarefa: Tarefa?
    
    init(addDelegate: AdicionaTarefaDelegate?, editDelegate: EditarTarefaDelegate? = nil) {
        super.init(nibName: "AdicionarListaDeTarefaViewController", bundle: nil)
        self.addDelegate = addDelegate
        self.editDelegate = editDelegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let tarefa = tarefa {
            addButton.isHidden = true
            editButton.isHidden = false
            titleTextLabel.text = tarefa.title
            descriptionTextLabel.text = tarefa.description
        } else {
            addButton.isHidden = false
            editButton.isHidden = true
        }
    }

    @IBAction func adicionarTarefa(_ sender: Any) {
        //criar o objeto da tarefa
        guard let titulo = titleTextLabel.text, let descricao = descriptionTextLabel.text else {return}
    
        let tarefa = Tarefa(createdAt: "", title: titulo, description: descricao, id:"" )
        addDelegate?.add(tarefa)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func editarTarefa(_ sender: Any) {
        //editar o objeto da tarefa
        guard let titulo = titleTextLabel.text, let descricao = descriptionTextLabel.text else { return }
    
        let tarefa = Tarefa(createdAt: tarefa?.createdAt ?? "",
                            title: titulo,
                            description: descricao,
                            id: tarefa?.id ?? "" )
        navigationController?.popViewController(animated: true)
         editDelegate?.edit(tarefa)
    }
    
}
