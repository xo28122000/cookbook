//
//  CardCell.swift
//  CookBook
//
//  Created by Jainam, Himanshu, Ramy on 4/26/21.
//

import UIKit

class CardCell: UITableViewCell {

 
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    func configure(name: String, description: String, imgData: String){
//        guard let imageData = Data(base64Encoded: imgData, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)
//        else{
//            print("cannot convert")
//            return
//        }

        nameLabel.text = name
        descriptionLabel.text = description
        guard
            let defualtUIImg = UIImage(named: "icon1"),
            let defaultImg = defualtUIImg.jpegData(compressionQuality: 1)
        else {return}
        
        let url: URL? = URL(string: imgData)
        
        if let url: URL = url {
            let data = try? Data(contentsOf: url)
            imgView.image = UIImage(data: data ?? defaultImg)
        } else {
            print("ELSEEEE")
            imgView.image = UIImage(data: defaultImg)
        }
        

        

//        imgView.image = UIImage(data: imageData)
        
        cardView.layer.shadowColor = UIColor.gray.cgColor
//        cardView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        cardView.layer.shadowOffset = CGSize(width: 5, height: 5);
        cardView.layer.shadowOpacity = 0.2
        cardView.layer.masksToBounds = false
        cardView.layer.cornerRadius = 20.0
        cardView.layer.shadowPath = UIBezierPath(roundedRect: cardView.bounds, cornerRadius: 20).cgPath
        
//        cardView.layer.borderWidth = 0.2
//        cardView.layer.borderColor = UIColor.init(red: 255, green: 255, blue: 255, alpha: 0).cgColor


    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func checkAction(sender : UITapGestureRecognizer) {
        // Do what you want
    }

}
