//
//  MapViewController.swift
//
//  Created by Serhii
//


import UIKit
import GoogleMaps
import CoreLocation
import GooglePlaces
import Alamofire
import SwiftyJSON

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchLabel: UILabel!
    @IBOutlet weak var arButton: UIButton!
    
    var locationManager = CLLocationManager()
    var currentLocation = CLLocationCoordinate2D()
    var destinationLocation = CLLocationCoordinate2D()
    
    override func viewDidLayoutSubviews() {
        searchView.layer.cornerRadius = 12
        searchView.layer.borderWidth = 1
        searchView.layer.borderColor = UIColor.black.cgColor
        arButton.layer.cornerRadius = 25
        arButton.layer.borderWidth = 1
        arButton.layer.borderColor = UIColor.black.cgColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.bringSubviewToFront(backButton)
        setupLocationManager()
        
        let tapOnSearch = UITapGestureRecognizer(target: self, action: #selector(onSearchViewPressed(_:)))
        searchView.addGestureRecognizer(tapOnSearch)
    }

    @IBAction func onBackButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    private func makeRouteUrl() -> String {
        
        return "https://maps.googleapis.com/maps/api/directions/json?origin=\(currentLocation.latitude),\(currentLocation.longitude)&destination=\(destinationLocation.latitude),\(destinationLocation.longitude)&mode=driving&key=\(Constants.googleMapsKey)"
    }
    
    private func buildRoute() {
        let url = makeRouteUrl()
        print("in map destinationLocation= \(destinationLocation)")
        AF.request(url).responseJSON { (reseponse) in
                   guard let data = reseponse.data else {
                       return
                   }
                   do {
                       let jsonData = try JSON(data: data)
                       let routes = jsonData["routes"].arrayValue
                       
                       for route in routes {
                           let overview_polyline = route["overview_polyline"].dictionary
                           let points = overview_polyline?["points"]?.string
                           let path = GMSPath.init(fromEncodedPath: points ?? "")
                           let polyline = GMSPolyline.init(path: path)
                           polyline.strokeColor = .systemBlue
                           polyline.strokeWidth = 5
                           polyline.map = self.mapView
                       }
                   }
                    catch let error {
                       print(error.localizedDescription)
                   }
               }
        
        // MARK: Marker for source location
        let sourceMarker = GMSMarker()
        sourceMarker.position = CLLocationCoordinate2D(latitude: currentLocation.latitude, longitude: currentLocation.longitude)
        sourceMarker.title = "Myself"
        sourceMarker.map = self.mapView
        
        
        // MARK: Marker for destination location
        let destinationMarker = GMSMarker()
        destinationMarker.position = CLLocationCoordinate2D(latitude: destinationLocation.latitude, longitude: destinationLocation.longitude)
        destinationMarker.title = searchLabel.text!
        destinationMarker.map = self.mapView
        
        
        let camera = GMSCameraPosition(target: currentLocation, zoom: 10)
        self.mapView.animate(to: camera)
    }

    
    private func setupLocationManager() {
        mapView?.isMyLocationEnabled = true
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
       }
    
    @objc func onSearchViewPressed(_ sender: UITapGestureRecognizer) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.primaryTextColor = UIColor.black
        autocompleteController.secondaryTextColor = UIColor.lightGray
        autocompleteController.tableCellSeparatorColor = UIColor.lightGray
        autocompleteController.tableCellBackgroundColor = UIColor.white
        autocompleteController.delegate = self

           // Specify the place data types to return.
           let fields: GMSPlaceField = GMSPlaceField(rawValue:UInt(GMSPlaceField.name.rawValue) |
                                                                                    UInt(GMSPlaceField.placeID.rawValue) |
                                                                                    UInt(GMSPlaceField.coordinate.rawValue) |
                                                                                    GMSPlaceField.addressComponents.rawValue |
                                                        GMSPlaceField.formattedAddress.rawValue)
           autocompleteController.placeFields = fields

           // Specify a filter.
           let filter = GMSAutocompleteFilter()
           filter.type = .address
           autocompleteController.autocompleteFilter = filter

           // Display the autocomplete view controller.
           present(autocompleteController, animated: true)
    }
    
    
    @IBAction func onArButtonPressed(_ sender: Any) {
    }
    
}
extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        currentLocation = location!.coordinate
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 10.0)

        mapView.animate(to: camera)
        locationManager.stopUpdatingLocation()
    }
}

//MARK: Google maps Delegate functions
extension MapViewController : GMSAutocompleteViewControllerDelegate {
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        searchLabel.text = place.name
        mapView.clear()
        destinationLocation =  place.coordinate
        dismiss(animated: true) {
            self.buildRoute()
        }
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        dismiss(animated: true, completion: nil)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        print("Autocomplete was cancelled.")
        self.dismiss(animated: true, completion: nil)
    }
}
