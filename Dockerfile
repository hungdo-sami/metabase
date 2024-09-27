# Sử dụng OpenJDK 17 như là image cơ sở
FROM openjdk:17-jdk-slim

# Đặt biến môi trường cho thư mục làm việc và file cơ sở dữ liệu
ENV MB_HOME=/metabase
ENV MB_DB_FILE=/metabase-data/metabase.db

# Tạo thư mục cần thiết
RUN mkdir -p ${MB_HOME} ${MB_HOME}/data

# Cài đặt wget và tải xuống Metabase từ link chính xác
RUN apt-get update && apt-get install -y wget && \
    wget -O ${MB_HOME}/metabase.jar https://downloads.metabase.com/enterprise/v1.50.27/metabase.jar && \
    apt-get remove -y wget && apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

# Lệnh để chạy Metabase
CMD ["java", "-jar", "/metabase/metabase.jar"]
