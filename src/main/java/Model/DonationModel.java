package Model;

import java.time.LocalDate;

public class DonationModel {
    private int id;
    private int userId;
    private String donationDate;
    private String donationTime;
    private String donationCenter;
    private String donationType;
    private String healthConditions;
    private String questions;
    private String status; // "Scheduled", "Completed", "Cancelled"
    private String bloodType;
    private String donorName; // Name of the donor for display purposes
    
    // Constructor with all fields
    public DonationModel(int id, int userId, String donationDate, String donationTime, String donationCenter, 
                         String donationType, String healthConditions, String questions, String status, String bloodType) {
        this.id = id;
        this.userId = userId;
        this.donationDate = donationDate;
        this.donationTime = donationTime;
        this.donationCenter = donationCenter;
        this.donationType = donationType;
        this.healthConditions = healthConditions;
        this.questions = questions;
        this.status = status;
        this.bloodType = bloodType;
    }
    
    // Constructor without id (for new records)
    public DonationModel(int userId, String donationDate, String donationTime, String donationCenter, 
                         String donationType, String healthConditions, String questions, String status, String bloodType) {
        this.userId = userId;
        this.donationDate = donationDate;
        this.donationTime = donationTime;
        this.donationCenter = donationCenter;
        this.donationType = donationType;
        this.healthConditions = healthConditions;
        this.questions = questions;
        this.status = status;
        this.bloodType = bloodType;
    }
    
    // Default constructor
    public DonationModel() {
    }
    
    // Getters and Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public int getUserId() {
        return userId;
    }
    
    public void setUserId(int userId) {
        this.userId = userId;
    }
    
    public String getDonationDate() {
        return donationDate;
    }
    
    public void setDonationDate(String donationDate) {
        this.donationDate = donationDate;
    }
    
    public String getDonationTime() {
        return donationTime;
    }
    
    public void setDonationTime(String donationTime) {
        this.donationTime = donationTime;
    }
    
    public String getDonationCenter() {
        return donationCenter;
    }
    
    public void setDonationCenter(String donationCenter) {
        this.donationCenter = donationCenter;
    }
    
    public String getDonationType() {
        return donationType;
    }
    
    public void setDonationType(String donationType) {
        this.donationType = donationType;
    }
    
    public String getHealthConditions() {
        return healthConditions;
    }
    
    public void setHealthConditions(String healthConditions) {
        this.healthConditions = healthConditions;
    }
    
    public String getQuestions() {
        return questions;
    }
    
    public void setQuestions(String questions) {
        this.questions = questions;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    // Getter and Setter for bloodType
    public String getBloodType() {
        return bloodType;
    }
    
    public void setBloodType(String bloodType) {
        this.bloodType = bloodType;
    }
    
    public String getDonorName() {
        return donorName;
    }
    
    public void setDonorName(String donorName) {
        this.donorName = donorName;
    }
    
    // Helper method to check if this is an upcoming donation
    public boolean isUpcoming() {
        if (this.status.equals("Cancelled")) {
            return false;
        }
        
        LocalDate appointmentDate = LocalDate.parse(this.donationDate);
        LocalDate today = LocalDate.now();
        
        return !appointmentDate.isBefore(today);
    }
    
    // Helper method to get a formatted date and time string
    public String getFormattedDateTime() {
        return this.donationDate + " at " + this.donationTime;
    }
}