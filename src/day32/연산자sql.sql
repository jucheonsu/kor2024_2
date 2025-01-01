drop database if exists mydb1128;
create database mydb1128;
use mydb1128;

# 1. 회원테이블
drop table if exists member;
create table member(				# 아이돌 그룹
	mid char(8) not null ,			# 식별키 		최대 8자리
    mname varchar(10) not null ,	# 그룹명		최대 10자리
    mnumber int not null ,			# 인원수		정수 +-21억정도
    maddr char(2) not null , 		# 지역		최대 2자리
    mphone1 char(3) ,				# 지역번호	최대 2자리 
    mphone2 char(8) ,				# 전화번호 	최대 8자리
    mheight smallint ,				# 평균키 		정수 +-3만정도
	mdebut date ,					# 데뷔일 		yyyy-mm-dd 
    primary key ( mid )				# 제약조건 
);
# 2. 구매테이블
drop table if exists buy;
create table buy(
	bnum int auto_increment , 			# 구매번호	정수 	자동번호 부여 
    mid char(8),						# 구매자		FK 
    bpname char(6) not null ,			# 제품명		최대 6자리 
    bgname char(4) , 					# 분류명 		최대	4자리
    bprice int not null ,				# 가격 		정수 
    bamout smallint not null ,			# 구매수량	정수 
    primary key(bnum) ,					# 제약조건 
    foreign key ( mid ) references member(mid) # 제약조건 
);

# 샘플데이터 
INSERT INTO member VALUES('TWC', '트와이스', 9, '서울', '02', '11111111', 167, '2015.10.19');
INSERT INTO member VALUES('BLK', '블랙핑크', 4, '경남', '055', '22222222', 163, '2016.08.08');
INSERT INTO member VALUES('WMN', '여자친구', 6, '경기', '031', '33333333', 166, '2015.01.15');
INSERT INTO member VALUES('OMY', '오마이걸', 7, '서울', NULL, NULL, 160, '2015.04.21');
INSERT INTO member VALUES('GRL', '소녀시대', 8, '서울', '02', '44444444', 168, '2007.08.02');
INSERT INTO member VALUES('ITZ', '잇지', 5, '경남', NULL, NULL, 167, '2019.02.12');
INSERT INTO member VALUES('RED', '레드벨벳', 4, '경북', '054', '55555555', 161, '2014.08.01');
INSERT INTO member VALUES('APN', '에이핑크', 6, '경기', '031', '77777777', 164, '2011.02.10');
INSERT INTO member VALUES('SPC', '우주소녀', 13, '서울', '02', '88888888', 162, '2016.02.25');
INSERT INTO member VALUES('MMU', '마마무', 4, '전남', '061', '99999999', 165, '2014.06.19');
INSERT INTO buy VALUES(NULL, 'BLK', '지갑', NULL, 30, 2);
INSERT INTO buy VALUES(NULL, 'BLK', '맥북프로', '디지털', 1000, 1);
INSERT INTO buy VALUES(NULL, 'APN', '아이폰', '디지털', 200, 1);
INSERT INTO buy VALUES(NULL, 'MMU', '아이폰', '디지털', 200, 5);
INSERT INTO buy VALUES(NULL, 'BLK', '청바지', '패션', 50, 3);
INSERT INTO buy VALUES(NULL, 'MMU', '에어팟', '디지털', 80, 10);
INSERT INTO buy VALUES(NULL, 'GRL', '혼공SQL', '서적', 15, 5);
INSERT INTO buy VALUES(NULL, 'APN', '혼공SQL', '서적', 15, 2);
INSERT INTO buy VALUES(NULL, 'APN', '청바지', '패션', 50, 1);
INSERT INTO buy VALUES(NULL, 'MMU', '지갑', NULL, 30, 1);
INSERT INTO buy VALUES(NULL, 'APN', '혼공SQL', '서적', 15, 1);
INSERT INTO buy VALUES(NULL, 'MMU', '지갑', NULL, 30, 4);

