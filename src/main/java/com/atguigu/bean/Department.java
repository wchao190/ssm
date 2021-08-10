package com.atguigu.bean;

public class Department {
    private Integer dId;

    private String dptName;

    public Department() {
    }

    public Department(Integer dId, String dptName) {
        this.dId = dId;
        this.dptName = dptName;
    }

    public Integer getdId() {
        return dId;
    }

    public void setdId(Integer dId) {
        this.dId = dId;
    }

    public String getDptName() {
        return dptName;
    }

    public void setDptName(String dptName) {
        this.dptName = dptName == null ? null : dptName.trim();
    }
}