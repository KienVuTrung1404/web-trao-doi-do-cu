<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập - TRAO ĐỔI ĐỒ CŨ</title>
    <link rel="icon" type="image/jpeg" href="/images/logo.jpg?v=1">
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

    <header style="background-color: #7A1E28;">
        <a href="index" class="logo">🔴 TRAO ĐỔI ĐỒ CŨ</a>
        <nav>
            <a href="index">Trang chủ</a>
        </nav>
    </header>

    <div class="container" style="display: flex; justify-content: center; align-items: center; min-height: 65vh; padding: 30px 15px;">
        
        <div style="background: white; border-radius: 16px; box-shadow: 0 4px 20px rgba(0,0,0,0.08); padding: 40px 30px; width: 100%; max-width: 420px; border: 1px solid #E2E8F0; text-align: center;">
            
            <h2 style="color: #7A1E28; font-size: 24px; margin-top: 0; margin-bottom: 12px; font-weight: bold;">Đăng nhập hệ thống</h2>
            <p style="color: #64748b; font-size: 14px; margin-bottom: 30px; line-height: 1.5;">
                Đăng nhập nhanh chỉ bằng <b>1 chạm</b> với tài khoản Google để trao đổi đồ cũ sinh viên PTIT.
            </p>

            <% String error = (String) request.getAttribute("error"); %>
            <% if (error != null) { %>
                <p style="color: #dc2626; font-weight: bold; margin-bottom: 20px; font-size: 14px; background: #fee2e2; padding: 10px; border-radius: 8px;"><%= error %></p>
            <% } %>

            <!-- Google Sign-In Init -->
            <div id="g_id_onload"
                 data-client_id="980739889720-ksura55kif5hdkoua7ggq9cqsotontdt.apps.googleusercontent.com"
                 data-callback="handleCredentialResponse"
                 data-auto_prompt="false">
            </div>

            <!-- Nút Đăng nhập Google Nền Đỏ PTIT -->
            <div onclick="triggerGoogleLogin()" 
                 style="background-color: #7A1E28; color: white; padding: 12px 20px; border-radius: 30px; font-weight: bold; font-size: 15px; cursor: pointer; display: flex; align-items: center; justify-content: center; gap: 12px; box-shadow: 0 4px 14px rgba(122, 30, 40, 0.3); transition: all 0.2s ease; margin: 20px 0;"
                 onmouseover="this.style.backgroundColor='#601820';" 
                 onmouseout="this.style.backgroundColor='#7A1E28';">
                <div style="background: white; border-radius: 50%; padding: 6px; display: flex; align-items: center; justify-content: center;">
                    <svg width="18" height="18" viewBox="0 0 48 48">
                        <path fill="#EA4335" d="M24 9.5c3.54 0 6.71 1.22 9.21 3.6l6.85-6.85C35.9 2.38 30.47 0 24 0 14.62 0 6.51 5.38 2.56 13.22l7.98 6.19C12.43 13.72 17.74 9.5 24 9.5z"/>
                        <path fill="#4285F4" d="M46.98 24.55c0-1.57-.15-3.09-.38-4.55H24v9.02h12.94c-.58 2.96-2.26 5.48-4.78 7.18l7.73 6c4.51-4.18 7.09-10.36 7.09-17.65z"/>
                        <path fill="#FBBC05" d="M10.53 28.59c-.48-1.45-.76-2.99-.76-4.59s.28-3.14.76-4.59l-7.98-6.19C.92 16.46 0 20.12 0 24c0 3.88.92 7.54 2.55 10.78l7.98-6.19z"/>
                        <path fill="#34A853" d="M24 48c6.48 0 11.93-2.13 15.89-5.81l-7.73-6c-2.15 1.45-4.92 2.3-8.16 2.3-6.26 0-11.57-4.22-13.47-9.91l-7.98 6.19C6.51 42.62 14.62 48 24 48z"/>
                    </svg>
                </div>
                <span>Tiếp tục sử dụng dịch vụ bằng Google</span>
            </div>

            <!-- Phao ẩn chứa nút Google gốc -->
            <div style="opacity: 0; position: absolute; pointer-events: none;">
                <div class="g_id_signin" data-type="standard"></div>
            </div>

            <p style="margin-top: 25px; font-size: 12px; color: #94a3b8; line-height: 1.4;">
                Dịch vụ được xác thực an toàn bởi Google.
            </p>

        </div>

    </div>

    <footer>
        <p>&copy; 2026 Trao Đổi Đồ Cũ - Hệ thống trao đổi đồ cũ sinh viên PTIT.</p>
    </footer>

</body>
</html>