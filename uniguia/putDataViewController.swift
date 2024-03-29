//
//  putDataViewController.swift
//  uniguia
//
//  Created by student on 29/05/19.
//  Copyright © 2019 student. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class putDataViewController: UIViewController, CLLocationManagerDelegate {
    @IBAction func botao(_ sender: Any) {
        func getEventos () {
            
            let endpoint: String = "https://uniguia.mybluemix.net/events"
            
            guard let url = URL(string: endpoint) else {
                print("Erroooo: Cannot create URL")
                return
            }
            
            let urlRequest = URLRequest(url: url)
            
            let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                
                if error != nil {
                    print("Error = \(String(describing: error))")
                    return
                }
                
                let responseString = String(data: data!, encoding: String.Encoding.utf8)
                print("responseString = \(String(describing: responseString))")
                
                DispatchQueue.main.sync() {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [[String: AnyObject]] {
                            
                            
                            let evento = Eventos(json: json[0])
                            
                            let nomelocal = evento.local
                            let nometitle = evento.title
                            
                            print("\(nomelocal) realizado em \(nometitle). ")
                            
                            
                        }else {
                            
                            print("Erro")
                        }
                    } catch let error as NSError {
                        print("Error = \(error.localizedDescription)")
                    }
                }
                
                
            })
            
            task.resume()
        }

    }
let locationManager = CLLocationManager()
var userLocation = CLLocation()

    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.showsUserLocation = true
        setupLocationManager()
        addGesture()
        
    }
    func setupLocationManager () {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    func zoomIn() {
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let region: MKCoordinateRegion = MKCoordinateRegionMake(userLocation.coordinate, span)
        mapView.setRegion(region, animated: true)
    }
    func addGesture() {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(addAnnotationToMap(gestureRecognizer:)))
        longPress.minimumPressDuration = 1.0
        mapView.addGestureRecognizer(longPress)
    }
    func addAnnotationToMap(gestureRecognizer: UIGestureRecognizer) {
        let touchPoint = gestureRecognizer.location(in: self.mapView)
        let newCoordinate: CLLocationCoordinate2D = mapView.convert(touchPoint, toCoordinateFrom: self.mapView)
        let newAnnotation = MKPointAnnotation()
        newAnnotation.coordinate = newCoordinate
        newAnnotation.title = "Novo local"
        newAnnotation.subtitle = "Informações"
        mapView.addAnnotation(newAnnotation)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations.last!
        print("Localização atual = ", userLocation.coordinate)
        zoomIn()
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Erro ao obter a localização do usuário: ", error)
    }
}
