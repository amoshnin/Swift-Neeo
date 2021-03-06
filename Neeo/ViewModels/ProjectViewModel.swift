//
//  ProjectViewModel.swift
//  Neeo
//
//  Created by Артём Мошнин on 6/3/21.
//

import Combine
import SwiftUI

class ProjectViewModel: ObservableObject, Identifiable {
    private let repository = ProjectsRepository()
    private var cancellables = Set<AnyCancellable>()
    
    @Published var project: ProjectModel
    var id: UUID?
    
    init(project: ProjectModel) {
        self.project = project
        
        $project
            .compactMap { $0.id }
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
    }
}
