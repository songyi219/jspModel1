package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import db.DBClose;
import db.DBConnection;
import dto.MemberDto;

public class MemberDao {
	// 싱글톤만들기. 어디서도 접근할 수 있게 하기 위해서
	private static MemberDao dao = null;

	private MemberDao() {
		DBConnection.initConnection();
	}

	public static MemberDao getInstance() {
		if (dao == null) {
			dao = new MemberDao();
		}
		return dao;
	}

	public boolean getId(String id) {

		String sql = " select id " 
				+ "    from member " 
				+ "    where id=? ";

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		boolean findid = false;

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 getId success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			System.out.println("2/3 getId success");
			
			rs = psmt.executeQuery();
			System.out.println("3/3 getId success");
			
			if(rs.next()) {
				findid = true;
			}
			
		} catch (SQLException e) {
			System.out.println("getId fail");
			e.printStackTrace();
		}finally {
			DBClose.close(conn, psmt, rs);
		}
		return findid;
	}
	
	public boolean addMember(MemberDto dto) {
		
		String sql = " insert into member(id, pwd, name, email, auth)  "
				+ "    values(?, ?, ?, ?, 3) ";			// auth 사용자:3 관리자:1
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 addMember success");
			
			psmt = conn.prepareStatement(sql);		// 쿼리문 실행
			
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getPwd());
			psmt.setString(3, dto.getName());
			psmt.setString(4, dto.getEmail());
			System.out.println("2/3 addMember success");
			
			count = psmt.executeUpdate();
			System.out.println("3/3 addMember success");
			
			
		} catch (SQLException e) {
			System.out.println("addMember fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}
		
		return count>0?true:false;
				
	}
	public MemberDto login(String id, String pwd) {
		
		String sql = " select id, name, email, auth  "
				+ "    from member "
				+ "    where id=? and pwd=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		MemberDto mem = null;
				
		try {
			conn = DBConnection.getConnection();		// db 연결
			System.out.println("1/3 login success");
			
			psmt = conn.prepareStatement(sql);		// db에 위에 작성한 sql쿼리문 실행..?
			psmt.setString(1, id);
			psmt.setString(2, pwd);
			System.out.println("2/3 login success");
			
			rs = psmt.executeQuery();
			System.out.println("3/3 login success");
			
			if(rs.next()) {		// 다음 데이터가 있는지.		데이터 1개만 가져오면 조건문. 여러개면 while
				String _id = rs.getString(1);		// or "id"로 받아와도 됨 
				String _name = rs.getString(2);
				String _email = rs.getString(3);
				int _auth = rs.getInt(4);
				
				mem = new MemberDto(_id, null, _name, _email, _auth);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBClose.close(conn, psmt, rs);
		}
		return mem;
	}
}





