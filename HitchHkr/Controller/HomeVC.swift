//
//  HomeVC.swift
//  HitchHkr
//
//  Created by Chihiro on 2017/11/11.
//  Copyright © 2017 chihiroshima. All rights reserved.
//

import UIKit
import MapKit

class HomeVC: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var actionBtn: RoundedShadowButton!

    var delegate: CenterVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
    }

    @IBAction func actionBtnWasPressed(_ sender: Any) {
        actionBtn.animateButton(shouldLoad: true, withMessage: nil)
    }

    @IBAction func menuBtnWasPressed(_ sender: Any) {
        delegate?.toggleLeftPanel()
    }
}
