<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập - TRAO ĐỔI ĐỒ CŨ</title>
    <link rel="icon" type="image/jpeg" href="images/logo.jpg?v=1">
    <link rel="stylesheet" href="css/style.css">
    
    <!-- Google Sign-In SDK -->
    <script src="https://accounts.google.com/gsi/client" async defer></script>
    <script>
        function handleCredentialResponse(response) {
            var form = document.createElement('form');
            form.method = 'POST';
            form.action = 'google-login';

            var input = document.createElement('input');
            input.type = 'hidden';
            input.name = 'credential';
            input.value = response.credential;

            form.appendChild(input);
            document.body.appendChild(form);
            form.submit();
        }

        function triggerGoogleLogin() {
            var googleBtn = document.querySelector('.g_id_signin div[role=button]');
            if (googleBtn) {
                googleBtn.click();
            } else if (window.google && google.accounts.id) {
                google.accounts.id.prompt();
            }
        }
    </script>
</head>
<body>

    <header>
        <a href="index" class="logo">
            <span class="logo-badge">PTIT</span>
            <span>TRAO ĐỔI ĐỒ CŨ</span>
        </a>
        <nav>
            <a href="index">Trang chủ</a>
            <a href="register.jsp" class="btn-header-post">Đăng ký</a>
        </nav>
    </header>

    <div class="container" style="display: flex; justify-content: center; align-items: center; min-height: 70vh; padding: 30px 15px;">
        
        <div class="form-card">
            
            <div class="form-header">
                <h2>Đăng Nhập Hệ Thống</h2>
                <p>Nền tảng Trao Đổi Đồ Cũ Sinh Viên PTIT</p>
            </div>

            <% 
                String error = (String) request.getAttribute("error"); 
                String msg = request.getParameter("msg");
            %>
            <% if (error != null) { %>
                <div class="alert-error">✕ <%= error %></div>
            <% } %>
            <% if ("registered".equals(msg)) { %>
                <div class="alert-success">✓ Đăng ký tài khoản thành công! Vui lòng đăng nhập.</div>
            <% } else if ("password_reset".equals(msg)) { %>
                <div class="alert-success">✓ Đặt lại mật khẩu thành công! Vui lòng đăng nhập.</div>
            <% } %>

            <!-- Form Đăng nhập thường -->
            <form action="login" method="post" style="box-shadow: none; padding: 0; margin: 0; max-width: 100%; border: none;">
                <div class="form-group">
                    <label for="username">Tên đăng nhập hoặc Email:</label>
                    <input type="text" id="username" name="username" required placeholder="Nhập tên đăng nhập hoặc email">
                </div>

                <div class="form-group" style="margin-bottom: 8px;">
                    <label for="password">Mật khẩu:</label>
                    <input type="password" id="password" name="password" required placeholder="Nhập mật khẩu">
                </div>

                <div style="display: flex; justify-content: flex-end; margin-bottom: 20px;">
                    <a href="forgot-password.jsp" style="color: #2563EB; font-size: 13px; text-decoration: none; font-weight: 600;">Quên mật khẩu?</a>
                </div>

                <button type="submit" class="btn-submit" style="margin-top: 0;">Đăng nhập</button>
            </form>

            <div style="display: flex; align-items: center; margin: 24px 0 20px; color: var(--text-light); font-size: 12px;">
                <div style="flex: 1; height: 1px; background: var(--border);"></div>
                <span style="padding: 0 12px; font-weight: 700; letter-spacing: 0.5px;">HOẶC TIẾP TỤC VỚI</span>
                <div style="flex: 1; height: 1px; background: var(--border);"></div>
            </div>

            <!-- Google Sign-In Init -->
            <div id="g_id_onload"
                 data-client_id="980739889720-ksura55kif5hdkoua7ggq9cqsotontdt.apps.googleusercontent.com"
                 data-callback="handleCredentialResponse"
                 data-auto_prompt="false">
            </div>

            <!-- Nút Đăng nhập Google -->
            <div onclick="triggerGoogleLogin()" 
                 style="background-color: #FFFFFF; color: var(--text-main); border: 1px solid var(--border); padding: 11px 16px; border-radius: var(--radius-sm); font-weight: 600; font-size: 14px; cursor: pointer; display: flex; align-items: center; justify-content: center; gap: 10px; transition: var(--transition); box-shadow: var(--shadow-xs);"
                 onmouseover="this.style.backgroundColor='#F8FAFC'; this.style.borderColor='var(--border-focus)';" 
                 onmouseout="this.style.backgroundColor='#FFFFFF'; this.style.borderColor='var(--border)';">
                <svg width="18" height="18" viewBox="0 0 48 48">
                    <path fill="#EA4335" d="M24 9.5c3.54 0 6.71 1.22 9.21 3.6l6.85-6.85C35.9 2.38 30.47 0 24 0 14.62 0 6.51 5.38 2.56 13.22l7.98 6.19C12.43 13.72 17.74 9.5 24 9.5z"/>
                    <path fill="#4285F4" d="M46.98 24.55c0-1.57-.15-3.09-.38-4.55H24v9.02h12.94c-.58 2.96-2.26 5.48-4.78 7.18l7.73 6c4.51-4.18 7.09-10.36 7.09-17.65z"/>
                    <path fill="#FBBC05" d="M10.53 28.59c-.48-1.45-.76-2.99-.76-4.59s.28-3.14.76-4.59l-7.98-6.19C.92 16.46 0 20.12 0 24c0 3.88.92 7.54 2.55 10.78l7.98-6.19z"/>
                    <path fill="#34A853" d="M24 48c6.48 0 11.93-2.13 15.89-5.81l-7.73-6c-2.15 1.45-4.92 2.3-8.16 2.3-6.26 0-11.57-4.22-13.47-9.91l-7.98 6.19C6.51 42.62 14.62 48 24 48z"/>
                </svg>
                <span>Đăng nhập với Google</span>
            </div>

            <!-- Phao ẩn chứa nút Google gốc -->
            <div style="opacity: 0; position: absolute; pointer-events: none;">
                <div class="g_id_signin" data-type="standard"></div>
            </div>

            <p style="text-align: center; margin-top: 20px; font-size: 13.5px; color: var(--text-muted);">
                Chưa có tài khoản? <a href="register.jsp" style="color: var(--primary); font-weight: 700; text-decoration: none;">Đăng ký ngay</a>
            </p>

        </div>

    </div>

    <!-- Footer -->
    <footer>
        <p><strong>&copy; 2026 Trao Đổi Đồ Cũ PTIT</strong> — Nền tảng trao đổi đồ dùng sinh viên Học viện Công nghệ Bưu chính Viễn thông.</p>
        <p class="footer-sub">Học tập • Chia sẻ • Tiết kiệm • Văn minh sinh viên</p>
    </footer>

</body>
</html>