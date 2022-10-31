//
//  CKAsset+Ext.swift
//  NBAStars
//
//  Created by Hafizh Mo on 27/10/22.
//

import CloudKit

extension CKAsset {
    func generateImage(completion: @escaping (_ photo: Data?) -> ()) {
        DispatchQueue.global(qos: .utility).async {
            guard
                let fileURL = self.fileURL
            else {
                return
            }
            let imageData: Data
            do {
                imageData = try Data(contentsOf: fileURL)
            } catch {
                return
            }
            do {
                DispatchQueue.main.async {
                    completion(imageData)
                }
            }
        }
    }
}
