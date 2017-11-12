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
    var leftVC: LeftSidePanelVC!
    var centerController: UIViewController!
    var currentState: SlideOutState = .collapsed

    var isHidden = false
    let centerPanelExpandedOffset: CGFloat = 160
    override func viewDidLoad() {
        super.viewDidLoad()
        initCenter(screen: showVC)
    }

    func initCenter(screen: ShowWhichVC) {
        var presentingController: UIViewController

        showVC = screen

        if homeVC == nil {
            homeVC = UIStoryboard.homeVC()
            addChildSidePanelViewController(leftVC)
        }

        presentingController = homeVC

        if let con = centerController {
            con.view.removeFromSuperview()
            con.removeFromParentViewController()
        }

        centerController = presentingController

        view.addSubview(centerController.view)
        addChildViewController(centerController)
        centerController.didMove(toParentViewController: self)
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
        if leftVC == nil {
            leftVC = UIStoryboard.leftViewController()
            addChildSidePanelViewController(leftVC!)
        }
    }

    func addChildSidePanelViewController(_ sidePanelController: LeftSidePanelVC) {
        view.insertSubview(sidePanelController.view, at: 0)
        addChildViewController(sidePanelController)
        sidePanelController.didMove(toParentViewController: self)
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
