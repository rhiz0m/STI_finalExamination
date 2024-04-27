//
//  TopBar.swift
//  sti_exam
//
//  Created by Andreas Antonsson on 2024-04-26.
//

import SwiftUI

struct TopBar: View {
    @ObservedObject var authDbViewAdapter: AuthDbViewAdapter
    
    var body: some View {
        HStack(alignment: .center) {
            Image("logo")
                .resizable()
                .frame(width: 80, height: 80)
                .scaledToFit()
                .cornerRadius(50)
                .overlay(
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(Color.gray, lineWidth: 2)
                )
            Spacer()
            Text(LocalizedStrings.welcome)
                .font(.title).bold()
                .foregroundStyle(.black)
            Spacer()
            Button(action: {
                authDbViewAdapter.logout()
            }, label: {
                RoundedBtn(icon: authDbViewAdapter.systemImages.power)
            }).background(.black).cornerRadius(50)
            
        }
        .padding(.vertical, GridPoints.half)
        .padding(.horizontal, GridPoints.x2)
        Spacer()
    }
    struct ViewModel {
        let logoutAction: () -> Void
    }

}

#Preview {
    TopBar(authDbViewAdapter: AuthDbViewAdapter())
}
