# Tạo bot slack nhận cảnh báo từ portal.

- Đầu tiên vào link sau để vào màn hình tạo app:
	```sh
	https://api.slack.com/apps
	```

- Click vào `Create New App`:

![](https://i.imgur.com/abex9br.png)

- Điền vào tên app (bot) vào workspace:

![](https://i.imgur.com/VQC2m9F.png)

- Chọn `Bot Users` rồi chọn `Add a Bot User`:

![](https://i.imgur.com/ucPyQYp.png)

- Chọn `OAuth & Permissions` rồi chọn `Install App to Workspace`: 

![](https://i.imgur.com/PB5uNrk.png)

- Chọn `Authorize`: 

![](https://i.imgur.com/LY50a8O.png)

- Lấy token `Bot User OAuth Access Token` để portal chứng thực:

![](https://i.imgur.com/noKnuFF.png)

- Sau đó tạo thêm 1 channel để bot gửi thông báo vào trong đó.

# Tạo bot telegram nhận cảnh báo từ portal.

- Đầu tiên chat với @BotFather để lấy token :

	```sh
	/start
	/newbot
	{your_bot_name}
	{your_bot_name}bot
	```
	
- Sau khi đã tạo được bot và lấy được token, tiến hành tạo một group :

![](https://i.imgur.com/wAjTvKm.png)

- Điền tên group và nhấn next :

![](https://i.imgur.com/qtlMi39.png)

- Add bot vào group mới tạo :

![](https://i.stack.imgur.com/cKd8W.png)

- Sau khi add bot vào group xong, lấy lại 2 thông tin để cấu hình trên portal.
	```sh
	Token : Lấy từ BotFather ở bước đầu.
	GroupID : Xem hướng dẫn bên dưới để lấy group ID.
	```
	
## Hướng dẫn lấy GroupID.

- Truy cập đường dẫn sau :

	```sh
	https://api.telegram.org/bot[token]/getUpdates
	```
	
- Lấy GroupID :

![](https://i.imgur.com/aRgQxSB.png)

==> Luôn là ID có dấu âm đằng trước.
