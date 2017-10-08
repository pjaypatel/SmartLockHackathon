//
//  ViewController.swift
//  SmartLock
//
//  Created by Pranay Jay Patel on 10/7/17.
//  Copyright © 2017 Hackathon2017. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    var simpleBluetoothIO: SimpleBluetoothIO!
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var numberField: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.simpleBluetoothIO = SimpleBluetoothIO(serviceUUID: "a3c9025d-f942-48fb-bb7a-c2397c029f85", delegate: self)

    }
    
    func generateString(name: String, number: String) -> String
    {
        var newName = ""
        for c in name
        {
            if c != " "
            {
                newName += String(c)
            }
            
        }
        return newName + number
    }
    
    func encrypt(password: String) -> Int8
    {
        var result = 0
        for c in password
        {
            result += Int(c.asciiValue!)
        }
        result = result % 127
        print(result)
        return Int8(result)
    }
    
    @IBAction func sendString(_ sender: Any)
    {
        let password = generateString(name: (nameField.text)!, number: (numberField.text)!)
        let encryption = encrypt(password: password)
        print(encryption)
        //for temp in password
        //{
//            let when = DispatchTime.now() + 0.3
//            DispatchQueue.main.asyncAfter(deadline: when) {
                simpleBluetoothIO.writeValue(value: encryption)
//            }
        //}
    }
}

extension ViewController: SimpleBluetoothIODelegate
{
    func simpleBluetoothIO(simpleBluetoothIO: SimpleBluetoothIO, didReceiveValue value: Int8)
    {
        if value > 0
        {
            view.backgroundColor = UIColor.yellow
        }
        else
        {
            view.backgroundColor = UIColor.black
        }
    }
}
extension Character {
    var asciiValue: UInt32? {
        return String(self).unicodeScalars.filter{$0.isASCII}.first?.value
    }
}
extension String {
    var asciiAray: [UInt32] {
            return unicodeScalars.filter{$0.isASCII}.map{$0.value}
    }
}
