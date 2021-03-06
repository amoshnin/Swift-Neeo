//
//  ProjectItemView.swift
//  Neeo
//
//  Created by Артём Мошнин on 6/3/21.
//

import SwiftUI

struct ProjectItemView: View {
    var project: Project
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(self.project.title)
                    .font(.title3)
                
                Text(self.project.description)
                    .font(.subheadline)
            }
            
            Spacer()
        }
        
    }
}

struct ProjectItemView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectItemView(project: Project(title: "Some title", description: "Some description"))
    }
}
