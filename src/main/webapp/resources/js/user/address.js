document.addEventListener('DOMContentLoaded', function() {
  // Thêm địa chỉ mới
  const addBtn = document.getElementById('addAddressBtn');
  const newForm = document.getElementById('newAddressForm');
  const cancelAddBtn = document.getElementById('cancelAddBtn');
  if (addBtn && newForm && cancelAddBtn) {
    addBtn.onclick = () => newForm.classList.remove('d-none');
    cancelAddBtn.onclick = () => newForm.classList.add('d-none');
  }

  // Sửa địa chỉ cũ
  document.querySelectorAll('.address-card').forEach(function(card) {
    const editBtn = card.querySelector('.editAddressBtn');
    const saveBtn = card.querySelector('.saveAddressBtn');
    const cancelBtn = card.querySelector('.cancelEditBtn');
    const inputs = card.querySelectorAll('input[type="text"]');

    if (editBtn && saveBtn && cancelBtn) {
      editBtn.onclick = function() {
        inputs.forEach(i => i.removeAttribute('readonly'));
        editBtn.classList.add('d-none');
        saveBtn.classList.remove('d-none');
        cancelBtn.classList.remove('d-none');
      };
      cancelBtn.onclick = function() {
        location.reload();
      };
    }
  });
});

document.addEventListener('DOMContentLoaded', function() {
  document.querySelectorAll('.address-form').forEach(function(form) {
    const editBtn = form.querySelector('.editAddressBtn');
    const saveBtn = form.querySelector('.saveAddressBtn');
    const cancelBtn = form.querySelector('.cancelEditBtn');
    const summary = form.querySelector('.address-summary');
    const editFields = form.querySelector('.address-edit-fields');

    if (editBtn && saveBtn && cancelBtn && summary && editFields) {
      editBtn.onclick = function() {
        summary.classList.add('d-none');
        editFields.classList.remove('d-none');
        editBtn.classList.add('d-none');
        saveBtn.classList.remove('d-none');
        cancelBtn.classList.remove('d-none');
      };
      cancelBtn.onclick = function() {
        summary.classList.remove('d-none');
        editFields.classList.add('d-none');
        editBtn.classList.remove('d-none');
        saveBtn.classList.add('d-none');
        cancelBtn.classList.add('d-none');
      };
    }
  });
});