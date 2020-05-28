//
//  OptionalViewsForReusables.swift
//  ReusuableComponents
//
//  Created by Daniel James on 5/14/20.
//  Copyright © 2020 Daniel James. All rights reserved.
//

import UIKit

public enum ReuseableViewTypes{
    case buttonListType
    case descriptionType
    case primerType
}

protocol OptionalViewsForReusablesDelegate: AnyObject {
    //do stuff
    func handleButtonActions(buttonTitle: String)
    func updateReducedHeight(with newReducedHeight: CGFloat)
}

class OptionalViewsForReusables: UIView {
    
    var selectedViewType: ReuseableViewTypes?
    var heightToReduce: CGFloat?
    
    //scrolling parameters
    var isScrollable = false
    let scroll = UIScrollView()
    let bgView = UIView()
    //delegate for communication between controller and self(view)
    weak var delegate: OptionalViewsForReusablesDelegate?
    
    
    //MARK: Overrideable Features
    //THESE FUNCTIONS ARE THE ONES WHICH YOU SHOULD OVERRIDE TO CREATE YOUR DESIRED VIEW
    func setHeader() -> String{
        return "Your Header Here"
    }
    func setBody() -> String{
        return "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
    }
    func setTitle() -> String{
        return "Your Title"
    }
    
    func setTopConstraintForButtonElement() -> CGFloat {
        return 80
    }
    
    func setNumberOfButtons() -> Int {
        return 4
    }
    
    func setButtonTitles() -> [String] {
        return ["Button One", "Button Two", "Button One", "Button Two"]
    }
    
    func setButtonImages() -> [UIImage] {
        return [UIImage(systemName: "triangle.fill")!, UIImage(systemName: "triangle.fill")!,UIImage(systemName: "triangle.fill")!, UIImage(systemName: "triangle.fill")!]
    }
    
    @objc func yourButtonAction(sender:UIButton){
       //Override your button actions to be handled in your view - using delegate pattern communicate from the view to the controller the action that you would like each button to take 
    }
    
    //Required Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(selection: ReuseableViewTypes, isScrollable: Bool) {
        self.init()
        self.isScrollable = isScrollable
        selectedViewType = selection
        switch selection {
        case .buttonListType:
            buildButtonListTypeView()
        case .descriptionType:
            buildDescriptionTypeView()
        default:
            builtPrimerTypeView()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        switch self.selectedViewType {
        case .buttonListType:
            buildButtonListTypeView()
        case .descriptionType:
            buildDescriptionTypeView()
        default:
            builtPrimerTypeView()
        }
    }
    
    
    //Functions which construct views
    func buildButtonListTypeView(){
          createWhiteBGandRoundCorners()
        
          let view = UILabel()
          view.text = setHeader()
          view.font = .boldSystemFont(ofSize: 24)
          view.textColor = .black
          view.sizeToFit()
          view.translatesAutoresizingMaskIntoConstraints = false
          scroll.addSubview(view)
            NSLayoutConstraint.activate([
            
            view.leadingAnchor.constraint(equalTo: scroll.leadingAnchor, constant: 24),
            view.topAnchor.constraint(equalTo: scroll.topAnchor, constant: 28),
            
            ])
        
        //Setup the mock tableview
        _ = setupTableViewElement()
      }
        //you may have one selector action and switch based on the sender parameter or create multiple selectors for each button action
    
