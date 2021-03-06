//
//  ProjectDetailsView.swift
//  Neeo
//
//  Created by Артём Мошнин on 6/3/21.
//

import SwiftUI

struct ProjectDetailsView: View {
    // MARK: - State
    
    
    // MARK: - State (Initialiser-modifiable)
    var project: Project
    
    // MARK: - UI Components
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
     
    private func editButton() -> some View {
        Button(action: {}) {
            Text("Edit")
        }
    }
}

struct ProjectDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let project = Project(title: "Changer", description: "Some long description")
        return ProjectDetailsView(project: project)
    }
}
