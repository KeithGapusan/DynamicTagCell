//
//  TagController.swift
//  DynamicTagCell
//
//  Created by Keith Randell Gapusan on 10/05/2019.
//  Copyright © 2019 Keith Randell Gapusan. All rights reserved.
//

import UIKit

class TagController: UIViewController {
    lazy var safeLayoutMargin = view.safeAreaLayoutGuide
    
    lazy var tableView : UITableView = {
        let tv = UITableView()
        self.view.addSubview(tv)
        tv.anchor(top: safeLayoutMargin.topAnchor, leading: safeLayoutMargin.leadingAnchor , bottom: safeLayoutMargin.bottomAnchor, trailing: safeLayoutMargin.trailingAnchor, padding: UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0))
        tv.register(TagButtonCell.self, forCellReuseIdentifier: .init(describing: TagButtonCell.self))
        tv.rowHeight = UITableView.automaticDimension
        tv.estimatedRowHeight = 100
        
        return tv
    }()
    
    lazy var viewModel =  TagViewModel()
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = viewModel
    }
    override func viewWillAppear(_ animated: Bool) {
        
    
    }
}


extension TagController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return viewModel.height
        }else{
            return UITableView.automaticDimension
        }
    }
}

