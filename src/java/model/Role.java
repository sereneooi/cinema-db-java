package model;

public class Role {
    private String roleId;
    private String role;
    
    public Role(){
        this("", "");
    }
    
    public Role(String roleId){
        this(roleId, "");
    }
    
    public Role(String roleId, String role){
        this.roleId = roleId;
        this.role = role;
    }

    public String getRoleId() {
        return roleId;
    }

    public void setRoleId(String roleId) {
        this.roleId = roleId;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    @Override
    public String toString() {
        return "Role{" + "roleId=" + roleId + ", role=" + role + '}';
    }
}
