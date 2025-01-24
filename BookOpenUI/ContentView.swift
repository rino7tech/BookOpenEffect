//
//  ContentView.swift
//  BookOpenUI
//
//  Created by 伊藤璃乃 on 2025/01/25.
//
import SwiftUI

struct BookView: View {
    @State var show = false
    @State var show2 = false
    @State var move = false
    @State var close = false
    @State var isAnimating = false

    var body: some View {
        ZStack {
            ZStack {
                pageone()
                BehindCaver(show2: $show2, close: $close)
                Rectangle().foregroundStyle(.black)
                    .opacity(0.7)
                    .frame(width: 1)
                    .frame(height: 263)
                    .blur(radius: 5)
                    .offset(x: -90)
            }
            BookCaver(show: $show)
        }
        .offset(x: move ? 90 : 0)
        .onTapGesture {
            if !isAnimating {
                openBookToggle()
            }
        }
    }

    func openBookToggle() {
        isAnimating = true

        if show {
            withAnimation(.linear(duration: 1).delay(0.49)) {
                show.toggle()
            }

            withAnimation(.linear(duration: 1)) {
                show2.toggle()
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.49) {
                close = true
            }

            withAnimation(.linear(duration: 0.4).delay(0.4)) {
                move.toggle()
            }

        } else {
            close = false

            withAnimation(.linear(duration: 0.5)) {
                show.toggle()
            }
            withAnimation(.linear(duration: 1.0)) {
                show2.toggle()
            }
            withAnimation(.linear(duration: 0.4).delay(0.4)) {
                move.toggle()
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) {
            isAnimating = false
        }
    }
}

struct BookCaver: View {
    @Binding var show: Bool
    
    var body: some View {
        Image(.book).resizable().scaledToFill()
            .clipShape(UnevenRoundedRectangle(topLeadingRadius: 0, bottomLeadingRadius: 0, bottomTrailingRadius: 8, topTrailingRadius: 8, style: .continuous))
            .frame(width: 180, height: 264)
            .rotation3DEffect(
                .degrees( show ? -90 : 0),
                axis: (x: 0, y: 1, z: 0),
                anchor: .leading,
                anchorZ: 0,
                perspective: 0.3
            )
    }
}
struct BehindCaver : View {
    @Binding var show2: Bool
    @Binding var close: Bool

    var body: some View {
        ZStack {
            UnevenRoundedRectangle(topLeadingRadius: 0, bottomLeadingRadius: 0, bottomTrailingRadius: 8, topTrailingRadius: 8, style: .continuous)
            .frame(width: 180, height: 264)
            .foregroundStyle(.white)
            VStack {
                Text("SWIFTUI").font(.title.bold())
                VStack {
                    Text("450").font(.largeTitle)
                    Text("pages")
                }
            }
            .foregroundStyle(.gray)
            .rotation3DEffect(.degrees(-180), axis: (x: 0, y: 1, z: 0))
        }
        .rotation3DEffect(
            .degrees( show2 ? -180 : 0),
            axis: (x: 0, y: 1, z: 0),
            anchor: .leading,
            anchorZ: 0,
            perspective: 0.3
        )
        .opacity(close ? 0 : 1)
    }
}

struct pageone: View {
    var body: some View {
        UnevenRoundedRectangle(topLeadingRadius: 0, bottomLeadingRadius: 0, bottomTrailingRadius: 8, topTrailingRadius: 8, style: .continuous)
            .frame(width: 180, height: 263)
            .foregroundStyle(.white)
        VStack(alignment: .leading, spacing: 16) {
            Text("Introduction").bold()
            Text("テストの文章が入ります。テストの文章が入ります。テストの文章が入ります。テストの文章が入ります。テストの文章が入ります。テストの文章が入ります。テストの文章が入ります。テストの文章が入ります。テストの文章が入ります。")
                .font(.system(size: 9))
                .lineSpacing(5)
        }
        .frame(width: 170, height: 220)
        .foregroundStyle(.gray)
    }
}

#Preview {
    BookView()
}
