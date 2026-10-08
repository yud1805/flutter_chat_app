# BÀI LAB: Xây Dựng Trợ Lý Chatbot AI Với Flutter

## 🎯 Mục Tiêu Bài Lab
Sau bài Lab này, sinh viên có thể:
* Hiểu nguyên lý hoạt động của Chat UI, cấu trúc dữ liệu tin nhắn hai chiều và luồng xử lý bất đồng bộ (`Future`/`Stream`).
* Xây dựng giao diện trò chuyện hoàn chỉnh (Chat Bubbles, Auto-scroll, Typing Indicator).
* Thành thạo kỹ thuật kết nối RESTful API, cấu hình Headers xác thực (Bearer Token / API Key) và bóc tách cấu trúc dữ liệu JSON đa tầng.
* Xử lý ngoại lệ mạng thực tế (`SocketException`, mã lỗi HTTP 404, 429 Rate Limit, 503 Overloaded).
* Nhận biết vai trò của Prompt, System Message, Token, Context Window và cơ chế duy trì ngữ cảnh hội thoại (Multi-turn Conversation).

> **💡 Yêu cầu chung:** Mỗi câu tập trung vào một cấp độ tăng tiến: Mô phỏng Chat UI trên DartPad ➔ Kết nối RESTful API thật ➔ Nâng cao với Context đa lượt hoặc Streaming. Ưu tiên luồng hoạt động chuẩn xác, kiến trúc code phân tầng rõ ràng (`models`, `services`, `screens`) và sinh viên có thể tự tin giải thích từng dòng code.

---

## 📝 Nội Dung Thực Hành

### 🟢 Question 1 — Mock Chatbot AI trên DartPad
**Mục đích:** Nắm vững cấu trúc dữ liệu tin nhắn, quản lý State của danh sách chat và tư duy UI/UX trò chuyện mà chưa cần đụng đến API Key hay kết nối mạng thật.

**Yêu cầu:**
1. Tạo một file Flutter duy nhất chạy trực tiếp trên DartPad (không cần cài package).
2. Định nghĩa Model `ChatMessage` gồm: nội dung (`text`), định danh người gửi (`isUser: bool`), thời gian (`timestamp`).
3. Xây dựng giao diện: AppBar, Danh sách tin nhắn dạng bong bóng (Chat Bubble), Khung nhập liệu ở đáy màn hình.
4. Khi gửi tin: Hiển thị trạng thái "AI đang suy nghĩ...". Tạo `MockAiService` dùng `Future.delayed(Duration(seconds: 1))` giả lập độ trễ mạng và trả về câu trả lời mẫu.
5. Tự động cuộn màn hình (`ScrollController`) xuống tin nhắn mới nhất.

### 🟡 Question 2 — Basic Chatbot AI với RESTful API Thật
**Mục đích:** Giao tiếp thực tế với hệ thống máy chủ AI (Groq / Google AI Studio / OpenAI) thông qua HTTP POST.

**Yêu cầu:**
1. Tạo dự án Flutter với cấu trúc phân tầng (`models/`, `services/`, `screens/`).
2. Cài đặt thư viện truyền dẫn mạng (`http` hoặc `dio`).
3. **Tầng AiService:** Gửi HTTP POST payload JSON chứa Model ID và prompt. Cấu hình Headers: `Content-Type: application/json` và `Authorization: Bearer <API_KEY>`.
4. **Xử lý phản hồi:**
    - HTTP 200: Bóc tách cây JSON đa tầng để lấy chuỗi văn bản trả lời của AI.
    - Lỗi mạng: Dùng `try-catch` bắt ngoại lệ, hiển thị thông báo thay vì để crash ứng dụng.
5. *Lưu ý bảo mật:* Tuyệt đối không commit/push mã API Key bí mật lên GitHub.

### 🔴 Question 3 — Nâng cao: Multi-turn Context hoặc Streaming Response
**Mục đích:** Nâng tầm chatbot thành trợ lý thông minh. Sinh viên chọn 1 trong 2 hướng. *(Yêu cầu chung: Thiết lập System Message và bắt lỗi 429/503).*

* **Hướng A — Duy trì ngữ cảnh hội thoại (Multi-turn Context):** Tầng Service phải chuyển đổi toàn bộ danh sách `List<ChatMessage>` thành mảng `messages` chuẩn JSON gửi lên server. Kết quả là AI trả lời đúng câu hỏi dựa vào bối cảnh tin nhắn cũ.
* **Hướng B — Phản hồi dòng thời gian thực (Streaming Response):** Bật cờ `"stream": true`. Lắng nghe luồng dữ liệu (SSE) và cập nhật liên tục vào tin nhắn cuối cùng để chữ xuất hiện mượt mà theo thời gian thực.

---

## 📚 Thuật Ngữ Cần Biết
* **LLM (Large Language Model):** Mô hình ngôn ngữ lớn (như GPT, Llama, Gemini).
* **Prompt & System Message:** Câu lệnh đầu vào và câu chỉ thị hệ thống đứng đầu để định hình phong cách AI.
* **Stateless:** API phi trạng thái, server không lưu bộ nhớ phiên giữa các lần gọi.
* **Rate Limit:** Hạn mức gọi API (ví dụ: HTTP 429).
* **Streaming (SSE):** Truyền dữ liệu một chiều liên tục từ server về client.

---

## 📦 Yêu Cầu Nộp Bài
1. **Mã nguồn (Source code):** Đầy đủ cả 3 câu (chia nhánh hoặc tách thư mục rõ ràng).
2. **Minh chứng chạy:** Ảnh/Video demo DartPad, gọi API thật, nhớ ngữ cảnh hoặc streaming.
3. **Tài liệu README:** Hướng dẫn điền API Key và cách chạy.
4. **Vấn đáp:** Giải thích đường đi của gói tin: từ lúc ấn nút ➔ Headers/Body ➔ HTTP Status ➔ Parsing JSON ➔ Cập nhật UI.
