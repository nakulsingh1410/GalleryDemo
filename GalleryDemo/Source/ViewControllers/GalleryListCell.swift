//
//  GalleryListCell.swift
//  GalleryDemo
//
//  Created by Nakul Singh on 24/12/22.
//

import UIKit

class GalleryListCell: UITableViewCell {
    // MARK: - Outlets
    
    @IBOutlet var galleryImageView: UIImageView!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblDate: UILabel!

    var galleryData: GalleryData? {
        didSet {
            loadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func loadData() {
        galleryImageView.loadImage(from: galleryData?.link)
        lblTitle.text = galleryData?.title
        lblDate.text = galleryData?.imageDate
    }
    
}
