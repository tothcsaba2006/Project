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

// auth.js
document.addEventListener('DOMContentLoaded', () => {
  const tabLogin = document.getElementById('tab-login');
  const tabRegister = document.getElementById('tab-register');
  const loginForm = document.getElementById('login-form');
  const registerForm = document.getElementById('register-form');

  tabLogin.addEventListener('click', () => {
    tabLogin.classList.add('active');
    tabRegister.classList.remove('active');
    loginForm.classList.remove('hidden');
    registerForm.classList.add('hidden');
  });

  tabRegister.addEventListener('click', () => {
    tabRegister.classList.add('active');
    tabLogin.classList.remove('active');
    registerForm.classList.remove('hidden');
    loginForm.classList.add('hidden');
  });

  // toggle password visibility
  document.querySelectorAll('.toggle-pass').forEach(btn => {
    btn.addEventListener('click', () => {
      const input = btn.parentElement.querySelector('input');
      if (!input) return;
      input.type = input.type === 'password' ? 'text' : 'password';
      btn.querySelector('i').classList.toggle('fa-eye-slash');
    });
  });

  // password strength helper
  const pwStrengthText = document.getElementById('pw-strength-text');
  const regPassword = document.getElementById('reg-password');
  regPassword.addEventListener('input', () => {
    const val = regPassword.value;
    let score = 0;
    if (val.length >= 8) score++;
    if (/[A-Z]/.test(val)) score++;
    if (/[0-9]/.test(val)) score++;
    if (/[^A-Za-z0-9]/.test(val)) score++;
    const labels = ['Gyenge','Közepes','Erős','Nagyon erős'];
    pwStrengthText.textContent = val.length === 0 ? '—' : labels[Math.max(0, score-1)];
  });

  // register submit
  registerForm.addEventListener('submit', async (e) => {
    e.preventDefault();
    const name = document.getElementById('reg-name').value.trim();
    const email = document.getElementById('reg-email').value.trim();
    const password = document.getElementById('reg-password').value;
    const password2 = document.getElementById('reg-password2').value;
    const msg = document.getElementById('register-msg');

    msg.textContent = '';

    if (!name || !email || !password) {
      msg.textContent = 'Kérlek tölts ki minden mezőt.';
      return;
    }
    if (password !== password2) {
      msg.textContent = 'A jelszavak nem egyeznek.';
      return;
    }
    if (password.length < 8) {
      msg.textContent = 'A jelszónak legalább 8 karakter hosszúnak kell lennie.';
      return;
    }

    try {
      const res = await fetch('/api/auth/register', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ name, email, password })
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.message || 'Hiba a regisztráció során');
      msg.style.color = '#1ab60c';
      msg.textContent = 'Sikeres regisztráció. Átirányítás...';
      // opcionális: átirányítás bejelentkezésre vagy profilra
      setTimeout(() => window.location.href = '/profile.html', 900);
    } catch (err) {
      msg.style.color = '#ffcc00';
      msg.textContent = err.message;
    }
  });

  // login submit
  loginForm.addEventListener('submit', async (e) => {
    e.preventDefault();
    const email = document.getElementById('login-email').value.trim();
    const password = document.getElementById('login-password').value;
    const remember = document.getElementById('remember-me').checked;
    const msg = document.getElementById('login-msg');

    msg.textContent = '';

    if (!email || !password) {
      msg.textContent = 'Kérlek tölts ki minden mezőt.';
      return;
    }

    try {
      const res = await fetch('/api/auth/login', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ email, password, remember })
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.message || 'Hiba a bejelentkezés során');
      msg.style.color = '#1ab60c';
      msg.textContent = 'Sikeres bejelentkezés. Átirányítás...';
      // token kezelése a backendtől függően
      setTimeout(() => window.location.href = '/profile.html', 700);
    } catch (err) {
      msg.style.color = '#ffcc00';
      msg.textContent = err.message;
    }
  });
});
