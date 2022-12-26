//
//  ImageTableViewCell.swift
//  GalleryDemo
//
//  Created by Nakul Singh on 24/12/22.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    // MARK: - Outlets
    
    @IBOutlet var galleryImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
