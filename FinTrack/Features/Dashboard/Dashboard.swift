//
//  Dashboard.swift
//  FinTrack
//
//  Created by Anjan Tewani on 26/12/25.
//

import SwiftUI

struct Dashboard: View {
    @ObservedObject var dashboardViewModel: DashboardViewModel
    @State var animateInsightChart: Bool = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: AppSpacing.sm) {
                
//                MARK: - Greeting
                greetingsView
                    .padding(.top, AppSpacing.sm)
                    .padding(.horizontal, AppSpacing.sm)
                
                
//                MARK: - Hero Card
                heroCard
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(AppSpacing.md)
                    .background(LinearGradient(gradient: Gradient(colors: [AppColors.accentPrimary, AppColors.accentSecondaryDisabled]), startPoint: .leading, endPoint: .trailing))
                    .overlay {
                        HStack {
                            Spacer()
                            
                            Image("dashboardWalletBG")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 150)
                                .opacity(0.25)
                        }
                    }
                    .overlay {
                        RoundedRectangle(cornerRadius: AppCornerRadius.md)
                            .stroke(AppColors.accentSecondaryDisabled.opacity(0.40), lineWidth: 1)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: AppCornerRadius.md))
                    .padding(.horizontal, AppSpacing.sm)

                
//                MARK: - Insights
                insightsCard
                    .frame(maxWidth: .infinity)
                    .padding(AppSpacing.md)
                    .background(AppColors.accentSecondaryDisabled.opacity(0.20))
                    .clipShape(RoundedRectangle(cornerRadius: AppCornerRadius.md))
                    .overlay {
                        RoundedRectangle(cornerRadius: AppCornerRadius.md)
                            .stroke(AppColors.accentSecondaryDisabled.opacity(0.40), lineWidth: 1)
                    }
                    .padding(.top, AppSpacing.sm)
                    .padding(.horizontal, AppSpacing.sm)
                
                
//                MARK: - Quick Stats
                quickStatsSection
                    .padding(.top, AppSpacing.sm)
                    .padding(.horizontal, AppSpacing.sm)
                
                
//                MARK: - Spending By Category Section
                spendingByCategoryView
                    .padding(AppSpacing.sm)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .clipShape(RoundedRectangle(cornerRadius: AppCornerRadius.md))
                
                
//                MARK: - Upcoming Renewals Section
                upcomingRenewalsView
                    .padding(AppSpacing.sm)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                
//                MARK: - Recent Expenses Section
                recentExpensesView
                    .padding(AppSpacing.sm)
                    .frame(maxWidth: .infinity, alignment: .leading)

            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, AppSpacing.sm)
            .padding(.horizontal, AppSpacing.sm)
        }
        .onAppear {
            if animateInsightChart == false {
                animateInsightChart = true
            }
        }
    }

    
    
//    MARK: -= REUSABLE COMPONENTS =-
    
    
//    MARK: - Greetings View
    var greetingsView: some View {
        VStack(alignment: .leading) {
            Text("Hello, People! 👋")
                .font(AppTypography.subtitle)
            
            Text("Here's your financial overview")
                .font(AppTypography.secondary)
                .foregroundStyle(.secondary)
        }
    }
    
    
//    MARK: - Hero Card
    var heroCard: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            Text("Total Expenses")
                .font(AppTypography.body)
                .foregroundStyle(AppColors.textOnAccentPrimary)
            
            Text("₹ \(dashboardViewModel.totalAmount, specifier: "%.0f")")
                .font(AppTypography.title)
                .fontWeight(.semibold)
                .foregroundStyle(AppColors.textOnAccentPrimary)
        }
    }
    
    
//    MARK: - Insights Card
    var insightsCard: some View {
        HStack(alignment: .center, spacing: AppSpacing.sm) {
            Image(systemName: "lightbulb.max")
                .padding(AppSpacing.sm)
                .foregroundStyle(Color.white)
                .background(AppColors.accentPrimary)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: AppSpacing.xs) {
                Text("Insight for you")
                    .font(AppTypography.secondary)
                    .fontWeight(.medium)
                    .foregroundStyle(AppColors.accentPrimary)
                
                var insightPercentText: AttributedString {
                    var attributedString = AttributedString(dashboardViewModel.insightPercentText)
                    attributedString.foregroundColor = dashboardViewModel.insightPercentColor
                    attributedString.font = AppTypography.caption.weight(.semibold)
                    return attributedString
                }
                
                Text("You spent \(insightPercentText) than last month")
                    .font(AppTypography.caption)
                    .foregroundStyle(.secondary)
                
                Text(dashboardViewModel.insightGuidanceText)
                    .font(AppTypography.caption)
                    .foregroundStyle(.secondary)
            }
            .padding(0)
            
            Spacer()
        }
    }
    
    
