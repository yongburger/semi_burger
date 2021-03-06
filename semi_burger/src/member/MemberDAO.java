package member;

import java.sql.*;
import java.util.*;

import yb.db.YB_DB;

public class MemberDAO {
	Connection conn;
	PreparedStatement ps;
	ResultSet rs;
	
	public static final int NOT_ID = 1; 
	public static final int NOT_PWD = 2;
	public static final int LOGIN_OK = 3;
	public static final int ERROR = -1;
	
	
	/** 회원가입 관련 메서드*/
	public int memberJoin(MemberDTO dto){
		try{
			conn = yb.db.YB_DB.getConn();
			
			String sql = "insert into member values(member_seq.nextval, ?, ?, ?, ?, ?, ?, ?, 0, 'D')";
			
			ps = conn.prepareStatement(sql);
			ps.setString(1, dto.getId());
			ps.setString(2, dto.getPasswd());
			ps.setString(3, dto.getName());
			ps.setString(4, dto.getBirth());
			ps.setString(5, dto.getCellphone());
			ps.setString(6, dto.getEmail());
			ps.setString(7, dto.getAddress());
			
			int count = ps.executeUpdate();
			
			return count;
			
		} catch(Exception e){
			e.printStackTrace();
			return ERROR;
		} finally{
			try{
				if(ps!=null) ps.close();
				if(conn!=null) conn.close();				
			} catch(Exception e2){}
		}
	}
	
	/** 아이디 중복 체크 관련 메서드*/
	public boolean idcheck(String userid){
		try{
			conn = yb.db.YB_DB.getConn();
			
			String sql = "select id from member where id=?";
			
			ps = conn.prepareStatement(sql);
			ps.setString(1, userid);
			
			rs = ps.executeQuery();
			
			if(rs.next()){
				return true;
			}			
			return false;
			
		} catch(Exception e){
			e.printStackTrace();
			return false;
		} finally{
			try{
				if(rs!=null) rs.close();
				if(ps!=null) ps.close();
				
				if(conn!=null) conn.close();				
			} catch(Exception e2){}
		}
	}
	
	/** 아이디 찾기 관련 메서드*/
	public String idfind(String name, String cell){
		try{
			conn = yb.db.YB_DB.getConn();
			
			String sql = "select id from member where name=? and cellphone=?";
			
			ps = conn.prepareStatement(sql);
			ps.setString(1, name);
			ps.setString(2, cell);
			
			rs = ps.executeQuery();
			String id=null;
			
			if(rs.next()){
				id = rs.getString("id");
			}
			
			return id;
			
		} catch(Exception e){
			e.printStackTrace();
			return null;
		} finally{
			try{
				if(rs!=null) rs.close();
				if(ps!=null) ps.close();
				
				if(conn!=null) conn.close();				
			} catch(Exception e2){}
		}
	}
	
	/** 비밀번호 설정 - 아이디 가져오기*/
	public int getId(String userid){
		try{
			conn = yb.db.YB_DB.getConn();
			
			String sql = "select id from member where id=?";
			
			ps = conn.prepareStatement(sql);
			ps.setString(1, userid);
			
			rs = ps.executeQuery();
			
			int count = 0;
			if(rs.next()){
				count = 1;
			}
			
			return count;			
		} catch(Exception e){
			e.printStackTrace();
			return ERROR;		
		} finally{
			try{
				if(rs!=null) rs.close();
				if(ps!=null) ps.close();
				
				if(conn!=null) conn.close();				
			} catch(Exception e2){}
		}
	}
	
	/** 비밀번호 설정*/
	public int SetPwd(String userpwd, String id){
		try{
			conn = yb.db.YB_DB.getConn();
			
			String sql = "update member set passwd=? where id=?";
			
			ps = conn.prepareStatement(sql);
			ps.setString(1, userpwd);
			ps.setString(2, id);
			
			int count = ps.executeUpdate();
			
			return count;
			
		} catch(Exception e){
			e.printStackTrace();
			return ERROR;			
		} finally{
			try{
				if(ps!=null) ps.close();
				
				if(conn!=null) conn.close();				
			} catch(Exception e2){}
		}
	}
	
	/** 로그인 관련 메서드*/
	public int memberLogin(String userid, String userpwd){
		try{
			conn = yb.db.YB_DB.getConn();
			
			String sql = "select passwd from member where id=?";
			
			ps = conn.prepareStatement(sql);
			ps.setString(1, userid);
			
			rs = ps.executeQuery();
			
			if(rs.next()){
				String db_pwd = rs.getString("passwd");
				
				if(userpwd.equals(db_pwd)){
					return LOGIN_OK;
				} else {
					return NOT_PWD;
				}				
			} else {
				return NOT_ID;				
			}					
			
		} catch(Exception e){
			e.printStackTrace();
			return ERROR;			
		} finally{
			try{
				if(rs!=null) rs.close();
				if(ps!=null) ps.close();
				
				if(conn!=null) conn.close();
			} catch(Exception e2){}
		}
	}
	
