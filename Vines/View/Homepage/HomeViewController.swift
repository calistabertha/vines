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
    @IBOutlet weak var viewMaps: GMSMapView! {
        didSet {
            viewMaps.isMyLocationEnabled = true
            viewMaps.delegate = self
        }
    }
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
    @IBOutlet weak var viewUserLoc: UIView!
    
    var tableDataSource: GMSAutocompleteTableDataSource?
    var locationManager:CLLocationManager?
    let profileSwipeVC = ProfileSwipeViewController()
    
    var counter: Int = 0
   
    // API Data
    var promotionList: [PromotionModelData] = []
    var markerDict: [String: GMSMarker] = [:]
    var locations: CLLocation?
    var latitude = ""
    var longitude = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(tap)
        let change = UITapGestureRecognizer(target: self, action: #selector(changeEnvironment))
        imgLogo.addGestureRecognizer(change)
        imgLogo.isUserInteractionEnabled = true
        viewUserLoc.layer.cornerRadius = viewUserLoc.layer.frame.height / 2
        setupView()
        setupCarousel()
        setupLeftMenu()
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
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.distanceFilter = 50
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.startUpdatingLocation()
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
    }
    
    private func setupLeftMenu() {
        profileSwipeVC.delegate = self
        profileSwipeVC.view.frame = CGRect(x: -UIScreen.main.bounds.maxX, y: 0, width: contentView.bounds.width, height: contentView.bounds.height)
        contentView.addSubview(profileSwipeVC.view)
        self.addChildViewController(profileSwipeVC)
        profileSwipeVC.didMove(toParentViewController: self)
    }
    
    private func fetchStore(latitude: String, longitude: String) {
        let params = [
            "longitude": longitude,
            "latitude": latitude
            ] as [String : Any]
        HTTPHelper.shared.requestAPI(url: Constants.ServicesAPI.Store.list, param: params, method: HTTPMethodHelper.post) { [weak self] (success, json) in
            guard let `self` = self else { return }
            let data = StoreListModelBaseClass(json: json ?? "")
            if data.message?.lowercased() == "success" {
                guard let markers = data.data else { return }
                for marker in markers {
                    guard let markerLatitude = marker.latitude,
                        let markerLongitude = marker.longitude else { return }
                    
                    let memberLatitude = CLLocationDegrees(markerLatitude)
                    let memberLongitude = CLLocationDegrees(markerLongitude)
                    let memberCoordinate2D = CLLocationCoordinate2D(latitude: memberLatitude, longitude: memberLongitude)
                    
                    let pinPlaceholder = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
                    pinPlaceholder.image = UIImage(named: "ico-PinPoint")
                    
                    let gmsMarker = GMSMarker(position: memberCoordinate2D)
                    gmsMarker.userData = marker
                    gmsMarker.iconView = pinPlaceholder
                    gmsMarker.title = marker.name
                    gmsMarker.map = self.viewMaps
                }
            } else {
                print(data.displayMessage ?? "")
            }
        }
    }
    
    @objc func hideKeyboard() {
        viewBackground.isHidden = true
        self.view.endEditing(true)
    }
    
    @IBAction func profileButtonDidPush(_ sender: Any) {
        UIView.animate(withDuration: 0.25) {
            self.profileSwipeVC.view.frame = CGRect(x: 0, y: 0, width: self.contentView.bounds.width, height: self.contentView.bounds.height)
        }
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
    
    @IBAction func userLocationButtonDidPush(_ sender: Any) {
        guard let locationCoordinate = locations?.coordinate else {return}
        self.viewMaps.animate(to: GMSCameraPosition(target: locationCoordinate, zoom: 15, bearing: 0, viewingAngle: 0))
    }
    
    @objc func changeEnvironment() {
        print(userDefault().isDebug())
        if counter >= 3 {
            let vc = SuperSecretViewController()
            navigationController?.pushViewController(vc, animated: true)
//            counter = 0
//            userDefault().changeEnvironment()
//            let delegate = UIApplication.shared.delegate as! AppDelegate
//            delegate.logout()
//            UIAlertController
//                .yesOrNoAlert(self,
//                              title: "Environment Changed to \(userDefault().isDebug() == true ? "Debug" : "Production")",
//                              message: nil,
//                              okButtonTitle: "OK",
//                              noButtonTitle: nil,
//                              no: nil,
//                              yes: nil)
      
        }
        counter += 1
    }
    
    func getOderCode(storeData: StoreListModelData) {
        let params = [
            "user_id": userDefault().getUserID(),
            "token": userDefault().getToken()
            ]as [String: Any]
        
        HTTPHelper.shared.requestAPI(url: Constants.ServicesAPI.User.orderCode, param: params, method: HTTPMethodHelper.post) { (success, json) in
            if json!["message"] == "success" {
                userDefault().setOrderCode(code: json!["data"][0]["order_code"].stringValue)
                let vc = StoreViewController()
                vc.storeId = storeData.storeId ?? 0
                vc.storeName = storeData.name ?? ""
                self.navigationController?.pushViewController(vc, animated: true)
            }else {
                let alert = JDropDownAlert()
                alert.alertWith("Oopss..", message: "Please check your connection", topLabelColor: UIColor.white, messageLabelColor: UIColor.white, backgroundColor: UIColor(red: 125/255, green: 6/255, blue: 15/255, alpha: 1), image: nil)
            }
        }
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
        guard let location = locations.last else { return }
        self.locations = location
        latitude = String(location.coordinate.latitude)
        longitude = String(location.coordinate.longitude)
        
        self.viewMaps.animate(to: GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0))
        self.fetchStore(latitude: latitude, longitude: longitude)
        self.locationManager?.stopUpdatingLocation()
    }
}

extension HomeViewController: GMSAutocompleteViewControllerDelegate {
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        print("Place name: \(place.name)")
        print("Place address: \(place.formattedAddress ?? "null")")
        self.txtSearch.text = place.formattedAddress
        print("Place attributions: \(String(describing: place.attributions))")
        
        self.dismiss(animated: true, completion: nil)
    }
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
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
        UIView.animate(withDuration: 0.25) {
            self.profileSwipeVC.view.frame = CGRect(x: -UIScreen.main.bounds.maxX, y: 0, width: self.contentView.bounds.width, height: self.contentView.bounds.height)
        }
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

extension HomeViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        guard let storeData = marker.userData as? StoreListModelData else { return }
        getOderCode(storeData: storeData)
    }
    
//    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
//        let vc = DetailPromoViewController()
//        vc.data = self.promotionList[1]
//        self.navigationController?.pushViewController(vc, animated: true)
//        return true
//    }
}

extension HomeViewController {
    private func fetchPromotions() {
        let params = [
            "limit": 10,
            ] as [String : Any]
        HTTPHelper.shared.requestAPI(url: Constants.ServicesAPI.Promotion.promotion, param: params, method: HTTPMethodHelper.post) { (success, json) in
            let data = PromotionModelBaseClass(json: json ?? "")
            if data.message == "success", let datas = data.data {
                self.promotionList = datas
                self.carouselView.reloadData()
            } else {
                print(data.displayMessage ?? "")
            }
        }
    }
}
