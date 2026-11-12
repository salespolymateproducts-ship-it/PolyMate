# ใช้ Nginx เวอร์ชัน Alpine เป็น Base Image (ขนาดเล็กและโหลดเร็ว)
FROM nginx:alpine

# (ทางเลือก) ลบหน้าเว็บตั้งต้นของ Nginx ทิ้งไปก่อนเพื่อความสะอาด
RUN rm -rf /usr/share/nginx/html/*

# คัดลอกไฟล์ HTML และโฟลเดอร์ทั้งหมด (เช่น css, js, images) จากเครื่องเรา 
# ไปไว้ในโฟลเดอร์ที่ Nginx ใช้สำหรับเสิร์ฟหน้าเว็บ
COPY . /usr/share/nginx/html

# ใช้ nginx.conf ของเราแทน default.conf (ตั้ง absolute_redirect off เพื่อไม่ให้ redirect ตกไป HTTP)
# แล้วลบสำเนาใน web root ออก ไม่ให้เว็บเสิร์ฟไฟล์ config ออกสู่สาธารณะ
COPY nginx.conf /etc/nginx/conf.d/default.conf
RUN rm -f /usr/share/nginx/html/nginx.conf

# เปิดพอร์ต 80 เพื่อให้ภายนอกสามารถเข้ามาเชื่อมต่อได้
EXPOSE 80

# คำสั่งสำหรับรัน Nginx ให้อยู่เบื้องหลัง (ปกติ Base Image มีให้อยู่แล้ว แต่ระบุไว้เพื่อความชัดเจน)
CMD ["nginx", "-g", "daemon off;"]