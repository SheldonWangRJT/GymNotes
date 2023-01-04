//
//  ProfileView.swift
//  GymNotes
//
//  Created by Xiaodan Wang on 1/3/23.
//

import SwiftUI

struct ProfileView: View {
    
    enum Const {
        static let imgWidth:CGFloat = 80
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName:"person.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: Const.imgWidth, height: Const.imgWidth)
                    .foregroundColor(.primary)
                    .shadow(color: .gray, radius: Const.imgWidth/2)
                    .backgroundStyle(.green)
                    .clipShape(Capsule())
                Text("Proile View".uppercased())
            }
        }.navigationTitle("My Proile")
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