//    MARK: - Quick Stats Section
    var quickStatsSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            Text("Quick Stats")
                .font(AppTypography.body)
                .fontWeight(.semibold)
            
            ScrollView(.horizontal) {
                HStack(spacing: AppSpacing.md) {
                    currentMonthExpensesOverviewCard
                        .padding(AppSpacing.md)
                        .frame(width: 180, height: 150, alignment: .leading)
                        .background(Color.green.opacity(0.05))
                        .clipShape(RoundedRectangle(cornerRadius: AppCornerRadius.md))
                        .overlay {
                            RoundedRectangle(cornerRadius: AppCornerRadius.md)
                                .stroke(Color.green.opacity(0.1), lineWidth: 1)
                        }
                    
                    monthlySubsOverviewCard
                        .padding(AppSpacing.md)
                        .frame(width: 180, height: 150, alignment: .leading)
                        .background(Color.yellow.opacity(0.05))
                        .clipShape(RoundedRectangle(cornerRadius: AppCornerRadius.md))
                        .overlay {
                            RoundedRectangle(cornerRadius: AppCornerRadius.md)
                                .stroke(Color.yellow.opacity(0.1), lineWidth: 1)
                        }
                    
                    yearlySubsOverviewCard
                        .padding(AppSpacing.md)
                        .frame(width: 180, height: 150, alignment: .leading)
                        .background(Color.cyan.opacity(0.05))
                        .clipShape(RoundedRectangle(cornerRadius: AppCornerRadius.md))
                        .overlay {
                            RoundedRectangle(cornerRadius: AppCornerRadius.md)
                                .stroke(Color.cyan.opacity(0.1), lineWidth: 1)
                        }
                }
            }
            .scrollIndicators(.hidden)
        }
    }
    
    
//    MARK: - Current Month Expenses Overview card
    var currentMonthExpensesOverviewCard: some View {
        VStack(alignment: .leading, spacing: AppSpacing.xs) {
            Image(systemName: "calendar")
                .padding(AppSpacing.sm)
                .foregroundStyle(Color.green)
                .background(Color.green.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: AppCornerRadius.sm))
            
            Text("This Month")
                .font(AppTypography.secondary)
                .fontWeight(.medium)
                .foregroundStyle(.secondary)
            
            Text("₹\(dashboardViewModel.currentMonthTotalExpense, specifier: "%.0f")")
                .font(AppTypography.subtitle)
                .fontWeight(.semibold)
            
            HStack(spacing: AppSpacing.xs) {
                Image(systemName: dashboardViewModel.expensePercentAgaintPreviousMonth >= 0 ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill" )
                    .foregroundStyle(dashboardViewModel.expensePercentAgaintPreviousMonth >= 0 ? Color.red : Color.green)
                    .imageScale(.small)
                
                var expensePercentAgaintPreviousMonth: AttributedString {
                    var attributedString = AttributedString(String(format: "%.0f", abs(dashboardViewModel.expensePercentAgaintPreviousMonth)) + "%")
                    attributedString.foregroundColor = dashboardViewModel.expensePercentAgaintPreviousMonth >= 0 ? Color.red : Color.green
                    
                    return attributedString
                }
                
                Text("\(expensePercentAgaintPreviousMonth) vs last month")
                    .font(AppTypography.caption)
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)
            }
        }
    }
    
    
//    MARK: - Monthly Subs Overview card
    var monthlySubsOverviewCard: some View {
        VStack(alignment: .leading, spacing: AppSpacing.xs) {
            Image(systemName: "indianrupeesign.arrow.trianglehead.counterclockwise.rotate.90")
                .padding(AppSpacing.sm)
                .foregroundStyle(Color.yellow)
                .background(Color.yellow.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: AppCornerRadius.sm))
            
            Text("Monthly Subs")
                .font(AppTypography.secondary)
                .fontWeight(.medium)
                .foregroundStyle(.secondary)

            Text("₹\(dashboardViewModel.monthlySubsTotalAmount, specifier: "%.0f")")
                .font(AppTypography.subtitle)
                .fontWeight(.semibold)

            Text("\(dashboardViewModel.activeMonthlySubs) Active")
                .font(AppTypography.caption)
                .fontWeight(.medium)
                .foregroundStyle(.secondary)
        }
    }
    
        
