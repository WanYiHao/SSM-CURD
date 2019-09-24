package com.practice.crud.bean;

import javax.validation.constraints.Pattern;

public class Employee {
    private Integer empId;

    @Pattern(regexp = "(^[a-zA-Z0-9_-]{3,16}$)|(^[\\u2E80-\\u9FFF]{2,5})",
    		message = "用户名必须是3-16位英文或2-5位中文")
    private String empName;

    private String gender;

    //@Email
    @Pattern(regexp = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$",
    		message = "邮箱格式不正确")
    private String email;

    private Integer deptId;
    
    //希望查询员工的同时查询他对应的部门信息
    private Department department;

    
    
    
    public Employee() {
		super();
	}

	public Employee(Integer empId, String empName, String gender, String email, Integer deptId) {
		super();
		this.empId = empId;
		this.empName = empName;
		this.gender = gender;
		this.email = email;
		this.deptId = deptId;
	}

	public Department getDepartment() {
		return department;
	}

	public void setDepartment(Department department) {
		this.department = department;
	}

	public Integer getEmpId() {
        return empId;
    }

    public void setEmpId(Integer empId) {
        this.empId = empId;
    }

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName == null ? null : empName.trim();
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender == null ? null : gender.trim();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    public Integer getDeptId() {
        return deptId;
    }

    public void setDeptId(Integer deptId) {
        this.deptId = deptId;
    }

	@Override
	public String toString() {
		return "Employee [empId=" + empId + ", empName=" + empName + ", gender=" + gender + ", email=" + email
				+ ", deptId=" + deptId + ", department=" + department + "]";
	}
    
    
}