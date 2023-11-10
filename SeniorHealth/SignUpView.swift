import SwiftUI

struct SignUp: Decodable {
    let userId: Int
}

struct SignUpView: View {
    @Binding var userProfile: UserProfile
    
    @State private var username: String = ""
    @State private var phoneNumber: String = "010"
    
    @State private var selectedGender = "남성"
    @State private var isUsernameValid: Bool = false
    @State private var isPhoneNumberValid: Bool = false
    
    @State private var isComplete = false
    
    @State private var showAlert = false
    @State private var userId: Int = -1
    
    var nicknameGenerated: (String, String) -> Void
    let usernameRegex = "^[^\\s]+$"
    
    let genderOptions = ["남성", "여성"]
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Spacer()
                
                Text("회원가입")
                    .font(.system(.title))
                    .bold()
                    .padding()
                
                HStack {
                    TextField("이름을 입력해주세요...", text: $username)
                        .onChange(of: username) { newValue in
                            isUsernameValid = newValue.range(of: usernameRegex, options: .regularExpression) != nil
                        }
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                        .onTapGesture {
                            username = ""
                        }
                }
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 15.0)
                        .strokeBorder()
                }
                
                Picker("성별", selection: $selectedGender) {
                    ForEach(genderOptions, id: \.self) {
                        Text($0)
                            .font(.system(size: 20))
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(maxWidth: .infinity)
                .padding()
                .background(RoundedRectangle(cornerRadius: 15.0).strokeBorder())
                
                HStack {
                    TextField("전화번호를 입력해주세요...", text: $phoneNumber)
                        .keyboardType(.numberPad)
                        .onChange(of: phoneNumber) { newValue in
                            isPhoneNumberValid = isValidPhoneNumber(newValue)
                                            }
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                        .onTapGesture {
                            phoneNumber = "010"
                        }
                }
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 15.0)
                        .strokeBorder()
                }
                
                VStack(alignment: .trailing) {
                    if isUsernameValid && isPhoneNumberValid {
                        Text("사용가능한 이름과 전화번호입니다.")
                            .foregroundColor(.green)
                    } else {
                        Text("사용 불가능한 이름 혹은 전화번호입니다.")
                            .foregroundColor(.red)
                    }
                }
//                .font(.system(.subheadline))
                .font(.system(size:16))
                .padding()
                
                Spacer()
            }
            .frame(width: 300)
            .padding()
            
            Button {
                if isUsernameValid && isPhoneNumberValid {
                    let nickname = username
                    let phone = phoneNumber
                    let deviceId = ""
                    signUp(deviceId, nickname, phone)
                    nicknameGenerated(nickname, phone)
                    isComplete = true
                } else {
                    showAlert = true
                }
            } label: {
                Text("완료")
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("입력이 올바르지 않습니다!"),
                    dismissButton: .default(Text("확인")))
            }
            .padding()
            .background(
                NavigationLink(destination: HomeView(userProfile: $userProfile), isActive: $isComplete) {
                    EmptyView()
                }
            )
        }
        
    }
    
    private func signUp(_ deviceId: String, _ username: String, _ phoneNumber: String) {
        // Need to implement
    }
    
    private func isValidPhoneNumber(_ phoneNumber: String) -> Bool {
        let phoneNumberDigits = phoneNumber.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "-", with: "")
//        return phoneNumberDigits.count == 11
        return phoneNumberDigits.hasPrefix("010") && phoneNumberDigits.count == 11
    }
}

//struct SignUpView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpView()
//    }
//}
