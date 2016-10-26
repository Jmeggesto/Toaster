//
//  Toaster.swift
//  ToasterTest
//
//  Created by Jackie Meggesto on 10/26/16.
//  Copyright © 2016 Jackie Meggesto. All rights reserved.
//

import Foundation
import UIKit

public class Toaster {
    
    static var currentToast: Toast?
    
    fileprivate static var toastQueue = [Toast]()
    
    public static func displayToast(message: String, displayTime: Double = 2.5) {
        
        let toast = Toast(message: message)
        toast.displayTime = displayTime
        toast.show()
    }
    public static func displayToast(message: String, image: UIImage, displayTime: Double = 2.5) {
        
        let toast = Toast(message: message, image: image)
        toast.displayTime = displayTime
        toast.show()
    }
    
}

extension Toaster {
    
    public static func addToastToQueue(toast: Toast) {
        
        if self.toastQueue.contains(where: {$0.message == toast.message}) ||
            
            toast.message == self.currentToast?.message {
            return
        }
        
        self.toastQueue.append(toast)
        
    }
    
    internal static func toastShouldShow() -> Bool {
        return self.currentToast == nil
    }
    
    
    internal static func nextToast() {
        
        self.currentToast = nil
        
        if self.toastQueue.count == 0 {
            return
        }
        
        let nextToast = self.toastQueue.removeFirst()
        
        nextToast.show()
    }
    
}
