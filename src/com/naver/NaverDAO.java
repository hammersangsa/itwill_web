package com.naver;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.naver.NaverDTO;


public class NaverDAO {

	private Connection conn;
	public NaverDAO(Connection conn) {
		this.conn = conn;
	}
	
	public int insertData(NaverDTO dto) {
		
		int result = 0;
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "insert into naver (userId,userPwd,userName,year,month,day,";
			sql+= "gender,email,tel1,tel2) ";
			sql+= "values(?,?,?,?,?,?,?,?,?,?)";
			
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, dto.getUserId());
			pstmt.setString(2, dto.getUserPwd());
			pstmt.setString(3, dto.getUserName());
			pstmt.setString(4, dto.getYear());
			pstmt.setString(5, dto.getMonth());
			pstmt.setString(6, dto.getDay());
			pstmt.setString(7, dto.getGender());
			pstmt.setString(8, dto.getEmail());
			pstmt.setString(9, dto.getTel1());
			pstmt.setString(10, dto.getTel2());

			result = pstmt.executeUpdate();
			
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}
	
	public List<NaverDTO> getLists(){
		
		List<NaverDTO> lists = new ArrayList<NaverDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "select userId,userPwd,userName,year,month,day,";
			sql+= "gender,email,tel1,tel2 ";
			sql+= "from naver";
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
		
			while(rs.next()) {
				NaverDTO dto = new NaverDTO();
				
				dto.setUserId(rs.getString("userId"));
				dto.setUserPwd(rs.getString("userPwd"));
				dto.setUserName(rs.getString("userName"));
				dto.setYear(rs.getString("year"));
				dto.setMonth(rs.getString("month"));
				dto.setDay(rs.getString("day"));
				dto.setGender(rs.getString("gender"));
				dto.setEmail(rs.getString("email"));
				dto.setTel1(rs.getString("tel1"));
				dto.setTel2(rs.getString("tel2"));
				
				lists.add(dto);
			}			
			pstmt.close();
			rs.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return lists;	
	}
	//수정할 데이터	가져오기(update.jsp)
	public NaverDTO getReadData(String userId) {
		
		NaverDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "select userId,userPwd,userName,year,month,day,";
			sql+= "gender,email,tel1,tel2 ";
			sql+= "from naver where userId=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, userId);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new NaverDTO();
				
				dto.setUserId(rs.getString("userId"));
				dto.setUserPwd(rs.getString("userPwd"));
				dto.setUserName(rs.getString("userName"));
				dto.setYear(rs.getString("year"));
				dto.setMonth(rs.getString("month"));
				dto.setDay(rs.getString("day"));
				dto.setGender(rs.getString("gender"));
				dto.setEmail(rs.getString("email"));
				dto.setTel1(rs.getString("tel1"));
				dto.setTel2(rs.getString("tel2"));
			}
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}
	//수정(update.jsp->update_ok.jsp)
	public int updateData(NaverDTO dto) {
		
		int result = 0;
		
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			sql = "update naver set userPwd=?,year=?,";
			sql+= "month=?,day=?,tel2=? ";
			sql+= "where userId=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getUserPwd());
			pstmt.setString(2, dto.getYear());
			pstmt.setString(3, dto.getMonth());
			pstmt.setString(4, dto.getDay());
			pstmt.setString(5, dto.getTel2());
			pstmt.setString(6, dto.getUserId());
			
			result = pstmt.executeUpdate();
			
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}
	//삭제(delete_ok.jsp)
	public int deleteData(String userId) {
		
		int result = 0;
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "delete naver where userId=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			
			result = pstmt.executeUpdate();
					
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}
	
}