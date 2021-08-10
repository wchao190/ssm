package com.atguigu.service;


import com.atguigu.bean.Employee;
import com.atguigu.bean.EmployeeExample;
import com.atguigu.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeService {

    @Autowired
    EmployeeMapper employeeMapper;

    //查询所有员工
    public List<Employee> getAll(EmployeeExample example) {

        return  employeeMapper.selectByExampleWithDept(example);
    }

    //保存新增员工
    public void saveEmployee(Employee employee) {
        employeeMapper.insertSelective(employee);
    }
}
