import SwiftUI

struct ReviewListView: View {
    @StateObject var viewState: ReviewListViewState
    
    var body: some View {
        NavigationStack(path: $viewState.path) {
            ZStack(alignment: .bottomTrailing) {
                List {
                    Button {
                        viewState.tapped()
                    } label: {
                        ReviewListRow()
                    }
                    .listRowInsets(EdgeInsets())
                }
                .listStyle(.inset)
                
                Button {
                    viewState.tapped()
                } label: {
                    VStack {
                        Image(systemName: "plus")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 28, height: 28)
                            .foregroundStyle(Color.white)
                    }
                    .frame(width: 48, height: 48)
                    .background(Color(.appGreenBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding(12)
                }

            }
            .onAppear {
                viewState.onAppear()
            }
            .navigationDestination(for: ReviewListViewPath.self) { pathValue in
                switch pathValue {
                case let .study(title, questions):
                    StudyView(viewState: StudyViewState(title: title, questions: questions, results: []))
                case .reviewDetail(title: let title):
                    ReviewDetailView(viewState: ReviewDetailViewState())
                }
            }            
            .scrollIndicators(.hidden)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(viewState.title)
                        .font(.system(size: 16).bold())
                        .foregroundStyle(Color.white)
                }
            }
            .toolbarBackground(Color(.appMain), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}

#Preview {
    ReviewListView(viewState: ReviewListViewState())
}








//            ZStack(alignment: .bottom) {
//                ScrollView {
//                    if let primariCategory = viewState.primariCategory {
//                        VStack {
//                            Picker("", selection: $viewState.favoriteColor) {
//                                ForEach(Array(primariCategory.secondaryCategories.enumerated()), id: \.element.hashValue) { index, secondaryCategory in
//                                    Text(secondaryCategory.title).tag(index)
//                                }
//                            }
//                            .pickerStyle(.segmented)
//                            .padding(.top, 16)
//                            .padding(.horizontal, 16)
//                            .padding(.bottom, 16)
//
//                            ForEach(primariCategory.secondaryCategories[viewState.favoriteColor].tertiaryCategories, id: \.hashValue) { tertiaryCategory in
//                                NavigationLink {
//                                    StudyCategoryDetailView(viewState: StudyCategoryDetailViewState(category: tertiaryCategory))
//                                } label: {
//                                    StudyCategoryListViewRow(title: tertiaryCategory.title)
//                                }
//                            }
//
//                            Spacer()
//                                .frame(height: 160)
//                        }
//
//                    } else {
//                        Text("Loading")
//                    }
//                }

//                VStack(spacing: 8) {
//                    HStack(spacing: 8) {
//                            Button {
//                                viewState.matigaeta()
//                            } label: {
//                                Text("間違えた問題")
//                                    .font(.system(size: 18).bold())
//                                    .foregroundStyle(Color.white)
//                                    .frame(height: 48)
//                                    .frame(minWidth: 0, maxWidth: .infinity)
//                                    .background(Color(.appBlueBackground))
//                                    .clipShape(RoundedRectangle(cornerRadius: 8))
//                            }
//
//                        Button {
//                            viewState.check()
//                        } label: {
//                            Text("チェックから出題")
//                                .font(.system(size: 18).bold())
//                                .foregroundStyle(Color.white)
//                                .frame(height: 48)
//                                .frame(minWidth: 0, maxWidth: .infinity)
//                                .background(Color(.appRedBackground))
//                                .clipShape(RoundedRectangle(cornerRadius: 8))
//                        }
//                    }
//                    .padding(.horizontal, 16)
//
//                    Button {
//                        viewState.random()
//                    } label: {
//                        Text("ランダムに出題")
//                            .font(.system(size: 18).bold())
//                            .foregroundStyle(Color.white)
//                            .frame(height: 48)
//                            .frame(minWidth: 0, maxWidth: .infinity)
//                            .background(Color(.appGreenBackground))
//                            .clipShape(RoundedRectangle(cornerRadius: 8))
//                            .padding(.horizontal, 16)
//                            .padding(.bottom, 8)
//                    }
//
//                }
//                .clipped()

//                if viewState.showingCover {
//                    VStack(spacing: 24) {
//                        CommonText(text: "問題を取得しています", font: .mPlus2Medium(size: 18), lineHeight: 18)
//                            .foregroundStyle(Color.white)
//
//                        ProgressView()
//                            .scaleEffect(1.8)
//                    }
//                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
//                    .background(
//                        Color.black
//                            .opacity(0.3)
//                            .ignoresSafeArea(.all)
//                    )
//                }




