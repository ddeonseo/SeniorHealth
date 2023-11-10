//
//  HomeView.swift
//  SeniorHealth
//
//  Created by 서은서 on 11/9/23.
//

import SwiftUI

struct HomeView: View {
    @Binding var userProfile: UserProfile
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: ConsultationView()) {
                    GridButton(label: "날씨 앱 들어갈거임")
                }
                .padding(.bottom, 30)
                
                NavigationLink(destination: ExerciseView()) {
                    GridButton(label: "운동하기")
                }
                .padding(.bottom, 30)
                HStack {
                    NavigationLink(destination: RecordView()) {
                        GridButton(label: "기록하기")
                    }

                    NavigationLink(destination: EditProfileView(userProfile: $userProfile)) {
                        GridButton(label: "내 정보 수정하기")
                    }
                }
                .navigationBarBackButtonHidden(true)
//                .padding(.bottom, 20)
                
            }
            .padding(20)
            .navigationTitle("활기찬 하루를 시작해요")
            .foregroundColor(Color.indigo)

        }
    }
}


struct ExerciseView: View {
    var body: some View {
        Text("운동하기 화면")
            .navigationBarTitle("운동하기", displayMode: .inline)
    }
}

struct RecordView: View {
    var body: some View {
        Text("기록하기 화면")
            .navigationBarTitle("기록하기", displayMode: .inline)
    }
}

struct ConsultationView: View {
    var body: some View {
        Text("상담하기 화면")
            .navigationBarTitle("상담하기", displayMode: .inline)
    }
}


struct GridButton: View {
    var label: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(height: 150)
                .foregroundColor(Color.teal)
                .shadow(color: Color.gray, radius: 5, x: 0, y: 2)
            
            Text(label)
                .font(.title)
                .bold()
                .foregroundColor(Color.white)
                .padding()
        }
    }
}


//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
