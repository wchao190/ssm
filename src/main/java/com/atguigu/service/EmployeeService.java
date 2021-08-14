package com.atguigu.service;


import com.atguigu.bean.Employee;
import com.atguigu.bean.EmployeeExample;
import com.atguigu.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
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

    //校验用户名是否可用
    public boolean checkName(String name) {
        EmployeeExample employeeExample = new EmployeeExample();
        EmployeeExample.Criteria criteria = employeeExample.createCriteria();
        criteria.andLastNameEqualTo(name);
        long count = employeeMapper.countByExample(employeeExample);
        return count==0;
    }

    //根据员工 id 查询员工
    public Employee getEmpById(Integer id) {
        return  employeeMapper.selectByPrimaryKeyWithDept(id);
    }

    //保存修改信息
    public Integer saveEmpById(Employee record) {
        return employeeMapper.updateByPrimaryKeySelective(record);
    }

    //删除单个员工
    public Integer delEmployee(Integer id) {
        return employeeMapper.deleteByPrimaryKey(id);
    }

    //批量删除员工
    public void batchDelEmployee(ArrayList<Integer> empIds) {
        EmployeeExample employeeExample = new EmployeeExample();
        //创建查询条件
        EmployeeExample.Criteria criteria = employeeExample.createCriteria();
        // 多个id
        criteria.andIdIn(empIds);
        employeeMapper.deleteByExample(employeeExample);
    }
}
