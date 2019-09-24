package com.practice.crud.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.practice.crud.bean.Department;
import com.practice.crud.bean.Employee;
import com.practice.crud.dao.DepartmentMapper;
import com.practice.crud.dao.EmployeeMapper;

/**
 * 测试Dao层工作
 * @author Desperado
 * 推荐使用Spring的单元测试，可以自动注入需要的组件
 * 1、导入SpringTest模块
 * 2、@ContextConfiguration 指定Spring配置文件的位置
 * 3、直接使用autowired需要的组件
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {

	@Autowired
	DepartmentMapper departmentMapper;
	
	@Autowired
	EmployeeMapper employeeMapper;
	
	@Autowired
	SqlSession sqlSession;
	
	/**
	 * 测试DepartmentMapper
	 * 问题：两行操作，只能执行一次插入操作
	 */
	@Test
	public void testCRUD() {
//		//1、创建SpringIOC容器
//		ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
//		//2、从容器中获取mapper
//		DepartmentMapper bean = ioc.getBean(DepartmentMapper.class);
		
//		System.out.println(departmentMapper);
	
		//1、插入部门
//		departmentMapper.insertSelective(new Department(null, "测试部"));
//		departmentMapper.insertSelective(new Department(null, "会计部"));
	
		//2、插入员工
//		System.out.println("point00");
//		employeeMapper.insertSelective(new Employee(null, "Jerry", "M", "Jerry@google.com", 1));
//		System.out.println("point01");
//		employeeMapper.insertSelective(new Employee(null, "Tom", "M", "Tom@163.com", 1));
//		System.out.println("point02");
		
		//3、批量插入多个员工
//		EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
//		for(int i = 500; i <= 500; i++) {
//			String uid = UUID.randomUUID().toString().substring(0, 5) + i;
//			mapper.insertSelective(new Employee(i, uid, "M", uid+"@google.com", 1));
//		}
//		System.out.println("批量完成");
		
		//4、删除多余的数据
//		for(int i = 1506; i <= 1510; i++) {
//			employeeMapper.deleteByPrimaryKey(i);
//		}
//		System.out.println("批量删除成功");
	}
	
}