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

struct ProjectEditView: View {
    // MARK: - State
    @Environment(\.presentationMode) private var presentationMode
    @State var isActionSheetPresent = false
    
    // MARK: - State (Initialiser-modifiable)
    @StateObject var viewModel = ProjectViewModel()
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
                        Button("Delete book") { self.isActionSheetPresent.toggle() }
                            .foregroundColor(.red)
                    } //: SECTION
                }
            } //: FORM
            .navigationTitle(self.mode == .new ? "New book" : viewModel.project.title)
            .navigationBarTitleDisplayMode(self.mode == .new ? .inline : .large)
            .navigationBarItems(
                leading: cancelButton(),
                trailing: saveButton()
            )
            .actionSheet(isPresented: self.$isActionSheetPresent) {
                ActionSheet(title: Text("Are you sure?"), buttons:
                                [.destructive(Text("Delete book"), action: { self.handleDeleteTapped() }),
                                 .cancel()])
            }
        } //: NAVIGATION_VIEW
    }
    
    private func cancelButton() -> some View {
        Button(action: { self.handleCancelTapped() }) {
            Text("Cancel")
        }
    }
    
    private func saveButton() -> some View {
        Button(action: { self.handleDoneTapped() }) {
            Text(self.mode == .new ? "Done" : "Save")
        } //: BUTTON
        .disabled(!viewModel.modified)
    }
    
    // MARK: - Action Handlers
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
        ProjectEditView()
    }
}
