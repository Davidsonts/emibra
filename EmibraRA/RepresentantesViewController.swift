//
//  RepresentantesViewController.swift
//  EmibraRA
//
//  Created by Davidson Santos on 18/01/21.
//  Copyright © 2021 Apple. All rights reserved.
//

import UIKit
import MapKit

class RepresentantesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    // 2
    // var yourTableView:UITableView = UITableView()
    @IBOutlet weak var yourTableView: UITableView!
    
    let locations = [
        ["title": "Emibra, Vila Maria de Maggi, Suzano - SP", "latitude": -23.5222096, "longitude": -46.8754915],
        ["title": "Emibra, São Paulo", "latitude": -23.561496, "longitude": -46.655939],
        ["title": "Emibra, Guarulhos - SP", "latitude": -23.3918537, "longitude": -46.5933868],
        ["title": "Emibra, Belo Horizonte - MG", "latitude": -19.9023384, "longitude": -44.1044799],
        ["title": "Emibra, Bahia - BA", "latitude": -9.416138, "longitude": -40.5012151],
        ["title": "Emibra, Fortaleza - CE", "latitude": -3.7900979, "longitude": -38.5889871],
        ["title": "Emibra, Curitiba - PR", "latitude": -25.4950501, "longitude": -49.4298832]
    ]
    
    @IBOutlet weak var mapView: MKMapView!
    
    let annotation = MKPointAnnotation()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let coordinate = CLLocationCoordinate2D(latitude: -23.5222096, longitude: -46.8754915)
        let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
        
        for location in locations {
            let annotation = MKPointAnnotation()
            annotation.title = location["title"] as? String
            annotation.coordinate = CLLocationCoordinate2D(latitude: location["latitude"] as! Double, longitude: location["longitude"] as! Double)
            mapView.addAnnotation(annotation)
        }
        
        self.yourTableView.backgroundColor = UIColor.clear
    
//        // 3
//        yourTableView.frame = CGRect(x: 0, y: 400, width: view.frame.width-0, height: view.frame.height-200)
//        self.view.addSubview(yourTableView)
//
//        // 4
        yourTableView.dataSource = self
        yourTableView.delegate = self
        
    }
    // 5
    // MARK - UITableView Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var cell : UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        }
        if self.locations.count > 0 {
            cell?.textLabel!.text = self.locations[indexPath.row]["title"] as! String
            cell?.backgroundColor = UIColor.clear
            //cell?.backgroundColor = UIColor.red
            
            //Use button
            let useButton = UIButton(frame: CGRect(x: 8, y: 4.5, width: 5000, height: 28))
            cell?.addSubview(useButton)
            useButton.setTitle(locations[indexPath.row]["title"] as! String, for: .normal)
            // useButton.center.y = tableView.cell.center.y
            useButton.tag = indexPath.row
            useButton.addTarget(self, action: #selector(useMaker), for: .touchUpInside)
            // cell?.textLabel?.text = ("\t" + locations[indexPath.row])
            
        }
        cell?.textLabel?.numberOfLines = 0
        cell?.textLabel?.backgroundColor = UIColor.clear

        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
//    func tableView(_ tableView: UITableView,
//                   didSelectRowAt indexPath: IndexPath) {
//        self.scrollToTop()
//    }
//
//    private func scrollToTop() {
//        let topRow = IndexPath(row: 0,
//                               section: 0)
//        self.yourTableView.scrollToRow(at: topRow,
//                                   at: .top,
//                                   animated: true)
//    }
    
    @objc func useMaker(_ sender: UIButton) {
         let indexPathRow = sender.tag
        // Do any additional setup after loading the view.
        let coordinate = CLLocationCoordinate2D(latitude: locations[indexPathRow]["latitude"] as! CLLocationDegrees, longitude: locations[indexPathRow]["longitude"] as! CLLocationDegrees)
        let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
        
        // print("The maker to use is \(locations[indexPathRow]["title"] as! String)")
     }
    
    func geocode(latitude: Double, longitude: Double, completion: @escaping (_ placemark: [CLPlacemark]?, _ error: Error?) -> Void)  {
        CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: latitude, longitude: longitude), completionHandler: completion)
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

