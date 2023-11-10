//
//  ContentView.swift
//  SeniorHealth
//
//  Created by 서은서 on 11/9/23.
//

import SwiftUI

struct ContentView: View {
    @State private var dummyUserProfile = UserProfile(username: "김현주", phoneNumber: "01012345678", gender: "여성", age: 0, height: 0, weight: 0, handStrength: (left: 0, right: 0), bodyFatPercentage: 0, bloodPressure: (min: 0, max: 0))

    var body: some View {
        NavigationView {
            // SignUpView에서 데이터를 업데이트하고 EditProfileView로 전달합니다.
            SignUpView(userProfile: $dummyUserProfile, nicknameGenerated: { (name, phone) in
                dummyUserProfile.username = name
                dummyUserProfile.phoneNumber = phone
            })


            EditProfileView(userProfile: $dummyUserProfile)
        }
    }
}


#Preview {
    ContentView()
}
