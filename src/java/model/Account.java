package model;

import java.util.Date;  

public class Account {
    private String emailAddress;
    private String name;
    private String password;
    private String ic;
    private char gender;
    private String birthDate;
    private String address;
    private String contactNo;
    private Role role;
    private Date dateCreated;
    private Date dateModified;
            
    public Account() {
        this("", "", "", "", '\0', "", "", "", null, null, null);
    }
    
    public Account(String emailAddress) {
        this(emailAddress, "", "", "", '\0', "", "", "", null, null, null);
    }
    
    public Account(String emailAddress, String password) {
        this(emailAddress, "", password, "", '\0', "", "", "", null, null, null);
    }
    
    public Account(String emailAddress, String name, String contactNo) {
        this(emailAddress, name, "", "", '\0', "", "", contactNo, null, null, null);
    }
    
    public Account(String emailAddress, String name, String ic, char gender, String birthDate, String address, String contactNo, Role role, Date dateModified) {
        this(emailAddress, name, "", ic, gender, birthDate, address, contactNo, role, null, dateModified);
    }

    public Account(String emailAddress, String name, String password, String ic, char gender, String birthDate, String address, String contactNo, Role role, Date dateCreated, Date dateModified) {
        this.emailAddress = emailAddress;
        this.name = name;
        this.password = password;
        this.ic = ic;
        this.gender = gender;
        this.birthDate = birthDate;
        this.address = address;
        this.contactNo = contactNo;
        this.role = role;
        this.dateCreated = dateCreated;
        this.dateModified = dateModified;
    }

    public String getEmailAddress() {
        return emailAddress;
    }

    public void setEmailAddress(String emailAddress) {
        this.emailAddress = emailAddress;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getIc() {
        return ic;
    }

    public void setIc(String ic) {
        this.ic = ic;
    }

    public char getGender() {
        return gender;
    }

    public void setGender(char gender) {
        this.gender = gender;
    }

    public String getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(String birthDate) {
        this.birthDate = birthDate;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getContactNo() {
        return contactNo;
    }

    public void setContactNo(String contactNo) {
        this.contactNo = contactNo;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public Date getDateCreated() {
        return dateCreated;
    }

    public void setDateCreated(Date dateCreated) {
        this.dateCreated = dateCreated;
    }

    public Date getDateModified() {
        return dateModified;
    }

    public void setDateModified(Date dateModified) {
        this.dateModified = dateModified;
    } 
}
