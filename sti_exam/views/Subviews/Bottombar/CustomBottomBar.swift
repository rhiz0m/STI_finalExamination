//
//  CustomBottomBar.swift
//  sti_exam
//
//  Created by Andreas Antonsson on 2024-04-03.
//

import SwiftUI

struct CustomBottomBar: View {
    @Binding var tabSelection: Int
    @Namespace private var animationNamespace
    
    let tabBarItems: [(image: String, title: String)] = [
        ("dumbbell.fill", LocalizedStrings.list),
        ("plus.circle.fill", LocalizedStrings.add),
        ("magnifyingglass.circle.fill", LocalizedStrings.search),
        ("map.fill", LocalizedStrings.map)
    ]
    
    var body: some View {
        HStack() {
            ForEach(0..<tabBarItems.count) { index in
                Button(action: {
                    tabSelection = index + 1
                }, label: {
                    VStack() {
                        PrimaryBtnStyle(title: tabBarItems[index].title, icon: tabBarItems[index].image, fontSize: 12)
                        if index + 1 == tabSelection {
                            Capsule().frame(height: 6).foregroundColor(CustomColors.cyan).matchedGeometryEffect(id: LocalizedStrings.selectedTabId, in: animationNamespace).offset(y: 3)
                            
                        } else {
                            Capsule()
                                .frame(height: 8)
                                .foregroundColor(.clear)
                                .offset(y: 3)
                            
                        }
                    }
                    .padding(.vertical, GridPoints.x2)
                    .padding(.horizontal, GridPoints.x1)
                })
            }
        }
        .background(.black)
    }
}

