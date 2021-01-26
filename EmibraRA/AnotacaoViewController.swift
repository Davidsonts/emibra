//
//  AnotacaoViewController.swift
//  EmibraRA
//
//  Created by Davidson Santos on 26/01/21.
//  Copyright © 2021 Apple. All rights reserved.
//

import UIKit
import CoreData

class AnotacaoViewController: UIViewController {
    var context: NSManagedObjectContext!
    var anotacao: NSManagedObject!
    
    @IBOutlet weak var texto: UITextView!
    
    @IBAction func salvar(_ sender: Any) {
        if anotacao != nil { // UPDATE
            self.atualizarAnotacao()
        }else{
            self.salvarAnotacao()
        }
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.texto.becomeFirstResponder()
        if anotacao != nil { // ATUALIZAR
            if let textoRecuperado = anotacao.value(forKey: "texto") {
                self.texto.text = String(describing: textoRecuperado)
            }
        } else {
            self.texto.text = ""
        }
       
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        // Do any additional setup after loading the view.
    }
    
    func salvarAnotacao() {
        let novaAnotacao = NSEntityDescription.insertNewObject(forEntityName: "Anotacao", into: context)
        
        novaAnotacao.setValue(self.texto.text, forKey: "texto")
        novaAnotacao.setValue(Date(), forKey: "data")
        
        do {
            try context.save()
            print("Sucesso ao Salvar Anotação!")
        } catch let erro {
            print("Erro ao Salvar: \(erro.localizedDescription)")
        }
    }
    
    func atualizarAnotacao() {
        anotacao.setValue(self.texto.text, forKey: "texto")
        anotacao.setValue(Date(), forKey: "data")
        
        do {
            try context.save()
            print("Sucesso ao Atualizar Anotação!")
        } catch let erro {
            print("Erro ao Salvar: \(erro.localizedDescription)")
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
