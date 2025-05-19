// Search functionality
document.getElementById('searchInput').addEventListener('keyup', function() {
    const searchText = this.value.toLowerCase();
    const rows = document.querySelectorAll('tbody tr');
    
    rows.forEach(row => {
        const name = row.cells[0].textContent.toLowerCase();
        const email = row.cells[1].textContent.toLowerCase();
        row.style.display = (name.includes(searchText) || email.includes(searchText)) ? '' : 'none';
    });
});

// Update modal functions
function showUpdateModal(email, name) {
    document.getElementById('updateEmail').value = email;
    document.getElementById('updateName').value = name;
    new bootstrap.Modal(document.getElementById('updateModal')).show();
}

// Delete confirmation
function confirmDelete(email) {
    if (confirm('Are you sure you want to delete this student?')) {
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = 'deleteStudent';
        
        const emailInput = document.createElement('input');
        emailInput.type = 'hidden';
        emailInput.name = 'email';
        emailInput.value = email;
        
        form.appendChild(emailInput);
        document.body.appendChild(form);
        form.submit();
    }
} 