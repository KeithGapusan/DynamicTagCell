//
//  TagViewModel.swift
//  DynamicTagCell
//
//  Created by Keith Randell Gapusan on 10/05/2019.
//  Copyright © 2019 Keith Randell Gapusan. All rights reserved.
//

import Foundation
import UIKit

class TagViewModel: NSObject{
    var listOfButton = [UIButton]()
    var height : CGFloat = 0
    var estimatedHeightRow  : (CGFloat, CGFloat) -> (CGFloat) = {($0 + ($1 * ((4 + 4) * 2) + ((4 + 4) * 2)))} //height + (row * (top + bottom margin) + (first row top margin) + (first row bottom margin))
    
    override init(){
        super.init()
        //It's just to demo to generate 50 # buttons
        for btn in 0...50{
            let button =  UIButton()
            button.setTitle("#\(self.randomString(length: Int.random(in: 1 ..< 10)))", for: .normal)
            button.backgroundColor = .white
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            button.tag = btn
            button.setTitleColor(.blue, for: .normal)
            listOfButton.append(button)
        }
        
    }
}



extension TagViewModel: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: .init(describing: TagButtonCell.self), for: indexPath) as? TagButtonCell{
            cell.listOfButtons = listOfButton
            cell.updateContent {[weak tableView, weak self] (height, row) -> () in
                tableView?.beginUpdates()
                self?.height = self?.estimatedHeightRow(height, row) ?? 0
                tableView?.endUpdates()
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func randomString(length: Int) -> String {
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        var randomString = ""
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
}
