package day30.boardservice10mvc.model;

import java.sql.*;
import java.util.ArrayList;

public class BoardDao {

    // JDBC 인터페이스 ,  import java.sql.
    private Connection conn ; // 연동된 결과의 연동 객체를 조작할 인터페이스

    // 싱글톤
    private static BoardDao boardDao = new BoardDao();

    // 생성자에서 DB연동 코드 작성
    private BoardDao(){
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb1125","root", "1234");
            System.out.println("[ BoardDB Connection OK ]");
        }catch ( ClassNotFoundException e ){
            e.getMessage(); System.out.println("[ BoardDB Connection fail ]");
            // 실패이유 : 1. 프로젝트내 JDBC 라이브러리 등록 2. 오타(클래스경로,DB서버경로) 체크 3. MYSQL 워크벤치에서 DB 존재 체크
        }catch( SQLException e ){
            e.getMessage(); System.out.println("[ BoardDB Connection fail ]");
        }
    }

    public static BoardDao getInstance(){  return boardDao; }

    // 1. 게시물 등록 접근 함수
    public boolean boardWrite( BoardDto boardDto){
        try {
            // 1. SQL 작성 , SQL 그대로 작성 하되 데이터가 들어가는 자리는 ? 로 작성
            String sql = "insert into board( content, writer, pwd) values( ? , ? , ? )";
            // 2. 작성한 SQL를 DB연동객체의 기재한다. prepare:준비하다 , Statement: 기재하다 , => SQL기재할준비한다.
            // - 연동된 객체로부터 SQL기재해서 준비된 객체를 PreparedStatement 인터페이스에 대입한다.
            PreparedStatement ps = conn.prepareStatement(sql);
            // 3. 기재된 SQL의 매개변수(?)에 값를 대입한다.
                // ps.setString( ?순서번호 , 대입할데이터 ) : ?에 대입할 데이터가 String 타입일때 사용.
                // ps.setInt( ?순서번호 , 대입할데이터 ) : ?에 대입할 데이터가 int 타입일때 사용.
            ps.setString(1, boardDto.getContent()); // 1:SQL내 첫번째 ? 뜻한다  : 첫번째 ? 에 입력받은 게시물 내용 을 대입한다.
            ps.setString(2, boardDto.getWriter()); // 2:SQL내 두번째 ? 뜻한다 : 두번째 ? 에 입력받은 게시물 작성자를 대입한다.
            ps.setInt(3, boardDto.getPwd()); // 3:SQL내 세번째 ? 뜻한다 : 세번째 ? 에 입력받은 게시물 비밀번호를 대입한다.
            // 4. 기재된 SQL 를 실행한다. execute:실행하다 , Update:최신화하다 , => sql 실행후 최신화한다.
            ps.executeUpdate();
            // 5. 성공했을때 true 반환
            return true;
        }catch ( SQLException e ){
            e.getMessage(); System.out.println("[ 게시물 등록시 예외발생]");
        }
        // 5. 실패 또는 오류 발생시 false 반환
        return false;
    } // m end

    // 2. 전체 게시물 출력 접근 함수
    public ArrayList<BoardDto> boardPrint( ){
        ArrayList<BoardDto> list = new ArrayList<>(); // -- 조회된 레코드들을 객체화 해서 저장할 리스트객체 선언
        try {
            String sql = "select * from board";  // 1. SQL 작성
            PreparedStatement ps = conn.prepareStatement(sql); // 2. SQL 기재
            // 3. SQL 조작
            // 4. SQL 실행 , executeQuery() : sql 실행 결과 조회된 SQL 결과 조작하는 resultSet 객체 반환
            ResultSet rs = ps.executeQuery();
            // 5. SQL 결과
            while( rs.next() ){ // while( 조건 ){} : 반복문  , rs.next() : 조회 결과 에서 다음 레코드 이동 함수
                // 만약에 결과 레코드가 3개 존재하면 rs.next() 3번 실행 된다.
                // [해석] 조회 결과 첫번째 레코드 부터 마지막 레코드 까지 하나씩 레코드 이동
                // 6. 각 레코드를 읽어서 각 필드별 데이터 호출  , rs.getXXX( "필드명" ) : 지정한 필드명의 값 타입에 맞게 값 반환
                int num = rs.getInt("num");           // 현재 조회중인 레코드의 게시물번호(num)필드 값 호출
                String content = rs.getString("content");    // 현재 조회중인 레코드의 게시물내용(content)필드 값 호출
                String writer = rs.getString("writer");     // 현재 조회중인 레코드의 게시물작성자(writer)필드 값 호출
                int pwd = rs.getInt("pwd");           // 현재 조회중인 레코드의 게시물비밀번호(pwd)필드 값 호출
                // 7. 각 레코드의 호출된 필드값들을 객체화 --> DTO 생성
                BoardDto boardDto = new BoardDto( content , writer , pwd );
               // 8. 1개 레코드를 DTO 객체로 변환된 DTO를 리스트에 저장
                list.add( boardDto );
            } // w end   // - 반복문 1번 실행에  레코드 1개 를 dto 로 변환
        }catch ( SQLException e ){ e.getMessage();  System.out.println("[ 게시물 출력시 예외발생]"); }
            // 9. 구성한 리스트 객체 반환
            return list;
    } // m end
} // class end


/* 예] 조회 결과가 아래와 같을때 예시
   num  content         writer      pwd     <------ rs: 인터페이스가 조작할수 있다.  rs.next() : 다음 레코드 이동
   1    자바에서작성      유재석       1234    <-(rs.next())
   2    안녕db           강호동       4567    <-(rs.next())
   3    하하하하하        하하         7897     <-(rs.next())
*/







