//
//  TbPessoa.swift
//  BancoDadosPos
//
//  Created by Faculdade Alfa on 24/03/2018.
//  Copyright © 2018 Faculdade Alfa. All rights reserved.
//

import UIKit
import CoreData

class TbPessoa{
    //nome da tabela no Model.xcdatamodeld
    private let nomeTabela = "TblPessoa"
    private var pessoas:[NSManagedObject] = []
    
    func buscar(filtro: NSPredicate?) -> [Pessoa]{// ? pode ser nulo
        pessoas = []
        var listaPessoa = [Pessoa]()
        
        //carregando o AppDelegate da aplicação, se retornar nulo, para a execução
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return listaPessoa
        }
        
        let managedContext = appDelegate.managedObjectContext
        
        //carregando a estrutura da tabela do model
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: nomeTabela)
        
        do {
            //verifica se existe filtro, se sim, adiciona o filtro na tabela
            if let condicao = filtro {
                fetchRequest.predicate = condicao
            }
            
            //faz a busca dos dados da tabela com os filtros
            pessoas = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Deu Erro: \(error). \(error.userInfo)")
        }
        
        for registro in pessoas{
            let nome = registro.value(forKey: "nome") as! String // as! String = retornando tipo String
            let cidade = registro.value(forKey: "cidade") as! String
            
            //criando um objeto pessoa com os dados do banco de dados
            let pes = Pessoa(nome: nome, cidade: cidade)
            
            //adicionando a pessoa na lista de retorno
            listaPessoa.append(pes)
        }
        
        return listaPessoa
    }
    
    func salvar() {
        
    }
    
    func deletar() {
        
    }
}

