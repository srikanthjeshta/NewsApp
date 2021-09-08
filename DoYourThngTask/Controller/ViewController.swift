//
//  ViewController.swift
//  DoYourThngTask
//
//  Created by Work Station 2 on 08/09/21.
//

import UIKit
import Alamofire
import SDWebImage
import SVProgressHUD

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let refreshControl = UIRefreshControl()

    var items = [News]()
    var db1:DBHelper = DBHelper()
    
    var todayNewDate = ""
    @IBOutlet weak var newsDataTblVw: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibs()
        
        newsDataTblVw.separatorStyle = .none
        self.newsDataTblVw.delegate = self
        self.newsDataTblVw.dataSource = self
        self.newsDataTblVw.reloadData()
        title = "News Data"
        let formatter = DateFormatter()
        //2016-12-08 03:37:22 +0000
        formatter.dateFormat = "MM-dd-yyyy HH:mm"
        let now = Date()
        todayNewDate = formatter.string(from:now)
        print("%@", todayNewDate)

        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        newsDataTblVw.addSubview(refreshControl) // not required when using UITableViewController

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        items.removeAll()
        items = db1.read()
        newsDataTblVw.reloadData()
        
        print(items.count)
        if items.count == 0{
            getAPI()
            print("callingapo")
        }
        else{
            
            
            
        }
    }
    
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        getAPI1()
       
      //  self.newsDataTblVw.reloadData()

    }
    func registerNibs() {
        
        newsDataTblVw.register(UINib(nibName: "NewsdataTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsdataTableViewCell")
        
    }
    //TableView Delegate 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsdataTableViewCell", for: indexPath) as! NewsdataTableViewCell
        
        cell.dateLbl.text = todayNewDate
        //cell.dateLbl.text = String(format: "%@",[indexPath.row],todayNewDate)
        cell.titleLbl.text = String(format: "%@ %@", "Title:  ",items[indexPath.row].title)
        cell.descLbl.text = String(format: "%@ %@", "Description:  ",items[indexPath.row].desc)
        let url1 = items[indexPath.row].imgVw
        cell.imgVw.sd_setImage(with: URL(string: url1), placeholderImage: UIImage(named: "userName"))
        
        cell.imgVw.layer.cornerRadius = 10
        cell.imgVw.clipsToBounds = true

        cell.bgVw.layer.cornerRadius = 10
        cell.bgVw.clipsToBounds = false
        cell.bgVw.layer.shadowColor = UIColor.gray.cgColor
        cell.bgVw.layer.shadowOpacity = 1
        cell.bgVw.layer.shadowOffset = CGSize.zero
        cell.bgVw.layer.shadowRadius = 3
        
        cell.selectionStyle = .none
        
        return cell
        
    }
    //DateApi Calling
    func getAPI() {
        
        if Reachability.isNetworkAvailable(){
            showActivityIndicator()
            let urlString = "\(BASE_URL)"
            print("Testing :" + urlString )
            showActivityIndicator()
            AF.request(urlString, method: .get, encoding: JSONEncoding.default)
                .responseJSON { response in
                    switch response.result {
                    
                    case .success(_):
                        
                        if let err = response.error {
                            print(err)
                            return
                        }
                        
                        if let result = response.value {
                            
                            if let json = result as? [String: Any]{
                                
                                print("responsejson",json)
                               

                                if let data = json["articles"] as? [[String:Any]]{
                                    
                                    for item in data{
                                        self.items.append(News(todayDate: item["publishedAt"] as? String ?? "", title: item["title"]as? String ?? "", desc: item["description"]as? String ?? "", imgVw: item["urlToImage"]as? String ?? ""))
                                    }
                                    
                                    print("items: =====> \(self.items.count)")
                                    print("date111111: =======> \(self.items[0].todayDate)")
                                    print("desc: =======> \(self.items[0].desc)")
                                    
                                }
                                
                                
                                DispatchQueue.main.async {
                                    self.newsDataTblVw.reloadData()
                                    
                                    for item in self.items{
                                        self.db1.insert(todayDate: item.todayDate, title: item.title, desc: item.desc, imgVw: item.imgVw)
                                    }
                                    self.newsDataTblVw.reloadData()
                                    let value = self.db1.read()
                                    print( "arrray count> ======= \(value.count)")
                                    
                                }
                                
                                
                                
                            }
                            
                        }
                        
                        self.hideActivityIndicator()
                    case .failure(let err):
                        print("\(err.localizedDescription)")
                        
                    }
                    self.hideActivityIndicator()
                    
                }
            
        } else {
            
            UIAlertController.showAlert(vc: self, title: "", message:"No Internet")
        }
    }
    
    //DateApi Calling
    func getAPI1() {
        
        if Reachability.isNetworkAvailable(){
           // showActivityIndicator()
            let urlString = "\(BASE_URL)"
            print("Testing :" + urlString )
           // showActivityIndicator()
            AF.request(urlString, method: .get, encoding: JSONEncoding.default)
                .responseJSON { response in
                    switch response.result {
                    
                    case .success(_):
                        
                        if let err = response.error {
                            print(err)
                            return
                        }
                        
                        if let result = response.value {
                            
                            if let json = result as? [String: Any]{
                                
                                print("responsejson",json)
                                self.refreshControl.endRefreshing()
                                self.items.removeAll()

                                if let data = json["articles"] as? [[String:Any]]{
                                    
                                    for item in data{
                                        self.items.append(News(todayDate: item["publishedAt"] as? String ?? "", title: item["title"]as? String ?? "", desc: item["description"]as? String ?? "", imgVw: item["urlToImage"]as? String ?? ""))
                                    }
                                    
                                    print("items: =====> \(self.items.count)")
                                    print("date111111: =======> \(self.items[0].todayDate)")
                                    print("desc: =======> \(self.items[0].desc)")
                                    
                                }
                                
                                
                                DispatchQueue.main.async {
                                    self.newsDataTblVw.reloadData()
                                    
                                    for item in self.items{
                                        self.db1.insert(todayDate: item.todayDate, title: item.title, desc: item.desc, imgVw: item.imgVw)
                                    }
                                    self.newsDataTblVw.reloadData()
                                    let value = self.db1.read()
                                    print( "arrray count> ======= \(value.count)")
                                    
                                }
                                
                                
                                
                            }
                            
                        }
                        
                        self.hideActivityIndicator()
                    case .failure(let err):
                        print("\(err.localizedDescription)")
                        
                    }
                    self.hideActivityIndicator()
                    
                }
            
        } else {
            
            UIAlertController.showAlert(vc: self, title: "", message:"No Internet")
        }
    }
    
}

