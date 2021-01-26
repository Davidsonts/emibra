//
//  HomeViewController.swift
//  EmibraRA
//
//  Created by Davidson Santos on 17/12/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import AVKit

class HomeViewController: UIViewController {
//    @IBOutlet weak var myWebView: UIWebView!
    // @IBOutlet weak var videoWebView: UIWebView!
    
    @IBAction func btnPlay(_ sender: Any) {
        getVideo(videoCode: video4)
    }
    
    @IBAction func btnCompra(_ sender: Any) {
        getVideo(videoCode: video2)
    }
    
    @IBAction func btnPED(_ sender: Any) {
        getVideo(videoCode: video3)
    }
    
    @IBAction func btnPlanejamento(_ sender: Any) {
        getVideo(videoCode: video1)
    }
    
    let video1 = "https://vittapet.s3-sa-east-1.amazonaws.com/emibra/video1.mp4" // planejamento

    let video2 = "https://vittapet.s3-sa-east-1.amazonaws.com/emibra/video2.mp4" // compras

    let video3 = "https://vittapet.s3-sa-east-1.amazonaws.com/emibra/video3.mp4" // P&D

    let video4 = "https://vittapet.s3-sa-east-1.amazonaws.com/emibra/video4.mp4" // connect
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getVideo(videoCode: video1)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getVideo(videoCode:String)
    {
        // let url = URL(string: "https://www.youtube.com/embed/\(videoCode)")
        //let url = URL(string: "\(videoCode)")
//        videoWebView.allowsInlineMediaPlayback = true
//        videoWebView.allowsLinkPreview = true
//        videoWebView.loadRequest(URLRequest(url: url!))
//
//        let html = "<video playsinline controls poster='/Assets.xcassets/Fundo 2.png' preload autoplay width=\"98%\" src=\"\(videoCode)\"> </video>"
//        self.videoWebView.loadHTMLString(html, baseURL: nil)
        
        let url = URL(string: "\(videoCode)")
        let player = AVPlayer(url: url!)
        let vc = AVPlayerViewController()
        vc.player = player

        present(vc, animated: true) {
            vc.player?.play()
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
