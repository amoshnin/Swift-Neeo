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
    @State private var time = Timer.publish(every: 0.1, on: .main, in: .tracking).autoconnect()
    
    
    // MARK: - UI Components
    var body: some View {
        // LazyGridView columns
        let columns = [GridItem(.flexible())]
        VStack(alignment: .leading, spacing: 20) {
            LazyVGrid(columns: columns, spacing: 20) {
                
                ForEach(self.viewModel.projects) { project in
                    
                    ZStack {
                        if self.viewModel.projects.last?.id == project.id {
                            self.lastProjectView(project: project)
                        } else {
                            ProjectItemView(project: project)
                        }
                    }
                }
            } //: LAZY_V_GRID
            .padding(.horizontal)
        } //: VSTACK
        .onAppear() { self.onAppear() }
    }
    
    // MARK: - UI Functions
    private func lastProjectView(project: Project) -> some View {
        GeometryReader { geo in
            ProjectItemView(project: project)
                .onAppear { self.time = Timer.publish(every: 0.1, on: .main, in: .tracking).autoconnect() }
                .onReceive(self.time, perform: { _ in
                    if geo.frame(in: .global).maxY < UIScreen.main.bounds.height - 80 {
                        self.updateData()
                        self.time.upstream.connect().cancel()
                    }
                })
        }
        .frame(height: 45)
    }
    
    // MARK: - Action Functions
    private func onAppear() {
        print("ProjectsListView appears. Subscribing to data updates.")
        self.viewModel.getProjects()
    }
    
    private func updateData() {
        print("Update data...")
        self.viewModel.getProjects()
    }
}

struct ProjectsListView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectsListView()
    }
}