    func buildDescriptionTypeView(){
        createWhiteBGandRoundCorners()
        
        let headerView = UILabel()
        headerView.text = setHeader()
        headerView.font = .boldSystemFont(ofSize: 24)
        headerView.textColor = .black
        headerView.sizeToFit()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        scroll.addSubview(headerView)
          NSLayoutConstraint.activate([
          
          headerView.leadingAnchor.constraint(equalTo: scroll.leadingAnchor, constant: 24),
          headerView.topAnchor.constraint(equalTo: scroll.topAnchor, constant: 28),
          
          ])
        
        let bottomBorder:CALayer = CALayer()
        bottomBorder.frame = CGRect(x: 0, y: 40, width: UIScreen.main.bounds.width-55, height: 1.0)
        bottomBorder.backgroundColor = UIColor.black.withAlphaComponent(0.1).cgColor
        headerView.layer.addSublayer(bottomBorder)
        
        let bodyView = UILabel()
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .light), NSAttributedString.Key.foregroundColor: UIColor.gray]
        let title = NSMutableAttributedString(string: setBody(), attributes: attributes)
        bodyView.attributedText = title

        bodyView.font = .systemFont(ofSize: 13, weight: .light)
        bodyView.textColor = .black
        bodyView.lineBreakMode = .byWordWrapping
        bodyView.numberOfLines = 0
        bodyView.sizeToFit()
        bodyView.textAlignment = .left
        bodyView.translatesAutoresizingMaskIntoConstraints = false
        scroll.addSubview(bodyView)
        
        NSLayoutConstraint.activate([
            bodyView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 40),
            bodyView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 0),
            bodyView.trailingAnchor.constraint(equalTo: scroll.trailingAnchor, constant: -20)
        ])
        
        //Setup the mock tableview
        _ = setupTableViewElement()

    }
    
    func returnContentHeight() -> CGFloat {
        if let heightToReduce = self.heightToReduce {
           return heightToReduce
        }
        return 0.0
    }
    
    func builtPrimerTypeView() {
        createWhiteBGandRoundCorners()
        
        let imageView = UIImageView(image: UIImage(systemName: "triangle.fill"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        scroll.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 60),
            imageView.heightAnchor.constraint(equalToConstant: 60),
            imageView.topAnchor.constraint(equalTo: scroll.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: scroll.centerXAnchor, constant: 0)
        ])
        
        let headerView = UILabel()
        headerView.text = setTitle()
        headerView.font = .boldSystemFont(ofSize: 24)
        headerView.textColor = .black
        headerView.sizeToFit()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        scroll.addSubview(headerView)
          NSLayoutConstraint.activate([
          
          headerView.centerXAnchor.constraint(equalTo: scroll.centerXAnchor, constant: 0),
          headerView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
          
          ])
        
        let bodyView = UILabel()
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .light), NSAttributedString.Key.foregroundColor: UIColor.gray]
        let title = NSMutableAttributedString(string: setBody(), attributes: attributes)
        bodyView.attributedText = title

        bodyView.font = .systemFont(ofSize: 13, weight: .light)
        bodyView.textColor = .black
        bodyView.lineBreakMode = .byWordWrapping
        bodyView.numberOfLines = 0
        bodyView.sizeToFit()
        bodyView.textAlignment = .center
        bodyView.translatesAutoresizingMaskIntoConstraints = false
        scroll.addSubview(bodyView)
        NSLayoutConstraint.activate([
            bodyView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            bodyView.leadingAnchor.constraint(equalTo: scroll.leadingAnchor, constant: 40),
            bodyView.trailingAnchor.constraint(equalTo: scroll.trailingAnchor, constant: -40)
        ])
        
        let bottomButton = UIButton()
        bottomButton.layer.cornerRadius = 30
        bottomButton.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        let attributes1 = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .semibold), NSAttributedString.Key.foregroundColor: UIColor.white]
        let title1 = NSMutableAttributedString(string: setTitle(), attributes: attributes1)
        bottomButton.setAttributedTitle(title1, for: .normal)
        bottomButton.translatesAutoresizingMaskIntoConstraints = false
        scroll.addSubview(bottomButton)
        NSLayoutConstraint.activate([
            bottomButton.topAnchor.constraint(equalTo: bodyView.bottomAnchor, constant: 40),
            bottomButton.centerXAnchor.constraint(equalTo: scroll.centerXAnchor, constant: 0),
            bottomButton.widthAnchor.constraint(equalToConstant: 220),
            bottomButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        
    }
    
}



extension OptionalViewsForReusables{
    
