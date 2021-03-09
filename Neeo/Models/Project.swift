//
//  ProjectModel.swift
//  Neeo
//
//  Created by Артём Мошнин on 5/3/21.
//

import Foundation
import FirebaseFirestoreSwift

struct Project: Identifiable, Codable {
    @DocumentID var id: String?
    var title: String
    var description: String
    var shown = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
    }
}
