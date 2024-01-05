package com.coma.model.dto;

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
public class Emp implements UserDetails{
	
   private String empId;
   private String empPw;
   private String empName;
   private String empGender;
   private Date empBrithDate;
   private Date empHireDate;
   private String empCurrent;
   private String empPhone;
   private String empPhoto;
   private int empVacation;
   private String empAccess;
   private Dept dept;
   private Job job;
   private String empAddr ;
   private String empAddrDetail ;
   
   @Override
	public Collection<? extends GrantedAuthority> getAuthorities() {	
		List<GrantedAuthority> auth = new ArrayList<>();
		
		//기본등급 EMP
		auth.add(new SimpleGrantedAuthority(MyAuthority.EMP.name()));
		//empId가 coma_1인 계정은 ADMIN 권한을 갖도록함
		if(empId.equals("COMA_1")){
			auth.add(new SimpleGrantedAuthority(MyAuthority.ADMIN.name()));
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

	public Emp getPassword(PasswordEncoder encoder) {
		this.empPw = encoder.encode(this.empPw);
		return this;
	}

	@Override
	public String getPassword() {
		// TODO Auto-generated method stub
		return null;
	}
	
}