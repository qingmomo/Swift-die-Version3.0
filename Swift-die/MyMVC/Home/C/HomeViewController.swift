

//
//  HomeViewController.swift
//  Swift-die
//
//  Created by 黎仕仪 on 17/2/23.
//  Copyright © 2017年 黎仕仪. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,BMKMapViewDelegate {
    var _mapView : BMKMapView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _mapView = BMKMapView(frame: self.view.bounds)
        self.view = _mapView
        _mapView?.zoomLevel = 14
        
        let coordinate = CLLocationCoordinate2DMake(39.90, 116.397)
        _mapView?.setCenter(coordinate, animated: true)

//        创建搜索按钮
        self.createSubViews()
        
    }
    
    func createSubViews() {
    let bgView = UIView(frame: CGRect(x: 15, y: 25, width: kWidth-30, height: 45))
        bgView.backgroundColor = UIColor.white
        bgView.layer.shadowOpacity = 0.8
        bgView.layer.cornerRadius = 3
        bgView.layer.shadowOffset = CGSize(width: 2, height: 2)
        bgView.layer.shadowRadius = 2
        bgView.layer.shadowColor = UIColor.gray.cgColor
        self.view.addSubview(bgView)
        
    let searchImageView = UIImageView(frame: CGRect(x: 14, y: 13, width: 18, height: 19))
        searchImageView.image = UIImage(named: "search-拷贝-2")
        bgView.addSubview(searchImageView)
        
    let lineView = UIView(frame: CGRect(x: 45, y: 10, width: 0.6, height: 25))
        lineView.backgroundColor = UIColor.lightGray
        bgView.addSubview(lineView)

    let searchLabel = UILabel(frame: CGRect(x: 59, y: 10, width: kWidth-30-50*2, height: 25))
        searchLabel.font = UIFont.systemFont(ofSize: 16)
        searchLabel.text = "搜北京市商铺或场地"
        searchLabel.textColor = UIColor.gray
        bgView.addSubview(searchLabel)
        
        
    let searchBtn = UIButton(type: .custom)
        searchBtn.frame = bgView.frame
        self.view.addSubview(searchBtn)
        searchBtn.addTarget(self, action: #selector(HomeViewController.search), for: .touchUpInside)
        
        
    }
    
    
    func search() {
        let buildListVC = BuildListViewController()
        self.navigationController?.pushViewController(buildListVC, animated: true)
    
    }
    
    
//    MARK: - view生命周期
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        _mapView?.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        _mapView?.delegate = nil
        self.navigationController?.navigationBar.isHidden = false
    }
    
    
//    MARK: - BMKMapViewDelegate
   
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
