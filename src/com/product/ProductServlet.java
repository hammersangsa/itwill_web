package com.product;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.sql.Connection;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.product.ProductDAO;
import com.product.ProductDTO;
import com.board.BoardDTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.util.DBConn;
import com.util.FileManager;
import com.util.MyPage;

public class ProductServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}
	protected void forward(HttpServletRequest req, HttpServletResponse resp, String url) throws ServletException, IOException {
		RequestDispatcher rd = req.getRequestDispatcher(url);
		rd.forward(req, resp);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		
		Connection conn = DBConn.getConnection();
		ProductDAO dao = new ProductDAO(conn);
		
		MyPage myPage = new MyPage();
		
		String cp = req.getContextPath();
		String uri = req.getRequestURI();
		String url;
		
		//���� ���� ��� ����
		String root = getServletContext().getRealPath("/");
		String path = root + "pds" + File.separator + "productImage";
		
		File f = new File(path);
		if(!f.exists()) {
			f.mkdirs();
		}
		
		if(uri.indexOf("write.do")!=-1) {
			
			url = "/product/write.jsp";
			forward(req, resp, url);
			
		}else if(uri.indexOf("write_ok.do")!=-1) {
			
			String encType = "UTF-8";
			int maxSize = 50*1024*1024;
			
			MultipartRequest mr =
					new MultipartRequest(req, path, maxSize, encType,
							new DefaultFileRenamePolicy());
			
			if(mr.getFile("upload")!=null) {
				
				ProductDTO dto= new ProductDTO();
				
				int maxNum = dao.getMaxNum();
				
				dto.setpNum(maxNum + 1);
				dto.setProductNum(Integer.parseInt(mr.getParameter("productNum")));
				dto.setProductName(mr.getParameter("productName"));
				dto.setImg(mr.getFilesystemName("upload"));
				dto.setCategory(mr.getParameter("category"));
				dto.setPrice(Integer.parseInt(mr.getParameter("price")));
				dto.setContent(mr.getParameter("content"));
				dto.setImg2(mr.getOriginalFileName("upload"));
				
				dao.insertData(dto);
			}
			url = cp + "/pdct/list.do";
			resp.sendRedirect(url);
			
		}else if(uri.indexOf("list.do")!=-1) {
			
			String pageNum = req.getParameter("pageNum");
			
			int currentPage = 1;
			
			if(pageNum!=null) {
				currentPage = Integer.parseInt(pageNum);
			}
			
			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");
			
			if(searchValue==null) {
				searchKey = "productName";
				searchValue = "";
			}else {
				if(req.getMethod().equalsIgnoreCase("GET")) {
					searchValue = URLDecoder.decode(searchValue, "UTF-8");
				}
			}
			
			int dataCount = dao.getDataCount(searchKey, searchValue);
			int numPerPage = 6;
			int totalPage = myPage.getPageCount(numPerPage, dataCount);
		
			
			if(currentPage>totalPage) {
				currentPage = totalPage;
			}
			
			int start = (currentPage-1)*numPerPage+1;
			int end = currentPage*numPerPage;
			
			
			List<ProductDTO> lists = dao.getLists(start, end, searchKey, searchValue);
			
			String param = "";
			if(searchValue!=null&&!searchValue.equals("")) {
				param = "searchKey=" + searchKey;
				param+= "&searchValue=" + URLEncoder.encode(searchValue, "UTF-8");
			}
			String listUrl = cp + "/pdct/list.do";

			if(!param.equals("")) {
				listUrl += "?" + param;
			}
			
			String downloadPath = cp + "/pdct/download.do";
			String updatePath = cp + "/pdct/updated.do";
			String deletePath = cp + "/pdct/deleted.do";
			String imagePath = cp + "/pds/productImage";
			
			String articleUrl = cp + "/pdct/article.do?pageNum=" + currentPage;

			
			if(!param.equals("")) {
				articleUrl += "&" + param;
			}
			
			String pageIndexList = 
					myPage.pageIndexList(currentPage, totalPage, listUrl);
			
			req.setAttribute("imagePath", imagePath);
			req.setAttribute("updatePath", updatePath);
			req.setAttribute("deletePath", deletePath);
			req.setAttribute("downloadPath", downloadPath);
			req.setAttribute("lists", lists);
			req.setAttribute("pageIndexList", pageIndexList);
			req.setAttribute("dataCount", dataCount);
			req.setAttribute("totalPage", totalPage);
			req.setAttribute("currentPage", currentPage);
			req.setAttribute("articleUrl", articleUrl);

			
			url = "/product/list.jsp";
			forward(req, resp, url);
			
		}else if(uri.indexOf("article.do")!=-1) {

 
			int pNum = Integer.parseInt(req.getParameter("pNum"));
			System.out.println(pNum);
			String pageNum = req.getParameter("pageNum");
			
			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");
			
			if(searchValue!=null&&!searchValue.equals("")) {
				searchValue = URLDecoder.decode(searchValue, "UTF-8");
			}
			
			
			ProductDTO dto = dao.getReadData(pNum);
			
			if(dto==null) {
				url = cp + "/pdct/list.do";
				resp.sendRedirect(url);
			}
			
			dto.setContent(dto.getContent().replace("\r", "<br/>"));
			
			String param = "pageNum=" + pageNum;
			
			if(searchValue!=null&&!searchValue.equals("")) {
				param += "&searchKey=" + searchKey;
				param += "&searchValue=" +URLEncoder.encode(searchValue, "UTF-8");
			}
			
			req.setAttribute("dto", dto);
			req.setAttribute("params", param);
			req.setAttribute("pageNum", pageNum);
			
			url = "/product/article.jsp";
			forward(req, resp, url);
			
		}else if(uri.indexOf("download.do")!=-1) {
			
			int num = Integer.parseInt(req.getParameter("pNum"));
			
			ProductDTO dto = dao.getReadData(num);
			
			if(dto==null) {
				return;
			}
			
			boolean flag =
					FileManager.doFileDownload(resp, dto.getImg(),dto.getImg(), path);
			
			if(flag==false) {
	
				resp.setContentType("text/html;charset=UTF-8");
				
				PrintWriter out = resp.getWriter();
				
				out.print("<script type='text/javascript'>");
				out.print("alert('Download Error!!!');");
				out.print("history.back();");
				out.print("</script>");
				
			}
			
		}else if(uri.indexOf("updated.do")!=-1) {
			
			int num = Integer.parseInt(req.getParameter("pNum"));
			String pageNum = req.getParameter("pageNum");
			
			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");
			
			if(searchValue!=null&&!searchValue.equals("")) {
				searchValue = URLDecoder.decode(searchValue, "UTF-8");
			}
			
			ProductDTO dto = dao.getReadData(num);
			
			if(dto==null) {
				url = cp + "/pdct/list.do";
				resp.sendRedirect(url);
			}

			String param = "pageNum=" + pageNum;
			
			if(searchValue!=null&&!searchValue.equals("")) {
				param += "&searchKey=" + searchKey;
				param += "&searchValue=" +URLEncoder.encode(searchValue, "UTF-8");
			}
			
			req.setAttribute("dto", dto);
			req.setAttribute("pageNum", pageNum);
			req.setAttribute("params", param);
			req.setAttribute("searchKey", searchKey);
			req.setAttribute("searchValue", searchValue);
			
			url = "/product/updated.jsp";
			forward(req, resp, url);
			
		}else if(uri.indexOf("updated_ok.do")!=-1) {
			
			int num = Integer.parseInt(req.getParameter("pNum"));
			String pageNum = req.getParameter("pageNum");
			
			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");
			
			if(searchValue!=null&&!searchValue.equals("")) {
				searchValue = URLDecoder.decode(searchValue, "UTF-8");
			}
			
			String encType = "UTF-8";
			int maxSize = 50*1024*1024;
			
			MultipartRequest mr =
					new MultipartRequest(req, path, maxSize, encType,
							new DefaultFileRenamePolicy());

			ProductDTO dto= new ProductDTO();
			
			int maxNum = dao.getMaxNum();
			
			dto.setProductNum(Integer.parseInt(mr.getParameter("productNum")));
			dto.setProductName(mr.getParameter("productName"));
			dto.setImg(mr.getFilesystemName("upload"));
			dto.setPrice(Integer.parseInt(mr.getParameter("price")));
			dto.setContent(mr.getParameter("content"));
			dto.setStock(Integer.parseInt(mr.getParameter("stock")));

			dao.updateData(dto);
			
			String param = "pageNum=" + pageNum;
			
			if(searchValue!=null&&!searchValue.equals("")) {
				param += "&searchKey=" + searchKey;
				param += "&searchValue=" +URLEncoder.encode(searchValue, "UTF-8");
			}
			
			url = cp + "/pdct/list.do?" + param;
			resp.sendRedirect(url);
			
		}else if(uri.indexOf("deleted.do")!=-1) {
			
			int num = Integer.parseInt(req.getParameter("pNum"));
			
			ProductDTO dto = dao.getReadData(num);
			//���ϻ���
			FileManager.doFileDelete(dto.getImg(), path);
			
			//DB������������
			dao.deleteData(num);
			
			url = cp + "/pdct/list.do";
			resp.sendRedirect(url);
		}
		
	}

}
