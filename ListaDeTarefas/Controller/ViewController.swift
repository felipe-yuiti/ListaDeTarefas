//
//  ViewController.swift
//  ListaDeTarefas
//
//  Created by Felipe Yuiti on 17/04/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var listaDeTarefa: [Tarefa] = []
    let service = ListaTarefaService()
    
    private func getTarefas() {
        //        listaDeTarefa.append(contentsOf: service.getAllTarefas())
        service.getAllTarefas { tarefas in
            self.listaDeTarefa.removeAll()
            self.listaDeTarefa.append(contentsOf: tarefas)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        getTarefas()
        
        let botaoAdicionarTarefa = UIBarButtonItem(title: "Adicionar", style: .plain, target: self, action: #selector(AdicionarTarefa))
        navigationItem.rightBarButtonItem = botaoAdicionarTarefa
    }
    
    @objc func AdicionarTarefa(){
        let adicionarTarefaViewController = AdicionarListaDeTarefaViewController(addDelegate: self)
        navigationController?.pushViewController(adicionarTarefaViewController, animated: true)
    }
}

extension ViewController: AdicionaTarefaDelegate {
    func add(_ tarefa: Tarefa) {
        self.service.createTarefa(tarefa: tarefa) { sucesso in
            if sucesso {
                self.getTarefas()
            } else {
                Alerta(controller: self).exibe(titulo: "Desculpe", mesagem: "Não foi possivel atualizar a tabela")
            }
        }
    }
}

extension ViewController: EditarTarefaDelegate {
    func edit(_ tarefa: Tarefa) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.service.updateTarefa(tarefa: tarefa) { sucesso in
                if sucesso {
                    self.getTarefas()
                } else {
                    Alerta(controller: self).exibe(titulo: "Desculpe", mesagem: "Não foi possivel alterar a tarefa")
                }
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
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tarefa = listaDeTarefa[indexPath.row]
        
        let detalheViewController = DetalheViewController()
        detalheViewController.editDelegate = self
        detalheViewController.tarefa = tarefa
        navigationController?.pushViewController(detalheViewController, animated: true)
    }
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        if let viewController = segue.destination as? ViewController {
    //            viewController.delegate = self
    //        }
    //    }
}
