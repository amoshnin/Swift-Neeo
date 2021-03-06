//
//  ProjectRepository.swift
//  Neeo
//
//  Created by Артём Мошнин on 5/3/21.
//

import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

class ProjectsRepository: ObservableObject {
    private let path: String = "projects"
    private let store = Firestore.firestore()
    
    @Published var projects = [ProjectModel]()
    
    init() {
        self.get()
    }
    
    func get() {
        store
            .collection(path)
            .addSnapshotListener { (querySnapshot, error) in
                if let error = error {
                    print("Error getting cards: \(error.localizedDescription)")
                    return
                }
                
                self.projects = querySnapshot?.documents.compactMap { document in
                    try? document.data(as: ProjectModel.self)
                } ?? []
            }
    }
    
    func add(_ project: ProjectModel) {
        do {
            _ =  try store.collection(path).addDocument(from: project)
        } catch { fatalError("Unable to add the project: \(error.localizedDescription)") }
    }
}
