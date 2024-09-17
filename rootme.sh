#!/bin/bash

# به‌روزرسانی و ارتقای لیست بسته‌ها
apt update && apt upgrade -y

# نصب بسته‌های مورد نیاز
PACKAGES="wget openssl-tool proot bash nano neofetch"
apt install $PACKAGES -y

# پیکربندی ذخیره‌سازی Termux
termux-setup-storage

# ایجاد یک نسخه‌ی پشتیبان از bash.bashrc
cd /data/data/com.termux/files/usr/etc/
cp bash.bashrc bash.bashrc.bak

# دانلود و اجرای اسکریپت نصب Kali Linux
cd /data/data/com.termux/files/usr/etc/Root
wget https://raw.githubusercontent.com/EXALAB/AnLinux-Resources/master/Scripts/Installer/Kali/kali.sh
bash kali.sh

# پیکربندی سیستم بر اساس انتخاب کاربر
read -p "لطفاً انتخاب خود را وارد کنید (۱ برای Boot2Root یا ۲ برای JustRoot): " choice

case $choice in
  1)
    # اگر کاربر انتخاب ۱ (Boot2Root) را وارد کند، این قسمت از اسکریپت یک خط را به فایل bash.bashrc اضافه می‌کند تا اسکریپت start-kali.sh در هنگام بوت اجرا شود.
    echo "bash /data/data/com.termux/files/usr/etc/Root/start-kali.sh" >> /data/data/com.termux/files/usr/etc/bash.bashrc
    echo "لطفاً Termux را مجدداً راه‌اندازی کنید تا به عنوان کاربر ریشه وارد شوید"
    ;;
  2)
    # اگر کاربر انتخاب ۲ (JustRoot) را وارد کند، این قسمت از اسکریپت یک alias را به فایل bash.bashrc اضافه می‌کند تا اسکریپت start-kali.sh با دستور rootme اجرا شود.
    echo "alias rootme='bash /data/data/com.termux/files/usr/etc/Root/start-kali.sh'" >> /data/data/com.termux/files/usr/etc/bash.bashrc
    cd /data/data/com.termux/files/usr/etc
    source bash.bashrc
    echo "لطفاً Termux را مجدداً راه‌اندازی کنید و دستور rootme را وارد کنید تا به عنوان کاربر ریشه وارد شوید"
    ;;
  *)
    # اگر کاربر انتخابی را وارد نکند، این قسمت از اسکریپت یک پیام خطا را نمایش می‌دهد.
    echo "انتخاب نامعتبر است. لطفاً دوباره تلاش کنید."
    exit
    ;;
esac
