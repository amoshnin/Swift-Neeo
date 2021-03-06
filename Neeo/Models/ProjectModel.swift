//
//  ProjectModel.swift
//  Neeo
//
//  Created by Артём Мошнин on 5/3/21.
//

import Foundation

struct ProjectModel: Identifiable, Codable {
    let id = UUID()
    let title: String
    
    let createdAt: Date
    let updatedAt: Date
}
