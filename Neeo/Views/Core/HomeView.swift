//
//  HomeView.swift
//  Neeo
//
//  Created by Артём Мошнин on 6/3/21.
//

import SwiftUI

let darkenWhite = #colorLiteral(red: 0.9305374026, green: 0.9509723783, blue: 0.9908421636, alpha: 1)
let purplish = #colorLiteral(red: 0.3607843137, green: 0.4941176471, blue: 0.9764705882, alpha: 1)
struct HomeView: View {
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
                .sheet(isPresented: self.$isSheetOpen, content: { ProjectEditView() })
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
        HomeView()
    }
}

struct NuemorphicShadow: ViewModifier {

    
    func body(content: Content) -> some View {
            content
                .shadow(color: Color(purplish).opacity(0.6), radius: 5, x: 5, y: 5)
                .shadow(color: Color.white, radius: 5, x: -5, y: -5)

    }
}

extension View {
    func neumorphicShadow() -> some View {
        self.modifier(NuemorphicShadow())
    }
}
