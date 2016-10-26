//
//  Toast.swift
//  ToasterTest
//
//  Created by Jackie Meggesto on 10/26/16.
//  Copyright © 2016 Jackie Meggesto. All rights reserved.
//

import Foundation
import UIKit


public class Toast {
    
    public var message: String?
    public var image: UIImage?
    public var displayTime: Double = 0.0

    fileprivate var window: UIWindow?
    fileprivate var view: UIView?
    fileprivate var messageLabel: UILabel?
    fileprivate var imageView: UIImageView?
    
    init() {
        self.window = UIApplication.shared.keyWindow
    }

    
}

public extension Toast {

    
    convenience init(message: String) {
        
        self.init()
        
        self.message = message
        
    }
    convenience init(message: String, image: UIImage) {
        
        self.init()
        
        self.message = message
        self.image = image
    }
    
}

public extension Toast {
    
    internal func show() {
        
        guard self.window != nil else {
            return
        }
        self.view = UIView(frame: CGRect(x: 50, y: self.window!.frame.height - 40, width: self.window!.frame.width - 50, height: 35))
        
        self.renderToast()
    
        if !Toaster.toastShouldShow() {
            Toaster.addToastToQueue(toast: self)
            return
        }
        
        Toaster.currentToast = self
        
        self.window?.addSubview(self.view!)
        
        UIView.animate(withDuration: 0.44, animations: {
            
            self.view?.alpha = 0.96
        
            }) { (finished) in
            
                DispatchQueue.main.asyncAfter(deadline: .now() + self.displayTime, execute: {
                    
                    self.close()
                    
                })
        }
        
    }
    
    fileprivate func pushToToast(view: UIView) {
        
        guard self.view != nil else {
            return
        }
        
        view.frame.origin.y = self.view!.frame.size.height - 35 / 2
        self.view!.frame.size.height += view.frame.size.height
        view.center.x = self.view!.center.x
        self.view!.addSubview(view)
        
    }
    
    fileprivate func centerViews() {
        
        guard self.window != nil && self.view != nil else {
            return
        }
        
        self.view?.frame.origin.x = self.window!.frame.width / 2 - self.view!.frame.width / 2
        
        self.view?.subviews.forEach{
        
            $0.frame.origin.x = self.view!.frame.width / 2 - $0.frame.width / 2
        
        }
        
    }
    
    fileprivate func renderToast() {
        
        self.view?.backgroundColor = UIColor.gray.withAlphaComponent(0.98)
        self.view?.layer.cornerRadius = 8
        self.view?.alpha = 0.0
        
        self.view?.layer.shadowColor = UIColor.black.cgColor
        self.view?.layer.shadowOpacity = 0.55
        self.view?.layer.shadowOffset = CGSize.zero
        self.view?.layer.shadowRadius = 3
        
        if self.image != nil {
            
            let frame = CGRect(x: self.view!.frame.width / 2 - self.view!.frame.height / 2, y: self.view!.frame.origin.y, width: self.view!.frame.height, height: self.view!.frame.height)
            
            self.imageView = UIImageView(frame: frame)
            self.imageView?.image = self.image
            self.pushToToast(view: self.imageView!)
        }

        if self.message != nil && self.message?.isEmpty == false {
            
            self.messageLabel = UILabel(frame: self.view!.frame)
            self.messageLabel?.numberOfLines = 0
            self.messageLabel?.textAlignment = NSTextAlignment.center
            self.messageLabel?.textColor = UIColor.black.withAlphaComponent(0.85)
            self.messageLabel?.text = self.message
            self.messageLabel?.font = UIFont.systemFont(ofSize: 15)
            self.messageLabel?.sizeToFit()
            self.view!.frame.size.width = self.messageLabel!.frame.size.width + 40
            self.pushToToast(view: self.messageLabel!)
            
        }
        
        if (self.view!.frame.origin.y + self.view!.frame.height) > UIScreen.main.bounds.height {
            
            self.view?.frame.origin.y = UIScreen.main.bounds.height - self.view!.frame.size.height - 74
        }
        self.centerViews()
        
    }
    
    fileprivate func close() {
        
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.44, animations: {
                
                self.view?.alpha = 0.0
                
                }, completion: { (finished) in
                    
                    self.view?.removeFromSuperview()
                    self.view = nil
                    self.window = nil
                    
                    Toaster.nextToast()
            })

        }
    }
    
}
