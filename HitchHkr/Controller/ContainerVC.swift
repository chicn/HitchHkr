//
//  ContainerVC.swift
//  HitchHkr
//
//  Created by Chihiro on 2017/11/12.
//  Copyright © 2017 chihiroshima. All rights reserved.
//

import UIKit
import QuartzCore

enum SlideOutState {
    case collapsed
    case leftPanelExpanded
}

enum ShowWhichVC {
    case homeVC
    case paymentVC
}

var showVC: ShowWhichVC = .homeVC

class ContainerVC: UIViewController {

    var homeVC: HomeVC!
    var currentState: SlideOutState = .collapsed

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func initCenter(screen: ShowWhichVC) {
        var presentingController: UIViewController

        showVC = screen

        if homeVC == nil {
            homeVC = UIStoryboard.homeVC()
            homeVC.delegate = self
        }
    }
}

extension ContainerVC: CenterVCDelegate {
    func toggleLeftPanel() {
        let notAlreadyExpanded = (currentState != .leftPanelExpanded)

        if notAlreadyExpanded {
            addLeftPanelViewController()
        }
        animateLeftPanel(shouldExpand: notAlreadyExpanded)
    }

    func addLeftPanelViewController() {
        //<#code#>
    }

    func animateLeftPanel(shouldExpand: Bool) {
        //<#code#>
    }
}

private extension UIStoryboard {
    class func mainStoryboard() -> UIStoryboard{
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }

    class func leftViewController() -> LeftSidePanelVC? {
        return mainStoryboard().instantiateViewController(withIdentifier: "LeftSidePanelVC") as? LeftSidePanelVC
    }

    class func homeVC() -> HomeVC? {
        return mainStoryboard().instantiateViewController(withIdentifier: "HomeVC") as? HomeVC
    }
}
