//
//  HourSheet.swift
//  iosApp
//
//  Created by Miguel Susano on 13/10/2024.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI

struct HourSheet: View {
    @Binding var hours: [Int]
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        // 1
        NavigationView {
            // 2
            VStack {
                // 3
                List {
                    // 4
                    ForEach(hours, id: \.self) {  hour in
                        Text("\(hour)")
                    }
                } // List
            } // VStack
            .navigationTitle("Found Meeting Hours")
            // 5
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Dismiss")
                            .frame(alignment: .trailing)
                            .foregroundColor(.black)
                    }
                } // ToolbarItem
            } // toolbar
        } // NavigationView

    }
}

#Preview {
    HourSheet(hours: .constant([8, 9, 10]))
}
