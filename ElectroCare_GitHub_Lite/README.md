# ElectroCare — Hệ thống quản lý sửa chữa thiết bị điện tử

ElectroCare là website quản lý sửa chữa theo 3 vai trò **Khách hàng / Kỹ thuật viên / Quản trị viên**, dùng Node.js + Express + MySQL/MariaDB (XAMPP) và Gemini API.

## Chạy trên Windows

1. Bật **Apache** và **MySQL** trong XAMPP.
2. Mở `http://localhost/phpmyadmin` và import `co-so-du-lieu/tao-co-so-du-lieu.sql`.
3. Mở `may-chu/.env` và điền `GEMINI_API_KEY` của bạn.
4. Chạy `CAI_DAT_ELECTROCARE.bat` một lần.
5. Chạy `CHAY_ELECTROCARE.bat`.
6. Mở `http://localhost:5173`.
7. Kiểm tra API/CSDL tại `http://localhost:3000/api/health`; kết quả đúng có `database: true`.

> **AI không còn chế độ mô phỏng.** Nếu chưa có Gemini API key, API AI sẽ báo cần cấu hình key thay vì tự tạo kết quả giả.

## 1. Khách hàng

- Đăng ký/đăng nhập thật, tài khoản được lưu trong MySQL/MariaDB.
- AI chẩn đoán bằng **Gemini API thật**, nhận triệu chứng và ảnh.
- AI trả về khả năng lỗi, dịch vụ đề xuất, linh kiện có thể liên quan và khoảng giá tham khảo lấy từ danh mục ElectroCare.
- Nút **Đặt lịch sửa chữa ngay** từ kết quả AI đưa khách sang trang đặt lịch và giữ lại thiết bị/triệu chứng/dịch vụ AI đề xuất.
- Đặt **một hoặc nhiều dịch vụ**.
- Xem khoảng giá từng dịch vụ trước khi đặt.
- Xem danh mục linh kiện theo loại, giá thấp/cao, thông số và dung lượng (RAM, SSD, pin, quạt...).
- Theo dõi trạng thái, tiến độ, nhật ký xử lý, báo giá và bảo hành.

## 2. Quy trình kỹ thuật viên

Trạng thái phiếu được kiểm soát theo luồng nghiệp vụ:

`Đã đặt lịch → Đã tiếp nhận → Đã phân công → Đang kiểm tra → Chờ duyệt báo giá → Đang sửa chữa → Kiểm tra chất lượng → Sẵn sàng bàn giao → Đã bàn giao`

Kỹ thuật viên không thể tự chuyển phiếu sang trạng thái không hợp lệ.

Dashboard kỹ thuật viên có các nhóm:

- **Sắp tới bàn giao**
- **Chưa tới bàn giao**
- **Chưa hoàn thành**
- **Sẵn sàng bàn giao**
- **Đã xong**
- **Quá hạn bàn giao**

Ngoài ra có:

- Phiếu được phân công cho chính kỹ thuật viên.
- Lịch bàn giao dự kiến.
- Cập nhật tiến độ và ghi chú kỹ thuật.
- Lập báo giá nhân công + linh kiện.
- Checklist kiểm tra chất lượng trước bàn giao.
- Chỉ được xác nhận **Đã bàn giao** khi phiếu đã ở trạng thái sẵn sàng, checklist tồn tại và báo giá (nếu có) đã được khách hàng duyệt.
- Nhật ký xử lý lưu theo từng phiếu.

## 3. Quản trị viên

Dashboard quản trị gồm:

- Tổng số phiếu.
- Phiếu đang xử lý.
- Phiếu sẵn sàng bàn giao.
- Phiếu quá hạn bàn giao.
- Tổng khách hàng.
- Tổng kỹ thuật viên.
- Danh sách tất cả phiếu.
- Phân công kỹ thuật viên.
- Theo dõi tải công việc của từng kỹ thuật viên.
- Quản lý người dùng.
- Quản lý danh mục linh kiện và tồn kho qua API quản trị.

Admin có thể phân công lại phiếu nhưng không thể phân công phiếu đã bàn giao hoặc đã hủy.

## 4. Database

Database: `electrocare_v2`

Các bảng chính:

- `users`
- `services`
- `parts`
- `part_compatibility`
- `bookings`
- `booking_services`
- `booking_parts`
- `repair_logs`
- `repair_quotes`
- `checklists`
- `reviews`
- `vouchers`
- `stores`

Đặc biệt `booking_services` cho phép một phiếu có **nhiều dịch vụ**.

## 5. Gemini API

Trong `may-chu/.env`:

```env
GEMINI_API_KEY=YOUR_GEMINI_API_KEY
GEMINI_MODEL=gemini-2.5-flash
```

Không đưa API key lên GitHub.

## 6. Tài khoản demo

Mật khẩu demo: `123456`

- Khách hàng: `customer@electrocare.local`
- Kỹ thuật viên: `staff@electrocare.local`
- Quản trị viên: `admin@electrocare.local`

Mã mời mặc định:

- Staff: `STAFF-2026`
- Admin: `ADMIN-2026`

Có thể đổi mã trong `.env` bằng `STAFF_INVITE_CODE` và `ADMIN_INVITE_CODE`.

## 7. Giá

Giá trên website là **giá tham khảo**. Giá sửa chữa cuối cùng phải do kỹ thuật viên kiểm tra thực tế, lập báo giá và khách hàng duyệt trước khi sửa.
