import SwiftUI

struct SignUp: Decodable {
    let userId: Int
}

struct SignUpView: View {
    @State private var username: String = ""
    @State private var phoneNumber: String = "010"
    
    @State private var isUsernameValid: Bool = false
    @State private var isPhoneNumberValid: Bool = false
    
    @State private var showAlert = false
    @State private var userId: Int = -1
    
    var nicknameGenerated: () -> Void
    let usernameRegex = "^[^\\s]+$"
    
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
                
                HStack {
                    TextField("전화번호를 입력해주세요...", text: $phoneNumber, onCommit: {
                        // Format the phone number with dashes if it's not already formatted
                        phoneNumber = formatPhoneNumber(phoneNumber)
                    })
                    .keyboardType(.numberPad) // Ensure numeric keyboard
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
                        Text("사용가능한 닉네임과 전화번호입니다.")
                            .foregroundColor(.green)
                    } else {
                        Text("사용 불가능한 닉네임 또는 전화번호입니다.")
                            .foregroundColor(.red)
                    }
                }
                .font(.system(.subheadline))
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
                    nicknameGenerated()
                } else {
                    showAlert = true
                }
            } label: {
                Text("완료")
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("닉네임 또는 전화번호가 올바르지 않습니다!"),
                    dismissButton: .default(Text("확인")))
            }
            .padding()
            
            Spacer()
        }
    }
    
    private func signUp(_ deviceId: String, _ username: String, _ phoneNumber: String) {
        // Implement the sign-up functionality, e.g., sending the data to your server.
        // You can use Alamofire or another networking library to make the API request.
    }
    
    private func isValidPhoneNumber(_ phoneNumber: String) -> Bool {
        // Implement your phone number validation logic here.
        // For example, you can check the length or format of the phone number.
        // Return true if it's valid, false otherwise.
        return phoneNumber.count == 11 // Modify this based on your validation criteria.
    }
    
    private func formatPhoneNumber(_ phoneNumber: String) -> String {
        var formattedPhoneNumber = phoneNumber
        // Remove any existing dashes or spaces
        formattedPhoneNumber = formattedPhoneNumber.replacingOccurrences(of: "-", with: "")
        formattedPhoneNumber = formattedPhoneNumber.replacingOccurrences(of: " ", with: "")
        
        return formattedPhoneNumber
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(nicknameGenerated: {})
    }
}
