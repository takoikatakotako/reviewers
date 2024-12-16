import SwiftUI
import SDWebImageSwiftUI
import LicenseList

struct ContactView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewState: ContactViewState

    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    VStack(alignment: .leading, spacing: 0) {
                        CommonText(text: "ユーザーID", font: Font.mPlus2SemiBold(size: 16), lineHeight: 32, alignment: .leading)
                        CommonText(text: viewState.uid, font: Font.mPlus2Regular(size: 16), lineHeight: 32, alignment: .leading)
                    }

                    VStack(alignment: .leading, spacing: 0) {
                        CommonText(text: "メールアドレス", font: Font.mPlus2SemiBold(size: 16), lineHeight: 32, alignment: .leading)
                        CommonText(text: "返信が必要な場合は入力をお願いします。", font: Font.mPlus2Regular(size: 16), lineHeight: 32, alignment: .leading)

                        TextField("", text: $viewState.email)
                            .foregroundStyle(Color.black)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 8)
                            .background(RoundedRectangle(cornerRadius: 8).fill(Color.white))
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(lineWidth: 1)
                                    .foregroundStyle(Color(.appSubText))
                            )
                    }

                    VStack(alignment: .leading, spacing: 0) {
                        CommonText(text: "お問い合わせ内容", font: Font.mPlus2SemiBold(size: 16), lineHeight: 32, alignment: .leading)
                        TextField("", text: $viewState.message, axis: .vertical)
                            .lineLimit(20)
                            .foregroundStyle(Color.black)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 8)
                            .background(RoundedRectangle(cornerRadius: 8).fill(Color.white))
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(lineWidth: 1)
                                    .foregroundStyle(Color(.appSubText))
                            )
                    }
                }
                .padding(16)
                .frame(minWidth: 0, maxWidth: .infinity)
            }

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
        .onAppear {
            viewState.onAppear()
        }
        .gesture(
            DragGesture(minimumDistance: 20, coordinateSpace: .global)
                .onChanged { value in
                    guard value.startLocation.x < 20, value.translation.width > 45 else { return }
                    dismiss()
                }
        )
        .alert("", isPresented: $viewState.showingCompleteAlert, actions: {
            Button("とじる", role: .none) {
                dismiss()
            }
        }, message: {
            Text("お問い合わせが完了しました。")
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

            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    viewState.sendMessage()
                } label: {
                    CommonText(text: "送信", font: Font.mPlus2SemiBold(size: 16), lineHeight: 32)
                        .foregroundStyle(Color.white)
                        .padding(.leading, 8)
                }
            }
        }
        .toolbarBackground(Color(.appMain), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    NavigationStack {
        ContactView(viewState: ContactViewState())
    }
}
