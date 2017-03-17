//
//  BuildViewController.swift
//  Swift-die
//
//  Created by 黎仕仪 on 17/2/27.
//  Copyright © 2017年 黎仕仪. All rights reserved.
//

import UIKit

class BuildViewController: UIViewController {

    var buildId   : String?
    var buildName : String?
    var inMapView : INNSMap_MapView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        let item = self.navigationController?.navigationBar.topItem
        item!.title = "返回"
        self.title = buildName! + "F1"
        

        self.createSubViews()
    }

    func createSubViews() {
        inMapView = INNSMap_MapView(frame: CGRect(x: 0, y: 64, width: kWidth, height: kHeight-64))
        self.view.addSubview(inMapView!)
    
        let res = INNSMap_ServicesResourceData()
        res.innsMap_getBuildingProperty(withBuildingID: buildId, success: { (BuildingProperty) -> Void in
            if (BuildingProperty?.overgroundCnt != 0){
            let overMap = BuildingProperty?.overgroundFloorArray[0] as? OvergroundFloorObj
                
                let floorId = overMap?.floorId
                
                DispatchQueue.main.async(execute: { () -> Void in
                    
                    self.inMapView?.load(withBuildID: self.buildId, withFloorID: floorId, success: { () -> Void in
                        
                        
                        }, failure: { (error) -> Void in
                            print(error ?? "有错误")
                    })
                    
                    
                })
                
            }
            
            
            }) { (error) -> Void in
                print(error ?? "有错误")
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController!.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
}
