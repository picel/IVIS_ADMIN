# ivis_admin

## 개요
- IVIS 신입 연구원 모집을 위한 관리자 패널
- [IVIS 신입 연구원 모집 페이지](https://ivis.dev) 에서 가입한 정보 및 지원서 열람 가능

## 사용 기술
- Flutter
    - http
        - 회원 인증 서버와 통신
        - 백엔드 서버와 통신
    - shared_preferences
        - 로그인 정보(JWT 토큰) 저장
    - responsive_builder
        - 반응형 디자인
- Nginx
    - Let's Encrypt
        - SSL 인증서 발급 (.dev 도메인용)
    - Reverse Proxy

## 실행 화면
- 로그인 화면<br>
>Desktop
<img src="https://user-images.githubusercontent.com/30901178/222893752-bd3cf393-fd54-4b0b-b7cd-09253a5d8528.png"><br>
>Mobile<p align="center">
<img src="https://user-images.githubusercontent.com/30901178/222893823-3dfb510d-6fea-4b9a-8810-e0748ea6fa92.PNG" height="300">
</p>

- 대쉬보드
>Desktop
<img src="https://user-images.githubusercontent.com/30901178/222894388-ee29c150-24e2-4a58-8e61-ed789c1bbdae.png"><br>
>Mobile<p align="center">
<img src="https://user-images.githubusercontent.com/30901178/222894399-4be1748b-1e95-43a0-bcc2-832cedd4b40c.PNG" height="300">
</p>

- 지원자 목록
>Desktop
<img src="https://user-images.githubusercontent.com/30901178/222894427-5e9d7733-c52f-4374-ad7e-dee4e352e87b.png"><br>
>Mobile<p align="center">
<img src="https://user-images.githubusercontent.com/30901178/222894430-b8a52932-442d-450f-9601-3b20c50fc5c8.PNG" height="300">
</p>

- 지원서 조회
>Desktop
<img src="https://user-images.githubusercontent.com/30901178/222894450-ed4598f2-d023-46fe-a9fc-fc5b1fda2dc6.png"><br>
>Mobile<p align="center">
<img src="https://user-images.githubusercontent.com/30901178/222894452-fbab1ae1-d271-4218-ae05-e52831562ba6.PNG" height="300">
</p>

## Update Log
- 2023.02.21.
    - 초기 버전 생성
- 2023.02.28.
    - 서버 연동 및 로그인 기능 구현
    - 지원자 목록 조회 기능 구현
    - 지원서 조회 기능 구현
- 2023.03.04.
    - 모바일 환경에서의 반응형 디자인 구현
    - 깃허브 레포지토리 생성
    - README.md 작성
    - 로그인 화면에서의 무한 라우팅 문제 해결