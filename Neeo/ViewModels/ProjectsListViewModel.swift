//
//  ProjectListViewModel.swift
//  Neeo
//
//  Created by Артём Мошнин on 5/3/21.
//

import Combine

class ProjectsListViewModel: ObservableObject {
    @Published var repository = ProjectsRepository()
    @Published var viewModels = [ProjectViewModel]()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        repository
            .$projects.map { projects in
                print(projects, "in listviewmodel")
                return projects.map(ProjectViewModel.init)
            }
            .assign(to: \.viewModels, on: self)
            .store(in: &cancellables)
    }
    
    func add(_ project: ProjectModel) { repository.add(project) }
}
