Trong bài viết trước, chúng ta đã khám phá Power BI và một số công cụ trực quan hóa dữ liệu hiện có trên thị trường. Mặc dù Power BI mang lại những tính năng vượt trội với sức mạnh và khả năng trực quan hóa dữ liệu ấn tượng, nhưng nó vẫn tồn tại những hạn chế. Chính vì vậy, mình đã quyết định tìm hiểu thêm về một giải pháp khác có thể đáp ứng đầy đủ hơn nhu cầu hiện tại của mình.

Hôm nay, chúng ta sẽ cùng tìm hiểu cách thiết lập Metabase - một công cụ mã nguồn mở mạnh mẽ và dễ sử dụng, lý tưởng cho việc trực quan hóa dữ liệu và xây dựng báo cáo. So với Power BI, Metabase có những lợi thế đáng kể như miễn phí, dễ triển khai và phù hợp với các nhóm nhỏ hoặc những công ty không có ngân sách lớn cho các công cụ BI. Hãy cùng nhau khám phá công cụ này để xem nó có thể giúp bạn trong việc phân tích dữ liệu như thế nào!

1. Sơ qua về Metabase

Metabase là một công cụ mã nguồn mở mạnh mẽ cho việc trực quan hóa dữ liệu và xây dựng báo cáo. Ứng dụng cho phép người dùng tương tác với dữ liệu thông qua SQL, cung cấp trình chỉnh sửa SQL trực quan để viết và lưu truy vấn giúp việc viết và lưu trữ truy vấn trở nên dễ dàng hơn bao giờ hết.. Người dùng có thể tạo Dashboard từ các truy vấn đã lưu và dễ dàng chia sẻ chúng với các thành viên khác trong tổ chức. 

Metabase hỗ trợ nhiều loại cơ sở dữ liệu khác nhau, giúp khai thác dữ liệu hiệu quả và nhanh chóng. Một điểm nổi bật nữa là Metabase cung cấp tính năng hỏi đáp (Q&A) cho phép người dùng không chuyên về kỹ thuật cũng có thể dễ dàng truy vấn dữ liệu chỉ với những câu hỏi tự nhiên.

Tại sao lại lựa chọn Metabase?

Trong khi Power BI Service chỉ cho phép làm mới dữ liệu mỗi 30 phút cho cơ sở dữ liệu hiện tại, mình cần một giải pháp linh hoạt hơn để tăng cường tần suất và tốc độ làm mới dữ liệu. Metabase cho phép làm mới dữ liệu mình thiểu 1 phút một lần, đáp ứng nhanh chóng nhu cầu phân tích và báo cáo của tổ chức.

2. Cài đặt Metabase
2.1. Chuẩn bị mã nguồn và những file cần thiết
Trong hướng dẫn này, mình sẽ sử dụng một máy chủ ảo trên Google Cloud Platform (GCP) với cấu hình như sau:

Hệ điều hành: Ubuntu 20.04 LTS
CPU: 2 vCPU
RAM: 8 GB
Ổ đĩa: 50 GB

Mình sẽ sử dụng Docker để quản lý và triển khai ứng dụng Metabase.

Các bạn clone repository này về hungdo-sami/metabase, trong đó có chứa các file cần thiết để cài đặt Metabase.

git clone https://github.com/hungdo-sami/metabase.git
2.2. Cấu hình cài đặt
Dưới đây là cấu trúc thư mục của Metabase mà chúng ta sẽ sử dụng:

/metabase        # Thư mục chính chứa các thành phần của Metabase
│
├── Dockerfile    # File Dockerfile để build image
│
├── docker-compose.yml # File cấu hình Docker Compose 
│
└── install_docker.sh      # Script cài đặt Docker
Chuyển đến thư mục làm việc.

cd metabase
Nếu đây là lần đầu bạn sử dụng Docker, mình có kèm sẵn trong folder file "install_docker.sh" chứa các script hỗ trợ cài đặt Docker và Docker Compose, để cài đặt bạn sử dụng lệnh sau:

chmod +x install_docker.sh  # Cấp quyền thực thi 
./install_docker.sh       # Chạy Script để cài đặt
Tiếp theo, bạn sẽ build image cho Metabase bằng lệnh sau:

docker build -t metabase-custom ~/metabase
Các bạn chờ một chút để quá trình build image được hoàn tất nhé.


