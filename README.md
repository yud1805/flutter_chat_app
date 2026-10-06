# TÀI LIỆU HƯỚNG DẪN - DỰ ÁN FLUTTER CHATBOT AI

## 1. Giới thiệu chung
Đây là ứng dụng Chatbot AI được phát triển bằng nền tảng **Flutter**, tích hợp toàn diện kiến thức từ **Module 8 (RESTful APIs & JSON)** và **Module 10 (Giao diện & Logic hoàn chỉnh)**. 

Ứng dụng cho phép người dùng tạo tài khoản, đăng nhập và trò chuyện trực tiếp với Trí tuệ nhân tạo (AI) thông qua việc kết nối với API của hệ thống Groq (Sử dụng model mã nguồn mở tiên tiến nhất).

---

## 2. Các chức năng nổi bật
*   **Hệ thống Xác thực (Authentication):** Hỗ trợ Đăng ký và Đăng nhập. Dữ liệu tài khoản được lưu trữ an toàn ngay trên bộ nhớ cục bộ của thiết bị thông qua `SharedPreferences`. Có bắt lỗi nhập liệu (Validation) chặt chẽ.
*   **Giao diện chuẩn Material Design:** 
    * Hiệu ứng Gradient hiện đại.
    * Giao diện Chat bong bóng (Chat Bubble) trực quan giống hệt Zalo/Messenger.
    * Tự động cuộn (Auto-scroll) xuống tin nhắn mới nhất.
*   **Tích hợp RESTful API:** 
    * Sử dụng phương thức `HTTP POST` để gửi tin nhắn đến máy chủ AI.
    * Xử lý và bóc tách dữ liệu JSON `jsonDecode` để lấy câu trả lời.
    * Hiển thị trạng thái "AI đang soạn tin..." (Loading indicator) trong lúc chờ.

---

## 3. Cấu trúc thư mục dự án
Dự án được phân chia thành 3 lớp chính (MVC pattern) để dễ quản lý:

```text
lib/
├── models/
│   └── chat_message.dart      # Định nghĩa cấu trúc tin nhắn (id, text, sender)
├── screens/
│   ├── login_screen.dart      # Giao diện Đăng nhập
│   ├── register_screen.dart   # Giao diện Đăng ký
│   └── chat_screen.dart       # Giao diện Trò chuyện với AI
├── services/
│   ├── auth_service.dart      # Xử lý logic Đăng nhập/Đăng ký/Lưu token
│   └── ai_service.dart        # Xử lý kết nối mạng, gọi API Groq
└── main.dart                  # File khởi chạy cấu hình Routes
```

---

## 4. Hướng dẫn Cài đặt & Khởi chạy

**Bước 1: Tải các thư viện cần thiết**
Mở file `pubspec.yaml`, đảm bảo bạn đã khai báo 2 thư viện sau:
```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.2.0
  shared_preferences: ^2.2.3
```
Sau đó bấm nút **Pub get** (hoặc chạy lệnh `flutter pub get` trong Terminal) để tải thư viện.

**Bước 2: Thay đổi API Key (Nếu cần)**
* Mở file `lib/services/ai_service.dart`.
* Tìm biến `_apiKey` và thay bằng mã API Key Groq của bạn nếu muốn sử dụng tài khoản khác.
* *Lưu ý:* Hệ thống đang dùng model `openai/gpt-oss-20b`.

**Bước 3: Chạy ứng dụng**
* Khuyên dùng chạy trên **Windows (desktop)** hoặc **Máy ảo Android** để tránh lỗi chặn mạng CORS của trình duyệt Web.
* Bấm nút **Run (Tam giác xanh)** trên Android Studio hoặc dùng lệnh `flutter run`.

---

## 5. Hướng dẫn Sử dụng (Dành cho Demo)

1. **Màn hình Đăng nhập:** Khi mới mở app, bạn chưa có tài khoản. Hãy bấm vào nút **"Đăng ký ngay"** ở dưới cùng.
2. **Màn hình Đăng ký:** Nhập một email bất kỳ (ví dụ: `admin@gmail.com`), nhập mật khẩu (tối thiểu 6 ký tự) và xác nhận lại mật khẩu. Bấm **Đăng ký**.
3. **Đăng nhập:** Ứng dụng sẽ quay lại màn hình cũ. Bạn nhập đúng Email và Mật khẩu vừa tạo để tiến vào màn hình Chat.
4. **Chat với AI:** Gõ bất kỳ câu hỏi nào vào ô nhập liệu (Ví dụ: "Viết cho tôi một bài thơ về lập trình viên") và bấm nút Gửi. Đợi 1-2 giây, AI sẽ trả lời bạn cực kỳ thông minh! 

---
