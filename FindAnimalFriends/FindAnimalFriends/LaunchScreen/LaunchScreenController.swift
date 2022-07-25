//
//  LaunchScreenController.swift
//  FindAnimalFriends
//
//  Created by Byeon jinha on 2022/07/23.
//

import AVFoundation
import UIKit
class LaunchScreenController: UIViewController, UIScrollViewDelegate {
    var window: UIWindow?
    // MARK: Properties
    // 각 animal memo의 위치 비율.
    // 배경화면 크기가 정비율을 지키며 2배가 될 때, 해당 정비율에 맞게 비율을 잡을 수 있도록 하기 위함.
    private let memosRatio: [[CGFloat]] = [
        [8, 6], //tiger
        [1.8, 5.5], //elephant
        [3, 2.5], //panda
        [8, 1.6], //dolphin
        [1.8, 1.5] //polarbear
    ]
    
    // 각 animal memo의 Asset image 이름. 위의 memosRatio와 index순서 같게 함.
    private let memosAnimal = [
        "tigerMemo",
        "elephantMemo",
        "pandaMemo",
        "dolphinMemo",
        "polarbearMemo"
    ]
    
    // 전체 크기변화 handling을 위한 버튼 배열.
    private var memoButtons: [UIButton] = []
    
    // MARK: UIComponents
    
    // origin(x,y좌표)와 Asset image이름을 받아 memo버튼을 생성하는 함수.
    func memoButton(_ origin: CGPoint, imageName: String) -> UIButton {
        let button = UIButton(frame: CGRect(origin: origin, size: .memoSize))
        button.setImage(UIImage(named: imageName), for: .normal)
        return button
    }
    
