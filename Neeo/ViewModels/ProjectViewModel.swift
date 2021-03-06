//
//  ProjectViewModel.swift
//  Neeo
//
//  Created by Артём Мошнин on 6/3/21.
//

import Foundation
import Combine
import FirebaseFirestore

class ProjectViewModel: ObservableObject {
    // MARK: - Public properties
    @Published var project: Project
    @Published var modified = false
    
    // MARK: - Internal properties
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Constructors
    init(project: Project = Project(title: "", description: "")) {
        self.project = project
        
        self.$project
            .dropFirst()
            .sink { [weak self] project in
                self?.modified = true
            }
            .store(in: &self.cancellables)
    }
    
    // MARK: - Firestore
    private var db = Firestore.firestore()
    private let path = "projects"
    
    private func addProject(_ project: Project) {
        do {
            let _ = try db.collection(path).addDocument(from: project)
        } catch { print(error.localizedDescription) }
    }
    
    private func updateProject(_ project: Project) {
        if let documentId = project.id {
            do {
                try db.collection(path).document(documentId).setData(from: project)
            } catch { print(error.localizedDescription) }
        }
    }
    
    private func deleteProject() {
        if let documentId = project.id {
            db.collection(path).document(documentId).delete { (error) in
                if let error = error { print(error.localizedDescription) }
            }
        }
    }
    
    // MARK: - UI Handlers
    func handleDoneTapped() {
        if let _ = project.id {
            self.updateProject(project)
        } else {
            self.addProject(project)
        }
    }
    
    func handleDeleteTapped() {
        self.deleteProject()
    }
}
