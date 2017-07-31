//
//  MaterialDesign.swift
//  Finder For Home
//
//  Created by Tushar Katyal on 31/07/17.
//  Copyright © 2017 Tushar Katyal. All rights reserved.
//
// Designing for uiview
import UIKit

private var materialKey = false
extension UIView {

    
    @IBInspectable var materialDesign : Bool {
        
        get{
            return materialKey
        }
        set {
             materialKey = newValue
            if materialKey {
                
                self.layer.masksToBounds = false
                self.layer.cornerRadius = 3.0
                self.layer.shadowOpacity = 0.8
                self.layer.shadowColor = UIColor(red: 157/255, green: 157/255, blue: 157/255, alpha: 1.0).cgColor
                self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
                self.layer.shadowRadius = 3.0
            }
            else {
                self.layer.cornerRadius = 0.0
                self.layer.shadowColor = nil
                self.layer.shadowRadius = 0.0
                self.layer.shadowOpacity = 0.0
            }
        }
    }

}
