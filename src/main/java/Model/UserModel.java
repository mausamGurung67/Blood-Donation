package Model;

public class UserModel {
	private int id;
	private String username;
	private String email;
	private String password;
	private int role=1;
	
	public UserModel(int id, String username, String email, String password, int role) {
		super();
		this.id = id;
		this.username = username;
		this.email = email;
		this.password = password;
//		this.profilePicture = profilePicture;
		this.role = role;
	}
	

	public UserModel(String username, String email, String password, int role) {
		super();
		this.username = username;
		this.email = email;
		this.password = password;
//		this.profilePicture = profilePicture;
		this.role = role;
	}



	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	

	public int getRole() {
		return role;
	}

	public void setRole(int role) {
		this.role = role;
	}
	
}
