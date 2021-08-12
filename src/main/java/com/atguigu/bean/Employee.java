package com.atguigu.bean;

import org.hibernate.validator.constraints.Length;
import javax.validation.constraints.Pattern;

public class Employee {
    private Integer id;

    @Pattern(regexp = "(^[a-z0-9_-]{6,12}$)|(^[\u2E80-\u9FFF]{2,8}$)",
            message = "用户名必须是2-8位中文或者6-12位英文和数字的组合！")
    private String lastName;

    private String gender;

    @Pattern(regexp = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$",message = "邮箱格式不正确")
    private String email;

    private Integer dptId;

    private Department department;

    public Employee() {
    }

    public Employee(Integer id, String lastName, String gender, String email, Integer dptId) {
        this.id = id;
        this.lastName = lastName;
        this.gender = gender;
        this.email = email;
        this.dptId = dptId;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName == null ? null : lastName.trim();
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

    public Integer getDptId() {
        return dptId;
    }

    public void setDptId(Integer dptId) {
        this.dptId = dptId;
    }

    public Department getDepartment() {
        return department;
    }

    public void setDepartment(Department department) {
        this.department = department;
    }

    @Override
    public String toString() {
        return "Employee{" +
                "id=" + id +
                ", lastName='" + lastName + '\'' +
                ", gender='" + gender + '\'' +
                ", email='" + email + '\'' +
                ", dptId=" + dptId +
                ", department=" + department +
                '}';
    }
}