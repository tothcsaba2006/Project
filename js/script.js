// Kosár számláló kezelése
let count = 0;
const cartCountElement = document.getElementById('cart-count');

// Eseményfigyelő a kosár ikonokhoz
document.addEventListener('click', function(e) {
    if (e.target.classList.contains('cart-btn-icon')) {
        e.stopPropagation(); // Megakadályozza a kártyára való kattintást
        count++;
        cartCountElement.innerText = count;
        
        // Vizuális visszajelzés
        e.target.style.transform = "scale(1.3)";
        setTimeout(() => {
            e.target.style.transform = "scale(1)";
        }, 200);
    }
});