# [1] 모든 필드의 테이블 조회 , 
select * from member; # 'member' 테이블의 모든 필드 표시 하는 모든 레코드 조회
select * from buy;	  # 'buy' 테이블의 모든 필드 표시 하는 모든 레코드 조회
# [2] 특정 필드의 테이블 조회 
select mid from member; # 'member' 테이블의 'mid' 필드 표시 하는 모든 레코드 조회
select mid , mname from member; # 'member' 테이블의 'mid' 와 'mname' 필드 표시 하는 모든 레코드 조회
# [3] as 별칭 , 조회 결과의 필드명을 부여 , 필드명 별칭 , as 생략가능
select mid as 회원아이디 from member;	# 'member' 테이블의 mid 필드를 '회원아이디'로 표시 하는 모든 레코드 조회 
select mid 회원아이디 from member m; # 'member' 테이블의 mid 필드를 '회원아이디' 로 표시 하는 모든 레코드 조회
# [4] 조건절 , where 
select * from member where mname = '블랙핑크'; #'member' 테이블의 모든 필드 표시 하는 mname이 블랙핑크인 레코드만 조회
select * from member where mnumber = 4;	#'member'테이블의 모든 필드 표시 하는 mnumber가 4 인 레코드만 조회
select * from member where mheight <= 162; # 'member' 테이블의 mheight 필드 값이 162 이하 인 레코드만 조회 
select * from member where mheight >= 165 and mheight <= 170; # 'mheight 필드 값이 165 이상 이면서 170 이하 인 레코드 조회 '
select * from member where mheight between 165 and 170; # 'mheight' 필드 값이 165 이상 이면서 170 이하 인 레코드 조회 '
select * from member where mheight >= 165 or mnumber > 6;  # 'mheight' 필드 값이 165 이상 이거나  'mnumber' 필드 값이 6 초과인 레코드 조회 
select * from member where maddr = '경기' or maddr ='전남' or maddr ='경남'; # 'maddr' 필드값이 '경기' 이거나 '전남' 이거나 '경남' 인 레코드 조회 
select * from member where maddr in( '경기' , '전남' , '경남' ); # 'maddr' 필드값이 '경기' 이거나 '전남' 이거나 '경남' 인 레코드 조회 
select * from member where maddr not in('경기','전남','경남');	# 'maddr' 필드값이 '경기' 이거나 '전남' 이거나 '경남' 이 아닌(부정) 레코드 조회 
select * from member where mname != '에이핑크';	# 'mname' 필드값이 에이핑크가 아닌 레코드 조회 
select * from member where not mname = '에이핑크';
select * from member where mname like '에이%';	# 'mname' 필드값이 에이 로 시작 하는 래코드 조회 
select * from member where mname like '%핑크';	# 'mname' 필드값이 핑크 로 끝나는 레코드 조회 
select * from member where mname like '%이%';	# 'mname' 필드값이 '이' 가 포함된 레코드 조회
select * from member where mname like '에이__';	# 'mname' 필드값이 '에이'로 시작하는 네글자 인 레코드 조회
select * from member where mname like '__핑크';	# 'mname' 필드값이 '핑크'로 끝나는 네글자 인 레코드 조회
select * from member where mname like '_이_';	# 'mname' 필드값이 두번째 글자가 '이' 세글자 인 레코드 조회 
select * from member where mphone1 = '';		# 'mphone1' 필드값이 ''공백인 레코드 조회
select * from member where mphone1 is null;		# ''공백 vs ' '띄어쓰기공백 vs null 모두 다른 데이터로 식별된다. 그러므로 null 조회시 is null
select * from member where mphone1 is not null ;	# 'mphone1' 필드값이 null 아닌 레코드 조회 

select mnumber + 3 as 더하기 , mnumber - 3 as 빼기 , mnumber * 3 , 
		mnumber / 3 as 나누기 , mnumber div 3 as 몫 , mnumber mod 3 as 나머지
from member;

# [5] 정렬  , 조회 결과의 레코드를 특정한 필드 기준으로 정렬 
# order by 필드명 asc[생략가능]		: 지정한 필드명기준으로 레코드를 오름차순 정렬 , 작은수 -> 큰수 , 과거날짜 -> 최근날짜 
# order by 필드명 desc			: 지정한 필드명기준으로 레코드를 내림차순 정렬 , 큰수 -> 작은수 , 최근날짜 -> 과거날짜
# order by 필드명1 asc/desc , 필드명2 asc/desc : 정렬기준이 2개 이상일때 ,(쉼표) 로 구분 하기  
select * from member order by mdebut asc;	# 'mdebut' 필드명 기준으로 오름차순 , 과거날짜(작은수) -> 최신날짜(큰수)
select * from member order by mdebut desc;	# 'mdebut' 필드명 기준으로 내림차순 , 최신날짜 -> 과거날짜  
# 주의할점 : 정렬 기준이 2개 이상일때 : 첫번째 필드 정렬 후 첫번째 필드내 *동일한 값이 있을경우 동일한 값* 중에서 두번째 정렬 실행 
select * from member order by maddr desc , mdebut asc ; # 먼저 주소별 정렬 후 동일한 주소가 존재하면 데뷔날짜로 정렬한다.

