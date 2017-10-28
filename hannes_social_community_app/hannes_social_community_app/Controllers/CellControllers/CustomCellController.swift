//
//  CustomCellController.swift
//  hannes_social_community_app
//
//  Created by Hannes van Tonder on 2017/10/28.
//  Copyright © 2017 Hannes van Tonder. All rights reserved.
//

import UIKit


class CustomTableViewCell: UITableViewCell {
    
    let title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let subTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //Own cell
//        self.backgroundColor = UIColor.appThemeGray()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        buildCell()
    }
    
    func applyDefaults(user: User){
        if let name = user.name{
            title.text = name
        }
        if let text =  user.createdAt{
            subTitle.text = "Joined at: \(text)"
        }
    }
    
    func buildCell(){
        //Title
        self.addSubview(title)
        title.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        title.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        title.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        title.numberOfLines = 1
        
        //Sub title
        self.addSubview(subTitle)
        subTitle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        subTitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8).isActive = true
        subTitle.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
    }
}

