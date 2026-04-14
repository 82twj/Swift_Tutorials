# Birthdays

간단한 친구 생일 관리 앱입니다.  
SwiftUI로 화면을 만들고, SwiftData로 친구 이름과 생일 데이터를 저장하는 흐름을 연습한 프로젝트입니다.

## 프로젝트 목적

이 프로젝트를 통해 아래 내용을 직접 코드로 익힐 수 있습니다.

- `SwiftData` 모델을 만들고 앱에 연결하는 방법
- `@Query`로 저장된 데이터를 자동으로 불러오는 방법
- `modelContext`를 이용해 데이터를 저장하는 방법
- `@State`로 입력값을 관리하고 `SwiftUI` 화면과 연결하는 방법
- 날짜 데이터를 화면에 보기 좋게 표시하는 방법

## 파일별 역할

### [BirthdaysApp.swift](/Users/taewonjin/Documents/XcodePractice/[2] DataModeling/Birthdays/Birthdays/BirthdaysApp.swift)

앱의 시작 지점입니다.

- `ContentView()`를 첫 화면으로 보여줍니다.
- `.modelContainer(for: Friend.self)`를 통해 `Friend` 모델을 SwiftData 저장소와 연결합니다.

즉, 앱 전체에서 `Friend` 데이터를 저장하고 조회할 수 있도록 환경을 세팅하는 역할입니다.

### [Friend.swift](/Users/taewonjin/Documents/XcodePractice/[2] DataModeling/Birthdays/Birthdays/Friend.swift)

친구 한 명의 데이터를 표현하는 모델입니다.

- `@Model`을 사용해 SwiftData가 관리하는 객체로 만듭니다.
- `name`, `birthday` 두 개의 속성을 가집니다.
- `isBirthdayToday` 계산 프로퍼티로 오늘 생일인지 확인하려고 합니다.

이 파일을 통해 배운 점은, SwiftData에서는 클래스에 `@Model`을 붙여 앱에서 저장 가능한 데이터 타입을 정의할 수 있다는 것입니다.

### [ContentView.swift](/Users/taewonjin/Documents/XcodePractice/[2] DataModeling/Birthdays/Birthdays/ContentView.swift)

앱의 메인 화면입니다.

- `@Query(sort: \Friend.birthday)`로 친구 목록을 생일 순서대로 가져옵니다.
- `List`로 친구 목록을 화면에 출력합니다.
- 생일이 오늘이면 케이크 아이콘을 보여주고 이름을 굵게 표시합니다.
- 하단 입력 영역에서 이름과 날짜를 입력받아 새 친구를 저장합니다.
- 저장 버튼을 누르면 `context.insert(newFriend)`로 SwiftData에 새 데이터를 추가합니다.
- 저장 후에는 입력값을 초기화합니다.

이 화면 하나에 조회, 입력, 저장, 상태 관리가 모두 들어 있어서 SwiftUI와 SwiftData의 연결 구조를 연습하기 좋습니다.

## 이 코드에서 배운 핵심 내용

### 1. `@Model`로 데이터 모델 만들기

```swift
@Model
class Friend {
    var name: String
    var birthday: Date
}
```

기존의 단순한 Swift 타입과 달리, `@Model`이 붙은 클래스는 SwiftData가 추적하고 저장할 수 있습니다.  
즉, 앱에서 사용할 데이터를 "화면용 값"이 아니라 "저장 가능한 데이터"로 정의하는 방식이라고 이해할 수 있습니다.

### 2. `modelContainer`로 저장소 연결하기

```swift
ContentView()
    .modelContainer(for: Friend.self)
```

모델만 만든다고 저장이 되는 것은 아니고, 앱 시작 지점에서 어떤 모델을 저장할지 등록해야 합니다.  
이 코드 덕분에 `Friend` 데이터가 앱 전체에서 관리됩니다.

### 3. `@Query`는 저장된 데이터를 자동으로 가져온다

```swift
@Query(sort: \Friend.birthday) private var friends: [Friend]
```

