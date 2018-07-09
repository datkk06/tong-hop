# Regular expression syntax.

- Cú pháp truy vẫn hỗ trợ cả `regexp` và `query_string`,  Lucene regular expression engine không tương thích với `Perl` nhưng hỗ trợ một số lượng nhỏ toán tử.

## 1. Một số cú pháp cơ bản.

- Hầu hết các biểu thức chính quy đều cho phép chuỗi truyền vào của chúng ta khớp với bất cứ phần nào của `String`. Nếu như chúng ta muốn bắt đầu chuỗi hoặc ở kết thúc chuỗi thì chúng ta cần có một thao tác cụ thể ví dụ như  : sử dụng `^` để đánh dấu đầu chuỗi hoặc `$` để đánh dấu cuối chuỗi.

- Ví dụ chúng ta có chuỗi String như sau : `mdtopen`

    ```sh
    mdt.* # trùng khớp
    mdt   # không khớp
    ```

### Các kí tự cho phép.

- Bất kỳ kí tự Unicode nào đều có thể được sử dụng ở trong pattern, nhưng phải chắc chắn rằng trong đó không có `escaped`. Các ký tự được cho phép là :

    ```sh
    . ? + * | { } [ ] ( ) " \
    ```

- Nếu chúng ta cho phép tùy chọn các tính năng, các ký tự mà chúng ta có thể sử dụng là :

    ```sh
    # @ & < >  ~
    ```

- Bất 