# [6] 제한 , 조회 결과의 레코드 수 제한 
# limit 레코드수 
# limit 시작레코드번호(0~) , 개수 
select * from member limit 2;	# 조회 결과의 레코드에서 위에서부터 2개만 조회 제한  
select * from member limit 0 , 3; # 조회 결과의 레코드에서 0(첫번째)레코드 부터 3개만 조회 제한 
select * from member limit 2 , 2; # 조회 결과의 레코드에서 2(세번째)레코드 부터 2개만 조회 제한 
select * from member order by mheight desc limit 3 ;	# 'mheight' 필드 기준으로 내림차순 하고 3개만 조회 제한 # 'mheight' 필드 상위 3개 

# [7] 필드값이 중복 인 레코드 제거 
# distinct
select maddr from member; # 주소 필드의 모든 레코드를 조회
select distinct maddr from member; # 주소 필드의 모든 레코드를 조회하는데 주소가 중복이면 중복된 레코드는 제거 

# [8] 동시에 여러개 절 작성할때 순서 # select -> from -> where -> order by -> limit  
# select 필드명 , 필드명 from 테이블명 where 조건절 order by 정렬 limit 레코드제한 
# select * from 테이블명 where 조건절 order by 정렬 limit 레코드제한 
# select * from member where maddr = '서울'; # 주소가 '서울'인 레코드 조회
select * from member where maddr = '서울' order by mdebut desc; # 주소가 '서울'인 레코드를 데뷔일 기준으로 내림차순 조회
select * from member where maddr = '서울' order by mdebut desc limit 0 , 2 ; 
# 주소가 '서울'인 레코드를 데뷔일 기준으로 내림차순 조회 결과 첫번째레코드부터 2개만 조회 

# [9] 그룹 
# GROUP BY 그룹필드 HAVING 그룹조건 
select * from buy; # 구매내역 테이블 'buy'
select bamout from buy; # 구매내역 테이블의 구매수량(bamout) 필드

# [10] 수학 집계 함수
# sum( 필드명 ) : 해당 필드의 데이터 합계  
# avg( 필드명 ) : 해당 필드의 데이터 평균 
# min( 필드명 ) : 해당 필드의 데이터 최솟값 
# max( 필드명 ) : 해당 필드의 데이터 최댓값 
# count( 필드명 ) : 해당 필드의 데이터 수 , null 포함 X 
# count( * ) : 전체 레코드수 , null 포함 o
select sum( bamout ) from buy;	# 모든 레코드의 (전체) 구매수량(bamout) 필드 합계 
select avg( bamout ) from buy;	# 모든 레코드의 (전체) 구매수량(bamout) 필드 평균 
select min( bamout ) from buy;	# 모든 레코드의 (전체) 구매수량 필드 최솟값 
select max( bamout ) from buy;  # 모든 레코드의 (전체) 구매수량 필드 최댓값 
select count( bgname ) from buy; # 모든 레코드의 bgname(그룹명) 데이터 개수 , null 값을 제외한 필드 레코드 수
select count( * ) from buy;	# 모든 레코드의 구매수량 레코드 수 
# 그룹 별 집계함수 사용.
select mid , bamout from buy;							# mid(회원아이디) , bamout(구매수량) 필드를 표시하는 모든 레코드 조회 
select sum(bamout) from buy;							# 다른 필드 없이 집계함수 필드만 사용할 경우. 전체 집계 , 그룹 필요없다. 
# select mid , sum(bamout) from buy;					# 오류 : sum()집계함수 이므로 다른 필드와 출력시 집계기준 필요.. 집계기준=그룹기준 
select mid , sum(bamout) from buy group by mid; 		# 회원아이디 별 구매수량 필드 합계 
select sum( bamout * bprice ) as 총구매금액 from buy;		# 전체 레코드의 총구매금액 조회
select mid as 회원아이디 , sum( bamout * bprice ) as 총구매금액 from buy group by mid;	# 회원아이디별 총구매금액 조회 
select mid  , avg( bprice ) from buy group by mid;		# 회원아이디별 구매금액필드의 평균 조회
select mid , count( mphone1 ) from member group by mid;	# 회원아이디별 연락처가 있는 회원수 
select mid , count( * ) from buy group by mid;			# 회원아이디별 레코드 수 
  
# [11] HAVING 그룹조건 
# where (일반조건) : 그룹전  vs having(그룹조건) : 그룹후 
# 회원아이디별 총구매금액이 1000 초과 인 레코드 조회
select mid , sum( bprice * bamout ) from buy group by mid having sum( bprice * bamout) > 1000;	

# 오류 : sum 집계 이후에 결과 이므로 일반 where절 사용불가능 
# select mid , sum( bprice * bamout ) from buy where sum( bprice * bamout) > 1000 group by mid; 