	/** 로그인 성공 회원정보 가져오기 메서드*/
	public String getUserId(String userid){
		try{
			conn = yb.db.YB_DB.getConn();
			
			String sql = "select * from member where id=?";
			
			ps = conn.prepareStatement(sql);
			ps.setString(1, userid);
			
			rs = ps.executeQuery();
			
			rs.next();
			
			return rs.getString("name");
			
		} catch(Exception e){
			e.printStackTrace();
			return null;			
		} finally{
			try{
				if(rs!=null) rs.close();
				if(ps!=null) ps.close();
				
				if(conn!=null) conn.close();				
			} catch(Exception e2){ }
		}		
	} 
	
	/** 회원 전체 정보 가져오기*/
	public ArrayList<MemberDTO> getUserInfo(String userid){
		try{
			conn = yb.db.YB_DB.getConn();
			
			String sql = "select * from member where id=?";
			
			ps = conn.prepareStatement(sql);
			ps.setString(1, userid);
			
			rs = ps.executeQuery();
			
			ArrayList<MemberDTO> arr = new ArrayList<MemberDTO>();
			
			if(rs.next()){
				int member_no = rs.getInt("member_no");
				String id = rs.getString("id");
				String passwd = rs.getString("passwd");
				String name = rs.getString("name");
				String birth = rs.getString("birth");
				String cellphone = rs.getString("cellphone");
				String email = rs.getString("email");
				String address = rs.getString("address");
				int discount = rs.getInt("discount");
				String grade = rs.getString("grade");
				
				MemberDTO dto = new MemberDTO(member_no, id, passwd, name, birth, cellphone, email, address, discount, grade);
				
				arr.add(dto);				
			}
			return arr;
			
		}catch(Exception e){
			 e.printStackTrace();
			 return null;
		 } finally{
			 try{
				 if(rs!=null) rs.close();
				 if(ps!=null) ps.close();
				 
				 if(conn!=null) conn.close();				 
			 } catch(Exception e2){}
		 }
	}
	
	/**회원 주소 가져오기 메서드*/
	public String getUserAddr(String userid){
		try{
			conn = yb.db.YB_DB.getConn();
			
			String sql = "select * from member where id=?";
			
			ps = conn.prepareStatement(sql);
			ps.setString(1, userid);
			
			rs = ps.executeQuery();
			
			rs.next();
			
			return rs.getString("address");
			
		} catch(Exception e){
			e.printStackTrace();
			return null;			
		} finally{
			try{
				if(rs!=null) rs.close();
				if(ps!=null) ps.close();
				if(conn!=null) conn.close();				
			} catch(Exception e2){ }
		}
		
	} 
	
	/** 회원정보 수정*/
	public int UpdateInfo(MemberDTO dto){
		try{
			conn = yb.db.YB_DB.getConn();
			
			String sql = "update member set passwd=?, name=?, birth=?, cellphone=?, email=?, address=? where id=?";
			
			ps = conn.prepareStatement(sql);
			ps.setString(1, dto.getPasswd());
			ps.setString(2, dto.getName());
			ps.setString(3, dto.getBirth());
			ps.setString(4, dto.getCellphone());
			ps.setString(5, dto.getEmail());
			ps.setString(6, dto.getAddress());
			ps.setString(7, dto.getId());
			
			int count = ps.executeUpdate();
			
			return count; 
			
		} catch(Exception e){
			e.printStackTrace();
			return ERROR;
		} finally{
			try{
				if(ps!=null) ps.close();
				if(conn!=null) conn.close();				
			} catch(Exception e2){}
		}
	}
	
	/** 탈퇴 전 비밀번호 가져오기*/
	public String getPwd(String userid){
		try{
			conn = yb.db.YB_DB.getConn();
			
			String sql = "select * from member where id=?";
			
			ps = conn.prepareStatement(sql);
			ps.setString(1, userid);
			
			rs = ps.executeQuery();
			
			rs.next();
			
			return rs.getString("passwd");
		} catch(Exception e){
			e.printStackTrace();
			return null;
		} finally{
			try{
				if(rs!=null) rs.close();
				if(ps!=null) ps.close();
				
				if(conn!=null) conn.close();				
			} catch(Exception e2){}
		}
	}
	
	/** 회원 탈퇴*/
	public int DelMember(String userid){
		try{
			conn = yb.db.YB_DB.getConn();
			
			String sql = "delete from member where id=?";
			
			ps = conn.prepareStatement(sql);
			ps.setString(1, userid);
			
			int count = ps.executeUpdate();
						
			return count;
			
		} catch(Exception e){
			e.printStackTrace();
			return ERROR;
		} finally{
			try{
				if(ps!=null) ps.close();
				if(conn!=null) conn.close();				
			} catch(Exception e2){}
		}
	}
	
	
	
	
	
	
}
