# Analysis
WireShark filter for HTTP requests:
```
((((http) && !(http.response_for.uri == "http://127.0.0.1:5555/favicon.ico"))) && !(http.response_for.uri == "http://127.0.0.1:3000/favicon.ico")) && !(http.request.uri == "/favicon.ico")
```