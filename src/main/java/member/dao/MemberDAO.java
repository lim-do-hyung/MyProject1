package member.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import common.DBConnPool;
import member.dto.MemberDTO;

public class MemberDAO extends DBConnPool {
	
	public MemberDAO() {
		super();
	}
	
	// 회원가입
	public int insertMember(MemberDTO dto) {
		int result =0;
		try {
			String query = "insert into memberp ("
					+ "id, pass, name, gender, email, phonenum, birthday) "
					+ "    values ("
					+ " ?,?,?,?,?,?,?)";
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getPass());
			psmt.setString(3, dto.getName());
			psmt.setString(4, dto.getGender());
			psmt.setString(5, dto.getEmail());
			psmt.setString(6, dto.getPhonenum());
			psmt.setDate(7, dto.getBirthday());
			result = psmt.executeUpdate();
			
			
		} catch (Exception e) {
			System.out.println("회원가입 중 예외 발생");
			e.printStackTrace();
		}
		
		
		return result;
	}
	
	
	//회원보기
	public List<MemberDTO> selectListMember(Map<String, Object> map) {
		List<MemberDTO> member = new ArrayList<MemberDTO>();
		
		String query = "select * from memberp";
		
		try {
			psmt = con.prepareStatement(query);
			rs = psmt.executeQuery();
			while(rs.next()) {
				MemberDTO dto = new MemberDTO();
				
				dto.setName(rs.getString(3));
				System.out.println(dto.getName());
				member.add(dto);
			}
		} catch (Exception e) {
			System.out.println("회원 조회 중 예외 발생");
			e.printStackTrace();
			// TODO: handle exception
		}
		
		return member;
	}
	public int selectCount(Map<String, Object> map) {
		int totalCount = 0;
		String query = "SELECT COUNT(*) FROM memberp ";
		
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);
			rs.next();
			totalCount = rs.getInt(1);
		} catch (Exception e) {
			System.out.println("회원 수를 구하는 중 예외 발생");
			e.printStackTrace();
			// TODO: handle exception
		}
		
		return totalCount;
	}
	
	//회원중복체크를 위한 함수
	public int duplicateCheck(Map<String, Object> map) {
		int count = 0;
		String query = "select count(*) from memberp where id='"+ map.get("id") +"'";
		
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);
			rs.next();
			count = rs.getInt(1);
		} catch (Exception e) {
			System.out.println("회원중복체크 하는 중 예외 발생");
			e.printStackTrace();
		}
		
		return count;
	}
	
	
	
	
	
	
	
}
