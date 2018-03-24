//
//  ViewController.swift
//  BancoDadosPos
//
//  Created by Faculdade Alfa on 24/03/2018.
//  Copyright © 2018 Faculdade Alfa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var campoNome: UITextField!
    @IBOutlet weak var campoCidade: UITextField!
    @IBOutlet weak var tabela: UITableView!
    @IBAction func salvar(_ sender: Any) {
        tbPessoa.salvar(i: -1, nome: campoNome.text!, cidade: campoCidade.text!)
        campoNome.text = ""
        campoCidade.text = ""
    }
    
    var tbPessoa = TbPessoa()
    var listaPessoa = [Pessoa]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //ao carragar a tela , carrega os dados da tabela pessoa
        carregarDados()
    }
    
    //carregar dados na tela
    func carregarDados() {
        //criando where da busca
        //var filtro = NSPredicate(format: "cidade = %@", "Umuarama")
        
        //carregando na lista  de os dados da tblPessoa
        listaPessoa = tbPessoa.buscar(filtro: nil)
        
        //recarregar dados na tela
        tabela.reloadData()
    }
}

