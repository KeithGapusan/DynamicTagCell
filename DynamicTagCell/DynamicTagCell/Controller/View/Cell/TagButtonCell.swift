//
//  TagButtonCell.swift
//  DynamicTagCell
//
//  Created by Keith Randell Gapusan on 10/05/2019.
//  Copyright © 2019 Keith Randell Gapusan. All rights reserved.
//

import Foundation
import UIKit


class TagButtonCell: BaseTvCell {

    var viewButtonHolder : UIView = {
        let view  = UIView()
        return view
    }()
    
    var listOfButtons : [UIButton]?
    
    var height:CGFloat = 0.0
    fileprivate func appendWidth(_ button: UIButton, _ listOfWidth: inout [CGFloat], _ horizontalSpacing: CGFloat) {
        if let buttonWidth = button.titleLabel?.text?.widthOfString(usingFont: .boldSystemFont(ofSize: 15)) {
            let requiredMinWidth = CGFloat(26.15478515625) // minimum width - If the button only have 1 character , we shoul declare w
            guard (buttonWidth >= requiredMinWidth) == true else{
                return listOfWidth.append(requiredMinWidth + horizontalSpacing)
            }
            listOfWidth.append(buttonWidth + horizontalSpacing)
        }
    }
 

    func updateContent( horizontalSpacing : CGFloat = 5 , leftMargin : CGFloat = 16 , rightMargin : CGFloat = 16 , topMargin : CGFloat = 4, bottomMargin : CGFloat = 4, completed: @escaping(_ height : CGFloat ,_ rows: CGFloat) -> ()){
        var listOfWidth = [CGFloat]()
        var row = 1.0
        
        addSubview(viewButtonHolder)
        addConstraintsWithFormat(format: "V:|-(\(topMargin))-[v0]-(\(bottomMargin))-|", views: viewButtonHolder)
        addConstraintsWithFormat(format: "H:|[v0]|", views: viewButtonHolder)
        
        for (index, button) in listOfButtons!.enumerated() {
            viewButtonHolder.addSubview(button)
            if button == listOfButtons?.first {
                viewButtonHolder.addConstraintsWithFormat(format: "H:|-\(leftMargin)-[v0]", views: button)
                viewButtonHolder.addConstraintsWithFormat(format: "V:|-(\(topMargin))-[v0]", views: button)
                appendWidth(button, &listOfWidth, horizontalSpacing)
                height = height + (button.titleLabel?.text?.heightOfString(usingFont: .boldSystemFont(ofSize: 15)))!
            }else{
                let prevButton = self.listOfButtons![index - 1]
                appendWidth(button, &listOfWidth, horizontalSpacing)
                let sumOfWidths = listOfWidth.reduce(0, +)
                if (sumOfWidths >= (self.frame.width - leftMargin - rightMargin)){
                    row = row + 1
                    listOfWidth.removeAll()
                    button.anchor(top: prevButton.bottomAnchor, leading: viewButtonHolder.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets.init(top: topMargin, left: leftMargin, bottom: bottomMargin, right: 0))
                    appendWidth(button, &listOfWidth, horizontalSpacing)
                    height = height + (button.titleLabel?.text?.heightOfString(usingFont: .boldSystemFont(ofSize: 15)))!
                }else{
                    button.anchor(top: prevButton.topAnchor, leading: prevButton.trailingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets.init(top: 0, left: horizontalSpacing, bottom: 0, right: 0))
                }
            }
        }
        completed(height,CGFloat(row))
    }
    override func setupView() {
        
    }
}
