//
//  CNLInechart.swift
//  BusinessTime
//
//  Created by mac on 16/5/26.
//  Copyright © 2016年 kaifa24. All rights reserved.
//

import UIKit

class CNLInechart: UIView, UITableViewDelegate, UITableViewDataSource {

    fileprivate var _tableView: UITableView?{
        didSet{
            if(_tableView == nil){
                return
            }
            
            _tableView?.backgroundColor = UIColor.blue
            
            _tableView?.delegate = self
            _tableView?.dataSource = self
            
            self.addSubview(_tableView!)
            _tableView?.translatesAutoresizingMaskIntoConstraints = false
            
            if let cs = _tableView?.constraints(self, top: 0, bottom: 0, leading: 0, trailing: 0){
                self.addConstraints(cs)
            }
        }
    }
    var tableView: UITableView{
        get{
            if(_tableView == nil){
                _tableView = UITableView()
            }
            
            return _tableView!
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - tableViewdelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.size.height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

}
