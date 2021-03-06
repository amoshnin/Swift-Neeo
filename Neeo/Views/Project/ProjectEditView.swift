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
    
    // MARK: - State (Initialiser-modifiable)
    
    // MARK: - UI Components
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
    // MARK: - Action Handlers
}

struct ProjectEditView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectEditView()
    }
}
