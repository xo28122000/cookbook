//
//  CardCell.swift
//  CookBook
//
//  Created by J on 4/26/21.
//

import UIKit

class CardCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    func configure(name: String, description: String, imgData: String){
//        guard let imageData = Data(base64Encoded: imgData)
//        else{
//            print("cannot convert")
//            return
//        }
//        print(imageData)
        
        nameLabel.text = name
        descriptionLabel.text = description
        imgView.image = UIImage(named: "icon1")
    }
    
}