    // 크기가 1배수~2배수로 변화하는 corkboard 배경.
    private let backImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "mainBackground")
        imageView.contentMode = .scaleToFill
        imageView.isUserInteractionEnabled = true //이거 추가해야 여기 subView 추가했을 때 서브버튼 액션이 가능해짐
        return imageView
    }()
    
    private lazy var xButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 200, width: 100, height: 100))
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.addTarget(self, action: #selector(zoomOutAction), for: .touchUpInside)
        return button
    }()
    
    // MARK: Sound 관련 변수, 함수
    var player: AVAudioPlayer!
    func playSound(sound: String){
         let url = Bundle.main.url(forResource: sound, withExtension: "wav")
         guard url != nil else{
             return
         }
         do{
             player = try AVAudioPlayer(contentsOf: url!)
             player?.play()
         }catch{
             print("\(error)")
         }
     }
    
    // MARK: 온보딩 관련 변수, 함수
    var isOnboarding = true
    let pageControlNum = 3
    lazy var onboardingExitButton: UIButton = {
        let posX: CGFloat = (.screenW*0.3)/2
        let posY: CGFloat = (.screenH*0.86)
        let button: UIButton = UIButton(frame: CGRect(x: posX, y: posY, width: .screenW*0.7, height: .screenH*0.08))
        button.setTitle("시작하기", for: .normal)
        button.titleLabel?.font = UIFont(name: "KOTRA HOPE", size: .screenW*0.06)
        button.clipsToBounds = true
        button.backgroundColor = UIColor.appColor(.primaryBrown)
        button.layer.cornerRadius = 10.0
        button.addTarget(self, action: #selector(onClickMyButton(_:)), for: .touchUpInside)
        button.layer.opacity = 0
        return button
    }()
    @objc internal func onClickMyButton(_ sender: Any) {
        if sender is UIButton {
            UIView.animate(withDuration: 0.1, delay: 0.1) {
                self.playSound(sound: "gameStartSound")
                self.view.layer.opacity = 0
            } completion: { _ in
                UIView.animate(withDuration: 0.1, delay: 0) {
                    self.scrollView.removeFromSuperview()
                    self.onboardingExitButton.removeFromSuperview()
                    self.view.backgroundColor = .systemBackground
                    self.addSubviewsWithFrame()
                    self.view.addSubview(self.xButton)
                }  completion: { _ in
                    UIView.animate(withDuration: 0.1, delay: 0.5) {
                        self.view.layer.opacity = 1
                    }
                }
            }
        }
    }
    
    // MARK: 시간경과에 따른 애니메이션 함수
    func timeCount() {
        UIView.animate(withDuration: 0.5, delay: 0.5) { [self] in
            self.playSound(sound: "findAnimalFreidnsSound")
            self.findLabel.layer.opacity = 1
        } completion: { _ in
            UIView.animate(withDuration: 0.5) {
                self.animalLabel.layer.opacity = 1
            } completion: { _ in
                UIView.animate(withDuration: 0.5) {
                    self.friendsLabel.layer.opacity = 1
                } completion: { _ in
                    UIView.animate(withDuration: 0.5) {
                        self.view.layer.opacity = 0
                    } completion: { _ in
                        UIView.animate(withDuration: 0.5) {
                            self.findLabel.removeFromSuperview()
                            self.animalLabel.removeFromSuperview()
                            self.friendsLabel.removeFromSuperview()
                            self.detectiveImage.removeFromSuperview()
                            if self.isOnboarding {
                                self.view.addSubview(self.imageSlider)
                                for i in 0 ..< self.pageControlNum {
                                    let onboardingView: UIView = UIView(frame: CGRect(x: CGFloat(i) * .screenW, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
                                    self.scrollView.addSubview(onboardingView)
                                    if i == 0 {
                                        onboardingView.addSubview(self.detectiveImage2)
                                        onboardingView.addSubview(self.troubleLabel)
                                        onboardingView.addSubview(self.animalFriendsLabel)
                                        onboardingView.addSubview(self.allLabel)
                                        onboardingView.addSubview(self.disappearLabel)
                                        onboardingView.addSubview(self.exclamationMarkLabel)
                                    }
                                    else if i == 1 {
                                        onboardingView.addSubview(self.assistantImage1)
                                        onboardingView.addSubview(self.toKimAssistantLabel)
                                        onboardingView.addSubview(self.ofAnimalFriendsLabel)
                                        onboardingView.addSubview(self.characteristicsLabel)
                                        onboardingView.addSubview(self.letMeKnowLabel)
                                        onboardingView.addSubview(self.bulbLabel)
                                    }
                                    else if i == 2 {
                                        onboardingView.addSubview(self.totalAnimalsImage1)
                                        onboardingView.addSubview(self.characteristicsOfAnimalFriendsLabel)
                                        onboardingView.addSubview(self.tellMeWellLabel)
                                        onboardingView.addSubview(self.yourAnimalFriendsLabel)
                                        onboardingView.addSubview(self.comingBackLabel)
                                    }
                                    else if i == 3 {
                                        continue
                                    }
                                }
                                self.view.addSubview(self.scrollView)
                                self.setupSliderLayout()
                            } else {
                                UIView.animate(withDuration: 0.1, delay: 0.1) {
                                    self.view.layer.opacity = 0
                                } completion: { _ in
                                    UIView.animate(withDuration: 0.1, delay: 0) {
                                        self.scrollView.removeFromSuperview()
                                        self.onboardingExitButton.removeFromSuperview()
                                        self.view.backgroundColor = .systemBackground
                                        self.addSubviewsWithFrame()
                                        self.view.addSubview(self.xButton)
                                    }  completion: { _ in
                                        UIView.animate(withDuration: 0.1, delay: 0.5) {
                                            self.view.layer.opacity = 1
                                        }
                                    }
                                }
                            }
                        } completion: { _ in
                            UIView.animate(withDuration: 0.5) {
                                self.view.layer.opacity = 1
                            } completion: { _ in
                                UIView.animate(withDuration: 0.5) {
                                    self.playSound(sound: "textSound")
                                    self.troubleLabel.layer.opacity = 1
                                } completion: { _ in
                                    UIView.animate(withDuration: 0.5) {
                                        self.playSound(sound: "textSound")
                                        self.animalFriendsLabel.layer.opacity = 1
                                    }  completion: { _ in
                                        UIView.animate(withDuration: 0.5) {
                                            self.playSound(sound: "textSound")
                                            self.allLabel.layer.opacity = 1
                                        } completion: { _ in
                                            UIView.animate(withDuration: 0.5) {
                                                self.playSound(sound: "textSound")
                                                self.disappearLabel.layer.opacity = 1
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    // MARK: 스플래시 & 온보딩 라벨 모음
    lazy var findLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: .screenW*0.15, y: .screenH*0.18, width: .screenW, height: .screenH*0.07))
        label.text = "찾아라!"
        label.font = UIFont(name: "KOTRA HOPE", size: .screenH*0.06)
        label.layer.opacity = 0
        return label
    }()
    lazy var animalLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: .screenW*0.4, y: .screenH*0.26, width: .screenW, height: .screenH*0.07))
        label.text = "동물"
        label.textColor = UIColor.appColor(.primaryGreen)
        label.font = UIFont(name: "KOTRA HOPE", size: .screenH*0.06)
        label.layer.opacity = 0
        return label
    }()
    lazy var friendsLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: .screenW*0.55, y: .screenH*0.34, width: .screenW, height: .screenH*0.07))
        label.text = "친구들"
        label.font = UIFont(name: "KOTRA HOPE", size: .screenH*0.06)
        label.layer.opacity = 0
        return label
    }()
    lazy var troubleLabel: UILabel = {
        
        let label = UILabel(frame: CGRect(x: (.screenW*0.66)/2, y: 0, width: .screenW, height: .screenH*0.06))
        label.layer.opacity = 0
        label.text = "큰일났어요"
    
        label.font = UIFont(name: "KOTRA HOPE", size: .screenH*0.05)
        return label
    }()
    lazy var animalFriendsLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: (.screenW*0.6)/2, y: .screenH*0.07, width: .screenW, height: .screenH*0.06))
        label.text = "동물 친구들이"
        label.layer.opacity = 0
        label.textColor = UIColor.appColor(.primaryGreen)
        label.font = UIFont(name: "KOTRA HOPE", size: .screenH*0.05)
        let fullText = label.text ?? ""
        let attribtuedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: "이")
        attribtuedString.addAttribute(.foregroundColor, value: UIColor.black, range: range)
        label.attributedText = attribtuedString
        return label
    }()
    lazy var allLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: (.screenW*0.9)/2, y: .screenH*0.14, width: .screenW, height: .screenH*0.06))
        label.text = "모두"
        label.layer.opacity = 0
        label.font = UIFont(name: "KOTRA HOPE", size: .screenH*0.05)
        return label
    }()
    lazy var disappearLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: (.screenW*0.66)/2, y: .screenH*0.21, width: .screenW, height: .screenH*0.06))
        label.text = "사라졌어요"
        label.layer.opacity = 0
        label.font = UIFont(name: "KOTRA HOPE", size: .screenH*0.05)
        
        return label
    }()
    lazy var exclamationMarkLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: (.screenW*0.97)/2, y: .screenH*0.28, width: .screenW, height: .screenH*0.06))
        label.text = "!"
        label.textColor = .red
        label.font = UIFont(name: "KOTRA HOPE", size: .screenH*0.05)
        return label
    }()
    lazy var toKimAssistantLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: (.screenW*0.66)/2, y: 0, width: .screenW, height: .screenW*0.12))
        label.text = "김조수에게"
        label.font = UIFont(name: "KOTRA HOPE", size: .screenH*0.05)
        label.layer.opacity = 0
        return label
    }()
    lazy var ofAnimalFriendsLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: (.screenW*0.6)/2, y: .screenH*0.07, width: .screenW, height: .screenH*0.06))
        label.text = "동물 친구들의"
        label.textColor =  UIColor.appColor(.primaryGreen)
        label.font = UIFont(name: "KOTRA HOPE", size: .screenH*0.05)
        label.layer.opacity = 0
        return label
    }()
    lazy var characteristicsLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: (.screenW*0.8)/2, y: .screenH*0.14, width: .screenW, height: .screenH*0.06))
        label.text = "특징을"
        label.font = UIFont(name: "KOTRA HOPE", size: .screenH*0.05)
        label.textColor =  UIColor.appColor(.primaryGreen)
        let fullText = label.text ?? ""
        let attribtuedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: "을")
        attribtuedString.addAttribute(.foregroundColor, value: UIColor.black, range: range)
        label.attributedText = attribtuedString
        label.layer.opacity = 0
        return label
    }()
    lazy var letMeKnowLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: (.screenW*0.66)/2, y: .screenH*0.21, width: .screenW, height: .screenH*0.06))
        label.text = "알려주세요!"
        label.font = UIFont(name: "KOTRA HOPE", size: .screenH*0.05)
        label.layer.opacity = 0
        return label
    }()
    lazy var bulbLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: (.screenW*0.88)/2, y: .screenH*0.30, width: .screenW, height: .screenH*0.06))
        label.text = "💡"
        label.textColor = .red
        label.font = UIFont(name: "KOTRA HOPE", size: .screenH*0.05)
        return label
    }()
    lazy var characteristicsOfAnimalFriendsLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: (.screenW*0.4)/2, y: 0, width: .screenW, height: .screenH*0.06))
        label.text = "동물친구들의 특징을"
        label.font = UIFont(name: "KOTRA HOPE", size: .screenW*0.1)
        label.textColor =  UIColor.appColor(.primaryGreen)
        let fullText = label.text ?? ""
        let attribtuedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: "을")
        attribtuedString.addAttribute(.foregroundColor, value: UIColor.black, range: range)
        label.attributedText = attribtuedString
        label.layer.opacity = 0
        return label
    }()
    lazy var tellMeWellLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: (.screenW*0.6)/2, y: .screenH*0.07, width: .screenW, height: .screenH*0.06))
        label.text = "잘 알려주면"
        label.font = UIFont(name: "KOTRA HOPE", size: .screenH*0.05)
        label.layer.opacity = 0
        return label
    }()
    lazy var yourAnimalFriendsLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: (.screenW*0.6)/2, y: .screenH*0.14, width: .screenW, height: .screenH*0.06))
        label.text = "동물친구들이"
        label.font = UIFont(name: "KOTRA HOPE", size: .screenH*0.05)
        label.layer.opacity = 0
        return label
    }()
    lazy var comingBackLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: (.screenW*0.66)/2, y: .screenH*0.21, width: .screenW, height: .screenH*0.06))
        label.text = "돌아와요♥️"
        label.font = UIFont(name: "KOTRA HOPE", size: .screenH*0.05)
        label.layer.opacity = 0
        return label
    }()
    
    // MARK: 스플래시 & 온보딩 이미지 모음
    lazy var detectiveImage: UIImageView = {
        let posX: CGFloat = (.screenW*0.4)/2
        let posY: CGFloat = (.screenH*0.9)/2
        let detectiveImage: UIImageView = UIImageView(frame: CGRect(x: posX, y: posY, width: .screenW*0.6, height: .screenH*0.4))
        detectiveImage.image =  UIImage(named: "detectiveImage1")!
        
        return detectiveImage
    }()
    lazy var detectiveImage2: UIImageView = {
        let posX: CGFloat = (.screenW*0.5)/2
        let posY: CGFloat = (.screenH*0.65)/2
        let detectiveImage: UIImageView = UIImageView(frame: CGRect(x: posX, y: posY, width: .screenW*0.5, height: .screenH*0.32))
        detectiveImage.image =  UIImage(named: "detectiveImage4")!
        
        return detectiveImage
    }()
    lazy var assistantImage1: UIImageView = {
        let posX: CGFloat = (.screenW*0.6)/2
        let posY: CGFloat = (.screenH*0.74)/2
        let assistantImage1: UIImageView = UIImageView(frame: CGRect(x: posX, y: posY, width: .screenW*0.4, height: .screenH*0.28))
        assistantImage1.image = UIImage(named: "assistantImage2")!
        
        return assistantImage1
    }()
    lazy var totalAnimalsImage1: UIImageView = {
        let posX: CGFloat = (.screenW*0.2)/2
        let posY: CGFloat = (.screenH*0.64)/2
        let totalAnimalsImage: UIImageView = UIImageView(frame: CGRect(x: posX, y: posY, width: .screenW*0.8, height: .screenH*0.32))
        totalAnimalsImage.image = UIImage(named: "totalAnimals")!
        
        return totalAnimalsImage
    }()
    
    // MARK: UIPageControl 관련 변수, 함수
    private lazy var imageSlider: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = pageControlNum
        pageControl.hidesForSinglePage = true
        pageControl.currentPageIndicatorTintColor = .systemGray
        pageControl.pageIndicatorTintColor = .systemGray3
        return pageControl
    }()
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: self.view.frame)
        scrollView.showsHorizontalScrollIndicator = false;
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: CGFloat(pageControlNum) * self.view.frame.maxX, height: 0)
        return scrollView
    }()
    private func setupSliderLayout(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: UIScreen.main.bounds.height*0.15),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant : -UIScreen.main.bounds.height*0.18),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        imageSlider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageSlider.topAnchor.constraint(equalTo: scrollView.bottomAnchor),
            imageSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(findLabel)
        view.addSubview(animalLabel)
        view.addSubview(friendsLabel)
        view.addSubview(detectiveImage)
        timeCount()
    }
}

