//
//  TextFieldStyling.swift
//  sti_exam
//
//  Created by Andreas Antonsson on 2024-04-22.
//

import SwiftUI

struct TextFeildStyling: ViewModifier {
    var customBgColor: Color?
    var customBgStroke: Color?
    
    func body(content: Content) -> some View {
        HStack {
            content
        }
        .frame(height: GridPoints.x6)
        .padding(.leading)
        .background(customBgColor)
        .border(.black, width: 4)
        .padding(.vertical, GridPoints.custom(0.2))
        .background(customBgStroke)
        .cornerRadius(GridPoints.custom(6))
      
//        .shadow(color: Color.white.opacity(0.8), radius: 1, x: 1, y: 1)
        .overlay(
            RoundedRectangle(cornerRadius: GridPoints.custom(6))
                .stroke(Color.mint, lineWidth: 0.5)
        )
    }
}
