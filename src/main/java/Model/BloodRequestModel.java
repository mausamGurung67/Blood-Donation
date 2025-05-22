package Model;

public class BloodRequestModel {
    private int id;
    private String patientName;
    private String hospital;
    private String bloodType;
    private int units;
    private String priority;
    private String status;
    private String requestDate;
    private String notes;
    private int userId;
    
    // Default constructor
    public BloodRequestModel() {
    }
    
    // Full constructor
    public BloodRequestModel(int id, String patientName, String hospital, String bloodType, 
                             int units, String priority, String status, String requestDate, String notes) {
        this.id = id;
        this.patientName = patientName;
        this.hospital = hospital;
        this.bloodType = bloodType;
        this.units = units;
        this.priority = priority;
        this.status = status;
        this.requestDate = requestDate;
        this.notes = notes;
    }
    
    // Getters and Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public String getPatientName() {
        return patientName;
    }
    
    public void setPatientName(String patientName) {
        this.patientName = patientName;
    }
    
    public String getHospital() {
        return hospital;
    }
    
    public void setHospital(String hospital) {
        this.hospital = hospital;
    }
    
    public String getBloodType() {
        return bloodType;
    }
    
    public void setBloodType(String bloodType) {
        this.bloodType = bloodType;
    }
    
    public int getUnits() {
        return units;
    }
    
    public void setUnits(int units) {
        this.units = units;
    }
    
    public String getPriority() {
        return priority;
    }
    
    public void setPriority(String priority) {
        this.priority = priority;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public String getRequestDate() {
        return requestDate;
    }
    
    public void setRequestDate(String requestDate) {
        this.requestDate = requestDate;
    }
    
    public String getNotes() {
        return notes;
    }
    
    public void setNotes(String notes) {
        this.notes = notes;
    }
    
    public int getUserId() {
        return userId;
    }
    
    public void setUserId(int userId) {
        this.userId = userId;
    }
} 