// Admin dashboard JavaScript functionality

// Confirmation before delete actions
function confirmDelete(itemName) {
    return confirm('Are you sure you want to delete ' + itemName + '?');
}

// Image preview for upload forms
function previewImage(input, previewElement) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        
        reader.onload = function(e) {
            document.getElementById(previewElement).src = e.target.result;
            document.getElementById(previewElement).style.display = 'block';
        }
        
        reader.readAsDataURL(input.files[0]);
    }
}

// Initialize tooltips
document.addEventListener('DOMContentLoaded', function() {
    // Initialize Bootstrap tooltips
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl);
    });
    
    // Add event listeners for image preview
    var imageInput = document.getElementById('image');
    if (imageInput) {
        imageInput.addEventListener('change', function() {
            previewImage(this, 'imagePreview');
        });
    }
    
    // Add fade out effect for alert messages after 5 seconds
    setTimeout(function() {
        var alerts = document.querySelectorAll('.alert');
        alerts.forEach(function(alert) {
            var bsAlert = new bootstrap.Alert(alert);
            bsAlert.close();
        });
    }, 5000);
}); 