//
//  ViewController.swift
//  SmartLock
//
//  Created by Pranay Jay Patel on 10/7/17.
//  Copyright © 2017 Hackathon2017. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var simpleBluetoothIO: SimpleBluetoothIO!
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var numberField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        simpleBluetoothIO = SimpleBluetoothIO(serviceUUID: "a3c9025d-f942-48fb-bb7a-c2397c029f85", delegate: self)
    }
    
    @IBAction func sendString(_ sender: Any) {
        simpleBluetoothIO.writeValue(value: 8)
    }
}

extension ViewController: SimpleBluetoothIODelegate {
    func simpleBluetoothIO(simpleBluetoothIO: SimpleBluetoothIO, didReceiveValue value: Int8) {
        if value > 0 {
            view.backgroundColor = UIColor.yellow
        } else {
            view.backgroundColor = UIColor.black
        }
    }
}
