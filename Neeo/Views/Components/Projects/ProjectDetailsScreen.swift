//
//  ProjectDetailsView.swift
//  Neeo
//
//  Created by Артём Мошнин on 6/3/21.
//

import SwiftUI

struct ProjectDetailsScreen: View {
    // MARK: - State
    @Environment(\.presentationMode) var presentationMode
    @State var isSheetOpen = false
    
    // MARK: - State (Initialiser-modifiable)
    var project: Project
    
    // MARK: - UI Components
    var body: some View {
        Form {
            Text(project.title)
            Text(project.description)
        } //: FORM
        .navigationBarTitle(project.title)
        .navigationBarItems(trailing: editButton { self.isSheetOpen.toggle() } )
        .sheet(isPresented: self.$isSheetOpen) {
            ProjectEditScreen(viewModel: ProjectViewModel(project: self.project), mode: .edit) { (result) in
                if case .success(let action) = result, action == .delete {
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
    
    private func editButton(action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text("Edit")
        }
    }
}

struct ProjectDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let project = Project(title: "Changer", description: "Some long description")
        return ProjectDetailsScreen(project: project)
    }
}
