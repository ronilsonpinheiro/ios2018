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
    }
    
    var tbPessoa = TbPessoa()
    var listaPessoa = [Pessoa]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

