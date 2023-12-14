//
//  DetailView.swift
//  Left off
//
//  Created by Bas Wilson on 11/12/2023.
//

import SwiftUI

struct DetailView: View {
    var dateFormatter: DateFormatter
    @EnvironmentObject var store: Store
    private var todaysDate: String
    
    @State var activeDayIndex = -1

    init() {
        self.dateFormatter = DateFormatter()
        self.dateFormatter.dateStyle = .short
        self.todaysDate = dateFormatter.string(from: Date())
    }
    
    var body: some View {
        
        if (store.project != nil) {
            let day = self.activeDayIndex == -1 ? store.project!.days.last : activeDayIndex <= store.project!.days.count - 1 ? store.project!.days[self.activeDayIndex] : nil
            let todaysDay = store.project!.days.first(where: {$0.date == self.todaysDate})
            let todayNeedsToBeFilled = todaysDay == nil ? true : todaysDay!.note1.isEmpty && todaysDay!.note2.isEmpty

            if (day != nil) {
                ScrollView {
                    
                    let currentDayIndex = (store.project!.days.firstIndex(of: day!) ?? 0) + 1
                    
                    VStack(alignment: .leading, spacing: 20) {
                        
                        // date
                        Text(day!.date)
                            .font(.subheadline)
                        
                        // days
                        Text(day!.id)
                            .font(.subheadline)
                        
                        
                        // day navigation
                        HStack {
                            let prevEnabled = currentDayIndex > 1
                            let nextEnabled = currentDayIndex < store.project!.days.count
                            
                            // days
                            Text(currentDayIndex.formatted() + "/" + store.project!.days.count.formatted())
                                .font(.subheadline)
                            
                            Button (
                                action: {
                                    if (activeDayIndex == -1) {
                                        activeDayIndex = store.project!.days.count - 1
                                    } else {
                                        activeDayIndex -= 1
                                    }
                                },
                                label: {
                                    Text("Previous")
                                }
                            )
                            .disabled(!prevEnabled)
                            
                            Button (
                                action: {
                                    activeDayIndex += 1
                                },
                                label: {
                                    Text("Next")
                                }
                            )
                            .disabled(!nextEnabled)
                            
                            
                        }
                            
                        // notes
                        VStack(spacing: 20) {
                            NoteView(note: .note1, project: store.project!, dayId: day!.id)
                            NoteView(note: .note2, project: store.project!, dayId: day!.id)
                        }
                        
                        // fill today
                        Button(
                            action: {
                            store.navPath.append(.FinishUpScreen1)
                        },
                            label: {
                                Text(todayNeedsToBeFilled ? "Finish up" : "You've already done today")
                                Image(systemName: "checkmark.circle.fill")
                        }
                        )
                            .buttonStyle(.borderedProminent)
                            .disabled(!todayNeedsToBeFilled)
                
                        Spacer()
                    }
                }
                .onAppear{
                    // set the -1 value to the index of last item in store
                    // sort days by time
                    store.project!.days = store.project!.days.sorted(by: { d1, d2 in
                        let date1 = dateFormatter.date(from: d1.date)
                        let date2 = dateFormatter.date(from: d2.date)
                        return date1!.timeIntervalSince1970 > date2!.timeIntervalSince1970
                    })
                    print("Days count: ", store.project!.days.count)
                    activeDayIndex = store.project!.days.count - 1
                }
    #if os(iOS)
                .navigationBarTitle(store.project!.name)
    #endif

    #if os(macOS)
            .padding()
            .scrollDisabled(true)
    #endif
            } else {
                ScrollView {
                    NoDaysView(project: store.project!)
                }
    #if os(iOS)
                .navigationBarTitle(store.project!.name)
    #endif

    #if os(macOS)
            .padding()
            .scrollDisabled(true)
    #endif
            }
        }


    }
    
    
}
