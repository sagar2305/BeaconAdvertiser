//
//  ViewController.swift
//  BeaconAdvertiser
//
//  Created by Sagar Mutha on 4/14/16.
//  Copyright © 2016 SmartApps India. All rights reserved.
//

import UIKit
import CoreBluetooth
import CoreLocation

class ViewController: UIViewController, CBPeripheralManagerDelegate {

    let peripheralManager = CBPeripheralManager(delegate: nil, queue: nil)
    let beaconRegion = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "416C0120-5960-4280-A67C-A2A9BB166D0F")!, identifier: "SmartApps_Beacon")
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        peripheralManager.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func turnOnAdvertising() {
        let major: CLBeaconMajorValue = CLBeaconMajorValue(arc4random_uniform(5000))
        let minor: CLBeaconMinorValue = CLBeaconMajorValue(arc4random_uniform(5000))
        let region: CLBeaconRegion = CLBeaconRegion(proximityUUID: beaconRegion.proximityUUID, major: major, minor: minor, identifier: beaconRegion.identifier)
        let beaconPeripheralData: NSDictionary = region.peripheralDataWithMeasuredPower(nil) as NSDictionary
        
        peripheralManager.startAdvertising(beaconPeripheralData as? [String : AnyObject])
        
        print("Turning on advertising for region: \(region).")
    }

    //MARK :- CBPeripheralManagerDelegate

    func peripheralManagerDidStartAdvertising(peripheral: CBPeripheralManager, error: NSError?) {
        if error != nil {
            print("Couldn't turn on advertising: \(error)")
        }
        
        if peripheralManager.isAdvertising {
            print("Turned on advertising.")
        }
    }
    
    func peripheralManagerDidUpdateState(peripheral: CBPeripheralManager) {
        if peripheralManager.state == .PoweredOff {
            print("Peripheral manager is off.")
        } else if peripheralManager.state == .PoweredOn {
            print("Peripheral manager is on.")
            turnOnAdvertising()
        }
    }

}

