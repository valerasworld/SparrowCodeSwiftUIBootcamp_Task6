//
//  MovingSquares.swift
//  SparrowCodeSwiftUIBootcamp_Task6
//
//  Created by Валерий Зазулин on 14.03.2024.
//

import SwiftUI

struct MovingSquares: View {
    
    @State var quantity: CGFloat = 6
    let spacing: CGFloat = 10
    @State var isDiagonal: Bool = false
    @State var isRising: Bool = true
    @State var frameWidth: CGFloat = UIScreen.main.bounds.width
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
                let squareHeight = (frameWidth - (spacing * (quantity - 1))) / quantity
                let bigSquareWidthAndHeight = geo.size.height / quantity
                let newSpacing = (frameWidth - bigSquareWidthAndHeight * quantity) / (quantity - 1)
                let isEven = Int(quantity) % 2 == 0
                
                HStack(spacing: isDiagonal ? newSpacing : spacing) {
                        ForEach(0..<Int(quantity), id: \.self) { index in
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(Color.blue)
                                .frame(
                                    width: isDiagonal ? bigSquareWidthAndHeight : squareHeight,
                                    height: isDiagonal ? bigSquareWidthAndHeight : squareHeight
                                )
                                .offset(y: isDiagonal ? findOffset(quantity: quantity,
                                                                   index: index,
                                                                   isEven: isEven,
                                                                   bigSquareWidthAndHeight: bigSquareWidthAndHeight,
                                                                   isRising: isRising)
                                                                   : 0
                                )
                                .onTapGesture {
                                    withAnimation {
                                        isDiagonal.toggle()
                                    }
                                }
                        }
                    }
                    .frame(maxHeight: .infinity)
            }
            .border(Color.red)
            .frame(width: frameWidth)

            VStack {
                buttonsAndSlider
                    .blendMode(.difference)
                    .overlay(
                        buttonsAndSlider.foregroundStyle(Color.white)
                            .blendMode(.hue)
                    )
                    .overlay(
                        buttonsAndSlider.foregroundStyle(Color.white)
                            .blendMode(.overlay)
                    )
            }
            .frame(width: .infinity)
        }
    }
    
    func findOffset(quantity: CGFloat, index: Int, isEven: Bool, bigSquareWidthAndHeight: CGFloat, isRising: Bool) -> CGFloat {
        let middleIndex = (Int(quantity) + 1) / 2
        let distance = index - middleIndex + 1
        
        if isEven {
            return isRising ? -bigSquareWidthAndHeight / 2 + bigSquareWidthAndHeight * -CGFloat(-middleIndex + index) : bigSquareWidthAndHeight / 2 + bigSquareWidthAndHeight * CGFloat(-middleIndex + index)
        } else {
            return isRising ? bigSquareWidthAndHeight * -CGFloat(distance) : -bigSquareWidthAndHeight * -CGFloat(distance)
        }
    }
}

#Preview {
    MovingSquares()
}

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundStyle(Color.white)
    }
}

extension MovingSquares {
    var buttonsAndSlider: some View {
        VStack {
            Spacer()
            
            HStack {
                Button {
                    withAnimation(.spring) {
                        quantity -= 1
                    }
                } label: {
                    Image(systemName: "minus")
                }
                
                Text("\(Int(quantity))")
                    .font(.largeTitle)
                    .foregroundStyle(Color.white)
                    .bold()
                
                Button {
                    withAnimation(.spring) {
                        quantity += 1
                    }
                } label: {
                    Image(systemName: "plus")
                }
            }
            
            HStack {
                Button {
                    withAnimation(.spring) {
                        isRising.toggle()
                    }
                } label: {
                    Image(systemName: "arrow.up.right")
                        .rotationEffect(isRising ? Angle(degrees: 0) : Angle(degrees: 90))
                }
            }
            Slider(value: $frameWidth, in: 100...UIScreen.main.bounds.width)
                .tint(Color.white)
                .padding(.horizontal)
        }
        .buttonStyle(CustomButtonStyle())
    }
}
