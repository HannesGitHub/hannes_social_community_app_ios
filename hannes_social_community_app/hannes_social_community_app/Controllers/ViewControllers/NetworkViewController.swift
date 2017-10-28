//
//  NetworkViewController.swift
//  hannes_social_community_app
//
//  Created by Hannes van Tonder on 2017/10/28.
//  Copyright © 2017 Hannes van Tonder. All rights reserved.
//

import UIKit

class NetworkViewController: UIViewController {
    
    let apiClient = ApiService()
    var viewData:[[User]] = [[], []]
    var cellId = "customCell"
    
    let tableView:UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildView()
    }
    
    func buildView(){
        //TableView
        self.view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        retrieveDataFromBackend()
    }
    
    func retrieveDataFromBackend(){
        apiClient.getFollowers { (dict, error) in
            if error != nil{
                print(error!.localizedDescription)
            }
            else{
                self.populateViewData(dict: dict, index: 0)
            }
        }
        apiClient.getFollowing { (dict, error) in
            if error != nil{
                print(error!.localizedDescription)
            }
            else{
                self.populateViewData(dict: dict, index: 1)
            }
        }
    }
    private func populateViewData(dict: NSDictionary?, index: Int){
        if let response = dict{
            self.viewData[index] = SocialHelper.populateUsersFromList(dict: response)
            tableView.reloadData()
        }
    }
}

extension NetworkViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewData[section].count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView:UIView! = UIView(frame: CGRect(x: 0, y: 0,width: self.view.frame.width,height: 40))
        headerView.backgroundColor = UIColor.appThemeColor()
        let lbl1:UILabel! = UILabel(frame: CGRect(x: 10,y: 5,width: self.view.frame.width,height: 30))
        lbl1.text = section == 0 ? "Followers" : "Following"
        headerView.addSubview(lbl1)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! CustomTableViewCell
        cell.applyDefaults(user: viewData[indexPath.section][indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
}
