//
//  InitialSettingViewModel.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/11/14.
//

import RxRelay

final class InitialSettingViewModel: BaseViewModel {
    private let service = SignUpService()
    
    let townRelay = BehaviorRelay<PlaceModel?>(value: nil)
    let signUpModelRelay = BehaviorRelay<SignUpRequestModel.SignUpModel?>(value: nil)
    let signUpSucceedRelay = PublishRelay<Void>()
    
    func signUp(_ nickname: String, _ placeCode: String) {
        guard var signUpModel = signUpModelRelay.value else { return }
        signUpModel.nickname = nickname
        signUpModel.placeCode = placeCode
        
        service.signUp(signUpModel)
            .subscribe(onSuccess: { [weak self] response in
                if response.responseCode == "SUCCESS_SIGN_UP" {
                    self?.signInProcess(response)
                } else {
                    self?.toastMessage.accept(.red(text: response.message))
                }
            }, onFailure: { [weak self] _ in
                self?.toastMessage.accept(.red(text: "네트워크 오류가 발생했습니다."))
            })
            .disposed(by: disposeBag)
    }
    
    private func signInProcess(_ response: ResponseModel<SignUpResponseModel>) {
        guard let token = response.data?.accessToken else {
            toastMessage.accept(.red(text: "네트워크 오류가 발생했습니다."))
            return
        }
        UserInformationManager.shared.signIn(token)
        toastMessage.accept(.green(text: response.message))
        
        signUpSucceedRelay.accept(Void())
    }
}
