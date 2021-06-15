create table cinema (
    localcode number(5),
    cinemacode number(5) primary key,
    cinemaname varchar2(100) not null,
    intro varchar2(500) not null,
    address varchar2(200) not null,
    one_cin number(1) default 1,
    two_cin number(1) default 1,
    three_cin number(1) default 1,
    four_cin number(1) default 1,
    five_cin number(1) default 1,
    six_cin number(1) default 1,
    FOREIGN KEY (localcode) REFERENCES local(localcode)
    ON DELETE CASCADE
);

insert into cinema values(10001, 90001, '강남', '강남의 중심! 강남 소비문화의 중심지인 지하철 2호선 , 신분당선 - 강남역과 연결
로맨틱 멀티플렉스! 젊은 도시 강남이 한 눈에 보이는 최상의 View를 제공', '서울 서초구 서초대로77길 3 아라타워 8층 메가박스 강남지점'
,1,1,1,0,0,0);

insert into cinema values(10001, 90003, '강동', '강동구청역 도보 5분 거리에 위치!
10개관 총 1500석 규모! 249석의 대형 상영관에서 생생한 관람을!', '서울특별시 강동구 성내로 48'
,1,0,0,1,0,1);

insert into cinema values(10001, 90004, '동대문', '전통과 현대가 공존하는 곳, 동대문 역사문화공원역 13, 14번 출구
쾌적하고 멋스러운 로비, 지상 40m에서 즐기는 환상의 뷰! (8개 상영관/1,744석)', '서울 중구 장충단로 247 굿모닝시티9층'
,0,1,1,1,0,0);

insert into cinema values(10001, 90010, '센트럴', '서초 강남구 최대 문화공간 FAMILLE STREET 내 위치
아르데코 양식으로 장식된 아늑한 THE BOUTIQUE', '서울시 서초구 신반포로 176 센트럴시티 빌딩 B1F'
,1,0,1,0,1,1);

insert into cinema values(10001, 90015, '홍대', '글로벌 핵인싸 아싸들의 놀이터!
홍대입구역 1번 출구 오른쪽 50M 위치!', '서울특별시 마포구 동교동 양화로 147 , 7-12층(동교동, 아일렉스)'
,0,1,1,1,0,1);

insert into cinema values(10002, 90016, '고양스타필드',
'스타필드와 메가박스의 만남, MEGABOX in 스타필드 고양 Meyer Sound와 Dolby ATMOS 시스템, 차세대 상영관의 표준 사운드 특화관 MX관',
'경기도 고양시 덕양구 고양대로 1955 스타필드고양 4층 메가박스 고양스타필드점'
,1,0,1,0,1,0);

insert into cinema values(10002, 90017, '남양주',
'남양주 호평 최대의 복합 문화공간 장애우를 배려한 좌석 등 항상 따뜻한 미소가 넘치는 메가박스 남양주',
'경기도 남양주시 호평동 늘을2로 26 메인시네마타워'
,0,0,1,1,1,1);

insert into cinema values(10002, 90018, '부천스타필드시티',
'스타필드 시티와 메가박스의 첫 만남! 더 밝고 선명한 관람을 위한 전상영관 레이저 영사기 도입',
'경기도 부천시 옥길로 1'
,1,1,0,1,0,1);

insert into cinema values(10003, 90019, '검단',
'더 밝고 깨끗한 화질 디지털 영사 줌렌즈 및 전 상영관 가죽시트!',
'인천광역시 서구 서곶로 788 (당하동) 홀리랜드 4층 메가박스 검단'
,0,0,0,1,1,1);

insert into cinema values(10003, 90020, '송도',
'기존 영화관 로비의 전형성을 탈피한 카페형 로비',
'인천광역시 연수구 송도과학로 16번길 33-4번지 트리플 스트리트 D동 2층 메가박스 송도지점'
,1,0,0,1,1,1);

insert into cinema values(10003, 90021, '영종',
'영종도 시민의 여가 문화를 선도하는 최적의 문화 플렛폼 영종도 중심 상권과 역세권에 위치한 탁월한 입지',
'인천 중구 영종대로 184(운서동, 7층)'
,1,1,1,0,0,0);