# TÀI LIỆU HƯỚNG DẪN - DỰ ÁN FLUTTER CHATBOT AI
> **Lưu ý dành cho sinh viên thực hành:**
> Vui lòng xem chi tiết yêu cầu, mục tiêu và hướng dẫn của bài Lab tại file [LAB_INSTRUCTIONS.md](LAB_INSTRUCTIONS.md).

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

### 4.1. Yêu cầu Môi trường & Công cụ chuẩn bị
Trước khi khởi chạy dự án, hãy đảm bảo máy tính đã được cài đặt:
* **Flutter SDK:** Phiên bản 3.x trở lên (đã cấu hình biến môi trường `PATH`).
* **Trình soạn thảo / IDE:**
    * **Android Studio** (Khuyên dùng - đã cài plugin Flutter & Dart).
* **Thiết bị chạy ứng dụng:**
    * *Tùy chọn 1 (Tiện lợi nhất):* **Windows Desktop** (Không tốn RAM, gõ tiếng Việt có dấu trực tiếp bằng Unikey siêu mượt).
    * *Tùy chọn 2 (Chuẩn di động):* **Máy ảo Android Emulator** (Pixel / API 30+).
* **Tài khoản Groq Cloud:** Để lấy API Key AI miễn phí.

---

### 4.2. Các bước thực hiện chi tiết

#### Bước 1: Mở dự án và Kiểm tra môi trường
1. Mở **Android Studio** -> Chọn **Open** -> Điều hướng đến thư mục dự án `flutter_labs`.
2. Mở cửa sổ **Terminal** tích hợp sẵn trong IDE (hoặc mở PowerShell tại thư mục dự án).
3. Gõ lệnh kiểm tra hệ thống:
   ```bash
   flutter doctor
   ```
4. Đảm bảo mục `[✓] Flutter` và `[✓] Android toolchain` hiển thị tích xanh. Nếu thiếu công cụ nào, hãy làm theo hướng dẫn tại màn hình console để hoàn tất.

#### Bước 2: Cấu hình và Cài đặt thư viện (`pubspec.yaml`)
1. Trong cây thư mục bên trái, mở file `pubspec.yaml`.
2. Tìm đến phần `dependencies:` và kiểm tra/bổ sung 2 thư viện cần thiết:
   ```yaml
   dependencies:
     flutter:
       sdk: flutter
     cupertino_icons: ^1.0.8

     # 2 thư viện bắt buộc cho đồ án Chatbot AI:
     http: ^1.2.0                  # Gửi yêu cầu RESTful API (POST) đến Groq AI
     shared_preferences: ^2.2.3    # Lưu trữ token xác thực và dữ liệu cục bộ
   ```
   > **Lưu ý định dạng YAML:** Thụt đầu dòng đúng **2 khoảng trắng (space)**, tuyệt đối không dùng phím `Tab` hoặc thụt lề sai hàng sẽ gây lỗi cú pháp.

3. **Tải các gói thư viện về máy:**
    * **Cách 1 (Bằng chuột):** Nhìn lên góc trên bên phải thanh soạn thảo file `pubspec.yaml`, nhấn vào nút **Pub get** (hoặc biểu tượng mũi tên tải xuống).
    * **Cách 2 (Bằng dòng lệnh):** Trong cửa sổ Terminal, gõ lệnh:
      ```bash
      flutter pub get
      ```
    * *Kết quả thành công:* Terminal xuất hiện dòng chữ `Process finished with exit code 0` (hoặc thông báo `Got dependencies!`).

