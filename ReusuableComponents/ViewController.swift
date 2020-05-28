//
//  ViewController.swift
//  ReusuableComponents
//
//  Created by Daniel James on 5/14/20.
//  Copyright © 2020 Daniel James. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let screenView = FordPopUp(selection: .buttonListType, isScrollable: true)
    private var reducedheight: CGFloat?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        self.screenView.returnContentHeight()
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            
            switch UIScreen.main.bounds.height {
            case (0...740):
                self.reducedheight = UIScreen.main.bounds.height*0.4
            default:
                self.reducedheight = UIScreen.main.bounds.height*0.5
            }
            
            let vc = PopupViewController(screenView: self.screenView, reducedHeight: self.reducedheight)
            let transitionDelegate = TransitionDelegate(from: self, to: vc)
            vc.modalPresentationStyle = .custom
            vc.transitioningDelegate = transitionDelegate
            self.present(vc, animated: true, completion: nil)
        }
        
    }


}

