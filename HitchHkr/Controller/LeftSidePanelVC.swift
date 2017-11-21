//
//  LeftSidePanelVC.swift
//  HitchHkr
//
//  Created by Chihiro on 2017/11/12.
//  Copyright © 2017 chihiroshima. All rights reserved.
//

import UIKit
import Firebase

class LeftSidePanelVC: UIViewController {

    let appDelegate = AppDelegate.getAppDelegate()

    let currentUserId = Auth.auth().currentUser?.uid

    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userAccountTypeLabel: UILabel!
    @IBOutlet weak var userImageView: RoundImageView!
    @IBOutlet weak var loginOutBtn: UIButton!
    @IBOutlet weak var pickUpModeSwitch: UISwitch!
    @IBOutlet weak var pickupModeLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        pickUpModeSwitch.isOn = false
        pickUpModeSwitch.isHidden = true
        pickupModeLabel.isHidden = true

        observePassengersAndDrivers()

        if Auth.auth().currentUser == nil {
            userEmailLabel.text = ""
            userAccountTypeLabel.text = ""
            userImageView.isHidden = true
            loginOutBtn.setTitle("Sign Up / Login", for: .normal)
        } else {
            userEmailLabel.text = Auth.auth().currentUser?.email
            userAccountTypeLabel.text = ""
            userImageView.isHidden = false
            loginOutBtn.setTitle("Logout", for: .normal)
        }

    }

    func observePassengersAndDrivers() {
        DataService.instance.REF_USERS.observeSingleEvent(of: .value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    if snap.key == Auth.auth().currentUser?.uid {
                        self.userAccountTypeLabel.text = "PASSENGER"
                    }
                }
            }
        })
        DataService.instance.REF_DRIVERS.observeSingleEvent(of: .value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    if snap.key == Auth.auth().currentUser?.uid {
                        self.userAccountTypeLabel.text = "DRIVER"
                        self.pickUpModeSwitch.isHidden = false
                        let switchStatus = snap.childSnapshot(forPath: "isPickupModeEnabled").value as! Bool
                        self.pickUpModeSwitch.isOn = switchStatus
                        self.pickupModeLabel.isHidden = false
                    }
                }
            }
        })
    }    
    @IBAction func switchWasToggled(_ sender: Any) {
        if pickUpModeSwitch.isOn {
            pickupModeLabel.text = "PICKUP MODE ENABLED"
            appDelegate.MenuContainerVC.toggleLeftPanel()
            DataService.instance.REF_DRIVERS.child(currentUserId!).updateChildValues(["isPickupModeEnabled": true])
        } else {
            pickupModeLabel.text = "PICKUP MODE DISABLED"
            appDelegate.MenuContainerVC.toggleLeftPanel()
            DataService.instance.REF_DRIVERS.child(currentUserId!).updateChildValues(["isPickupModeEnabled": false])
        }
    }

    @IBAction func SignUpLoginBtnWasPressed(_ sender: Any) {
        if Auth.auth().currentUser == nil {
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC
            present(loginVC! , animated: true, completion: nil)
        } else {
            do {
                try Auth.auth().signOut()
                userEmailLabel.text = ""
                userAccountTypeLabel.text = ""
                userImageView.isHidden = true
                pickupModeLabel.text = ""
                pickUpModeSwitch.isHidden = true
                loginOutBtn.setTitle("Sign Up / Login", for: .normal)
            } catch (let error) {
                print(error)
            }
        }
    }
}