Quá trình build image hoàn tất
2.3. Khởi Động Metabase
Dưới đây là nội dung file docker-compose.yml sẽ sử dụng để cấu hình Docker Compose cho Metabase:

services:
  metabase:
    image: metabase-custom
    container_name: metabase
    ports:
      - 3000:3000
    environment:
      - MB_DB_FILE=/metabase-data/metabase.db
    volumes:
      - ./metabase-data:/metabase-data
      - ./drivers:/plugins
    restart: always
Khởi động Metabase bằng lệnh:

docker-compose up -d
2.4. Truy cập và sử dụng
Đối với localhost: Nếu bạn đang chạy Docker trên máy tính của mình, bạn có thể truy cập Metabase bằng cách nhập vào thanh địa chỉ: http://localhost:3000
Đối với địa chỉ IP bên ngoài: Nếu bạn đang chạy Docker trên một máy chủ từ xa hoặc một máy ảo, bạn sẽ cần sử dụng địa chỉ IP bên ngoài của máy chủ đó. Bạn có thể nhập vào thanh địa chỉ: http://<External_IP>:3000

Khi khởi động lần đầu, bạn cần tạo tài khoản để truy cập ứng dụng.

3. Cài đặt các Connection Metabase mặc định chưa hỗ trợ:
Hiện tại, Metabase hỗ trợ một số nguồn dữ liệu như sau: 


Nguồn dữ liệu Metabase hỗ trợ
Nếu cơ sở dữ liệu của bạn không được hỗ trợ sẵn trong Metabase, như trong trường hợp của mình là ClickHouse và Starburst. Điều này có nghĩa là bạn sẽ không thể truy cập dữ liệu từ những nguồn này một cách trực tiếp khi cài đặt Metabase, bạn sẽ cần phải cài đặt các trình điều khiển bên ngoài để có thể kết nối và sử dụng chúng trong ứng dụng. 

May mắn thay, cộng đồng mã nguồn mở luôn sẵn sàng hỗ trợ bạn trong quá trình này. Bạn có thể dễ dàng tìm thấy các driver cần thiết trên các kho lưu trữ trực tuyến. Để cài đặt, bạn chỉ cần tải xuống các driver tương ứng và đặt chúng vào thư mục plugin của Metabase. Sau đó, khởi động lại ứng dụng, và bạn sẽ có thể kết nối và trực quan hóa dữ liệu từ ClickHouse và Starburst một cách dễ dàng. Điều này không chỉ giúp mở rộng khả năng của Metabase mà còn tạo ra nhiều cơ hội mới trong việc phân tích và trực quan hóa dữ liệu.

Trong file docker-compose.yml, mình đã mount thư mục /plugins trong container ra thư mục /drivers bên ngoài. Bây giờ, bạn chỉ cần tải các file .jar cần thiết cho các driver, sau đó đưa chúng vào thư mục metabase/drivers. Cuối cùng, bạn chỉ cần khởi động lại các container bằng lệnh docker-compose restart metabase để hoàn tất quá trình cài đặt và sử dụng các kết nối mới.

Có thể dùng các lệnh bash để tải nhanh các driver như sau:

wget -O ~/metabase/drivers/clickhouse.metabase-driver.jar https://github.com/ClickHouse/metabase-clickhouse-driver/releases/download/1.50.7/clickhouse.metabase-driver.jar 
wget -O ~/metabase/drivers/starburst-5.0.0.metabase-driver.jar https://github.com/starburstdata/metabase-driver/releases/download/5.0.0/starburst-5.0.0.metabase-driver.jar
Khởi động lại container:

docker-compose restart metabase
Bây giờ bạn đã hoàn tất việc cài đặt các driver cần thiết, bạn có thể sẵn sàng với những kết nối và báo cáo của mình.


Các driver mới được cập nhật
Hy vọng rằng bài viết này đã cung cấp cho bạn cái nhìn rõ ràng về cách thiết lập và tối ưu hóa Metabase cho nhu cầu phân tích dữ liệu của bạn. Đối với mình, đây là một công cụ và giải pháp khá thú vị. Trong các bài viết sau, mình sẽ tiếp tục trải nghiệm những công cụ BI khác và cùng mọi người đánh giá, từ đó chọn ra giải pháp phù hợp nhất cho nhu cầu của từng tổ chức.

Cảm ơn bạn đã theo dõi và ủng hộ!
