//
//  ReuseableViewMenu.swift
//  ReusuableComponents
//
//  Created by Daniel James on 5/14/20.
//  Copyright © 2020 Daniel James. All rights reserved.
//

import UIKit

//YOUR PRESENTED CONTROLLER MUST CONFORM TO OPTIONALVIEWFORREUSABLESDELEGATE
class PopupViewController: UIViewController, OptionalViewsForReusablesDelegate {
    
    //SET THE VARIABLE FOR A NEW UIVIEW SUBCLASS
    var screenView: OptionalViewsForReusables?
    //YOU MUST PASS THE DESIRED REDUCED HEIGHT IN YOUR CONTROLLER
    var reducedHeight: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    init(screenView: OptionalViewsForReusables, reducedHeight: CGFloat?) {
        self.screenView = screenView
        self.reducedHeight = reducedHeight
        super.init(nibName: "PopupViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = screenView
    }
    
    func handleButtonActions(buttonTitle: String) {
        //HANDLE YOUR BUTTON ACTIONS IN YOUR CONTROLLER AFTER COMMUNICATING FROM THE VIEW THROUGH DELEGATE PATTERN
    }
    
    func updateReducedHeight(with newReducedHeight: CGFloat) {
        //Function for dynamically updating the reduced height
        self.reducedHeight = newReducedHeight
        
    }
    
}
