import SwiftUI

struct StudyCategoryDetailView: View {
    @Environment(\.dismiss) var dismiss
    @State var viewState: StudyCategoryDetailViewState

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack {

                    
                    
                    
//                    ForEach(viewState.category.questions, id: \.self) { questionCategory in
//                        NavigationLink {
//                            Text("XX")
//                        } label: {
//                            ReviewListViewRow(title: questionCategory.title)
//                        }
//                    }

                    //                    NavigationLink {
                    //                        StudyCategoryDetailView()
                    //                    } label: {
                    //                        StudyCategoryListViewRow(title: <#String#>)
                    //                    }
                    //

                    //
                    //                    NavigationLink {
                    //                        Text("XX")
                    //                    } label: {
                    //                        StudyCategoryListViewRow()
                    //                    }
                    //
                    //                    NavigationLink {
                    //                        Text("XX")
                    //                    } label: {
                    //                        StudyCategoryListViewRow()
                    //                    }
                    //
                    //                    NavigationLink {
                    //                        Text("XX")
                    //                    } label: {
                    //                        StudyCategoryListViewRow()
                    //                    }
                    //
                    //                    NavigationLink {
                    //                        Text("XX")
                    //                    } label: {
                    //                        StudyCategoryListViewRow()
                    //                    }
                    //
                    //                    NavigationLink {
                    //                        Text("XX")
                    //                    } label: {
                    //                        StudyCategoryListViewRow()
                    //                    }
                    //
                    //                    NavigationLink {
                    //                        Text("XX")
                    //                    } label: {
                    //                        StudyCategoryListViewRow()
                    //                    }
                    //
                    //                    NavigationLink {
                    //                        Text("XX")
                    //                    } label: {
                    //                        StudyCategoryListViewRow()
                    //                    }

                    Spacer()
                        .frame(height: 160)
                }
            }

//            VStack(spacing: 8) {
//                HStack(spacing: 8) {
//                    Button {
//
//                    } label: {
//                        Text("間違えた問題")
//                            .font(.system(size: 18).bold())
//                            .foregroundStyle(Color.white)
//                            .frame(height: 48)
//                            .frame(minWidth: 0, maxWidth: .infinity)
//                            .background(Color(.appBlueBackground))
//                            .clipShape(RoundedRectangle(cornerRadius: 8))
//                    }
//
//                    Button {
//
//                    } label: {
//                        Text("チェックから出題")
//                            .font(.system(size: 18).bold())
//                            .foregroundStyle(Color.white)
//                            .frame(height: 48)
//                            .frame(minWidth: 0, maxWidth: .infinity)
//                            .background(Color(.appRedBackground))
//                            .clipShape(RoundedRectangle(cornerRadius: 8))
//                    }
//                }
//                .padding(.horizontal, 16)
//
//                Button {
//
//                } label: {
//                    Text("ランダムに出題")
//                        .font(.system(size: 18).bold())
//                        .foregroundStyle(Color.white)
//                        .frame(height: 48)
//                        .frame(minWidth: 0, maxWidth: .infinity)
//                        .background(Color(.appGreenBackground))
//                        .clipShape(RoundedRectangle(cornerRadius: 8))
//                        .padding(.horizontal, 16)
//                        .padding(.bottom, 8)
//                }
//            }
//            .clipped()
        }
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
//
//            ToolbarItem(placement: .principal) {
//                Text(viewState.title)
//                    .font(.system(size: 16).bold())
//                    .foregroundStyle(Color.white)
//            }

        }
        .toolbarBackground(Color(.appMain), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

//#Preview {
//    StudyCategoryDetailView(viewState: StudyCategoryDetailViewState(category: TertiaryCategory(title: "Title", questions: [])))
//}
