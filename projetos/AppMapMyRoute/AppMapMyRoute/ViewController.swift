//
//  ViewController.swift
//  AppMapMyRoute
//
//  Created by Davi Orzechowski on 24/05/24.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {

    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var speedLabel: UILabel!
    private var locationManager:CLLocationManager?
    private var currentLocation = CLLocation()
    private var startLocation = CLLocation()

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        map.showsUserLocation = true
        map.delegate = self
        map.isZoomEnabled = true
    }
    override func viewWillAppear(_ animated: Bool) {
        if(locationManager != nil){
            locationManager?.startUpdatingLocation()
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        if(locationManager != nil){
            locationManager?.stopUpdatingLocation()
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.last ?? CLLocation()
        let speed = currentLocation.speed
        let speedkm = speed * 3.6
        speedLabel.text = String.init(format: "Velocidade: %.0f km/h", speedkm)
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = MKMapItem(placemark: MKPlacemark(coordinate: startLocation.coordinate))
        directionRequest.destination = MKMapItem(placemark: MKPlacemark(coordinate: currentLocation.coordinate))
        directionRequest.transportType = .automobile
        let directions = MKDirections(request: directionRequest)
        directions.calculate(completionHandler: {
            response,error in
            if error != nil {
                print("Error: \(error!)")
                return
            }
            let route = response?.routes[0]
            self.map.addOverlay((route!.polyline),level: MKOverlayLevel.aboveRoads)
        })
        
    }
    func mapView(_ mapView: MKMapView, rendererFor overlay: any MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .red
        renderer.lineWidth = 5.0
        return renderer
    }
    @IBAction func centralizar(_ sender: Any) {
        let center = CLLocationCoordinate2D(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))
        self.map.setRegion(region, animated: true)
    }
    
    @IBAction func inicio(_ sender: Any) {
        map.removeAnnotations(map.annotations)
        map.removeOverlays(map.overlays)
        let annotation = MKPointAnnotation()
        annotation.coordinate = currentLocation.coordinate
        startLocation = currentLocation
        annotation.title = "Inicio"
        self.map.addAnnotation(annotation)
        
    }
}

