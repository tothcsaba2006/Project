document.addEventListener('DOMContentLoaded', () => {
    
    // --- 1. UI ELEMEK ---
    const cartIcon = document.querySelector('.cart-icon');
    const cartSidebar = document.getElementById('cart-sidebar');
    const cartOverlay = document.getElementById('cart-overlay');
    const closeCartBtn = document.getElementById('close-cart');
    const sidebarItemsContainer = document.getElementById('cart-items-container');
    const sidebarTotalElement = document.getElementById('sidebar-total');
    const cartCountBadge = document.getElementById('cart-count');
    
    // Termék oldal elemek
    const addToCartBtn = document.getElementById('add-to-cart-btn');
    const productSizeSelect = document.getElementById('product-size');
    const productQtyInput = document.getElementById('product-qty');

    // Rendelés oldal elemek
    const checkoutItemsList = document.getElementById('checkout-items-list');
    const checkoutSubtotal = document.getElementById('checkout-subtotal');
    const checkoutTotal = document.getElementById('checkout-total');
    const checkoutForm = document.getElementById('checkout-form');

    // --- 2. KOSÁR LOGIKA (LOCALSTORAGE) ---

    function loadCart() {
        const cart = JSON.parse(localStorage.getItem('snkrs_cart')) || [];
        const total = cart.reduce((sum, item) => sum + (item.price * item.quantity), 0);

        if(cartCountBadge) cartCountBadge.innerText = cart.length;
        if(sidebarItemsContainer) renderSidebar(cart, total);
        if(checkoutItemsList) renderCheckoutPage(cart, total);
    }

    function addToCart(product) {
        let cart = JSON.parse(localStorage.getItem('snkrs_cart')) || [];
        const existingItem = cart.find(item => item.id === product.id && item.size === product.size);

        if (existingItem) {
            existingItem.quantity += product.quantity;
        } else {
            cart.push(product);
        }

        localStorage.setItem('snkrs_cart', JSON.stringify(cart));
        loadCart();
        openCart();
    }

    function removeFromCart(productId, size) {
        let cart = JSON.parse(localStorage.getItem('snkrs_cart')) || [];
        cart = cart.filter(item => !(item.id === productId && item.size === size));
        localStorage.setItem('snkrs_cart', JSON.stringify(cart));
        loadCart();
    }

    // --- 3. MEGJELENÍTÉS ---

    // Sidebar Renderelés
    function renderSidebar(items, total) {
        sidebarItemsContainer.innerHTML = '';
        
        // OKOS ÚTVONAL KEZELÉS A GOMBHOZ
        let checkoutLink = 'rendeles.html'; // Alapértelmezett (ha html mappában vagyunk)
        
        // Ha a "termekek" mappában vagyunk, akkor ki kell lépni és be a html-be
        if (window.location.pathname.includes('/termekek/')) {
            checkoutLink = '../html/rendeles.html';
        }

        // Sidebar Footer HTML
        const footerHTML = `
            <div class="cart-total">
                <span>Összesen:</span>
                <span id="sidebar-total">${total.toLocaleString()} Ft</span>
            </div>
            <button class="btn-checkout" onclick="window.location.href='${checkoutLink}'">
                Tovább a pénztárhoz
            </button>
        `;

        // Keressük meg a cart-footer-t és frissítsük, VAGY ha nincs, illesszük be
        const existingFooter = document.querySelector('.cart-footer');
        if(existingFooter) {
            existingFooter.innerHTML = footerHTML;
        }

        if(items.length === 0) {
            sidebarItemsContainer.innerHTML = '<p style="color:#888;text-align:center; margin-top:20px">Üres a kosár</p>';
            if(existingFooter) existingFooter.querySelector('span').innerText = '0 Ft'; // Csak az összeget nullázzuk
            return;
        }

        items.forEach(item => {
            // Törlés gombnál figyelni kell a string idézőjelekre
            const sizeParam = item.size ? `'${item.size}'` : 'null';
            
            sidebarItemsContainer.innerHTML += `
                <div class="sidebar-item">
                    <img src="${item.image}" alt="${item.name}">
                    <div class="sidebar-item-info">
                        <h4>${item.name}</h4>
                        <p>${item.quantity} x ${item.price.toLocaleString()} FT</p>
                        ${item.size ? `<span style="font-size:11px; color:#888">Méret: ${item.size}</span>` : ''}
                    </div>
                    <i class="fa-solid fa-trash remove-btn" 
                       style="cursor:pointer; color:#ff4444; margin-left:auto;"
                       onclick="removeItem('${item.id}', ${sizeParam})"></i>
                </div>
            `;
        });
        
        // Globális segédfüggvény a HTML onclick-hez
        window.removeItem = (id, size) => removeFromCart(id, size);
    }

    // Rendelés oldal összegzés
    function renderCheckoutPage(items, total) {
        checkoutItemsList.innerHTML = '';
        if(items.length === 0) {
            checkoutItemsList.innerHTML = '<p>Üres a kosarad.</p>';
            checkoutSubtotal.innerText = '0 Ft';
            checkoutTotal.innerText = '0 Ft';
            return;
        }
        items.forEach(item => {
            checkoutItemsList.innerHTML += `
                <div class="summary-item">
                    <img src="${item.image}" alt="termék">
                    <div>
                        <p>${item.name}</p>
                        <small>Méret: ${item.size || '-'} | Mennyiség: ${item.quantity}</small>
                    </div>
                    <p>${(item.price * item.quantity).toLocaleString()} Ft</p>
                </div>
            `;
        });
        checkoutSubtotal.innerText = `${total.toLocaleString()} Ft`;
        checkoutTotal.innerText = `${total.toLocaleString()} Ft`;
    }

    // --- 4. ESEMÉNYEK ---

    function openCart() {
        cartSidebar.classList.add('open');
        cartOverlay.classList.add('open');
    }
    function closeCart() {
        cartSidebar.classList.remove('open');
        cartOverlay.classList.remove('open');
    }

    if(cartIcon) cartIcon.addEventListener('click', (e) => { e.preventDefault(); openCart(); });
    if(closeCartBtn) closeCartBtn.addEventListener('click', closeCart);
    if(cartOverlay) cartOverlay.addEventListener('click', closeCart);

    // KOSÁRBA RAKÁS (Termék oldal)
    if(addToCartBtn) {
        addToCartBtn.addEventListener('click', (e) => {
            e.preventDefault();
            const size = productSizeSelect ? productSizeSelect.value : null;
            if(productSizeSelect && !size) { alert("Válassz méretet!"); return; }

            const product = {
                id: addToCartBtn.dataset.id,
                name: addToCartBtn.dataset.name,
                price: parseInt(addToCartBtn.dataset.price),
                image: addToCartBtn.dataset.image,
                quantity: parseInt(productQtyInput ? productQtyInput.value : 1),
                size: size
            };
            addToCart(product);
        });
    }

    // RENDELÉS LEADÁS
    if(checkoutForm) {
        checkoutForm.addEventListener('submit', (e) => {
            e.preventDefault();
            alert("Köszönjük a rendelésed!");
            localStorage.removeItem('snkrs_cart');
            window.location.href = 'index.html';
        });
    }

    // Betöltés
    loadCart();
});