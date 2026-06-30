//
//  Subscriptions.swift
//  FinTrack
//
//  Created by Anjan Tewani on 26/12/25.
//

import SwiftUI

struct Subscriptions: View {
    @ObservedObject var subscriptionsViewModel: SubscriptionsViewModel
    @State var showAddSubscrpitions: Bool = false
    
    var body: some View {
        context
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showAddSubscrpitions = true
                    } label: {
                        Text("Add Subscription")
                    }
                }
            }
            .sheet(isPresented: $showAddSubscrpitions) {
                NavigationStack {
                    AddSubscriptionView(subscriptionsViewModel: subscriptionsViewModel)
                        .navigationTitle("Add Susbcription")
                }
            }
    }
    
    @ViewBuilder
    var context: some View {
        switch subscriptionsViewModel.state {
        case .loading:
            ProgressView()
                .progressViewStyle(.circular)
                .scaleEffect(2)

        case .empty:
            EmptyStateView(title: "No Subscriptions", description: "You have no subscriptions yet.", action: {})

        case .loaded:
            VStack {
                List {
                    ForEach(subscriptionsViewModel.subscriptions) { subscription in
                        SubscriptionRowView(subscription: subscription)
                    }
                    .onDelete(perform: { indexes in
                        subscriptionsViewModel.deleteSubscriptions(withIndexes: indexes)
                    })
                }
            }

        case .error:
            EmptyStateView() {
                Button {
                    subscriptionsViewModel.loadSubscriptions()
                } label: {
                    Text("Retry")
                }
            }
        }
    }
}

#Preview {
//    Subscriptions()
}
