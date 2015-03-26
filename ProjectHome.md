## 웹사이트 프로토타입 빌더(Website Prototype Builder), zi5 ##

zi5는 신속하고 간단하게 웹사이트 프로토타이핑을 만들고 그 결과를 바탕으로 실제 웹사이트를 쉽게 제작할 수 있도록 해주는 루비온레일스 기반 오픈소스 애플리케이션으로, 주요 특징은 다음과 같습니다.

  * 루비온레일스 2.3.2 기반
  * yml 스크립트를 이용한 간편한 메뉴 생성
  * 게시판 및 페이지 자동생성 지원
  * 관리자페이지 지원(/admin)


### 설치법(Installation) ###

1. 소스를 다운로드 받는다.

$ **svn checkout http://zi5.googlecode.com/svn/trunk/ mysite**

2. 다운로드 받은 디렉터리로 이동한다.

$ **cd mysite**

3. 데이터베이스 설정파일을 만들고 (필요시) 설정을 조정한다.

$ **mv config/database.yml.example config/database.yml**

(zi5는 기본으로 SQLite3를 사용하게 되어 있으며 mysql 등 다른 데이터베이스를 사용할 경우는 config/database.yml 파일을 열어 설정을 조정해 주면 됨)

4. 필요한 gem을 설치한다.(acts\_as\_markup 이 필요합니다)

$ **rake gems:install**

5. 데이터베이스를 생성하고 스키마를 생성한다.

$ **rake db:migrate**

6. config/menu.yml 파일을 열어 메뉴를 편집한 다음 메뉴 빌더를 실행한다.

$ **rake zi5:build:menu**

7. 서버를 실행한다.

$ **ruby script/server**

8. 웹 브라우저에서 http://localhost:3000/ 으로 접속하여 작동을 확인한다. 끝.


### 데모(Working demo) ###

http://usefulparadigm.com