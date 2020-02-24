//
//  MapViewController.swift
//  AirAsiaAirportLocator
//
//  Created by Tarang Kaneriya on 21/02/20.
//  Copyright © 2020 Tarang Kaneriya. All rights reserved.
//

import UIKit
import MapKit

// Map Viewcontroller
class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var gpsButton: UIButton!

    // MapViewModel
    private(set) lazy var viewModel: MapViewModel<MapViewController> = {
        let _viewModel = MapViewModel(locationProvider: airportLocationProvider, requestManager: airportRequestManager, listener: self)
        return _viewModel
    }()

    // Location Provider
    private(set) lazy var airportLocationProvider: LocationProvidable = {
        let _locationProvider = LocationProvider(locationManager: locationManager)
        return _locationProvider
    }()

    // Airport Request Manager
    private(set) lazy var airportRequestManager: RequestManager = {
        let _requestManager = RequestManager()
        return _requestManager
    }()

    // Location Manager
    private(set) lazy var locationManager: LocationManagerConfigurable = {
        let _clLocationManager = CLLocationManager()
        return _clLocationManager
    }()

    let regionRadius: CLLocationDistance = 30.milesToMeters()

    //Viewcontroller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
        bindViewModel()
    }


    func updateUI() {

        title = "Airport Locator"
        navigationController?.navigationBar.setTitltColor(.white)

        gpsButton.layer.shadowColor = UIColor.black.cgColor
        gpsButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        gpsButton.layer.shadowRadius = 5
        gpsButton.layer.shadowOpacity = 0.5
    }

    // Binding View with viewModel
    func bindViewModel() {

        // Observing Airport List to show
        viewModel.didUpdate = { [weak self] _ in
            guard let strongSelf = self else { return }

            for location in strongSelf.viewModel.airportLocationList {
                print("Location.coordinate: \(location.coordinate.latitude) : \(location.coordinate.longitude)")
                DispatchQueue.main.async { [weak self] in
                    self?.mapView.addAnnotation(location)
                }
            }
        }

        // Observing errors to show
        viewModel.onError = { (error) in
            switch error {
            case .internetError(let message):
                MessageView.sharedInstance.showOnView(message: message, theme: .error)
            case .serverMessage(let message):
                MessageView.sharedInstance.showOnView(message: message, theme: .warning)
            }
        }

    }

    // Reset to Current Location
    @IBAction func resetLocation(_ sender: Any) {
        viewModel.centerMapToCurrentLocationAction()
        viewModel.getAirports()
    }

    // Set Current Location Region
    func centerMapOnLocation(location: CLLocation) {
        
        let coordinateRegion = MKCoordinateRegion.init(center: location.coordinate,
                                                       latitudinalMeters: regionRadius,
                                                       longitudinalMeters: regionRadius)
        DispatchQueue.main.async { [weak self] in
            self?.mapView.setRegion(coordinateRegion, animated: true)
        }
    }
}


// MARK: - MapViewModelObsevable Extension

extension MapViewController: MapViewModelObservable{

    typealias Airport = AirportLocation

    func addLocationToMap(location: Airport) { }

    func setCurrentLocation(latitude: Double, longitude: Double) {
        print("current latitude: \(latitude), longitude: \(longitude)")
        let currentLocation = CLLocation(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude))
        centerMapOnLocation(location: currentLocation)
        viewModel.getAirports()
    }

    func centerMapToCurrentLocation(latitude: Double, longitude: Double) {
        let currentLocation = CLLocation(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude))
        centerMapOnLocation(location: currentLocation)
    }
}

// MARK: - MKMapView Delegate

extension MapViewController: MKMapViewDelegate {

    //Creating MKAnnotationView
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        guard let annotation = annotation as? AirportLocation else {
            return nil
        }

        let identifier = "marker"
        var view: MKMarkerAnnotationView

        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            let mapsButton = UIButton(type: .detailDisclosure)
            mapsButton.setBackgroundImage(UIImage(named: "Maps-icon"), for: UIControl.State())
            view.rightCalloutAccessoryView = mapsButton
            let detailLabel = UILabel()
            detailLabel.numberOfLines = 0
            detailLabel.font = detailLabel.font.withSize(12)
            detailLabel.text = "Distance from Current Location \(annotation.relativeTo.distanceKM) km"
            view.detailCalloutAccessoryView = detailLabel
        }
        return view
    }

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {

        guard let location = view.annotation as? AirportLocation else {
            return
        }
        
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
}
