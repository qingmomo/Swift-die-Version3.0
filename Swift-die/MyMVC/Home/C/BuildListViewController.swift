//
//  BuildListViewController.swift
//  Swift-die
//
//  Created by 黎仕仪 on 17/2/27.
//  Copyright © 2017年 黎仕仪. All rights reserved.
//

import UIKit

class BuildListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var buildListTableView : UITableView?
    var buListArray        : NSMutableArray!
    var buIdBuNameDic      : NSMutableDictionary?
    var buildNameArray     : [String]?
    var sectionDataArray   : NSMutableArray?
    var rowDataArray       : NSMutableArray?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.view.backgroundColor = UIColor.white
        let item = self.navigationController?.navigationBar.topItem
        item!.title = "返回"
        self.navigationController!.navigationBar.tintColor = UIColor.black
        
        buListArray      = NSMutableArray()
        buIdBuNameDic    = NSMutableDictionary()
//        buildNameArray = NSMutableArray()
        buildNameArray   = [String]()
        sectionDataArray = NSMutableArray()
        rowDataArray     = NSMutableArray()

        self.createSubViewsAndLoadData()

    }
    
    func createSubViewsAndLoadData() {
        buildListTableView = UITableView(frame: self.view.bounds, style: .grouped)
        buildListTableView?.delegate = self
        buildListTableView?.dataSource = self
        buildListTableView?.tableFooterView = UIView(frame: CGRect.zero)
        self.view.addSubview(buildListTableView!)
        
        let res = INNSMap_ServicesResourceData()
        res.innsMap_getCityBuildingList(withCountryID: 86, withCityID: 103, success: { (buildListArr) -> Void in
            self.buListArray = buildListArr
            
            for i in 0..<self.buListArray.count{
            let cityBuild = buildListArr?[i] as! CityBuilding
            let buildName = cityBuild.buildingNameStr
            let buildId   = cityBuild.buildingCodeStr
                
                self.buIdBuNameDic?.setObject(buildId, forKey: buildName as! NSCopying)
//                self.buildNameArray?.addObject(buildName)
                self.buildNameArray?.append(buildName!)
            }
            
            self.sectionDataArray = ChineseString.indexArray(self.buildNameArray)
            self.rowDataArray     = ChineseString.letterSortArray(self.buildNameArray)
            
            DispatchQueue.main.async(execute: { () -> Void in
                self.buildListTableView?.reloadData()
            })
            
            
            }) { (error) -> Void in
                print(error)
        }
        
    }

//    MARK : - TableView代理和数据源

    @available(iOS 2.0, *)
    func numberOfSections(in tableView: UITableView) -> Int {
        return (sectionDataArray?.count)!
    }
    
    @available(iOS 2.0, *)
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let identifier = "myCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if ((cell == nil)){
        cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
        }
        
        let rowArr = rowDataArray![indexPath.section] as! [String]
        
        cell?.textLabel?.text = rowArr[indexPath.row]
        cell?.textLabel?.textAlignment = .center
        
        return cell!
    }

    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return (rowDataArray![section] as AnyObject).count
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        buildListTableView?.sectionIndexBackgroundColor = UIColor.clear
        buildListTableView?.sectionIndexColor = UIColor.gray
        let strArr = sectionDataArray! as NSArray as! [String]
        return strArr
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: kWidth, height: 30))
        
        let label = UILabel(frame: view.frame)
        label.text = sectionDataArray![section] as? String
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        view.addSubview(label)
        
        return view;
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0000001
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rowArr = rowDataArray![indexPath.section] as! [String]
        let buildName = rowArr[indexPath.row]
        let buildId   = buIdBuNameDic![buildName]
        
        let buildVC       = BuildViewController()
        buildVC.buildId   = buildId as? String
        buildVC.buildName = buildName
        self.navigationController?.pushViewController(buildVC, animated: true)
        
    }
    
    
    
}
