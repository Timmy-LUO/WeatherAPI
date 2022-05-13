# 天氣API

## Skill Description:

1. URLSession Get data
2. UISearchController (輸入城市名稱、經緯度，找到對應城市的天氣)
3. 加入 UITapGestureRecognizer 可切換攝氏、華氏溫度
4. 加入 Lottie 套件，載入時告知使用者資料正在 Loading
5. AutoLayout (SnapKit)
6. Delegation
7. MVC 設置

### 功能：

* #### 可輸入城市名稱、經緯度，找到對應城市的天氣
* #### 可切換攝氏、華氏溫度
* #### 點擊搜尋到的天氣，可查看該城市的詳細資料 (ex: 體感溫度、最高溫、最低溫、日出時間、日落時間、風速)


串接 Current Weather API (https://openweathermap.org/current) 取得各城市的天氣資訊，可藉由二種搜尋方式(城市名稱、經緯度)來獲得該地區天氣。
還有額外加入 Country API (https://www.universal-tutorial.com/rest-apis/free-rest-api-for-country-state-city) 來提供搜尋的功能。

![image](https://github.com/Timmy-LUO/WeatherAPI/blob/main/GIF/WeatherAPI.gif)
