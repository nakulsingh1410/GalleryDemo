//
//  ImageDataModel.swift
//  GalleryDemo
//
//  Created by Nakul Singh on 24/12/22.
//

import Foundation

struct ImageDataModel: Codable {
    let success: Bool
    let status: Int
    let data: [GalleryData]
}

struct GalleryData: Codable {
    let link: String?
    let title: String?
    let description: String?
    let datetime: TimeInterval?
    
    var imageDate: String {
        guard let timestamp = datetime else { return "" }
        let date = Date(timeIntervalSince1970: timestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm a"
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
}