extension LaunchScreenController: UICollectionViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let nextPage = Int(targetContentOffset.pointee.x / self.view.frame.width)
        self.imageSlider.currentPage = nextPage
        
        //페이지가 넘어갈 때마다 라벨 넘어가는 애니메이션 추가
        if nextPage == 1 {
            self.onboardingExitButton.removeFromSuperview()
            UIView.animate(withDuration: 0.5) {
                self.toKimAssistantLabel.layer.opacity = 1
                self.playSound(sound: "textSound")
            } completion: { _ in
                UIView.animate(withDuration: 0.5) {
                    self.playSound(sound: "textSound")
                    self.ofAnimalFriendsLabel.layer.opacity = 1
                }  completion: { _ in
                    UIView.animate(withDuration: 0.5) {
                        self.playSound(sound: "textSound")
                        self.characteristicsLabel.layer.opacity = 1
                    } completion: { _ in
                        UIView.animate(withDuration: 0.5) {
                            self.playSound(sound: "textSound")
                            self.letMeKnowLabel.layer.opacity = 1
                           
                        }
                    }
                }
            }
        } else if nextPage == 2 {
            UIView.animate(withDuration: 0.5) {
                self.characteristicsOfAnimalFriendsLabel.layer.opacity = 1
                self.playSound(sound: "textSound")
            } completion: { _ in
                UIView.animate(withDuration: 0.5) {
                    self.playSound(sound: "textSound")
                    self.tellMeWellLabel.layer.opacity = 1
                }  completion: { _ in
                    UIView.animate(withDuration: 0.5) {
                        self.playSound(sound: "textSound")
                        self.yourAnimalFriendsLabel.layer.opacity = 1
                    } completion: { _ in
                        UIView.animate(withDuration: 0.5) {
                            self.playSound(sound: "textSound")
                            self.comingBackLabel.layer.opacity = 1
                            self.onboardingExitButton.layer.opacity = 1
                        }
                    }
                }
            }
            // 마지막 페이지 일 때만 온보딩 종료 버튼을 보여줌
            view.addSubview(onboardingExitButton)
        }
    }
}

