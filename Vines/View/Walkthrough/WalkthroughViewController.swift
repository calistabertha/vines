//
//  WalkthroughViewController.swift
//  Vines
//
//  Created by Calista Bertha on 24/01/19.
//  Copyright © 2019 Calista Bertha. All rights reserved.
//

import UIKit

class WalkthroughViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var btnShopNow: UIButton!
    var slides:[Slide] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            // Fallback on earlier versions
        }
        
        slides = createSlides()
        setupSlideScrollView(slides: slides)
        
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        view.bringSubview(toFront: pageControl)
        
        btnShopNow.layer.cornerRadius = 5
        btnShopNow.isHidden = true
        navigationController?.isNavigationBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     
    }

    func createSlides() -> [Slide] {
        let slide1:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide1.imgWalkthrough.image = UIImage(named: "img-Walkthrough-1")
        slide1.lblTitle.text = "Choose nearest Vines Store from your location."
        slide1.lblSubtitle.text = "Make sure your GPS Location is on."
       
        let slide2:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide2.imgWalkthrough.image = UIImage(named: "img-Walkthrough-2")
        slide2.lblTitle.text = "Add to cart what would you like to buy."
        slide2.lblSubtitle.text = "Double check your shoping cart and quantity before check out."
        
        let slide3:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide3.imgWalkthrough.image = UIImage(named: "img-Walkthrough-3")
        slide3.lblTitle.text = "Pick up your item from the nearest Vines Store.."
        slide3.lblSubtitle.text = "Don’t forget to bring your ID card before show this receipt to Vines Store staff."
        
        return [slide1, slide2, slide3]
    }

    func setupSlideScrollView(slides : [Slide]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        scrollView.isPagingEnabled = true
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(slides[i])
        }
    }
    
    @IBAction func shopNow(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.checkLogin()
    }
}

extension WalkthroughViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
        if pageControl.currentPage == 2 {
            pageControl.isHidden = true
            btnShopNow.isHidden = false
        }else{
            pageControl.isHidden = false
            btnShopNow.isHidden = true
        }
 
    }
}
