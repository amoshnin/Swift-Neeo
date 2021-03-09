//
//  ProjectEditView.swift
//  Neeo
//
//  Created by Артём Мошнин on 6/3/21.
//

import SwiftUI

enum Mode {
    case new
    case edit
}

enum Action {
    case delete
    case done
    case cancel
}

struct ProjectEditScreen: View {
    // MARK: - State
    @Environment(\.presentationMode) private var presentationMode
    @StateObject var viewModel = ProjectViewModel()
    @State private var isSheetOpen = false
    
    // MARK: - State (Initialiser-modifiable)
    var mode: Mode = .new
    var completionHandler: ((Result<Action, Error>) -> Void)?
    
    // MARK: - UI Components
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Project")) {
                    TextField("Title", text: $viewModel.project.title)
                    TextField("Description", text: $viewModel.project.description)
                } //: SECTION
                
                if self.mode == .edit {
                    Section {
                        Button("Delete book") { self.isSheetOpen.toggle() }
                            .foregroundColor(.red)
                    } //: SECTION
                }
            } //: FORM
            .navigationTitle(self.mode == .new ? "New book" : viewModel.project.title)
            .navigationBarTitleDisplayMode(self.mode == .new ? .inline : .large)
            .navigationBarItems(
                leading: cancelButtonView(),
                trailing: saveButtonView()
            )
            .actionSheet(isPresented: self.$isSheetOpen) {
                ActionSheet(title: Text("Are you sure?"), buttons:
                                [.destructive(Text("Delete book"), action: { self.handleDeleteTapped() }),
                                 .cancel()])
            }
        } //: NAVIGATION_VIEW
    }
    
    // MARK: - View Functions
    private func cancelButtonView() -> some View {
        Button(action: { self.handleCancelTapped() }) {
            Text("Cancel")
        }
    }
    
    private func saveButtonView() -> some View {
        Button(action: { self.handleDoneTapped() }) {
            Text(self.mode == .new ? "Done" : "Save")
        } //: BUTTON
        .disabled(!viewModel.modified)
    }
    
    // MARK: - Action Functions
    private func handleCancelTapped() {
        self.dismiss()
    }
    
    private func handleDoneTapped() {
        self.viewModel.handleDoneTapped()
        self.dismiss()
    }
    
    private func handleDeleteTapped() {
        viewModel.handleDeleteTapped()
        self.dismiss()
        self.completionHandler?(.success(.delete))
    }
    
    private func dismiss() {
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct ProjectEditView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectEditScreen()
    }
}
