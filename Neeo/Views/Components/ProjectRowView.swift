//
//  ProjectRowView.swift
//  Neeo
//
//  Created by Артём Мошнин on 6/3/21.
//

import SwiftUI

struct ProjectRowView: View {
    var project: ProjectViewModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ProjectRowView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectRowView(project: ProjectViewModel(project: ProjectModel(title: "", createdAt: Date(), updatedAt: Date())))
    }
}