#### Bước 3: Lấy và Cấu hình Groq API Key
1. **Đăng ký lấy API Key miễn phí:**
    * Truy cập trang quản lý Groq Console: [https://console.groq.com/keys](https://console.groq.com/keys).
    * Đăng nhập bằng tài khoản Google hoặc GitHub.
    * Nhấn nút **Create API Key**.
    * Đặt tên gợi nhớ (ví dụ: `flutter_chat_key`) rồi bấm **Submit**.
    * Bấm nút **Copy** để sao chép chuỗi mã (có dạng: `gsk_xxxxxxxxxxxxxxxxxxxxxx`). *Lưu ý: Hãy lưu lại mã này ở nơi an toàn vì hệ thống chỉ hiển thị nó một lần duy nhất.*
2. **Cập nhật mã khóa vào mã nguồn dự án:**
    * Mở file `lib/services/ai_service.dart`.
    * Tìm đến hằng số khai báo `_apiKey`:
      ```dart
      static const String _apiKey = 'gsk_your_groq_api_key_here';
      ```
    * Dán mã API Key bạn vừa copy vào giữa hai dấu nháy đơn.

#### Bước 4: Lựa chọn & Khởi động Thiết bị chạy thử
Bạn có thể chọn 1 trong 2 hình thức chạy sau tùy vào cấu hình máy tính:

* **Tùy chọn A: Chạy trên máy ảo Android (Android Emulator)**
    1. Trong Android Studio, vào menu **Tools** -> chọn **Device Manager** (hoặc icon điện thoại ở góc phải).
    2. Bấm nút **Play (▶️)** tại máy ảo bạn đã tạo (ví dụ: *Pixel 6 Pro API 34*) để bật máy ảo.
    3. Đợi 1-2 phút cho điện thoại ảo khởi động hoàn tất đến màn hình chính.
    4. Trên thanh công cụ chính của IDE, tại menu xổ xuống chọn thiết bị (Device Selector), hãy chọn tên máy ảo vừa mở.

* **Tùy chọn B: Chạy trên Windows Desktop (Khuyên dùng khi máy yếu hoặc demo)**
    1. Tại menu chọn thiết bị (Device Selector) trên thanh công cụ của IDE, chọn mục **Windows (windows-x64)**.
    2. Ưu điểm: Khởi động trong vòng 3 - 5 giây, không tốn RAM chạy máy ảo, gõ tiếng Việt có dấu bằng Unikey hoàn toàn bình thường.


#### Bước 5: Biên dịch và Khởi chạy ứng dụng (Run App)
* **Cách 1 (Chạy bằng giao diện IDE):**
    1. Mở file `lib/main.dart`.
    2. Đảm bảo thiết bị chạy thử đã được chọn ở thanh công cụ.
    3. Nhấn vào nút **Run (Biểu tượng tam giác xanh ▶️)** hoặc nhấn tổ hợp phím `Shift + F10` (trên Android Studio).
* **Cách 2 (Chạy bằng dòng lệnh Terminal):**
    1. Kiểm tra danh sách thiết bị đang kết nối:
       ```bash
       flutter devices
       ```
    2. Khởi chạy ứng dụng:
       ```bash
       flutter run
       ```

---

### 4.3. Xử lý các sự cố thường gặp (Troubleshooting)

1. **Lỗi cú pháp khi chạy `flutter pub get`:**
    * *Hiện tượng:* Báo lỗi `Error on line xx of pubspec.yaml: mapping values are not allowed here...`
    * *Nguyên nhân:* Thụt dòng không chuẩn (thường do dùng phím Tab hoặc lùi cách không đều nhau).
    * *Khắc phục:* Đặt con trỏ chuột trước tên thư viện `http:` và `shared_preferences:`, xóa hết khoảng trắng về sát mép trái, sau đó nhấn phím Space đúng 2 lần để thẳng hàng với các thuộc tính bên trong `dependencies`.

2. **Lỗi mạng khi bấm gửi tin nhắn (`SocketException` hoặc không thấy AI phản hồi):**
    * *Hiện tượng:* App báo lỗi mạng hoặc quay vòng tròn loading mãi không dừng.
    * *Khắc phục:*
        * Kiểm tra máy tính có kết nối Internet không.
        * Kiểm tra lại chuỗi `_apiKey` trong `ai_service.dart` có bị thừa khoảng trắng hoặc sai ký tự nào không.
        * Mở Groq Console kiểm tra xem tài khoản có bị hết hạn mức (rate limit) hay không.

3. **Lỗi không gõ được Tiếng Việt có dấu trên máy ảo Android:**
    * *Hiện tượng:* Khi gõ tiếng Việt bằng Unikey trên máy tính, chữ trên máy ảo bị nhảy ký tự lạ hoặc mất dấu.
    * *Khắc phục:*
        * *Giải pháp 1 (Nhanh nhất):* Gõ sẵn câu hỏi tiếng Việt bên ngoài Notepad, nhấn `Ctrl + C`, sau đó vào ô chat trên máy ảo bấm `Ctrl + V` (dán vào).
        * *Giải pháp 2 (Chuẩn nhất):* Cài **Gboard Tiếng Việt** trực tiếp trên máy ảo: Vào `Settings` -> `System` -> `Languages & input` -> `Keyboard apps` -> `Gboard` -> `Languages` -> `Add keyboard` -> Chọn `Vietnamese (Telex)` -> Nhấn `Done`. Khi gõ, nhấn giữ phím Space để chuyển sang tiếng Việt.
        * *Giải pháp 3:* Đổi thiết bị sang **Windows Desktop** để demo trực tiếp.

---

## 5. Hướng dẫn Sử dụng (Dành cho Demo)

1. **Màn hình Đăng nhập:** Khi mới mở app, bạn chưa có tài khoản. Hãy bấm vào nút **"Đăng ký ngay"** ở dưới cùng.
2. **Màn hình Đăng ký:** Nhập một email bất kỳ (ví dụ: `admin@gmail.com`), nhập mật khẩu (tối thiểu 6 ký tự) và xác nhận lại mật khẩu. Bấm **Đăng ký**.
3. **Đăng nhập:** Ứng dụng sẽ quay lại màn hình cũ. Bạn nhập đúng Email và Mật khẩu vừa tạo để tiến vào màn hình Chat.
4. **Chat với AI:** Gõ bất kỳ câu hỏi nào vào ô nhập liệu (Ví dụ: "Viết cho tôi một bài thơ về lập trình viên") và bấm nút Gửi. Đợi 1-2 giây, AI sẽ trả lời bạn cực kỳ thông minh! 

---
