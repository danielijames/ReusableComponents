//
//  PresentationController.swift
//  ReusuableComponents
//
//  Created by Daniel James on 5/14/20.
//  Copyright © 2020 Daniel James. All rights reserved.
//

import UIKit

class PresentationController: UIPresentationController {
    
    private var reducedPresentedScreenHeight = CGFloat(450)
   
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        
        let presentedVC = presentedViewController as! PopupViewController
        self.reducedPresentedScreenHeight = presentedVC.reducedHeight ?? 450
    }
    
    //Dim the rear view controller and dismiss the view upon tappping
    private lazy var dimView: UIView! = {
        guard let container = containerView else { return nil }
        let view = UIView(frame: container.bounds)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        view.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(didTap(tap:)))
        )
        return view
    }()
    
    //dismiss the controller when rear view is tapped
    @objc func didTap(tap: UITapGestureRecognizer) {
          presentedViewController.dismiss(animated: true, completion: nil)
      }

    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let container = containerView else { return .zero }
        
        //Add the corner radius to the presented view
        self.presentedView?.layer.cornerRadius = 20
        
        //Adjust the height that the view
        return CGRect(x: 0, y: self.reducedPresentedScreenHeight, width: container.bounds.width, height: container.bounds.height - (self.reducedPresentedScreenHeight))
    }
    
    
    //Mark: Setup controllers for beginning transition
    override func presentationTransitionWillBegin() {
        
        //Setup container and user coordinator to add additional commands to the transition
        guard let container = containerView,
            let coordinator = presentingViewController.transitionCoordinator else { return }

        dimView.alpha = 0
        container.addSubview(dimView)
        dimView.addSubview(presentedViewController.view)

        coordinator.animate(alongsideTransition: { [weak self] context in
            guard let self = self else { return }
            self.dimView.alpha = 1
            }, completion: nil)
    }
    
    //Mark: Setup controllers for dismissing transition
    override func dismissalTransitionWillBegin() {
        guard let coordinator = presentingViewController.transitionCoordinator else { return }
        
        //Setup container and user coordinator to add additional commands to the transition
        coordinator.animate(alongsideTransition: { [weak self] (context) -> Void in
            guard let self = self else { return }
            self.dimView.alpha = 0
            }, completion: nil)
    }
    
    //Mark: Take action at end of transition
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            dimView.removeFromSuperview()
            self.presentedView?.layer.cornerRadius = 0
        }
    }
}