    func createWhiteBGandRoundCorners(){
        //        bgView.frame = .init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        bgView.backgroundColor = .white
        bgView.layer.cornerRadius = 20
        
        if isScrollable == true{
            scroll.isScrollEnabled = true
        } else {
            scroll.isScrollEnabled = false
        }
        
        
        scroll.contentSize = .init(width: bgView.bounds.width, height: 1000)
        scroll.layer.cornerRadius = 22.5
        scroll.backgroundColor = .white
        scroll.translatesAutoresizingMaskIntoConstraints = false
        super.addSubview(scroll)
        NSLayoutConstraint.activate([
            scroll.topAnchor.constraint(equalTo: super.topAnchor, constant: 0),
            scroll.widthAnchor.constraint(equalTo: super.widthAnchor, constant: 0),
            scroll.heightAnchor.constraint(equalTo: super.heightAnchor, constant: 0)
        ])
        
        
        scroll.addSubview(bgView)
        
        bgView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: scroll.topAnchor, constant: 0),
            bgView.widthAnchor.constraint(equalTo: scroll.widthAnchor, constant: 0),
            bgView.bottomAnchor.constraint(equalTo: scroll.bottomAnchor, constant: 0),
            bgView.heightAnchor.constraint(equalTo: scroll.heightAnchor, constant: 1000),
        ])
        
    }
    
    /*This function allows us to build a mock tableview element - implemented because we dont need tableView functionality because design has promised to limit the amount of "cells" this screen will have - for implementation just call the function and increment each top constraint by 72 -> (the vertical width of each cell)
        */
    
    func mockTableViewElement(title: String, leftImage: UIImageView, topConstraint: CGFloat, selector: Selector) -> UIButton?{
            let button = UIButton()
            button.backgroundColor = .white

            let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .semibold), NSAttributedString.Key.foregroundColor: UIColor.gray]
            let titleForButton = NSMutableAttributedString(string: title, attributes: attributes)
            button.setAttributedTitle(titleForButton, for: .normal)
            button.contentEdgeInsets = .init(top: 0, left: 75, bottom: 0, right: 0)
            button.contentHorizontalAlignment = .left
            button.addTarget(self, action: selector, for: .touchUpInside)
//
            let iconView = leftImage
            iconView.translatesAutoresizingMaskIntoConstraints = false
            button.addSubview(iconView)
            
            let arrowImage = UIImageView(image: UIImage(systemName: "chevron.right"))
               arrowImage.translatesAutoresizingMaskIntoConstraints = false
            button.addSubview(arrowImage)

            
            button.translatesAutoresizingMaskIntoConstraints = false
            scroll.addSubview(button)
            
            
            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalTo: scroll.widthAnchor, constant: 0),
                button.topAnchor.constraint(equalTo: scroll.topAnchor, constant: topConstraint),
                button.heightAnchor.constraint(equalToConstant: 72)
                
            ])
            
            //The icon view set of constraints must come after the button view otherwise crash will occur
            NSLayoutConstraint.activate([
                iconView.widthAnchor.constraint(equalToConstant: 40),
                iconView.heightAnchor.constraint(equalToConstant: 40),
                iconView.topAnchor.constraint(equalTo: button.topAnchor, constant: 16),
                iconView.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 24)
            ])
            button.bringSubviewToFront(iconView)
            
            //The icon view set of constraints must come after the button view otherwise crash will occur
            NSLayoutConstraint.activate([
                arrowImage.centerYAnchor.constraint(equalTo: button.centerYAnchor, constant: 0),
                arrowImage.widthAnchor.constraint(equalToConstant: 7.5),
                arrowImage.heightAnchor.constraint(equalToConstant: 15),
                arrowImage.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -24)
            ])
            button.bringSubviewToFront(arrowImage)
            
            
            let bottomBorder:CALayer = CALayer()
            bottomBorder.frame = CGRect(x: 30, y: 70, width: UIScreen.main.bounds.width-60, height: 1.0)
            bottomBorder.backgroundColor = UIColor.black.withAlphaComponent(0.1).cgColor
            button.layer.addSublayer(bottomBorder)
            
           return button
        }
    
    
    func setupTableViewElement() -> [UIButton]? {
        var buttonArray = [UIButton]()
        let incrementSize = 72
        
        if self.selectedViewType == .some(.buttonListType) || self.selectedViewType == .some(.descriptionType){
            for (index, _) in (1...setNumberOfButtons()).enumerated() {
                switch index {
                case 0:
                    let button = mockTableViewElement(title: setButtonTitles()[index], leftImage: UIImageView(image: setButtonImages()[index]), topConstraint: setTopConstraintForButtonElement(), selector: #selector(self.yourButtonAction(sender:)))
                    buttonArray.append(button!)
                default:
                    let button = mockTableViewElement(title: setButtonTitles()[index], leftImage: UIImageView(image: setButtonImages()[index]), topConstraint: setTopConstraintForButtonElement()+CGFloat(incrementSize*index), selector: #selector(self.yourButtonAction(sender:)))
                    buttonArray.append(button!)
                }
            }
            return buttonArray
        }
        return nil
    }
    
    
}