# select mid , avg( bprice ) from buy;	# 오류?? 집계함수 사용시 다른 필드와 같이 조회시 집계기준 = 그룹기준 
select mid , avg( bprice ) from buy where bamout > 2 group by mid; # 구매수량이 2개 초과 인 레코드 에서 회원아이디별 구매금액 평균 조회 
# 구매수량이 2개 초과 인 레코드 에서 회원아이디별 구매금액 평균이 50 이상인 레코드 조회  
select mid , avg( bprice ) from buy where bamout > 2 group by mid having avg(bprice) >= 50;
# 구매수량이 2개 초과 인 레코드 에서 회원아이디별 구매금액 평균이 50 이상인 레코드 조회 , 회원아이디별 내림차순으로 정렬   
select mid , avg( bprice ) from buy where bamout > 2 group by mid having avg(bprice) >= 50 order by mid desc;
# 구매수량이 2개 초과 인 레코드 에서 회원아이디별 구매금액 평균이 50 이상인 레코드 조회 , 회원아이디별 내림차순으로 정렬 후 첫번째 레코드에서 1개만 제한 조회
select mid , avg( bprice ) from buy where bamout > 2 group by mid having avg(bprice) >= 50 order by mid desc limit 0 , 1;


/*
	1. 비교연산자 
		1.같다 : 필드명 = 비교값 , 지정한 필드명의 값이 비교값과 같으면 true 
		2.이하 : 필드명 <= 비교값 , 지정한 필드명의 값이 비교값 보다 이하 이면 true 
		3.이상 : 필드명 >= 비교값 , 지정한 필드명의 값이 비교값 보다 이상 이면 true 
        4.초과 : 필드명 > 비교값  
        5.미만 : 필드명 < 비교값 
        6.다르다 : 필드명 != 비교값 
	2. 관계연산자
		1. 이면서/면서/이고/그리고 :  조건1 and 조건2 
		2. 이거나/또는/하나라도   :  조건1 or 조건2
		3. 부정/반대			: not 조건		, 조건결과의 반대 , true -> false , false -> true 
	3. 기타연산자 
		- 필드명 between 시작값 and 끝값 	: 지정한 필드명의 값이 시작값과 끝값 사이이면 true 
		- 필드명 in( 값1 , 값2 , 값3 ) 	: 지정한 필드명의 값이 in 안에 있는 값이 하나라도 존재하면 true
		- 필드명 like 패턴 : 지정한 필드명의 값이 패턴과 일치하면 true
			- 패턴 
            1. % : 모든 문자수 대응 			, 김% : 김으로 시작하는 문자열 
            2. _ : _개수만큼 문자수 대응 		, 김_ : 김으로 시작하는 두글자인 문자열 
		- 필드명 is null	: 지정한 필드명의 값이 null 이면 true 
		- 필드명 is not null : 지정한 필드명의 값이 null 이 아니면 true 
	4. 산술연산자 
		필드명 + 값 : 지정한 필드값에 값 더하기
        필드명 - 값 : 지정한 필드값에 값 빼기 
        필드명 * 값 : 지정한 필드값에 값 곱하기 
        필드명 / 값 : 지정한 필드값에 값 나누기 
        필드명 div 값 : 지정한 필드값에 값 를 나눈 몫 
        필드명 mod 값 : 지정한 필드값에 값 를 나눈 나머지
    5. 키워드 
		1. as 별칭				: select 필드명 as 필드명별칭 from 테이블명 테이블별칭  
        2. distinct 중복제거 		: select distinct 필드명 from 테이블명 
        
        3. where 조건절 			: select * from 테이블명 where 조건필드 = 조건값 
        4. group by 그룹절 		: select 필드명 from 테이블명 group by 그룹필드명	, 
								  select 필드명 , 집계함수(필드명) from 테이블명 group by 그룹필드명
        5. having 그룹조건			: select 필드명 from 테이블명 where 일반조건 group by 그룹필드명 having 그룹조건 
									select 필드명 , 집계함수(필드명) from 테이블명 where 일반조건 group by 그룹필드명 having 그룹조건 
        6. order by 정렬			: select * from 테이블명 order by 정렬필드 [asc/desc]
        7. limit 레코드제한 		: select * from 테이블명 limit 시작레코드번호 , 개수 
        
	6. 집계함수 
		sum( 필드명 ) : 해당 필드의 데이터 합계  
		avg( 필드명 ) : 해당 필드의 데이터 평균 
		min( 필드명 ) : 해당 필드의 데이터 최솟값 
		max( 필드명 ) : 해당 필드의 데이터 최댓값 
		count( 필드명 ) : 해당 필드의 데이터 수 , null 포함 X 
		count( * ) : 전체 레코드수 , null 포함 o
*/



















