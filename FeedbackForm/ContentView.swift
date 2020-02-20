//
//  ContentView.swift
//  FeedbackForm
//
//  Created by Ramill Ibragimov on 20.02.2020.
//  Copyright © 2020 Ramill Ibragimov. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var show = false
    @State private var ratings = 0
    
    var body: some View {
        ZStack {
            VStack {
                Button(action: {
                    self.ratings = 0
                    self.show.toggle()
                }) {
                    Text("Review")
                        .fontWeight(.bold)
                        .foregroundColor(.orange)
                }
                
                if self.ratings != 0 {
                    Text("Ratings = \(self.ratings)")
                        .fontWeight(.bold)
                        .foregroundColor(.orange)
                        .padding(.top, 25)
                }
            }
            if self.show {
                GeometryReader { _ in
                    VStack {
                        Feedback(ratings: self.$ratings, show: self.$show)
                            .padding()
                    }
                }.background(Color.black.opacity(0.2).edgesIgnoringSafeArea(.all))
            }
        }.animation(.default)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Feedback: View {
    @Binding var ratings: Int
    @Binding var show: Bool
    
    var body: some View {
        VStack {
            HStack {
                Text("Please Rate The Quality Of The Product")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Spacer()
            }.padding()
            .background(Color.orange)
            
            VStack {
                if self.ratings != 0 {
                    if self.ratings == 5 {
                        Text("Excellent")
                            .fontWeight(.bold)
                            .foregroundColor(.orange)
                    } else if self.ratings == 4 {
                        Text("Good")
                            .fontWeight(.bold)
                            .foregroundColor(.orange)
                    } else {
                        Text("Okay")
                            .fontWeight(.bold)
                            .foregroundColor(.orange)
                    }
                }
            }.padding(.top, 20)
            
            HStack(spacing: 15) {
                ForEach(1...5, id: \.self) { i in
                    Image(systemName: self.ratings == 0 ? "star" : "star.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(i <= self.ratings ? .orange : Color.black.opacity(0.2))
                        .onTapGesture {
                            self.ratings = i
                    }
                }
            }.padding()
            
            HStack {
                Spacer()
                Button(action: {
                    self.ratings = 0
                    self.show.toggle()
                }) {
                    Text("Cancel")
                        .foregroundColor(.orange)
                        .fontWeight(.bold)
                }
                
                Button(action: {
                    self.show.toggle()
                }) {
                    Text("Submit")
                        .foregroundColor(self.ratings != 0 ? .orange : Color.black.opacity(0.2))
                        .fontWeight(.bold)
                }.padding(.leading, 20)
                .disabled(self.ratings != 0 ? false : true)
                
            }.padding()
        }
        .background(Color.white)
        .cornerRadius(10)
    }
}
