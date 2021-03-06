//
//  HomeView.swift
//  Neeo
//
//  Created by Артём Мошнин on 6/3/21.
//

import SwiftUI

struct HomeView: View {
    // MARK: - State
    @State var isSheetOpen = false
    
    // MARK: - UI Components
    var body: some View {
        NavigationView {
            ProjectsListView()
                .sheet(isPresented: self.$isSheetOpen, content: { ProjectEditView() })
        } //: NAVIGATION_VIEW
        .navigationBarTitle("Projects")
        .navigationBarItems(trailing: self.addButton())
    }
    
    private func addButton() -> some View {
        Button(action: { self.isSheetOpen.toggle() }) {
            Image(systemName: "plus")
        } //: BUTTON
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
