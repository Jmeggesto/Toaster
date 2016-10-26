//
//  ViewController.swift
//  ToasterTest
//
//  Created by Jackie Meggesto on 10/26/16.
//  Copyright © 2016 Jackie Meggesto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button = UIButton(frame: CGRect(x: 20, y: 20, width: 100, height: 50))
        button.titleLabel?.text = "Tap me"
        button.titleLabel?.textColor = UIColor.black
        
        button.backgroundColor = UIColor.red
        
        button.addTarget(self, action: #selector(ViewController.testToast), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    func testToast() {
        Toaster.displayToast(message: "asdfsdfgjnasefkjnasdfkjasdfknasf")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

