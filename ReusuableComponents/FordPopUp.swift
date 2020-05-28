//
//  FordPopUp.swift
//  ReusuableComponents
//
//  Created by Daniel James on 5/15/20.
//  Copyright © 2020 Daniel James. All rights reserved.
//

import UIKit

class FordPopUp: OptionalViewsForReusables{
 
    override func setTopConstraintForButtonElement() -> CGFloat {
        return 260
    }
    
    override func setHeader() -> String{
         return "Ford"
     }
    
    override func setBody() -> String{
        return "Your body text goes here for the ford project"
    }
    
    
    override func setNumberOfButtons() -> Int {
        return 2
    }
    
    override func setButtonTitles() -> [String] {
        return ["Button One", "Button Two"]
    }
    
    override func setButtonImages() -> [UIImage] {
        return [UIImage(systemName: "triangle.fill")!, UIImage(systemName: "triangle.fill")!,UIImage(systemName: "triangle.fill")!]
    }
}
