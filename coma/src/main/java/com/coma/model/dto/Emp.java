package com.coma.model.dto;

import java.io.Serializable;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.coma.MyAuthority;

//import java.util.ArrayList;
//import java.util.Collection;
//import java.util.List;

//import org.springframework.security.core.GrantedAuthority;
//import org.springframework.security.core.authority.SimpleGrantedAuthority;
//import org.springframework.security.core.userdetails.UserDetails;
//import org.springframework.security.crypto.password.PasswordEncoder;

//import com.coma.MyAuthority;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
 
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Emp implements UserDetails, Serializable{
	
	private static final long serialVersionUID = 1L;
	
   private String empId;
   private String empPw;
   private String empName;
   private String empGender;
   private Date empBrithDate;
   private Date empHireDate;
   private String empCurrent;
   private String empPhone;
   private String empPhoto;
   private double empVacation;
   private String empAccess;
   private Dept dept;
   private Job job;
   private String empAddr ;
   private String empAddrDetail ;
   private String sign;
   
   
   @Override
	public Collection<? extends GrantedAuthority> getAuthorities() {	
		List<GrantedAuthority> auth = new ArrayList<>();
		
		//기본등급 EMP
		//empId가 coma_1인 계정은 ADMIN 권한을 갖도록함
		/*
		 * if(empId.equals("COMA_1")){ auth.add(new
		 * SimpleGrantedAuthority(MyAuthority.ADMIN.name())); } else { auth.add(new
		 * SimpleGrantedAuthority(MyAuthority.EMP.name())); }
		 */
		
		switch (empId) {
		
		//관리자
		case "COMA_1":
			auth.add(new SimpleGrantedAuthority(MyAuthority.ADMIN.name()));
			break;
		//행정부장
		case "COMA_2":
			auth.add(new SimpleGrantedAuthority(MyAuthority.DIRECTOR1.name()));
			break;
		//교육부장
		case "COMA_3":
			auth.add(new SimpleGrantedAuthority(MyAuthority.DIRECTOR2.name()));
			break;
		//취업팀
		case "COMA_4","COMA_5","COMA_6","COMA_7","COMA_8":
			auth.add(new SimpleGrantedAuthority(MyAuthority.EMPTEAM.name()));
			break;
		//강사
		case "COMA_10","COMA_11","COMA_12","COMA_13","COMA_14":
			auth.add(new SimpleGrantedAuthority(MyAuthority.TEACHER.name()));
			break;
			
		//기본등급 EMP
		default:
			auth.add(new SimpleGrantedAuthority(MyAuthority.EMP.name()));	
			break;
		}
		
		return auth;

}

   @Override
	public String getUsername() {
		return this.empId;
	
	}
	@Override
	public boolean isAccountNonExpired() {
		return true;	
	}
	@Override
	public boolean isAccountNonLocked() {
		// TODO Auto-generated method stub
		return true;	
	}
	@Override
	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}
	@Override
	public boolean isEnabled() {
		// TODO Auto-generated method stub
		return true;
	}

//	public Emp getPassword(PasswordEncoder encoder) {
//		this.empPw = encoder.encode(this.empPw);
//		return this;
//	}

	@Override
	public String getPassword() {
		// TODO Auto-generated method stub
		return empPw;
	}
	
}