//    MARK: - Yearly Subs Overview card
    var yearlySubsOverviewCard: some View {
        VStack(alignment: .leading, spacing: AppSpacing.xs) {
            Image(systemName: "indianrupeesign.arrow.trianglehead.counterclockwise.rotate.90")
                .padding(AppSpacing.sm)
                .foregroundStyle(Color.cyan)
                .background(Color.cyan.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: AppCornerRadius.sm))
            
            Text("Yearly Subs")
                .font(AppTypography.secondary)
                .fontWeight(.medium)
                .foregroundStyle(.secondary)

            Text("₹\(dashboardViewModel.yearlySubsTotalAmount, specifier: "%.0f")")
                .font(AppTypography.subtitle)
                .fontWeight(.semibold)

            Text("\(dashboardViewModel.activeYearlySubs) Active")
                .font(AppTypography.caption)
                .fontWeight(.medium)
                .foregroundStyle(.secondary)
        }
    }
    
    
//    MARK: - Spending By Category View
    var spendingByCategoryView: some View {
        VStack(alignment: .leading) {
            Text("Spending By Category")
                .font(AppTypography.body)
                .fontWeight(.semibold)

            if dashboardViewModel.categoryChartData.isEmpty {
                Text("No Category data")
                    .font(AppTypography.body)
                    .padding(.horizontal, AppSpacing.md)
                    .padding(.top, AppSpacing.sm)
            } else {
                VStack(alignment: .leading, spacing: AppSpacing.sm) {
                    ForEach(dashboardViewModel.categoryChartData, id: \.self) { categoryChartData in
                        SpendingByCategoryRowView(icon: categoryChartData.category.icon, category: categoryChartData.category.title, amount: categoryChartData.amount, percentage: categoryChartData.percentage)
                        
                        if categoryChartData.id != dashboardViewModel.categoryChartData.last?.id {
                            Divider()
                        }
                    }
                }
                .padding(AppSpacing.md)
                .background(.background)
                .clipShape(RoundedRectangle(cornerRadius: AppCornerRadius.md))
                .shadow(radius: AppShadowRadius.xs)
            }
        }
    }
    
//    MARK: - Upcoming Renewals View
    var upcomingRenewalsView: some View {
        VStack(alignment: .leading) {
            Text("Upcoming Renewals")
                .font(AppTypography.body)
                .fontWeight(.semibold)
            
            if dashboardViewModel.upcomingRenewals.isEmpty {
                Text("No Upcoming Renewals")
                    .font(AppTypography.body)
                    .padding(.horizontal, AppSpacing.md)
                    .padding(.top, AppSpacing.sm)
            } else {
                VStack(alignment: .leading, spacing: AppSpacing.sm) {
                    ForEach(dashboardViewModel.upcomingRenewals, id: \.id) { upcomingRenewal in
                        UpcomingRenewalsRowView(upcomingRenewal: upcomingRenewal)

                        if upcomingRenewal.id != dashboardViewModel.upcomingRenewals.last?.id {
                            Divider()
                        }
                    }
                }
                .padding(AppSpacing.md)
                .background(.background)
                .clipShape(RoundedRectangle(cornerRadius: AppCornerRadius.md))
                .shadow(radius: AppShadowRadius.xs)
            }
        }
    }
    
    
//    MARK: - Recent Expenses View
    var recentExpensesView: some View {
        VStack(alignment: .leading) {
            Text("Recent Expenses")
                .font(AppTypography.body)
                .fontWeight(.semibold)
            
            if dashboardViewModel.upcomingRenewals.isEmpty {
                Text("No Recent Expenses")
                    .font(AppTypography.body)
                    .padding(.horizontal, AppSpacing.md)
                    .padding(.top, AppSpacing.sm)
            } else {
                VStack(alignment: .leading, spacing: AppSpacing.sm) {
                    ForEach(dashboardViewModel.recentExpenses, id: \.id) { recentExpense in
                        RecentExpenseRowView(expense: recentExpense)

                        if recentExpense.id != dashboardViewModel.recentExpenses.last?.id {
                            Divider()
                        }
                    }
                }
                .padding(AppSpacing.md)
                .background(.background)
                .clipShape(RoundedRectangle(cornerRadius: AppCornerRadius.md))
                .shadow(radius: AppShadowRadius.xs)
            }
        }
    }    
}

//#Preview {
//    Dashboard()
//}
