//
//  DetalheViewController.swift
//  ListaDeTarefas
//
//  Created by Felipe Yuiti on 19/04/22.
//

import UIKit

class DetalheViewController: UIViewController {

    private lazy var labelTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var labelDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 1
        return label
    }()
    
    var tarefa: Tarefa?
    var editDelegate: EditarTarefaDelegate?
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        view.backgroundColor = .white
        labelTitle.text = tarefa?.title
        labelDescription.text = tarefa?.description
        
        let botaoEditarTarefa = UIBarButtonItem(title: "Editar", style: .plain, target: self, action: #selector(EditarTarefa))
        navigationItem.rightBarButtonItem = botaoEditarTarefa
        
        buildViewHierachy()
        addConstraints()
    }
    
    private func buildViewHierachy() {
        view.addSubview(labelTitle)
        view.addSubview(labelDescription)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            labelTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            labelTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            labelTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            labelDescription.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 20),
            labelDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            labelDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
        ])
    }
    
    @objc func EditarTarefa(){
        let adicionarTarefaViewController = AdicionarListaDeTarefaViewController(addDelegate: nil, editDelegate: self)
        adicionarTarefaViewController.tarefa = tarefa
        navigationController?.pushViewController(adicionarTarefaViewController, animated: true)
    }
}

extension DetalheViewController: EditarTarefaDelegate {
    func edit(_ tarefa: Tarefa) {
        navigationController?.popViewController(animated: true)
        editDelegate?.edit(tarefa)
    }
}
