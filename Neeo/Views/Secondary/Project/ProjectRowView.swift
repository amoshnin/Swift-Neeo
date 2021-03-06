//
//  ProjectRowView.swift
//  Neeo
//
//  Created by Артём Мошнин on 6/3/21.
//

import SwiftUI
import PureSwiftUI

struct ProjectRowView: View {
    var projectViewModel: ProjectViewModel
    
    var body: some View {
        HStack {
            Text(projectViewModel.project.title)
        }
    }
}

private struct CheckboxShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        return path
    }
}

struct ProjectRowView_Previews: PreviewProvider {
    static var previews: some View {
        let project = projectsTestData[0]
        ProjectRowView(projectViewModel: project)
            .previewSizeThatFits()
            .padding()
    }
}
