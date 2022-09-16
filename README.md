<h1 align="center">
  <br>
  <img src="https://user-images.githubusercontent.com/95853235/190580774-bd77acae-6a73-43c5-92e0-d7bcbdcda6d1.png" alt="How Old Am I" width="200">
  <br>
</h1>

# 😍 MC3-Team14-FindAnimalFriends
**멸종위기동물이란 키워드를 이용해서 아이들이 환경문제에 관심을 가질 수 있도록 하자!**

> 아이들이 좋아할만한 소재인 "탐정"과 "조수" 세계관.
>
> 각 동물버튼을 클릭해서 해당 동물에 관한 퀴즈들을 풀 수 있음.
>
> 정답 시 설명.
> 
> 해당 동물에 대한 퀴즈를 모두 풀면 다음 동물 퀴즈를 풀 수 있음.

<br>

## Skills & Tech Stack
<img src="https://img.shields.io/badge/Swift-F05138?style=for-the-badge&logo=Swift&logoColor=white"><br>
1. 이슈 및 형상관리 : Github
2. 커뮤니케이션 : Notion, Miro, Zoom
3. 스킬 : UIKit, AVFoundation, Lottie, CAAnimation
4. 상세 사용
   - Application : UIKit
   - Design : Sketch

<br>

## 🌅 Screenshots
|<img src="https://user-images.githubusercontent.com/95853235/190582033-2b0857c0-99a7-4e4e-b30f-ebe60488aaec.PNG" width=300>|<img src="https://user-images.githubusercontent.com/95853235/190582049-8ebdc7d5-6f91-409e-9eea-c35762933264.PNG" width=300>|<img src="https://user-images.githubusercontent.com/95853235/190582080-1ca46aba-eec6-4f67-95af-f81c82bb1991.PNG" width=300>|
|------|---|---|

<br>

## 🙋🏻‍♂️ Members

| 이름                                                         | 역할                                 |
| ------------------------------------------------------------ | ------------------------------------ |
| [김현수](https://github.com/BrightHyeon) - swiftist9891@gmail.com | 메인 코르크보드뷰 구현. 줌 애니메이션 구현. |
| [민병수](https://github.com/Byeongsoo-Min) - qaz9783@naver.com | 퀴즈 오답 페이지 및 퀴즈 페이지 설명 데이터 관리.     |
| [전동진](https://github.com/hotsunnyday) - hotsunnyday@naver.com   | 동물 퀴즈 페이지 및 페이징 애니메이션 구현.      |
| [허재녕](https://github.com/mizz0224) - wosud0224@naver.com | 데이터 관리 총괄. 퀴즈 정답 및 완료 시 페이지 구현.      |
| [변진하](https://github.com/Byeonjinha) - jinhaday@gmail.com | 런치스크린 및 온보딩페이지 구현. 사운드 로직 총괄.      |

<br>

## Git Commit Message
### 커밋 메시지 구조

<br>

> type: Subject<br><br>
> body<br><br>
> footer

<br>

### Type
타입에는 작업 타입을 나타내는 태그를 적습니다.<br>
작업 타입에는 대략 다음과 같은 종류가 있습니다.
|*Type*|*Subject*|
|:---|:---|
|**[Feat]**|새로운 기능 추가|
|**[Add]**|새로운 뷰, 에셋, 파일, 데이터... 추가|
|**[Fix]**|버그 수정|
|**[Chore]**|빌드, 설정 관련 파일 수정|
|**[Design]**|UI Design 변경|
|**[Docs]**|문서 (문서 추가, 수정, 삭제)|
|**[Style]**|스타일 (코드 형식, 세미콜론 추가: 비즈니스 로직에 변경 없는 경우)|
|**[Refactor]**|코드 리팩토링|
|**[Rename]**|파일명 또는 디렉토리명을 단순히 변경만 한 경우|
|**[Delete]**|파일 또는 디렉토리를 단순히 삭제만 한 경우|

예시) [Type] #이슈번호 커밋메세지 `git commit -m "[Feat] #12 로그인 기능 추가"`

### Issue

- Issue 의 title 시작을 tag로 시작한다

- PR를 올리기 전에 Issue를 생성하고 연결한다

- 작업에 대한 원인과 흐름등을 설정한다

### PR

- PR 의 title 시작을 tag로 시작한다

- Title 은 작업된 File 이름 혹은 기능 이름으로 한다

- 최소 2명의 Approve

- PR를 올리기 전에 Issue를 생성하고 연결한다

- 단위 : 수정/추가된 기능 혹은 File 단위로 한다.

### Commit

- Commit 의 title 시작을 tag로 시작한다

- Title 은 작업된 File 이름 혹은 기능 이름으로 한다

- Commit 의 description 에는 작업된 상세 내용이 들어간다

- Description에는 작업한 내용과 To Reviewers 로 review 할 내용을 전달한다

- 단위 : 같은 File 혹은 기능내에서 가능한 작은 단위의 기능으로 쪼개어 commit 한다 얘) func , class, component 등

### Project ToDo

- 개인의 할일 Reminder 로 사용한다

<br>

### Subject(필수)
서브젝트는 50글자가 넘지 않도록 작성합니다.<br>
서브젝트는 마침표를 찍지 않습니다.<br>
영어로 작성하는 경우 첫 문자는 대문자로 작성합니다.<br>

### Body(옵셔널)
바디는 서브젝트에서 한 줄 건너뛰고 작성합니다.<br>
바디는 없어도 큰 문제가 없는 경우도 많습니다. 따라서 항상 작성해야 하는 부분은 아닙니다.<br>
설명해야 하는 변경점이 있는 경우에만 작성하도록 합시다!<br>
바디에는 뭐가 어떻게 변경됐다는 구체적 정보보다는 왜 이 작업을 했는지에 대한 정보를 적는 것이 좋습니다.<br>

### Footer(옵셔널)
푸터도 바디와 마찬가지로 옵션입니다.<br>
푸터의 경우 일반적으로 트래킹하는 이슈가 있는 경우 트래커 ID를 표기할 때 사용합니다.<br>
'#' 를 누르면 이슈 번호나 커밋 번호를 확인할 수 있습니다.<br>
필요한 경우 푸터를 남겨주세요!

<br>

## Git Pull Request Message
[태스크] >> 브랜치 명

예시) [추가 모달 뷰 연결] >> addModalView


