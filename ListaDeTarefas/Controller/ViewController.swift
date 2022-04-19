//
//  ViewController.swift
//  ListaDeTarefas
//
//  Created by Felipe Yuiti on 17/04/22.
//

import UIKit

class ViewController: UIViewController, AdicionaTarefaDelegate {
   
    
    @IBOutlet weak var tableView: UITableView!
    var listaDeTarefa: [Tarefa] = []
    let service = ListaTarefaService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        //        listaDeTarefa.append(contentsOf: service.getAllTarefas())
        service.getAllTarefas { tarefas in
            self.listaDeTarefa.append(contentsOf: tarefas)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        let botaoAdicionarTarefa = UIBarButtonItem(title: "Adicionar", style: .plain, target: self, action: #selector(AdicionarTarefa))
        navigationItem.rightBarButtonItem = botaoAdicionarTarefa
    }
    
    @objc func AdicionarTarefa(){
        let adicionarTarefaViewController = AdicionarListaDeTarefaViewController(delegate:self)
        navigationController?.pushViewController(adicionarTarefaViewController, animated: true)
    }
    
    func add(_ tarefa: Tarefa) {
        self.service.createTarefa(tarefa: tarefa) { sucesso in
            if sucesso {
                print("tarefa criada")
                self.listaDeTarefa.append(tarefa)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            else    {
                Alerta(controller: self).exibe(titulo: "Desculpe", mesagem: "Não foi possivel atualizar a tabela")
                    }
            }
        }
    }

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaDeTarefa.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { action, indexPath in
            let tarefa = self.listaDeTarefa[indexPath.row]
            self.service.deleteTarefa(tarefa: tarefa) { sucesso in
                if sucesso {
                    print("tarefa deletada")
                  self.listaDeTarefa.remove(at: indexPath.row)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            else  {
                    Alerta(controller: self).exibe(titulo: "Desculpe", mesagem: "Não foi possivel atualizar a tabela")
                }
            }
        }
        return [delete]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let tarefa = listaDeTarefa[indexPath.row]
        cell.textLabel?.text = tarefa.title
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(mostrarDetalhes(_:)))
        cell.addGestureRecognizer(longPress)
        
        return cell
        }
    
    @objc func mostrarDetalhes(_ gesture: UILongPressGestureRecognizer){
        //ver o estado que o objeto está em relacao a celula
        if gesture.state == .began   {
            //o metodo gesture pode ser usado em outros componentes de view, não só celula.
            //recuperando refeicao
            let cell = gesture.view as! UITableViewCell
            guard let indexPath = tableView.indexPath(for: cell) else {return}
            var tarefa = listaDeTarefa[indexPath.row]
            let alerta = UIAlertController(title: "Editar",
                                           message: "atualizar as tarefas",
                                           preferredStyle: .alert)
            
            let editar = UIAlertAction(title: "save", style: .default) { (action) in
                guard let textField = alerta.textFields?.first else{
                    return
                }
                if let textToEdit = textField.text {
                    if textToEdit.count == 0 {
                        return
                    }
                    tarefa.title = textToEdit
                    self.tableView?.reloadRows(at: [indexPath], with: .automatic)
                } else {
                    return
                }
            }
            let cancelAction = UIAlertAction(title: "Cancelar",
                                             style: .default)
            alerta.addTextField()
            guard let textField = alerta.textFields?.first else{
                return
            }
            textField.placeholder =  "Alterar titulo"
            alerta.addAction(editar)
            alerta.addAction(cancelAction)
            present(alerta, animated: true)
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let viewController = segue.destination as? ViewController {
//            viewController.delegate = self
//        }
//    }
}

