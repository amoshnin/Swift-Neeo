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
    init() {
        for index in 0...10 {
            let temp = Project(id: "A\(index)", title: "", description: "", shown: false)
            self.projects.append(temp)
            
            withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                self.projects[index].shown.toggle()
            }
        }
    }
    
    // MARK: - Firestore
    func getProjects() {
        let request = store.collection(path)
        if let lastDoc = self.lastDoc {
            
            if self.projects.last?.id != "temp" {
                self.projects.append(Project(id: "temp", title: "", description: "", shown: false))
                
                withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                    self.projects[self.projects.count - 1].shown.toggle()
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    request.start(atDocument: lastDoc).limit(to: 2).getDocuments { (snap, error) in
                        if error != nil {
                            return
                        }
                        
                        guard let documents = snap?.documents else {
                            print("No documents")
                            return
                        }
                        
                        self.projects.removeLast()
                        if !documents.isEmpty {
                            self.projects.appendDistinct(contentsOf:  documents.compactMap({ (queryDocumentSnapshot) in
                                try? queryDocumentSnapshot.data(as: Project.self)
                            }),  where: {(one, two) -> Bool in return one.id != two.id}
                            )
                        }
                        
                        self.lastDoc = documents.last
                    }
                }
            }
        } else {
            request.limit(to: 2).getDocuments { (snap, error) in
                if error != nil {
                    return
                }
                
                
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
}

extension Array{
    public mutating func appendDistinct<S>(contentsOf newElements: S, where condition:@escaping (Element, Element) -> Bool) where S : Sequence, Element == S.Element {
        newElements.forEach { (item) in
            if !(self.contains(where: { (selfItem) -> Bool in
                return !condition(selfItem, item)
            })) {
                self.append(item)
            }
        }
    }
}
