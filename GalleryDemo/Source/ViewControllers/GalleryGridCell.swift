//
//  ImageCollectionViewCell.swift
//  GalleryDemo
//
//  Created by Nakul Singh on 26/12/22.
//

import UIKit

class GalleryGridCell: UICollectionViewCell {
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
        // Initialization code
    }
   
    private func loadData() {
        galleryImageView.loadImage(from: galleryData?.link)
        lblTitle.text = galleryData?.title
        lblDate.text = galleryData?.imageDate
    }
}
