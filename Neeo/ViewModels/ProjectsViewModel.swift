//
//  ProjectsViewModel.swift
//  Neeo
//
//  Created by Артём Мошнин on 6/3/21.
//

import Foundation
import Combine
import FirebaseFirestore

class ProjectsViewModel: ObservableObject {
    // MARK: - Public properties
    @Published var projects = [Project]()
    
    // MARK: - Internal properties
    private let path = "projects"
    private var db = Firestore.firestore()
    private var listenerRegistration: ListenerRegistration?
    
    // MARK: - Constructors
    deinit {
        self.unsubscribe()
    }
    
    // MARK: - Firestore
    func unsubscribe() {
        if self.listenerRegistration != nil {
            self.listenerRegistration?.remove()
            self.listenerRegistration = nil
        }
    }
    
    func subscribe() {
        if listenerRegistration == nil {
            listenerRegistration = db.collection(path).addSnapshotListener({ (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                
                self.projects = documents.compactMap({ (queryDocumentSnapshot) in
                    try? queryDocumentSnapshot.data(as: Project.self)
                })
            })
        }
    }
    
    func deleteProjects(indexSet: IndexSet) {
        let projects = indexSet.lazy.map { self.projects[$0] }
        projects.forEach { (project) in
            if let documentId = project.id {
                db.collection(path).document(documentId).delete { (error) in
                    if let error = error {
                        print("Unable to remove document: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
}
