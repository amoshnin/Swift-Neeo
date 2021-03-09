//
//  HomeView.swift
//  Neeo
//
//  Created by Артём Мошнин on 6/3/21.
//

import SwiftUI


struct HomeScreen: View {
    // MARK: - State
    @State var isSheetOpen = false
    
    // MARK: - UI Components
    var body: some View {
        NavigationView {
            ZStack {
                Color(darkenWhite).edgesIgnoringSafeArea(.all)
                VStack {
                        self.Header()
                        
                        ScrollView(.vertical) {
                            self.StoriesScroller()
                            ProjectsListView()
                        } //: SCROLL_VIEW
                    } //: VSTACK
                    .navigationBarHidden(true)
                .sheet(isPresented: self.$isSheetOpen, content: { ProjectEditScreen() })
            }
        } //: NAVIGATION_VIEW
    }
    
    private func Header() -> some View {
            ZStack {
                HStack {
                    self.addButton(icon: "plus.app") { self.isSheetOpen.toggle() }
                    Spacer()
                    self.addButton(icon: "paperplane") { self.isSheetOpen.toggle() }
                } //: HSTACK
                .padding()
                
                Text("Instgram")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
            }
    }
    
    
    private func addButton(icon: String, onClick: @escaping () -> ()) -> some View {
        Button(action: onClick) {
            Image(systemName: icon)
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.gray)
                .padding(.all)
                .background(Color(darkenWhite))
                .clipShape(Circle())
                .neumorphicShadow()
        } //: BUTTON
    }
    
    private func StoriesScroller() -> some View {
         Group {
            ScrollView(.horizontal) {
               StoryBadgeView()
            } //: SCROLL_VIEW
            Divider()
                .padding(.horizontal)
        } //: GROUP
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}

