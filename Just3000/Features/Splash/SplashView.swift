import SwiftUI

struct SplashView: View {
    @Binding var isPresented: Bool

    var body: some View {
        ZStack {
            Color.appBackground
                .ignoresSafeArea()

            VStack {
                Image(AppImages.splashOrnamentTop)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)

                Spacer()

                Image(AppImages.splashOrnamentBottom)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
            }
            .ignoresSafeArea()

            Image(AppImages.splashLogo)
                .resizable()
                .scaledToFit()
                .frame(width: 320)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation(.easeIn(duration: 0.2)) {
                    isPresented.toggle()
                }
            }
        }
    }
}

#Preview {
    SplashView(isPresented: .constant(true))
}
