//
//  ProjectsViewModel.swift
//  Neeo
//
//  Created by Артём Мошнин on 6/3/21.
//

import SwiftUI
import Combine
import FirebaseFirestore

class ProjectsViewModel: ObservableObject {
    // MARK: - Public properties
    @Published var projects = [Project]()
    @Published var lastDoc: QueryDocumentSnapshot?
    
    // MARK: - Internal properties
    private let path = "projects"
    private var store = Firestore.firestore()
    
    // MARK: - Constructors
    
    // MARK: - Firestore
    func getProjects() {
        let request = store.collection(path)
        if let lastDoc = self.lastDoc {
            let tempItem = Project(id: "JAJA\(self.projects.count)", title: "treterer", description: "rere", shown: false)
            self.projects.append(tempItem)
            withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                self.projects[self.projects.count - 1].shown.toggle()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.projects.removeLast()
                request.start(afterDocument: lastDoc).getDocuments { (snap, error) in
                                guard let documents = snap?.documents else {
                                    print("No documents")
                                    return
                                }
                
                               
                                self.projects.append(contentsOf: documents.compactMap({ (queryDocumentSnapshot) in
                                    try? queryDocumentSnapshot.data(as: Project.self)
                                }))
                
                                self.lastDoc = documents.last
            }
            }
        } else {
            request.limit(to: 8).getDocuments { (snap, error) in
                guard let documents = snap?.documents else {
                    print("No documents")
                    return
                }
                
                self.projects = documents.compactMap({ (queryDocumentSnapshot) in
                    try? queryDocumentSnapshot.data(as: Project.self)
                })
                
                self.lastDoc = documents.last
            }
        }
    }
    
    func deleteProjects(indexSet: IndexSet) {
        let projects = indexSet.lazy.map { self.projects[$0] }
        projects.forEach { (project) in
            if let documentId = project.id {
                store.collection(path).document(documentId).delete { (error) in
                    if let error = error {
                        print("Unable to remove document: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
}
