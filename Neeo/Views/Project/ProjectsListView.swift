//
//  ProjectsListView.swift
//  Neeo
//
//  Created by Артём Мошнин on 6/3/21.
//

import SwiftUI

struct ProjectsListView: View {
    // MARK: - State
    @StateObject var viewModel = ProjectsViewModel()
    @State var isAddProjectSheet = false
    
    // MARK: - UI Components
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.projects) { project in
                    self.projectRowView(project: project)
                }
                .onDelete() { indexSet in viewModel.deleteProjects(indexSet: indexSet) }
            } //: LIST
            .navigationBarTitle("Projects")
            .navigationBarItems(trailing: self.addButton())
            .onAppear() {
                print("ProjectsListView appears. Subscribing to data updates.")
                self.viewModel.subscribe()
            }
            .onDisappear() {
              // By unsubscribing from the view model, we prevent updates coming in from
              // Firestore to be reflected in the UI. Since we do want to receive updates
              // when the user is on any of the child screens, we keep the subscription active!
              //
              // print("BooksListView disappears. Unsubscribing from data updates.")
              // self.viewModel.unsubscribe()
            }
            .sheet(isPresented: self.$isAddProjectSheet, content: { ProjectEditView() })
        } //: NAVIGATION_VIEW
    }
    
    private func addButton() -> some View {
        Button(action: { self.isAddProjectSheet.toggle() }) {
            Image(systemName: "plus")
        } //: BUTTON
    }
    
    private func projectRowView(project: Project) -> some View {
        NavigationLink(destination: ProjectDetailsView(project: project)) {
            VStack(alignment: .leading) {
                Text(project.title)
                    .font(.headline)
                
                Text(project.description)
                    .font(.subheadline)
            } //: VSTACK
        } //: NAVIGATION_LINK
    }
}

struct ProjectsListView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectsListView()
    }
}
