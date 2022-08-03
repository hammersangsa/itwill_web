package com.product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.board.BoardDTO;
import com.product.ProductDTO;

public class ProductDAO {

private Connection conn = null;
	
	public ProductDAO(Connection conn) {
		this.conn = conn;
	}
	//�ѹ�ó��
	public int getMaxNum() {
		
		int maxNum = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			
			sql = "select nvl(max(pNum),0) from product";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				maxNum = rs.getInt(1);
			}
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return maxNum;
	}
	//�̹����������� ����
	public void insertData(ProductDTO dto) {
		
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			
			sql = "insert into product(productNum,productName,";
			sql+= "img,category,price,content,stock,pNum,img2) ";
			sql+= "values (?,?,?,?,?,?,100,?,?)";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getProductNum());
			pstmt.setString(2, dto.getProductName());
			pstmt.setString(3, dto.getImg());
			pstmt.setString(4, dto.getCategory());
			pstmt.setInt(5, dto.getPrice());
			pstmt.setString(6, dto.getContent());
			pstmt.setInt(7, dto.getpNum());
			pstmt.setString(8, dto.getImg2());
			
			pstmt.executeUpdate();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
	}
	//�̹��� ����Ʈ ��������
	public List<ProductDTO> getLists(int start, int end,
			String searchKey,String searchValue) {
		
		List<ProductDTO> lists = new ArrayList<ProductDTO>();
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			searchValue = "%" + searchValue + "%";
			
			sql = "select * from (";
			sql+= "select rownum rnum,data.* from (";
			sql+= "select productNum,productName,img,category,";
			sql+= "price,content,stock,pNum ";
			sql+= "from product where " + searchKey + " like ? order by productNum desc) data) "; 
			sql+= "where rnum>=? and rnum<=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, searchValue);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ProductDTO dto = new ProductDTO();
				
				dto.setProductNum(rs.getInt("productNum"));
				dto.setProductName(rs.getString("productName"));
				dto.setImg(rs.getString("img"));
				dto.setCategory(rs.getString("category"));
				dto.setPrice(rs.getInt("price"));
				dto.setContent(rs.getString("content"));
				dto.setStock(rs.getInt("stock"));
				dto.setpNum(rs.getInt("pNum"));

				lists.add(dto);
			}
			pstmt.close();
			rs.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return lists;
	}
	//��ü�������� ����
	public int getDataCount(String searchKey,String searchValue) {
		
		int dataCount = 0;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			searchValue = "%" + searchValue + "%";

			sql = "select nvl(count(*),0) from product ";
			sql+= "where " + searchKey + " like ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, searchValue);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dataCount = rs.getInt(1);//�Ļ��÷��̹Ƿ� 1(�̸�����)
			}
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dataCount;
	}
	
	//������ �о����
	public ProductDTO getReadData(int pNum) {
		
		ProductDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "select pNum,productNum,productName,img,category,";
			sql+= "price,content,stock ";
			sql+= "from product where pNum=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pNum);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new ProductDTO();
				
				dto.setpNum(rs.getInt("pNum"));
				dto.setProductNum(rs.getInt("productNum"));
				dto.setProductName(rs.getString("productName"));
				dto.setImg(rs.getString("img"));
				dto.setCategory(rs.getString("category"));
				dto.setPrice(rs.getInt("price"));
				dto.setContent(rs.getString("content"));
				dto.setStock(rs.getInt("stock"));
			}
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}
	
	public int updateData(ProductDTO dto) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql;

		try {
			sql = "update product set productNum=?,productName=?,img=?,price=?,";
			sql+= "content=? where pNum=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getProductNum());
			pstmt.setString(2, dto.getProductName());
			pstmt.setString(3, dto.getImg());
			pstmt.setInt(4, dto.getPrice());
			pstmt.setString(5, dto.getContent());
			pstmt.setInt(6, dto.getpNum());
			
			result = pstmt.executeUpdate();
			
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}
	
	public void deleteData (int pNum) {
		
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "delete product where pNum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pNum);
			
			pstmt.executeUpdate();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
	}
}
