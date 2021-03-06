//
//  ContentView.swift
//  Neeo
//
//  Created by Артём Мошнин on 5/3/21.
//

import SwiftUI

struct HomeView: View {
    @State private var showForm: Bool = false
    @ObservedObject var projectsListViewModel: ProjectsListViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                self.list(projects: projectsListViewModel.viewModels)
            } //: VSTACK
            .sheet(isPresented: self.$showForm,
                   content: { ProjectForm(showForm: self.$showForm, projectsListViewModel: projectsListViewModel) })
            
            .navigationBarItems(trailing: Button("Add new") { self.showForm.toggle() })
        } //: NAVIGATION_VIEW
    }
    
    private func list(projects: [ProjectViewModel]) -> some View {
        return List {
            ForEach(0..<projects.count) { index in
                ProjectRowView(project: projects[index])
            }
        }
    }
}

private struct ProjectForm: View {
    @Binding var showForm: Bool
    var projectsListViewModel: ProjectsListViewModel
    
    @State private var text: String = ""
    @State private var dueDate = Date()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Information")) {
                    TextField("Title", text: self.$text)
                } //: SECTION
                
                DatePicker("Please select the due date", selection: self.$dueDate)
                
                Button("Submit") {
                    self.addProject(title: text)
                    self.showForm = false
                } //: BUTTON
            } //: FORM
            .navigationBarTitle("New Project")
        } //: NAVIGATION_VIEW
    }
    
    private func addProject(title: String) {
        let project = ProjectModel(title: title, createdAt: Date(), updatedAt: Date())
        projectsListViewModel.add(project)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(projectsListViewModel: ProjectsListViewModel())
    }
}