// MARK: Private Extension

private extension LaunchScreenController {
    func addSubviewsWithFrame() {
        backImageView.frame = view.bounds
        view.addSubview(backImageView)
        
        // corkboard배경에 animal memo 버튼들 .addSubview로 추가
        for i in 0...4 {
            let ratio = memosRatio[i]
            let button = memoButton(CGPoint(x: .screenW / ratio[0], y: .screenH / ratio[1]), imageName: memosAnimal[i])
            button.tag = i
            button.addTarget(self, action: #selector(zoomInAction(_:)), for: .touchUpInside)
            backImageView.addSubview(button)
            memoButtons.append(button) // 빈 배열에 버튼들 추가. 줌 축소 확대 시 .map 사용하여 전체 핸들링을 위함
        }
    }
    
    @objc func zoomInAction(_ sender: UIButton) {
        let ratio = memosRatio[sender.tag] // 뒷 배경이미지의 origin을 잡기 위해 클릭된 버튼의 ratio를 받음.
        
        UIView.animate(withDuration: 1.5, delay: 0, options: .curveEaseInOut) { [weak self] in
            guard let self = self else { return }
            
            self.backImageView.frame.size = .backDoubleSize // corkboard 배경늘리기. 너비, 높이 * 2 (면적으로는 4배)
            
            // frame을 한 번에 CGRect로 잡지않고, CGPoint&CGSize로 나누어 잡은 이유
            // -> 커진 back을 기준으로 ratio를 잡아야하기에 먼저 사이즈를 키우고, 커진 사이즈와 ratio를 통해 origin을 잡은 것.
            self.backImageView.frame.origin = CGPoint(
                x: -self.backImageView.frame.width / ratio[0] + .screenW/5,
                y: -self.backImageView.frame.height / ratio[1] + .screenH/3
            )
            // sender를 통해선 클릭된 버튼만 전달되지만, 실제 메인에선 하나의 버튼이 커질 때 나머지들도 함께 커져야한다. 그래서 배열을 만들고 map 고차함수를 이용하여 모두의 frame을 잡아준다.
            let _ = self.memoButtons.map { button in
                let tag = button.tag
                button.frame = CGRect(
                    origin: CGPoint(
                        x: self.backImageView.frame.width / self.memosRatio[tag][0],
                        y: self.backImageView.frame.height / self.memosRatio[tag][1]
                    ),
                    size: .memoDoubleSize
                )
            }
        }
        sender.isUserInteractionEnabled = false // zoom in 후에 터치 잠기도록.
    }
    
    @objc func zoomOutAction() {
        UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseInOut) { [weak self] in
            guard let self = self else { return }
            self.backImageView.frame = self.view.bounds // 원래 크기인 view.bounds로 회귀.
            let _ = self.memoButtons.map { button in
                let tag = button.tag
                button.frame = CGRect(
                    origin: CGPoint(
                        x: .screenW / self.memosRatio[tag][0],
                        y: .screenH / self.memosRatio[tag][1]
                    ),
                    size: .memoSize
                )
                button.isUserInteractionEnabled = true // 추후 핸들링 예정
            }
        }
    }
}

class AVPlay {
    
    var player: AVAudioPlayer!
    
    func playSound(sound: String){
         let url = Bundle.main.url(forResource: sound, withExtension: "wav")
         guard url != nil else{
             return
         }
         do{
             player = try AVAudioPlayer(contentsOf: url!)
             player?.play()
         }catch{
             print("\(error)")
         }
     }
}
