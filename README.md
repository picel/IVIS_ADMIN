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