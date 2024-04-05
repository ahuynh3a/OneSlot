// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("DOMContentLoaded", () => {
  document.querySelectorAll('.day').forEach(day => {
    day.addEventListener('click', () => {
      const modalId = day.getAttribute('data-target');
      const modal = new bootstrap.Modal(document.querySelector(modalId));
      modal.show();
    });
  });
});
