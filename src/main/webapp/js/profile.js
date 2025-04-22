// DOM elements
document.addEventListener('DOMContentLoaded', function() {
    // Sample data
    const userData = {
        fullName: 'Nana Op',
        email: 'nana.op@example.com',
        contactNumber: '+1 234 567 8901',
        address: '123 Main Street, City, Country',
        bloodType: 'O+',
        gender: 'Female',
        dob: '1995-05-15',
        emergencyContact: '+1 987 654 3210'
    };
    
    // Populate profile fields
    function populateUserData() {
        document.getElementById('fullName').value = userData.fullName;
        document.getElementById('email').value = userData.email;
        document.getElementById('contactNumber').value = userData.contactNumber;
        document.getElementById('address').value = userData.address;
        document.getElementById('bloodType').value = userData.bloodType;
        document.getElementById('gender').value = userData.gender;
        document.getElementById('dob').value = userData.dob;
        document.getElementById('emergencyContact').value = userData.emergencyContact;
    }
    
    // Modal functionality
    const editBtn = document.getElementById('editProfileBtn');
    const modal = document.getElementById('editProfileModal');
    const closeBtn = document.querySelector('.close-modal');
    const cancelBtn = document.getElementById('cancelEdit');
    const profileForm = document.getElementById('profileEditForm');
    
    function populateEditForm() {
        if(!document.getElementById('editFullName')) return;
        
        document.getElementById('editFullName').value = userData.fullName;
        document.getElementById('editEmail').value = userData.email;
        document.getElementById('editContactNumber').value = userData.contactNumber;
        document.getElementById('editAddress').value = userData.address;
        document.getElementById('editBloodType').value = userData.bloodType;
        document.getElementById('editGender').value = userData.gender;
        document.getElementById('editDob').value = userData.dob;
        document.getElementById('editEmergencyContact').value = userData.emergencyContact;
    }
    
    function showModal() {
        modal.style.display = 'flex';
        populateEditForm();
    }
    
    function hideModal() {
        modal.style.display = 'none';
    }
    
    // Initialize
    populateUserData();
    
    // Event listeners
    if(editBtn) {
        editBtn.addEventListener('click', showModal);
    }
    
    if(closeBtn) {
        closeBtn.addEventListener('click', hideModal);
    }
    
    if(cancelBtn) {
        cancelBtn.addEventListener('click', hideModal);
    }
    
    if(profileForm) {
        profileForm.addEventListener('submit', function(e) {
            e.preventDefault();
            
            // Update userData object with form values
            userData.fullName = document.getElementById('editFullName').value;
            userData.email = document.getElementById('editEmail').value;
            userData.contactNumber = document.getElementById('editContactNumber').value;
            userData.address = document.getElementById('editAddress').value;
            userData.bloodType = document.getElementById('editBloodType').value;
            userData.gender = document.getElementById('editGender').value;
            userData.dob = document.getElementById('editDob').value;
            userData.emergencyContact = document.getElementById('editEmergencyContact').value;
            
            // Update display
            populateUserData();
            
            // Close modal
            hideModal();
            
            // Show success message
            alert('Profile updated successfully!');
        });
    }
    
    // Close modal when clicking outside
    window.addEventListener('click', function(event) {
        if(event.target === modal) {
            hideModal();
        }
    });
});