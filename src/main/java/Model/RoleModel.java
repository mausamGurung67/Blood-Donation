package Model;

public class RoleModel {
     private int roleId;
     private String roleName;

     public RoleModel(int roleId, String roleName) {
          this.roleId = roleId;
          this.roleName = roleName;
     }

     public RoleModel() {
     }

     public int getRoleId() {
          return roleId;
     }

     public void setRoleId(int roleId) {
          this.roleId = roleId;
     }

     public String getRoleName() {
          return roleName;
     }

     public void setRoleName(String roleName) {
          this.roleName = roleName;
     }
}
