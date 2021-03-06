package com.practice.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.practice.crud.bean.Employee;
import com.practice.crud.bean.EmployeeExample;
import com.practice.crud.bean.EmployeeExample.Criteria;
import com.practice.crud.dao.EmployeeMapper;

@Service
public class EmployeeService {

	@Autowired
	EmployeeMapper employeeMapper;
	
	/**
	 * 查询所有员工信息
	 * @return
	 */
	public List<Employee> getAll() {
		return employeeMapper.selectByExampleWithDept(null);
	}

	/**
	 * 员工保存方法
	 * @param employee
	 */
	public void saveEmp(Employee employee) {
		
		employeeMapper.insertSelective(employee);
	}

	/**
	 * 检验用户名是否可用
	 * @param empName
	 * @return
	 * true:输入的用户名不存在，可用
	 * false:用户名已存在，不可用
	 */
	public boolean checkUser(String empName) {
		
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpNameEqualTo(empName);
		long count = employeeMapper.countByExample(example);
		return count == 0;
	}

	/**
	 * 按照员工ID查询员工
	 * @param id
	 * @return
	 */
	public Employee getEmp(Integer id) {
		Employee employee = employeeMapper.selectByPrimaryKey(id);
		return employee;
	}

	/**
	 * 更新员工修改后的信息
	 * @param employee
	 */
	public void updateEmp(Employee employee) {
		employeeMapper.updateByPrimaryKeySelective(employee);
		
	}

	public void deleteEmp(Integer id) {
		employeeMapper.deleteByPrimaryKey(id);
	}

	public void deleteBatch(List<Integer> ids) {

		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		//DELETE FROM table_name WHERE emp_id in (1,2,3);
		criteria.andEmpIdIn(ids);
		employeeMapper.deleteByExample(example);
	}


}
