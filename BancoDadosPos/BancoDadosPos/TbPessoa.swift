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
    
    func salvar(i: Int, nome: String, cidade: String) {
        if (i >= 0){
            //alterar
            alterar(i: i, nome: nome, cidade: cidade)
        } else {
            // inserir
            inserir(nome: nome, cidade: cidade)
        }
    }
    
     private func inserir(nome: String, cidade: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.managedObjectContext
        
        //carrega do banco a entidade (tabela)
        var tabela = NSEntityDescription.entity(forEntityName: nomeTabela, in: managedContext)!
        
        //pega a estrutura da tabela e cria um objeto manipulável para inserir dados
        var pes = NSManagedObject(entity: tabela, insertInto: managedContext)
        
        //adicionando os valores passados por parametros
        pes.setValue(nome, forKey: "nome")
        pes.setValue(cidade, forKey: "cidade")
    }
    
    private func alterar(i: Int, nome: String, cidade: String) {
        //alterando os dados do array com os novos dados da pessoa
        self.pessoas[i].setValue(nome, forKey: nome)
        self.pessoas[i].setValue(cidade, forKey: cidade)
        
        do {
            try self.pessoas[i].managedObjectContext?.save()
        } catch let error as NSError{
            
            //caso de erro avisa mostrando o indice, nome e mensagem de erro
            print("Erro ao alterar: \(i) - \(nome). \(error)")
        }
    }
    
    func deletar(i: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.managedObjectContext
        
        //deletando o objeto na tabela
        managedContext.delete(self.pessoas[1])
    }
}

