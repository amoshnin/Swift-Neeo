//
//  ProjectModel.swift
//  Neeo
//
//  Created by Артём Мошнин on 5/3/21.
//

import Foundation
import FirebaseFirestoreSwift

struct ProjectModel: Identifiable, Codable {
    @DocumentID var id: String?
    var title: String
    
    var createdAt: Date
    var updatedAt: Date
}

#if DEBUG
let projectsTestData = (1...10).map { index in
    ProjectViewModel( project: ProjectModel(title: "Title", createdAt: Date(), updatedAt: Date()) )
}
#endif
