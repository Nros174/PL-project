import re

def validate_email(email: str) -> bool:
    # รูปแบบที่ต้องการของอีเมล
    regex = r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
    
    # ตรวจสอบว่าตรงกับรูปแบบที่กำหนดหรือไม่
    if re.match(regex, email):
        # ตรวจสอบว่าอีเมลไม่ขึ้นต้นด้วย '.', '@' หรือ 'www.'
        if not (email.startswith('.') or email.startswith('@') or email.startswith('www.')):
            return True
    return False

def test_validate_email():
    # ลิสต์ของอีเมลที่จะทดสอบ
    emails = [
        "avc@abc.com",
        "www.abc@abc.com",
        "@abc.abc.com",
        ".abc@abc.com",
        "abc@abc.c"
    ]
    
    # ทดสอบอีเมลทีละตัว
    for email in emails:
        if validate_email(email):
            print(f"{email} is a valid email")
        else:
            print(f"{email} is not a valid email")

# เรียกใช้ฟังก์ชันทดสอบ
test_validate_email()
