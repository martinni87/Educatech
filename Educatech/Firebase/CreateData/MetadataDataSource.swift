//
//  MetadataDataSource.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 22/9/23.
//

import Foundation
import LinkPresentation

final class MetadataDataSource {
    
    private var metadataProvider: LPMetadataProvider
    
    func getMetadata(urlString: String, completionBlock: @escaping (Result<CourseModel, Error>) -> Void ) {
        guard let url = URL(string: urlString) else {
            completionBlock(.failure(AppErrors.badURL))
            return
        }
        metadataProvider = LPMetadataProvider()
        metadataProvider?.startFetchingMetadata(for: url, completionHandler: { metadata, error in
            if let error = error {
                completionBlock(.failure(error))
                return
            }
            let courseModel = CourseModel(title: metadata?.title,
                                          description: "",
                                          image: metadata?.image)
        })
    }
}
