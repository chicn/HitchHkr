//
//  ViewController.swift
//  HitchHkr
//
//  Created by Chihiro on 2017/11/11.
//  Copyright © 2017 chihiroshima. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
    }

}

