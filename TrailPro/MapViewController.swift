//
//  MapViewController.swift
//  TrailPro
//
//  Created by Molly Tian on 2/10/17.
//  Copyright © 2017 Molly Tian. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

//    MARK: - Outlets
    
    @IBOutlet weak var mapView: MKMapView!
    var locationManager: CLLocationManager?
    
//    MARK: - Properties
    
    var trail = Trail()
    
//    MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.mapType = MKMapType.standard
        
        locationManager = CLLocationManager()
        locationManager!.delegate = self
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            locationManager!.startUpdatingLocation()
        } else {
            locationManager!.requestWhenInUseAuthorization()
        }
        
        let latDelta = trail.overlayTopLeftCoordinate.latitude - trail.overlayBottomRightCoordinate.latitude
        let span = MKCoordinateSpanMake(fabs(latDelta), 0.0)
        let region = MKCoordinateRegionMake(trail.midCoordinate, span)
        
        mapView.region = region
        
        let currentLocationButton = MKUserTrackingBarButtonItem(mapView: mapView)
        navigationItem.rightBarButtonItem = currentLocationButton
        
        addOverlay()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    MARK: - Private
    func addOverlay() {
        let overlay = TrailMapOverlay(trail: trail)
        mapView.add(overlay)
    }
    


}

extension MapViewController: MKMapViewDelegate, CLLocationManagerDelegate{
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is TrailMapOverlay {
            let magicMountainImage = UIImage(named: "WalnutCreek")
            let overlayView = TrailMapOverlayView(overlay: overlay, overlayImage: magicMountainImage!)
            
            return overlayView
        }
        return MKOverlayPathRenderer()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            print("NotDetermined")
        case .restricted:
            print("Restricted")
        case .denied:
            print("Denied")
        case .authorizedAlways:
            print("AuthorizedAlways")
        case .authorizedWhenInUse:
            print("AuthorizedWhenInUse")
            locationManager!.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first!
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 500, 500)
        mapView.setRegion(coordinateRegion, animated: true)
        locationManager?.stopUpdatingLocation()
        locationManager = nil
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to initialize GPS: ", error.localizedDescription)
    }
}
