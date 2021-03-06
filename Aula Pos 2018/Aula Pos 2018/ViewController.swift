//
//  ViewController.swift
//  Aula Pos 2018
//
//  Created by Faculdade Alfa on 17/03/2018.
//  Copyright © 2018 Faculdade Alfa. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet var campoGasolina:UITextField! //! quando não for inicializado, esta avisando que tera valor
    @IBOutlet var campoEtanol:UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func cancelar(){
        campoGasolina.text = ""
        campoEtanol.text = ""
    }
    
    @IBAction func calcular(){
        let valorGasolina:Double = (campoGasolina.text as! NSString).doubleValue
        let valorEtanol = (campoEtanol.text as! NSString).doubleValue
        
        if ((valorGasolina <= 0) || (valorEtanol <= 0)){
            mostrarMensagem(titulo: "Pós Alfa", mensagem: "Valor da gasolina ou do etanol inválido")
            return
        }
        
        if (valorEtanol <= (valorGasolina * 0.7)){
            mostrarMensagem(titulo: "Pós Alfa", mensagem: "Etanol é melhor!")
        } else {
            mostrarMensagem(titulo: "Pós Alfa", mensagem: "Gasolina é melhor!")
        }
    }
    
    func mostrarMensagem(titulo:String, mensagem:String) {
        let alerta = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        
        alerta.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alerta, animated: true, completion: nil)
    }
    @IBAction func compartilhar(){
        let alerta = UIAlertController(title: "Compartilhar", message: "Escolha onde compartilhar", preferredStyle: .actionSheet)
        
        let emailAction = UIAlertAction(title: "E-mail", style: .default, handler: { action -> Void in self.compartilharEmail()})
        alerta.addAction(emailAction)
        
        let whatsappAction = UIAlertAction(title: "Whatsapp", style: .default, handler: {action -> Void in self.compartilharWhatsapp()})
        alerta.addAction(whatsappAction)
        
        let voltarAction = UIAlertAction(title: "Voltar", style: .cancel, handler: nil)
        alerta.addAction(voltarAction)
        
        let exibirAction = UIAlertAction(title: "Exibir", style: .default, handler: { action -> Void in self.mostrarMensagem(titulo: "Pos Alfa", mensagem: self.mensagemCompartilhar())})
        alerta.addAction(exibirAction)
        
        self.present(alerta, animated: true, completion: nil)
    }
    
    func mensagemCompartilhar() -> String {
        return "Valor da gasolina: \(campoGasolina.text!). Valor etanol: \(campoEtanol.text!)."
    }
    
    func compartilharEmail() {
        if (MFMailComposeViewController.canSendMail()){
            let compose = MFMailComposeViewController()
            compose.mailComposeDelegate = self
            
            compose.setToRecipients(["ronilsonpinheiro@gmail.com"])
            compose.setSubject("Assunto do E-mail")
            compose.setMessageBody("Mensagem: \(mensagemCompartilhar())", isHTML: false)
            compose.addAttachmentData(UIImageJPEGRepresentation(UIImage(named: "image.jpg")!, CGFloat(1.0))!, mimeType: "image.jpeg", fileName: "imagem.jpg")
            
            self.present(compose, animated: true, completion: nil)
        }
    }
    
    //fechar tela de email
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
       controller.dismiss(animated: true, completion: nil)
    }
    
    func compartilharWhatsapp() {
        let link = "whatsapp://send?text="
        
        if let chamarLink = URL(string:link) {
            UIApplication.shared.open(chamarLink, options: [:], completionHandler: nil)
        }
    }
}
