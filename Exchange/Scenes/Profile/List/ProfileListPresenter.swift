//
//  ProfileListPresenter.swift
//  Exchange
//
//  Created by Douglas Cicarello on 18/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol ProfileListPresentationLogic {
    func load(response: ProfileList.Load.Response)
    func boostStatus(response: ProfileList.BoostStatus.Response)
    func fetch(response: ProfileList.Fetch.Response)
    func save(response: ProfileList.Save.Response)
    func deleteAccount(response: ProfileList.DeleteAccount.Response)
    func logout(response: ProfileList.Logout.Response)
    func avatar(response: ProfileList.Avatar.Response)
}


class ProfileListPresenter: ProfileListPresentationLogic {
  
    
    // Var's
    weak var viewController: ProfileListDisplayLogic?
  
    
    // Handler load
    func load(response: ProfileList.Load.Response) {
        
        let viewModel = ProfileList.Load.ViewModel()
        viewController?.onLoad(viewModel: viewModel)
        
    }
    
    
    // Handler boost status
    func boostStatus(response: ProfileList.BoostStatus.Response) {
        let viewModel = ProfileList.BoostStatus.ViewModel()
        viewController?.onBoostStatus(viewModel: viewModel)
    }
    
    
    // Handler fetch
    func fetch(response: ProfileList.Fetch.Response) {
        
        var rows: [MainTableRow] = []
        let auth = response.auth
        let user = response.user
        let remote = response.remote
        
        // User
        rows.append(
            .profileUser(
                .init(
                    avatar: user.getAvatarUrl(),
                    name:
                    auth.getAnonymous()
                    ? "Profile.Anonymous.Name".localized
                    : user.getName().isEmpty
                    ? "Profile.Anonymous.Name".localized
                    : user.getName(),
                    email: auth.getAnonymous() ? "" : user.getEmail()
                )
            )
        )
        
        
        // Boost
        if user.getBoostProfileIsActive() {
            
            rows.append(
                .textCaptionSemibold(
                    .init(
                        color: .matchBoost,
                        icon: .none,
                        title: "Profile.Boost.Section".localized.uppercased()
                    )
                )
            )
            let boostRemainingMinutes = user.getBoostRemainingMinutes()
            let boostTotalMinutes = max(remote.getBoostProfileMinutes(), 1)
            let clampedRemainingMinutes = min(max(boostRemainingMinutes, 0), boostTotalMinutes)
            let progress = Float(clampedRemainingMinutes) / Float(boostTotalMinutes)
            rows.append(
                .productProgress(
                    .init(
                        id: 0,
                        iconLeft: .rocket,
                        image: nil,
                        title: "Profile.Boost.Title".localized,
                        progress: progress,
                        description: "Profile.Boost.Time".localized
                            .replacingOccurrences(of: "{$0}", with: "\(boostRemainingMinutes)"),
                        iconRight: .barChart,
                        color: .matchBoost,
                        identifier: .boostProfile
                    )
                )
            )
            rows.append(.spacing(.init(size: .xl)))
        }
        
        
        
        // Profile
        rows.append(
            .textCaptionSemibold(
                .init(
                    color: .textOnSurfaceSecondary,
                    icon: .none,
                    title: "Profile.My.Section".localized.uppercased()
                )
            )
        )
        if auth.getAnonymous() {
            rows.append(
                .default(
                    .init(
                        iconLeft: .none,
                        iconRight: .alertCircle,
                        title: "Profile.Anonymous.SignIn".localized,
                        style: .normal,
                        identifier: .signIn,
                    )
                )
            )
        }
        rows.append(
            .default(
                .init(
                    iconLeft: .none,
                    iconRight: auth.getAnonymous() ? .none : .arrowRight,
                    title: "Profile.My.Photo".localized,
                    style: auth.getAnonymous() ? .disabled : .normal,
                    identifier: .picture,
                )
            )
        )
        rows.append(
            .default(
                .init(
                    iconLeft: .none,
                    iconRight: auth.getAnonymous() ? .none : .arrowRight,
                    title: "Profile.My.Name".localized,
                    style: auth.getAnonymous() ? .disabled : .normal,
                    identifier: .name,
                )
            )
        )
        
        
        
        
        
        // Notifications
        rows.append(.spacing(.init(size: .xl)))
        rows.append(
            .textCaptionSemibold(
                .init(
                    color: .textOnSurfaceSecondary,
                    icon: .none,
                    title: "Profile.Notifications.Section".localized.uppercased()
                )
            )
        )
        rows.append(
            .switch(
                .init(
                    title: "Profile.Notifications.Match".localized,
                    isOn: user.getNotificationMatch(),
                    identifier: .match
                )
            )
        )
        rows.append(
            .switch(
                .init(
                    title: "Profile.Notifications.Message".localized,
                    isOn: user.getNotificationMessage(),
                    identifier: .message
                )
            )
        )
        
        
        // Contact
        rows.append(.spacing(.init(size: .xl)))
        rows.append(
            .textCaptionSemibold(
                .init(
                    color: .textOnSurfaceSecondary,
                    icon: .none,
                    title: "Profile.Contact.Section".localized.uppercased()
                )
            )
        )
        rows.append(
            .default(
                .init(
                    iconLeft: .none,
                    iconRight: .arrowRight,
                    title: "Profile.Contact.Rating".localized,
                    style: .normal,
                    identifier: .ratingApp,
                )
            )
        )
        rows.append(
            .default(
                .init(
                    iconLeft: .none,
                    iconRight: .arrowRight,
                    title: "Profile.Contact.Share".localized,
                    style: .normal,
                    identifier: .shareApp,
                )
            )
        )
        
        
        
        
        // Legal
        rows.append(.spacing(.init(size: .xl)))
        rows.append(
            .textCaptionSemibold(
                .init(
                    color: .textOnSurfaceSecondary,
                    icon: .none,
                    title: "Profile.Legal.Section".localized.uppercased()
                )
            )
        )
        rows.append(
            .default(
                .init(
                    iconLeft: .none,
                    iconRight: .arrowRight,
                    title: "Profile.Legal.Terms".localized,
                    style: .normal,
                    identifier: .terms,
                )
            )
        )
        rows.append(
            .default(
                .init(
                    iconLeft: .none,
                    iconRight: .arrowRight,
                    title: "Profile.Legal.Privacy".localized,
                    style: .normal,
                    identifier: .privacy,
                )
            )
        )
        
        if response.showAds {
            rows.append(.spacing(.init(size: .xl)))
            rows.append(
                .adBanner(
                    .init(placement: .profileListBanner)
                )
            )
        }
        
        
        // Actions
        rows.append(.spacing(.init(size: .xl)))
        rows.append(
            .textCaptionSemibold(
                .init(
                    color: .textOnSurfaceSecondary,
                    icon: .none,
                    title: "Profile.Actions.Section".localized.uppercased()
                )
            )
        )
        
        if auth.getAnonymous() {
            rows.append(
                .default(
                    .init(
                        iconLeft: .none,
                        iconRight: .logout,
                        title: "Profile.Actions.Reset".localized,
                        style: .normal,
                        identifier: .resetApp,
                    )
                )
            )
        }
        else {
            rows.append(
                .default(
                    .init(
                        iconLeft: .none,
                        iconRight: .alertCircle,
                        title: "Profile.Actions.Delete".localized,
                        style: .normal,
                        identifier: .deleteAccount,
                    )
                )
            )
            rows.append(
                .default(
                    .init(
                        iconLeft: .none,
                        iconRight: .logout,
                        title: "Profile.Actions.Logout".localized,
                        style: .normal,
                        identifier: .logoutApp,
                    )
                )
            )
        }
        
        rows.append(.spacing(.init(size: .xxl)))
        
        
        let viewModel = ProfileList.Fetch.ViewModel(rows: rows)
        viewController?.onFetch(viewModel: viewModel)
        
    }
    
    
    // Handler save
    func save(response: ProfileList.Save.Response) {
        
        let viewModel = ProfileList.Save.ViewModel()
        viewController?.onSave(viewModel: viewModel)
        
    }
    
    
    // Handler delete account
    func deleteAccount(response: ProfileList.DeleteAccount.Response) {
        
        let viewModel = ProfileList.DeleteAccount.ViewModel()
        viewController?.onDeleteAccount(viewModel: viewModel)
        
    }
    
    
    // Handler logout
    func logout(response: ProfileList.Logout.Response) {
        
        let viewModel = ProfileList.Logout.ViewModel()
        viewController?.onLogout(viewModel: viewModel)
        
    }
    
    
    // Handler avatar
    func avatar(response: ProfileList.Avatar.Response) {
        
        if let error = response.error {
            viewController?.onAvatar(error: error)
        }
        else {
            let viewModel = ProfileList.Avatar.ViewModel()
            viewController?.onAvatar(viewModel: viewModel)
        }
    }
    
    
}
