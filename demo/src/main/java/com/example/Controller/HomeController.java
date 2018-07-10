package com.example.Controller;

import com.example.Beans.Employee;
import com.example.Beans.Message;
import com.example.Services.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.validation.Valid;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/")
public class HomeController {

	@Autowired
	EmployeeService employeeService;

	//支持JSR303需要导入hibernate
	//保存员工
	@RequestMapping(value = "/emp", method = RequestMethod.POST)
	@ResponseBody
	public Message saveEmp(@Valid Employee employee, BindingResult result) {
        if (result.hasErrors()) {
			Map<String, Object> map = new HashMap<>();
        	List<FieldError> errors = result.getFieldErrors();
			for (FieldError fieldError : errors) {
				map.put(fieldError.getField(),fieldError.getDefaultMessage());
			}
        	return Message.fail().add("errorFields", map);
		} else {
			employeeService.saveEmp(employee);
			return Message.sucess();
		}

	}

	//检查用户名是否可用
	@RequestMapping(value = "/checkuser")
	@ResponseBody
    public Message checkuser(@RequestParam("empName") String empName) {
		//先判断是否合法
		String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
		if (!empName.matches(regx)) {
			return Message.fail().add("va_msg", "用户名必须6-16位英文数字组合或者2-5为中文。");
		}
		boolean result = employeeService.checkUser(empName);
		if (result)
			return Message.sucess();
		else
			return Message.fail().add("va_msg", "用户名不可用");
	}

	@RequestMapping(value = "emps")
	@ResponseBody
	public Message getEmpsWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn,
								   Model model) {
		PageHelper.startPage(pn,5);
		//startPage后紧跟的查询就是分页查询
		List<Employee> emps = employeeService.getAll();

		PageInfo pageInfo = new PageInfo(emps, 5);
//		model.addAttribute("pageInfo", pageInfo);
		return Message.sucess().add("pageInfo", pageInfo);
	}

	@RequestMapping(method = RequestMethod.GET)
	public String home() {
//		EmployeeMapper employeeMapper = sqlSession.getMapper(EmployeeMapper.class);
//		for (int i = 0; i < 100; i++) {
//			String uuid = UUID.randomUUID().toString().substring(0,5)+i;
//			employeeMapper.insertSelective(new Employee(null, uuid, "M", uuid+"@gmail.com", 1));
//		}
//		System.out.println("aaa完成");
		return "index";
	}

	@RequestMapping(value = "viewemps", method = RequestMethod.GET)
	public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn,
						  Model model) {
		//查询前调用
		PageHelper.startPage(pn,5);
		//startPage后紧跟的查询就是分页查询
		List<Employee> emps = employeeService.getAll();

		PageInfo pageInfo = new PageInfo(emps, 5);
		model.addAttribute("pageInfo", pageInfo);
		return "lists";
	}
}
