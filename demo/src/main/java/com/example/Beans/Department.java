package com.example.Beans;

public class Department {
    private Integer depId;

    private String depName;

    public Integer getDepId() {
        return depId;
    }

    public void setDepId(Integer depId) {
        this.depId = depId;
    }

    public String getDepName() {
        return depName;
    }

    public void setDepName(String depName) {
        this.depName = depName == null ? null : depName.trim();
    }

    public Department() {
        super();
    }

    public Department(Integer depId, String depName) {
        this.depId = depId;
        this.depName = depName;
    }
}