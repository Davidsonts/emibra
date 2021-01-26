//
//  ChatViewController.swift
//  EmibraRA
//
//  Created by Davidson Santos on 18/01/21.
//  Copyright © 2021 Apple. All rights reserved.
//

import UIKit
import WebKit

class ChatViewController: UIViewController, WKUIDelegate {

    @IBOutlet weak var mWKWebView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        mWKWebView = WKWebView(frame: .zero, configuration: webConfiguration)
        mWKWebView.uiDelegate = self
        view = mWKWebView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let myURL = URL(string:"https://tawk.to/emibra")
                let myRequest = URLRequest(url: myURL!)
        mWKWebView.load(myRequest)
    }
    
    
    /// CHECK INTERNET
    func Alert (Message: String){
        
        let alert = UIAlertController(title: "Alert", message: Message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    /// CHECK INTERNET
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        if (ARConfiguration.isSupported) {
//
//              // Great! let have experience of ARKIT
//        } else {
//             // Sorry! you don't have ARKIT support in your device
//
//        }
        
        if CheckInternet.Connection(){
            
            // self.Alert(Message: "Connected")
            
        }
        
        else{
            
            self.Alert(Message: "Seu dispositivo não está conectado à internet")
        }
        
        // Prevent the screen from being dimmed to avoid interuppting the AR experience.
        UIApplication.shared.isIdleTimerDisabled = true

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
