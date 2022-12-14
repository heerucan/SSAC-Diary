//
//  WriteView.swift
//  Diary
//
//  Created by heerucan on 2022/08/22.
//

import UIKit

import Kingfisher

class WriteView: BaseView, UITextViewDelegate {
    
    // MARK: - Property
        
    let photoImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.backgroundColor = Constant.Color.background
        view.tintColor = Constant.Color.lightGray
        view.makeCornerStyle()
        return view
    }()
    
    let imageButton: UIButton = {
        let view = UIButton()
        view.setBackgroundImage(Constant.Image.photo.assets, for: .normal)
        view.tintColor = Constant.Color.point
        return view
    }()
    
    lazy var datePickerView: UIDatePicker = {
        let view = UIDatePicker(frame: .zero)
        view.preferredDatePickerStyle = .wheels
        view.datePickerMode = .date
        view.locale = Locale(identifier: "Ko-kr")
        view.maximumDate = .now
        return view
    }()
    
    let titleTextField = DiaryTextField(.title)
    let dateTextField = DiaryTextField(.date)
    
    lazy var diaryTextView: UITextView = {
        let view = UITextView()
        view.text = Constant.Placeholder.diary.rawValue
        view.font = .systemFont(ofSize: 18)
        view.textAlignment = .center
        view.contentInset = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
        view.makeCornerStyle()
        return view
    }()
    
    let saveButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = Constant.Color.point
        view.makeCornerStyle()
        return view
    }()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure UI & Layout
    
    override func configureUI() {
        dateTextField.inputView = datePickerView
    }
    
    override func configureLayout() {
        self.addSubviews([photoImageView,
                          imageButton,
                          titleTextField,
                          dateTextField,
                          saveButton,
                         diaryTextView])
           
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).inset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        dateTextField.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        diaryTextView.snp.makeConstraints { make in
            make.top.equalTo(dateTextField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        photoImageView.snp.makeConstraints { make in
            make.top.equalTo(diaryTextView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(self).multipliedBy(0.4)
        }

        imageButton.snp.makeConstraints { make in
            make.bottom.equalTo(photoImageView.snp.bottom).inset(10)
            make.trailing.equalTo(photoImageView.snp.trailing).inset(10)
            make.width.height.equalTo(50)
        }
                
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(50)
        }
    }
    
    // MARK: - Set Data
    
    func setupData(data: UserDiary) {
        let image = data.image == nil ? Constant.Image.image.assets : UIImage(named: data.image!)
        titleTextField.text = data.title
        dateTextField.text = data.createdAt.toString()
        diaryTextView.text = data.content
        photoImageView.image = image
    }
}
