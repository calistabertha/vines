//
//  HomeViewController.swift
//  Vines
//
//  Created by Calista Bertha on 07/10/18.
//  Copyright © 2018 Calista Bertha. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class HomeViewController: UIViewController {

    @IBOutlet weak var viewMaps: GMSMapView!
    @IBOutlet weak var viewTransparantTop: UIView!
    @IBOutlet weak var viewTransparantBottom: UIView!
    @IBOutlet weak var viewSeeAllStore: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var viewHistory: UIView!
    @IBOutlet weak var txtSearch: UITextField!{
        didSet{
            txtSearch.delegate = self
        }
    }
    
    var tableDataSource: GMSAutocompleteTableDataSource?
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(tap)
        setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupView() {
        viewHistory.layer.cornerRadius = 10
        viewSeeAllStore.layer.cornerRadius = 15
        viewSearch.layer.cornerRadius = 5
        viewSearch.layer.borderColor = UIColor.black.cgColor
        viewSearch.layer.borderWidth = 1
        
        let topLayer = CAGradientLayer()
        topLayer.frame = self.viewTransparantTop.bounds;
        topLayer.colors = [UIColor.white.withAlphaComponent(0.7).cgColor, UIColor.white.withAlphaComponent(0).cgColor ]
        topLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        topLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        self.viewTransparantTop.layer.mask = topLayer
        
        let botomLayer = CAGradientLayer()
        botomLayer.frame = self.viewTransparantBottom.bounds;
        botomLayer.colors = [UIColor.black.withAlphaComponent(1).cgColor, UIColor.white.withAlphaComponent(0.7).cgColor, UIColor.white.withAlphaComponent(0).cgColor ]
        botomLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        botomLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        self.viewTransparantBottom.layer.mask = botomLayer
        
//        self.locationManager.delegate = self
//        self.locationManager.startUpdatingLocation()
//        viewMaps.delegate = self
        
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true

        self.viewMaps.camera = camera
        self.viewMaps = mapView

        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(-33.86, 151.20)
        marker.title = "title"
        marker.snippet = "snippet"
        marker.icon = UIImage(named: "ico-PinPoint")
        marker.map = mapView
    }
    
    @objc func hideKeyboard() {
        viewBackground.isHidden = true
        self.view.endEditing(true)
    }
    
    @IBAction func menuButtonDidPush(_ sender: Any) {
    }
    
    @IBAction func seeStoreButtonDidPush(_ sender: Any) {
        let storyboard = UIStoryboard(name: Constants.StoryboardReferences.home, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: Constants.ViewControllerID.Homepage.allStore)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        viewBackground.isHidden = false
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       // viewBackground.isHidden = true
        self.view.endEditing(true)
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let acController = GMSAutocompleteViewController()
        acController.delegate = self
        self.present(acController, animated: true, completion: nil)
    }
}

//extension HomeViewController: CLLocationManagerDelegate{
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//
//        let location = locations.last
//
//        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude:(location?.coordinate.longitude)!, zoom:14)
//        viewMaps.animate(to: camera)
//
//        //Finally stop updating location otherwise it will come again and again in this delegate
//        self.locationManager.stopUpdatingLocation()
//
//    }
//}

//extension HomeViewController: GMSMapViewDelegate{
//    func mapViewDidFinishTileRendering(_ mapView: GMSMapView) {
//        let location = mapView.myLocation
//        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude:(location?.coordinate.longitude)!, zoom:14)
//        mapView.animate(to: camera)
//
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2DMake((location?.coordinate.latitude)!, (location?.coordinate.longitude)!)
//        marker.title = "title"
//        marker.snippet = "snippet"
//        marker.icon = UIImage(named: "ico-PinPoint")
//        marker.map = mapView
//    }
//}

extension HomeViewController: GMSAutocompleteViewControllerDelegate {
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        print("Place name: \(place.name)")
        print("Place address: \(place.formattedAddress ?? "null")")
        self.txtSearch.text = place.formattedAddress
        print("Place attributions: \(String(describing: place.attributions))")
        
        self.dismiss(animated: true, completion: nil)
    }
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        //        print("Error: \(error.description)")
        self.dismiss(animated: true, completion: nil)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        print("Autocomplete was cancelled.")
        self.dismiss(animated: true, completion: nil)
    }
}