별도의 fetch 코드를 직접 작성하지 않아도 SwiftData가 데이터를 읽어옵니다.  
또한 데이터가 바뀌면 화면도 같이 갱신되므로 SwiftUI와 잘 어울립니다.

### 4. `modelContext`로 데이터 추가하기

```swift
let newFriend = Friend(name: newName, birthday: newDate)
context.insert(newFriend)
```

입력값으로 새 모델 객체를 만든 뒤 `insert`하면 저장 대상에 포함됩니다.  
즉, `modelContext`는 SwiftData에서 데이터를 생성, 수정, 삭제할 때 중심이 되는 객체입니다.

### 5. `@State`는 입력 폼 상태를 관리한다

```swift
@State private var newName = ""
@State private var newDate = Date.now
```

텍스트필드와 날짜선택기의 현재 값을 저장하는 상태입니다.  
사용자가 값을 바꾸면 화면과 데이터가 함께 갱신되며, 저장 후 다시 초기화할 수도 있습니다.

### 6. SwiftUI에서는 입력 UI를 자연스럽게 조합할 수 있다

```swift
DatePicker(selection: $newDate, in: Date.distantPast...Date.now, displayedComponents: .date) {
    TextField("Name", text: $newName)
}
```

`DatePicker`, `TextField`, `Button`, `List` 같은 기본 뷰를 조합해서 간단한 CRUD 화면을 빠르게 만들 수 있습니다.  
특히 날짜 범위를 `Date.distantPast...Date.now`로 제한해 미래 날짜를 선택하지 못하게 한 점도 실용적인 처리입니다.

## 알아둘 점

### `isBirthdayToday`는 현재 구현상 연도까지 함께 비교될 가능성이 있다

```swift
var isBirthdayToday: Bool {
    Calendar.current.isDateInToday(birthday)
}
```

이 코드는 저장된 `birthday`가 "오늘 날짜와 완전히 같은 날"인지 확인하는 방식입니다.  
생일 앱에서는 보통 연도는 무시하고 월/일만 비교하고 싶기 때문에, 의도에 따라 로직을 다시 작성해야 할 수 있습니다.

예를 들면 아래처럼 월과 일만 비교하는 방식이 더 자연스러울 수 있습니다.

```swift
var isBirthdayToday: Bool {
    let calendar = Calendar.current
    let birthdayComponents = calendar.dateComponents([.month, .day], from: birthday)
    let todayComponents = calendar.dateComponents([.month, .day], from: .now)
    return birthdayComponents.month == todayComponents.month &&
           birthdayComponents.day == todayComponents.day
}
```

이 부분은 단순 구현을 넘어서 "도메인에 맞는 날짜 비교"가 왜 중요한지 배울 수 있는 포인트입니다.

### 입력 검증은 아직 없다

현재는 이름이 비어 있어도 저장할 수 있습니다.  
실제 앱으로 확장하려면 아래 같은 검증이 있으면 더 좋아집니다.

- 이름이 비어 있으면 저장 버튼 비활성화
- 중복 이름 처리
- 저장 성공 후 사용자 피드백 표시

## 정리

이 프로젝트의 핵심은 `SwiftUI 화면`과 `SwiftData 저장 구조`를 자연스럽게 연결해 보는 데 있습니다.

- `Friend` 모델로 저장할 데이터 구조를 정의했다.
- `BirthdaysApp`에서 모델 컨테이너를 연결했다.
- `ContentView`에서 데이터를 조회하고, 입력받고, 저장했다.
- 상태값과 저장 데이터를 함께 다루는 흐름을 연습했다.

작은 프로젝트이지만, iOS 앱에서 자주 쓰이는 데이터 흐름의 기본이 잘 담겨 있습니다.

## 다음에 확장해볼 기능

- 친구 삭제 기능 추가
- 친구 정보 수정 기능 추가
- 오늘 생일인 사람만 따로 보여주기
- 이름 기준 정렬 / 날짜 기준 정렬 전환
- 빈 상태 화면 추가
- 알림 기능 추가
