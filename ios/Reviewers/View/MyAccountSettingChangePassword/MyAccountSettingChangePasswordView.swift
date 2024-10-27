import SwiftUI
import SDWebImageSwiftUI
import LicenseList

struct MyAccountSettingChangePasswordView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewState: MyAccountSettingChangePasswordViewState
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                VStack(alignment: .leading, spacing: 12) {
                    CommonText(text: "\(viewState.email) にパスワードリセットメールを送ります。", font: .mPlus2Medium(size: 14), lineHeight: 24, alignment: .leading)
                        .foregroundStyle(Color(.appMainText))
                }
                
                Button {
                    viewState.resetPassword()
                } label: {
                    HStack {
                        Spacer()
                        CommonText(text: "パスワードをリセット", font: .mPlus2Bold(size: 14), lineHeight: 20)
                            .foregroundStyle(Color(.white))
                        
                        Spacer()
                    }
                    .frame(height: 48)
                    .background(Color(.appGreenBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .disabled(viewState.indicator)
                .padding(.top, 24)
                
                Spacer()
            }
            .padding(16)
            
            if viewState.indicator {
                ProgressView()
                    .progressViewStyle(.circular)
                    .padding()
                    .tint(Color.white)
                    .background(Color.gray)
                    .cornerRadius(8)
                    .scaleEffect(1.2)
            }
        }
        .alert(
            "",
               isPresented: $viewState.showingFinishAlert,
            actions: {},
            message: {
            Text("パスワードリセットメールを送信しました。メールをご確認ください。")
        })
        .alert(
            "",
            isPresented: $viewState.showingErrorAlert,
            presenting: viewState.showingErrorAlertPresenting,
            actions: { _ in
                Button("とじる", role: .none) {}
            }, message: { message in
                Text(message)
            }
        )
        .scrollIndicators(.hidden)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                        .foregroundStyle(Color.white)
                        .padding(.vertical, 8)
                        .padding(.trailing, 8)
                }
            }
            
            ToolbarItem(placement: .principal) {
                Text("パスワード変更")
                    .font(.system(size: 16).bold())
                    .foregroundStyle(Color.white)
            }
            
        }
        .toolbarBackground(Color(.appMain), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        
    }
}
#Preview {
    NavigationStack {
        MyAccountSettingChangePasswordView(viewState: MyAccountSettingChangePasswordViewState(email: "takoikatakotako@example.com"))
    }
}
