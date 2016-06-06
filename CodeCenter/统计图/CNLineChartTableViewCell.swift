//
//  CNLineChartTableViewCell.swift
//  CodeCenter
//
//  Created by mac on 16/5/26.
//  Copyright © 2016年 Five. All rights reserved.
//

import UIKit

class CNLineChartTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private var _shapLayer: CAShapeLayer?
    var shapLayer: CAShapeLayer{
        get{
            if _shapLayer == nil{
                _shapLayer = CAShapeLayer()
            }
            
            return _shapLayer!
        }
    }
    
    
    var data: [Double]?{
        didSet{
            if data == nil{
                return
            }
            
            let bezierPath = UIBezierPath()
            bezierPath.moveToPoint(CGPointMake(0, 0))
            
            for v in data! {
                bezierPath.addLineToPoint(CGPointMake(0, CGFloat(v)))
            }
        }
    }

}
