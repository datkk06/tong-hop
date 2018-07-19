# Tìm hiểu về Elasticsearch

======================================================

# Mục Lục.

- [1. Elasticsearch là gì?](#1)

- [2. Các khái niệm cơ bản cần phải biết.](#2)

    - [2.1. Document.](#2.1)

    - [2.2. Index.](#2.2)

    - [2.3. Shard.](#2.3)

    - [2.4. Node.](#2.4)

    - [2.5. Cluster.](#2.5)

- [3. Cách thức hoạt động của Elasticsearch.](#3)

- [4. Ưu điểm và nhược điểm của Elasticsearch.](#4)

    - [4.1. Ưu điểm.](#4.1)

    - [4.2. Nhược điểm](#4.2)



======================================================

<a name="1"></a>

## 1. Elasticsearch là gì?

- Elasticsearch là một công cụ tìm kiếm dựa trên nền tảng Apache Lucene. Nó cung cấp một bộ máy tìm kiếm dạng phân tán, có đầy đủ công cụ với một giao diện web HTTP có hỗ trợ dữ liệu JSON. Elasticsearch được phát triển bằng Java và được phát hành dạng nguồn mở theo giấy phép Apache. (Theo wikipedia)

- Mục tiêu của nó là tạo thành một công cụ, nền tảng kỹ thuật tìm kiếm và phân tích thời gian thực (ở đây là nhanh trong và chính xác), cũng như cách để nó có thể áp dụng hay triển khai một cách dễ dàng vào các nguồn dữ liệu (data sourcecs) khác nhau.

- Nguồn dữ liệu nói trên bao gồm các cơ sở dữ liệu nổi tiếng như MS SQL, MySQL, PostgreSQL ... mà nó có thể là văn bản(text), thư điện tử(email), pdf ... nói chung là tất cả những thứ có liên quan tới dữ liệu có văn bản.

- ElastichSearch được phát triển bởi Shay Banon và dựa trên Apache Lucene, ElasticSearch là một bản phân phối mã nguồn mở cho việc tìm kiếm dữ liệu trên máy chủ. Đây là một giải pháp mở rộng. hỗi trợ tìm kiếm thời gian thực mà không cần có một cấu hình. Nó đã được áp dụng bời một số công ty bao gồm cả StumbleUpon và Mozilla.

- Tóm lại :

    - Elasticsearch là một search engine.

    - Elasticsearch được kế thừa từ Lucene Apache.

    - Elasticsearch thực chất hoặt động như 1 web server, có khả năng tìm kiếm nhanh chóng (near realtime) thông qua giao thức RESTful.

    - Elasticsearch có khả năng phân tích và thống kê dữ liệu.

    - Elasticsearch chạy trên server riêng và đồng thời giao tiếp thông qua RESTful do vậy nên nó không phụ thuộc vào client viết bằng gì hay hệ thống hiện tại của bạn viết bằng gì. Nên việc tích hợp nó vào hệ thống bạn là dễ dàng, bạn chỉ cần gửi request http lên là nó trả về kết quả.

    - Elasticsearch là 1 hệ thống phân tán và có khả năng mở rộng tuyệt vời (horizontal scalability). Lắp thêm node cho nó là nó tự động auto mở rộng cho bạn.

    - Elasticsearch là 1 open source được phát triển bằng Java.

<a name="2"></a>

## 2. Các khái niệm cơ bản cần phải biết.

<a name="2.1"></a>

### 2.1. Document.

- Document là một JSON object với một số dữ liệu. Đây là basic information unit trong ES. Hiểu 1 cách cơ bản thì đây là đơn vị nhỏ nhất để lưu trữ dữ liệu trong Elasticsearch.

<a name="2.2"></a>

### 2.2. Index.

- Index có lẽ là 1 khái niệm quá quen thuộc đối với những người dùng Mysql rồi. Khi đọc đến đây có lẽ chúng ta đã thừa hiểu chức năng của index là gì rồi. Tuy nhiên nếu các bạn nghĩ rằng index trong ES hoàn toàn giống trong Mysql thì các bạn nhầm rồi nhé !

- Trong Elasticsearch , sử dụng một cấu trúc được gọi là inverted index . Nó được thiết kế để cho phép tìm kiếm full-text search. Cách thức của nó khá đơn giản, các văn bản được phân tách ra thành từng từ có nghĩa sau đó sẽ đk map xem thuộc văn bản nào. Khi search tùy thuộc vào loại search sẽ đưa ra kết quả cụ thể. (inverted index là gì thì chúng ta sẽ nói đến phần 3. cách thức hoạt động).

<a name="2.3"></a>

### 2.3. Shard.

- Shard là đối tượng của Lucene , là tập con các documents của 1 Index. Một Index có thể được chia thành nhiều shard.

- Mỗi node bao gồm nhiều Shard . Chính vì thế Shard mà là đối tượng nhỏ nhất, hoạt động ở mức thấp nhất, đóng vai trò lưu trữ dữ liệu.

- Chúng ta gần như không bao giờ làm việc trực tiếp với các Shard vì Elasticsearch đã support toàn bộ việc giao tiếp cũng như tự động thay đổi các Shard khi cần thiết.

-  Có 2 loại Shard là : primary shard và replica shard.

#### 2.3.1 : Primary Shard

- Primary Shard là sẽ lưu trữ dữ liệu và đánh index . Sau khi đánh xong dữ liệu sẽ được vận chuyển tới các Replica Shard.

- Mặc định của Elasticsearch là mỗi index sẽ có 5 Primary shard và với mỗi Primary shard thì sẽ đi kèm với 1 Replica Shard.

#### 2.3.2. Replica Shard.

- Replica Shard đúng như cái tên của nó, nó là nơi lưu trữ dữ liệu nhân bản của Primary Shard.

- Replica Shard có vai trò đảm bảo tính toàn vẹn của dữ liệu khi Primary Shard xảy ra vấn đề.

- Ngoài ra Replica Shard có thể giúp tăng cường tốc độ tìm kiếm vì chúng ta có thể setup lượng Replica Shard nhiều hơn mặc định của ES.

<a name="2.4"></a>

### 2.4. Node.

- Là trung tâm hoạt động của Elasticsearch. Là nơi lưu trữ dữ liễu ,tham gia thực hiện đánh index cúa cluster cũng như thực hiện các thao tác tìm kiếm.

- Mỗi node được định danh bằng 1 unique name.

<a name="2.5"></a>

### 2.5. Cluster.

- Tập hợp các nodes hoạt động cùng với nhau, chia sẽ cùng thuộc tính cluster.name. Chính vì thế Cluster sẽ được xác định bằng 1 'unique name'. Việc định danh các cluster trùng tên sẽ gây nên lỗi cho các node vì vậy khi setup chúng ta cần hết sức chú ý điểm này.

- Mỗi cluster có một node chính (master), được lựa chọn một cách tự động và có thể thay thế nếu sự cố xảy ra. Một cluster có thể gồm 1 hoặc nhiều nodes. Các nodes có thể hoạt động trên cùng 1 server . Tuy nhiên trong thực tế , một cluster sẽ gồm nhiều nodes hoạt động trên các server khác nhau để đảm bảo nếu 1 server gặp sự cố thì server khác (node khác) có thể hoạt động đầy đủ chức năng so với khi có 2 servers. Các node có thể tìm thấy nhau để hoạt động trên cùng 1 cluster qua giao thức unicast.

Chức năng chính của Cluster đó chính là quyết định xem shards nào được phân bổ cho node nào và khi nào thì di chuyển các Cluster để cân bằng lại Cluster.

<a name="3"></a>

## 3. Cách thức hoạt động của Elasticsearch.

- Về cơ bản thì ElasticSearch cũng áp dụng giải pháp giống index,Tuy nhiên về mặt cơ chế xử lý và tìm kiếm thì có sự khác biệt, Index trong ElasticSearch được gọi là `inverted index`.

- Kỹ thuật thay vì index theo từng đơn vị row(document) giống như mysql thì chúng ta sẽ biến thành index theo đơn vị term. Cụ thể hơn, Inverted index là một cấu trúc dữ liệu, nhằm mục đích map giữa term và các document chứa term đó.

Ta sẽ xém xét ví dụ sau để hiểu rõ hơn về inverted index :

- Ta có 3 document là D1, D2, D3 :

    - D1 = "hom nay troi mua"

    - D2 = "hom nay troi nang"

    - D3 = "mot ngay dep troi"

- Theo đó ta sẽ có inverted index của 3 document trên là :

    - "hom" = {D1, D2}

    - "nay" = {D1, D2}

    - "troi" = {D1, D2, D3}

    - "mua" = {D1}

    - "nang" = {D2}

    - "mot" = {D3}

    - "ngay" = {D3}

    - "dep" = {D3}

- Nhìn vào kết quả của inverted index trên ta có thể thấy việc search full text sẽ diễn ra rất dễ dàng và nhanh chóng. nó chỉ là việc tính toán của các term. Ví dụ khi muốn query từ “hom nay” (tùy theo việc là query theo kiểu and hay or thì phép tính toán sẽ khác đi. ở đây mình sẽ lấy ví dụ là query theo kiểu and.) thì phép toán là :

    - {D1, D2} ∩ {D1, D2} = {D1, D2}

    - Kết quả thu được chính là document 1 và 2 (D1 and D2).

<a name="4"></a>

## 4. Ưu điểm và nhược điểm của Elasticsearch.

<a name="4.1"></a>

### 4.1. Ưu điểm.

- Tìm kiếm dữ liệu rất nhanh chóng, mạnh mẽ dựa trên Apache Lucene ( near-realtime searching).

- Có khả năng phân tích dữ liệu (Analysis data).

- Khả năng mở rộng theo chiều ngang tuyệt vời.

- Hỗ trợ tìm kiếm mờ (fuzzy), tức là từ khóa tìm kiếm có thể bị sai lỗi chính tả hay không đúng cú pháp thì vẫn có khả năng elasticsearch trả về kết quả tốt.

- Hỗ trợ Structured Query DSL (Domain-Specific Language ), cung cấp việc đặc tả những câu truy vấn phức tạp một cách cụ thể và rõ ràng bằng JSON.

- Hỗ trợ nhiều Elasticsearc client như Java, PhP, Javascript, Ruby, .NET, Python.

<a name="4.2"></a>

### 4.2. Nhược điểm.

- Elasticsearch được thiết kế cho mục đích search, do vậy với những nhiệm vụ khác ngoài search như CRUD thì elastic kém thế hơn so với những database khác như Mongodb, Mysql …. Do vậy người ta ít khi dùng elasticsearch làm database chính, mà thường kết hợp nó với 1 database khác.

- Trong elasticsearch không có khái niệm database transaction , tức là nó sẽ không đảm bảo được toàn vẹn dữ liệu trong các hoạt độngInsert, Update, Delete.Tức khi chúng ta thực hiện thay đổi nhiều bản ghi nếu xảy ra lỗi thì sẽ làm cho logic của mình bị sai hay dẫn tới mất mát dữ liệu. Đây cũng là 1 phần khiến elasticsearch không nên là database chính.

- Không thích hợp với những hệ thống thường xuyên cập nhật dữ liệu. Sẽ rất tốn kém cho việc đánh index dữ liệu.

## Tham khảo

- https://viblo.asia/p/tim-hieu-ve-elasticsearch-MdZkAQMKkox

- https://viblo.asia/p/elasticsearch-la-gi-1Je5E8RmlnL