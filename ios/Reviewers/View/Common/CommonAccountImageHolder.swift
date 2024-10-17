import SwiftUI

struct CommonAccountImageHolder: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Rectangle()
                    .foregroundStyle(Color(.appBlueBackground))
                    .frame(width: geometry.size.width, height: geometry.size.height)

                Image(systemName: "person.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(Color.white)
                    .frame(
                        width: geometry.size.width * (52.0 / 64.0),
                        height: geometry.size.height * (52.0 / 64.0)
                    )
            }
        }
    }
}

#Preview {
    VStack {
        CommonAccountImageHolder()
            .frame(width: 60, height: 60)
            .clipShape(RoundedRectangle(cornerRadius: 8))

        CommonAccountImageHolder()
            .frame(width: 30, height: 30)
            .clipShape(RoundedRectangle(cornerRadius: 4))
    }
}
