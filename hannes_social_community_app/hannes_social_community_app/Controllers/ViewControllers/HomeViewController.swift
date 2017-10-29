//
//  HomeViewController.swift
//  hannes_social_community_app
//
//  Created by Hannes van Tonder on 2017/10/28.
//  Copyright © 2017 Hannes van Tonder. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    let apiClient = ApiService()
    let cellId = "CustomId"
    var viewData: [Post] = []
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildView()
        updateStyling()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        retrieveDataFromBackend()
    }
    
    func retrieveDataFromBackend(){
        viewData = []
        apiClient.getNewsFeed { (dict, error) in
            if error != nil{
                print(error!.localizedDescription)
            }
            else{
                if let dictionary = dict{
                    if let dArray = dictionary["data"] as? NSDictionary{
                        if let arrayData = dArray["data"] as? NSArray{
                            for obj in arrayData{
                                if let object = obj as? NSDictionary{
                                    self.viewData.append(Post(dict: object))
                                }
                            }
                        }
                    }
                }
            }
            self.viewData.sort(){$0.createdAt! > $1.createdAt!}
            self.tableView.reloadData()
        }
    }
    
    func buildView(){
        //TableView
        self.view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        tableView.register(PostCellController.self, forCellReuseIdentifier: cellId)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func updateStyling(){
        self.view.backgroundColor = UIColor.orange
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewData.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView:UIView! = UIView(frame: CGRect(x: 0, y: 0,width: self.view.frame.width,height: 40))
        headerView.backgroundColor = UIColor.appThemeColor()
        let lbl1:UILabel! = UILabel(frame: CGRect(x: 10,y: 5,width: self.view.frame.width,height: 30))
        lbl1.text = "Posts"
        headerView.addSubview(lbl1)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! PostCellController
        cell.applyDefaults(post: viewData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
}
