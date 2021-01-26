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
    
    
    struct DemoData: Decodable {
        let title: String
        let latitude: String
        let longitude: String
    }
    
    var locations = [
        ["title": "Emibra, R. Maj. Pinheiro Fróes, 2300 - Vila Maria de Maggi, Suzano - SP", "latitude": -23.5222096, "longitude": -46.8754915],
        ["title": "R. Doná Olinda de Albuquerque, 60 - Jardim São Paulo, Guarulhos - SP", "latitude": -23.3918537, "longitude": -46.5933868],
        ["title": "Emibra, R. Curitiba, 605 - Centro, Belo Horizonte - MG", "latitude": -19.9023384, "longitude": -44.1044799],
        ["title": "Emibra, Rua Dom Pedro II 95 - Terreo, Alagoinhas - BA", "latitude": -9.416138, "longitude": -40.5012151],
        ["title": "Emibra, R.Gen. Sampaio, 1267 - Centro, Fortaleza - CE", "latitude": -3.7900979, "longitude": -38.5889871],
        ["title": "Emibra, Av. Pref. Erasto Gaertner, 148 - Bacacheri, Curitiba - PR", "latitude": -25.4950501, "longitude": -49.4298832]
    ]
    
//    var locations =
//        [
//            ["title": "", "latitude": -23.5222096, "longitude": -46.8754915]
//        ]
    
    @IBOutlet weak var mapView: MKMapView!
    
    let annotation = MKPointAnnotation()
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        if let localData = self.readLocalFile(forName: "data") {
//            self.parse(jsonData: localData)
//        }
        
//        let urlString = "https://emibra.com.br/appJson/data.json"
//
//        self.loadJson(fromURLString: urlString) { (result) in
//            switch result {
//            case .success(let data):
//                self.parse(jsonData: data)
//            case .failure(let error):
//                print(error)
//            }
//        }
        
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

    override func viewWillAppear(_ animated: Bool) {
        // dataSource?.bind(to: linksTableView)
         self.yourTableView.reloadData()
     }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var cell : UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        }
        
        if self.locations.count > 0 {
            if self.locations[indexPath.row]["title"] as! String != "" {
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
        }
        cell?.textLabel?.numberOfLines = 0
        cell?.textLabel?.backgroundColor = UIColor.clear

        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
        
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
    
    
    /// JSON
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
    
    private func loadJson(fromURLString urlString: String,
                          completion: @escaping (Result<Data, Error>) -> Void) {
        if let url = URL(string: urlString) {
            let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                }
                
                if let data = data {
                    completion(.success(data))
                }
            }
            
            urlSession.resume()
        }
    }

    private func parse(jsonData: Data) {
        do {
            // let myIndexPath = IndexPath(row: 1, section: 0)
            // self.yourTableView.deleteRows(at: [myIndexPath], with: .automatic)
             
            let result = try JSONDecoder().decode([String:DemoData].self, from: jsonData)
            
            for (key, value) in result {
//                print(key, value.title)
                
                self.locations.append(["title": value.title, "latitude": Double(value.latitude), "longitude": Double(value.longitude)])
            }
            
           // self.yourTableView.reloadData()
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

             
        } catch let erro {
            print("decode error  \(erro.self)")
        }
        
       /// self.yourTableView.reloadData()
    }
}

