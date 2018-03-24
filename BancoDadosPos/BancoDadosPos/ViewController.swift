//
//  ViewController.swift
//  BancoDadosPos
//
//  Created by Faculdade Alfa on 24/03/2018.
//  Copyright © 2018 Faculdade Alfa. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var campoNome: UITextField!
    @IBOutlet weak var campoCidade: UITextField!
    @IBOutlet weak var tabela: UITableView!
    @IBAction func salvar(_ sender: Any) {
        tbPessoa.salvar(i: -1, nome: campoNome.text!, cidade: campoCidade.text!)
        
        //limpar campos apos salvar
        campoCidade.text = ""
        campoNome.text = ""
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
    
    //número de sessões na tabela
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //número de linhas dentro da sessão
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaPessoa.count
    }
    
    //retornar a célula com o valor do array de pessoa
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //carregando os dados da pessoa de acordo com o índice da tabela
        let pes = listaPessoa[indexPath.row]
        
        //busca na tabela se existe um modelo de celula e retorma
        let celula = tableView.dequeueReusableCell(withIdentifier: "celula")!
        
        celula.textLabel?.text = pes.nome
        celula.detailTextLabel?.text = pes.cidade
        
        return celula
    }
    
}

