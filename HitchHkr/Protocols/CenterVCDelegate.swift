//
//  CenterVCDelegate.swift
//  HitchHkr
//
//  Created by Chihiro on 2017/11/12.
//  Copyright © 2017 chihiroshima. All rights reserved.
//

import UIKit

protocol CenterVCDelegate {
    func togleLeftPanel()
    func addLeftPanelViewController()
    func anumateLeftPanel(shouldExpand: Bool)
}
