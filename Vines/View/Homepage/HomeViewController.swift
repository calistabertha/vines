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
import iCarousel

class HomeViewController: UIViewController {
    
    @IBOutlet weak var viewMaps: GMSMapView!
    @IBOutlet weak var viewTransparantTop: UIView!
    @IBOutlet weak var viewTransparantBottom: UIView!
    @IBOutlet weak var viewSeeAllStore: UIView!
    @IBOutlet weak var carouselView: iCarousel!
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var viewMore: UIView!
    @IBOutlet weak var txtSearch: UITextField!{
        didSet{
            txtSearch.delegate = self
        }
    }
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var contentView: UIView!
    
    var tableDataSource: GMSAutocompleteTableDataSource?
    var locationManager:CLLocationManager?
    
    var counter: Int = 0
    
    // API Data
    var promotionList: [PromotionModelData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(tap)
        let change = UITapGestureRecognizer(target: self, action: #selector(changeEnvironment))
        imgLogo.addGestureRecognizer(change)
        imgLogo.isUserInteractionEnabled = true
        
        setupView()
        setupCarousel()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        fetchPromotions()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupLocation()
    }
    
    private func setupLocation() {
        locationManager = CLLocationManager()
        // Ask for Authorisation from the User.
        self.locationManager?.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager?.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager?.delegate = self
            locationManager?.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager?.startUpdatingLocation()
        }
    }
    
    private func setupView() {
        viewMore.layer.cornerRadius = 10
        viewSeeAllStore.layer.cornerRadius = 15
        viewSearch.layer.cornerRadius = 5
        viewSearch.layer.borderColor = UIColor.black.cgColor
        viewSearch.layer.borderWidth = 1
        
        let topLayer = CAGradientLayer()
        topLayer.frame = self.viewTransparantTop.bounds;
        topLayer.colors = [UIColor.black.withAlphaComponent(1).cgColor, UIColor.white.withAlphaComponent(0.7).cgColor, UIColor.white.withAlphaComponent(0).cgColor]
        topLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        topLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        self.viewTransparantTop.layer.mask = topLayer
        
        let botomLayer = CAGradientLayer()
        botomLayer.frame = self.viewTransparantBottom.bounds;
        botomLayer.colors = [UIColor.black.withAlphaComponent(1).cgColor, UIColor.white.withAlphaComponent(0.7).cgColor, UIColor.white.withAlphaComponent(0).cgColor ]
        botomLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        botomLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        self.viewTransparantBottom.layer.mask = botomLayer
        
        let camera = GMSCameraPosition.camera(withLatitude: -11.0, longitude: 13.0, zoom: 6)
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
    
    @IBAction func profileButtonDidPush(_ sender: Any) {
        let vc = ProfileSwipeViewController()
        vc.promotionList = promotionList
        contentView.addSubview(vc.view)
        self.addChildViewController(vc)
        vc.delegate = self
        vc.didMove(toParentViewController: self)

    }
    
    @IBAction func seeStoreButtonDidPush(_ sender: Any) {
        let vc = AllStoreViewController()
        guard let location = self.locationManager?.location else { return }
        vc.location = location
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func moreButtonDidPush(_ sender: Any) {
        let vc = PromotionsViewController()
        vc.promotionList = self.promotionList
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func changeEnvironment() {
        print(userDefault().isDebug())
        if counter >= 3 {
            counter = 0
            userDefault().changeEnvironment()
            UIAlertController
                .yesOrNoAlert(self,
                              title: "Environment Changed to \(userDefault().isDebug() == true ? "Debug" : "Production")",
                              message: nil,
                              okButtonTitle: "OK",
                              noButtonTitle: nil,
                              no: nil,
                              yes: nil)
        }
        counter += 1
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

extension HomeViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        
        let camera = GMSCameraPosition.camera(withLatitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude, zoom: 14)
        
        // Animate still not working.
        self.viewMaps?.camera = camera
        self.viewMaps?.animate(to: camera)
        
        //Finally stop updating location otherwise it will come again and again in this delegate
        self.locationManager?.stopUpdatingLocation()
    }
}

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

extension HomeViewController: ProfileSwipeDelegate{
    func dismissView(controller: ProfileSwipeViewController) {
        controller.willMove(toParentViewController: nil)
        controller.view.removeFromSuperview()
    }
}

extension HomeViewController: iCarouselDelegate, iCarouselDataSource {
    func setupCarousel() {
        carouselView.type = .linear
        carouselView.isPagingEnabled = false
        carouselView.delegate = self
        carouselView.dataSource = self
        carouselView.bounces = false
        carouselView.stopAtItemBoundary = true
        
        carouselView.backgroundColor = UIColor.clear
        carouselView.reloadData()
    }
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return self.promotionList.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let view: BannerView = BannerView.instantiateFromNib()
        let data = self.promotionList[index]
        let width = UIScreen.main.bounds.width / 2.2
        view.frame = CGRect(x: 0, y: 0, width: width, height: self.carouselView.bounds.height)
        view.backgroundColor = UIColor(white: 1, alpha: 0.0)
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.bannerImage.af_setImage(withURL: URL(string: data.image!)!, placeholderImage: UIImage(named: "placeholder")) { image in
            if let img = image.value {
                view.bannerImage.image = img
            } else {
                view.bannerImage.image = UIImage(named: "placeholder")
            }
        }
        return view
    }
    
    func carousel(_ carousel: iCarousel, didSelectItemAt index: Int) {
        let vc = DetailPromoViewController()
        vc.data = self.promotionList[index]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        switch (option) {
        case .wrap:
            return 0
        case .spacing:
            return value * 1.1
        default:
            return value
        }
    }
}

extension HomeViewController {
    private func fetchPromotions() {
        let params = [
            "limit": 10,
            ] as [String : Any]
        HTTPHelper.shared.requestAPI(url: Constants.ServicesAPI.Promotion.promotion, param: params, method: HTTPMethodHelper.post) { (success, json) in
            let data = PromotionModelBaseClass(json: json!)
            if data.message == "success", let datas = data.data {
                self.promotionList = datas
                self.carouselView.reloadData()
            } else {
                print(data.displayMessage!)
            }
        }
    }
}
