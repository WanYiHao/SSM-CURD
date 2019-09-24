package com.practice.crud.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.practice.crud.bean.Employee;
import com.practice.crud.bean.Msg;
import com.practice.crud.service.EmployeeService;

/**
 * 处理员工的CRUD请求
 * @author Desperado
 *
 */
@Controller
public class EmployeeController {

	@Autowired
	EmployeeService employeeService;
	
	/**
	 * 批量删除：1-2-3
	 * 单个删除：1，没有-
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/emp/{ids}", method=RequestMethod.DELETE)
	@ResponseBody
	public Msg deleteEmpById(@PathVariable("ids") String ids) {
		if(ids.contains("-")) {
			//批量删除
			List<Integer> del_ids = new ArrayList<>();
			String[] str_ids = ids.split("-");
			for (String string : str_ids) {
				del_ids.add(Integer.parseInt(string));
			}
			employeeService.deleteBatch(del_ids);
		}else {
			//单个删除
			Integer id = Integer.parseInt(ids);
			employeeService.deleteEmp(id);
		}
		return Msg.success();
	}
	
	
	/**
	 * 直接支持PUT请求需要封装请求体中的数据
	 * 配置HttpPutFormContentFilter
	 * 员工更新
	 * @param employee
	 * @return
	 */
	@RequestMapping(value="/emp/{empId}", method=RequestMethod.PUT)
	@ResponseBody
	public Msg saveEmp(Employee employee) {
//		System.out.println("传入的数据"+employee.toString());
		employeeService.updateEmp(employee);
		return Msg.success();
	}
	
	
	/**
	 * 通过员工ID查询员工数据
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/emp/{id}", method=RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("id") Integer id) {
		
		Employee employee = employeeService.getEmp(id);
		return Msg.success().add("emp", employee);
	}
	
	
	/**
	 * 检验用户名是否可用
	 */
	@ResponseBody
	@RequestMapping("/checkuser")
	public Msg checkUser(@RequestParam("empName") String empName) {
		//先判断用户名是否是合法的表达式
		String regex = "(^[a-zA-Z0-9_-]{3,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
		if(!empName.matches(regex)) {
			return Msg.fail().add("va_msg", "用户名必须是3-16位英文或2-5位中文，包括符号“-”、“_”");
		}
		
		//数据库用户名重复校验
		boolean flag = employeeService.checkUser(empName);
		if(flag) {
			return Msg.success();
		}else {
			return Msg.fail().add("va_msg", "用户名已被占用");
		}
	}
	
	/**
	 *  新增员工信息保存
	 *  1、支持JSR303校验
	 *  2、导入Hibernate-Validate
	 *  
	 * @param employee
	 * @return
	 */
	@RequestMapping(value="/emps", method=RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee, BindingResult result) {
		if(result.hasErrors()) {
			//校验失败，模态框中显示错误信息
			Map<String, Object> map = new HashMap<>();
			List<FieldError> errors = result.getFieldErrors();
			for (FieldError fieldError : errors) {
				System.out.println("错误的字段名：" + fieldError.getField());
				System.out.println("错误信息：" + fieldError.getDefaultMessage());
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);
		}else {
			employeeService.saveEmp(employee);
			return Msg.success();
		}
	}
	
	/**
	 * 需要导入Jackson包
	 * @param pn
	 * @return
	 */
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpsWithJson(@RequestParam(value="pn", defaultValue="1") Integer pn) {
		
		//不是分页查询，引入PageHelper分页插件
		//查询之前只需要调用,插入页码、每页数据量，startPage方法后紧跟的查询就可分页
		PageHelper.startPage(pn, 5);
		List<Employee> emps = employeeService.getAll();
		
		//使用PageInfo把数据包装,只需要把pageinfo交给页面即可
		//封装了详细的的分页信息,包括查询出的数据、传入连续显示的页数
		PageInfo page = new PageInfo(emps, 5);
				
		return Msg.success().add("pageInfo", page);
	}
	
	/**
	 * 查询员工数据（分页查询）
	 * @return
	 */
//	@RequestMapping("/emps")
	public String getEmps(@RequestParam(value="pn", defaultValue="1") Integer pn, 
			Model model) {
		//不是分页查询，引入PageHelper分页插件
		//查询之前只需要调用,插入页码、每页数据量，startPage方法后紧跟的查询就可分页
		PageHelper.startPage(pn, 5);
		List<Employee> emps = employeeService.getAll();
		
		//使用PageInfo把数据包装,只需要把pageinfo交给页面即可
		//封装了详细的的分页信息,包括查询出的数据、传入连续显示的页数
		PageInfo page = new PageInfo(emps, 5);
		model.addAttribute("pageInfo", page);
		
		return "list";
	}
	
}
