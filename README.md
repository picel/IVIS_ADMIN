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