//
//  TabBarButton.swift
//  Swift-die
//
//  Created by 黎仕仪 on 17/2/24.
//  Copyright © 2017年 黎仕仪. All rights reserved.
//

import UIKit

class TabBarButton: UIButton {

    var btnImgView    : UIImageView?
    var btnTitleLabel : UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        btnImgView = UIImageView(frame: CGRect(x: (kWidth/3-24)/2, y: 6, width: 23, height: 23))
//        btnImgView?.image =
        self.addSubview(btnImgView!)
        
        btnTitleLabel = UILabel(frame: CGRect(x: 0, y: 31, width: kWidth/3, height: 15))
        btnTitleLabel?.textAlignment = .center
        btnTitleLabel?.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(btnTitleLabel!)
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
