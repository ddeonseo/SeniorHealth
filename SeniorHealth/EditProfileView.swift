//
//  EditProfileView.swift
//  SeniorHealth
//
//  Created by 서은서 on 11/9/23.
//
import SwiftUI

struct UserProfile {
    var username: String
    var phoneNumber: String
    var gender: String
    var age: Int
    var height: Int
    var weight: Int
    var handStrength: (left: Int, right: Int)
    var bodyFatPercentage: Int
    var bloodPressure: (min: Int, max: Int)
}

struct EditProfileView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var userProfile: UserProfile
    
    

//    @State private var dummyUserProfile = UserProfile(username: "김현주", phoneNumber: "01012345678", gender: "여성", age: 72, height: 163, weight: 50, handStrength: (left: 25, right: 18), bodyFatPercentage: 34, bloodPressure: (min: 80, max: 120))
//    
    
    @State private var age: String = ""
    @State private var height: String = ""
    @State private var weight: String = ""
    @State private var leftHandStrength: String = ""
    @State private var rightHandStrength: String = ""
    @State private var bodyFatPercentage: String = ""
    @State private var minBloodPressure: String = ""
    @State private var maxBloodPressure: String = ""
    
    @State private var showAlert: Bool = false
    
    init(userProfile: Binding<UserProfile>) {
        _userProfile = userProfile
    }

    
    func updateDummyUserProfile() {
        guard let age = Int(age),
              let height = Int(height),
              let weight = Int(weight) else {
            showAlert = true
            return
        }
        
        userProfile.age = age  // userProfile을 업데이트합니다.
        userProfile.height = height
        userProfile.weight = weight
        userProfile.handStrength.left = Int(leftHandStrength) ?? 0
        userProfile.handStrength.right = Int(rightHandStrength) ?? 0
        userProfile.bodyFatPercentage = Int(bodyFatPercentage) ?? 0
        userProfile.bloodPressure.min = Int(minBloodPressure) ?? 0
        userProfile.bloodPressure.max = Int(maxBloodPressure) ?? 0
    }

    
    
    var body: some View {
        Form {
            Section(header: Text("개인 정보")) {
                Text("나이")
                TextField("나이", text: $age)
                    .keyboardType(.numberPad)
                
                Text("키 (cm)")
                TextField("키", text: $height)
                    .keyboardType(.numberPad)
                
                Text("몸무게 (kg)")
                TextField("몸무게", text: $weight)
                    .keyboardType(.numberPad)
            }
            
            Section(header: Text("체력 정보")) {
                HStack {
                    VStack {
                        Text("왼손 악력 (kg)")
                        TextField("kg", text: $leftHandStrength)
                            .keyboardType(.numberPad)
                    }
                    Spacer()
                    VStack {
                        Text("오른손 악력 (kg)")
                        TextField("kg", text: $rightHandStrength)
                            .keyboardType(.numberPad)
                    }
                }
                
                Text("체지방률")
                TextField("체지방률", text: $bodyFatPercentage)
                    .keyboardType(.numberPad)
            }
            
            Section(header: Text("혈압 정보")) {
                HStack {
                    VStack {
                        Text("최저 혈압")
                        TextField("최저 혈압", text: $minBloodPressure)
                            .keyboardType(.numberPad)
                    }
                    Spacer()
                    VStack {
                        Text("최고 혈압")
                        TextField("최고 혈압", text: $maxBloodPressure)
                            .keyboardType(.numberPad)
                    }
                }
            }
            
            Button(action: {
                // 저장 또는 업데이트 작업 수행
                updateDummyUserProfile()
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("저장")
                    .font(.title)
                    .frame(maxWidth: .infinity)
            }
        }
        .navigationBarTitle("내 정보 수정하기", displayMode: .inline)
        .alert(isPresented: $showAlert) {
            Alert(
            title: Text("나이, 키, 몸무게"),
            message: Text("반드시 입력해주세요"),
            dismissButton: .default(Text("확인"))
            )
        }
    }
}

//struct EditProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditProfileView()
//    }
//}
