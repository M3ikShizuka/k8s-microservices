# Concept
Ory Hydra serves APIs via two ports:
* Public port (default 4444) 
* Administrative port (default 4445)

## Docker compose:
* Public port (default 4444)            http://127.0.0.1:4444/
* Administrative port (default 4445)    http://127.0.0.1:4445/
* An example web application (hydra's example app).           http://127.0.0.1:5555/
* Consent (hydra's Consent example app).                              http://127.0.0.1:3000/

## Kubernetes:
* Hydra Public API external (accessible outside the kubernetes network): "http://public.hydra.localhost"
* Hydra Public API private (accessible only within the kubernetes network): "http://chart-hydra1-public.default.svc.cluster.local:4444"
* Hydra Admin API private (accessible only within the kubernetes network): 
"http://chart-hydra1-admin.default.svc.cluster.local:4445"
* Service-account (AuthN) and Consent (external, accessible outside the kubernetes network): "http://account.localhost"

### Sequence Diagram UML Sign In and Consent
App backend service is any app that uses an authorization token.
Device is any user's device or web browser.
![alt text](OAuth2%20ory%20hydra%20sequence%20diagram%20kubernetes.drawio.png)

## Page: **Welcome**
![alt text](https://www.ory.sh/docs/assets/images/oauth2-consumer-47a7db778f7f12ab7492fd69e6b2f091.png)

Addr:
```
http://127.0.0.1:5555/
```

Request
```
GET / HTTP/1.1
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9
Accept-Encoding: gzip, deflate, br
Accept-Language: ru-RU,ru;q=0.9,en-US;q=0.8,en;q=0.7
Cache-Control: no-cache
Connection: keep-alive
Cookie: _csrf=5eg04kX6X_8EJXOuPOaJTT_E; oauth2_authentication_csrf_insecure=MTY1ODY3MzI1MHxEdi1CQkFFQ180SUFBUkFCRUFBQVB2LUNBQUVHYzNSeWFXNW5EQVlBQkdOemNtWUdjM1J5YVc1bkRDSUFJREprWmpsaE5HUmpNMkZsTlRRelpXTmlPRE0xWW1ZM1ltWmxZMkV3Tm1NM3x6kchEHha7UhxVULLwVYIBazvkAAa1cC7FIjIXsQ2Hqg==; oauth2_consent_csrf_insecure=MTY1ODY3MzI1NXxEdi1CQkFFQ180SUFBUkFCRUFBQVB2LUNBQUVHYzNSeWFXNW5EQVlBQkdOemNtWUdjM1J5YVc1bkRDSUFJRGczWXpObE16WTBZVEExTkRSak1qRTVNRGswWmpnM1pHRmtPVGc0T0dZM3wMeO9p4QWA93GKlKrUxerMQ0Ebo88K3AHboxyDswppZg==
Host: 127.0.0.1:5555
Pragma: no-cache
Sec-Fetch-Dest: document
Sec-Fetch-Mode: navigate
Sec-Fetch-Site: none
Sec-Fetch-User: ?1
Upgrade-Insecure-Requests: 1
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.5005.115 Safari/537.36 OPR/88.0.4412.85
sec-ch-ua: "Chromium";v="102", "Opera GX";v="88", ";Not A Brand";v="99"
sec-ch-ua-mobile: ?0
sec-ch-ua-platform: "Windows"

```
Response:
```
HTTP/1.1 200 OK
Date: Sun, 24 Jul 2022 14:35:42 GMT
Content-Length: 881
Content-Type: text/html; charset=utf-8

<html>
    <body>
        <h1>Welcome to the exemplary OAuth 2.0 Consumer!</h1>
        <p>
            This is an example app which emulates an OAuth 2.0 consumer application. Usually, this would be your web or mobile
    application and would use an <a href="https://oauth.net/code/">OAuth 2.0</a>
            or <a href="https://oauth.net/code/">OpenID
        Connect</a>
            library.
        </p>
        <p>This example requests an OAuth 2.0 Access, Refresh, and OpenID Connect ID Token from the OAuth 2.0 Server (Ory
    Hydra).
    To initiate the flow, click the "Authorize Application" button.</p>
        <p>
            <a href="http://127.0.0.1:4444/oauth2/auth?audience=&amp;client_id=client-auth-code-service-account&amp;max_age=0&amp;nonce=mmbtkvwsmmjbqlquazvyvwps&amp;prompt=&amp;redirect_uri=http%3A%2F%2F127.0.0.1%3A5555%2Fcallback&amp;response_type=code&amp;scope=openid&#43;offline&amp;state=mmysuxebnrkaewtemfwetvva">Authorize application</a>
        </p>
    </body>
</html>

```

## Request with redirect: **http://127.0.0.1:4444/oauth2/auth?audience**
Addr:
```
http://127.0.0.1:4444/oauth2/auth?audience=&client_id=client-auth-code-service-account&max_age=0&nonce=mmbtkvwsmmjbqlquazvyvwps&prompt=&redirect_uri=http%3A%2F%2F127.0.0.1%3A5555%2Fcallback&response_type=code&scope=openid+offline&state=mmysuxebnrkaewtemfwetvva
```

Request
```
GET /oauth2/auth?audience=&client_id=client-auth-code-service-account&max_age=0&nonce=mmbtkvwsmmjbqlquazvyvwps&prompt=&redirect_uri=http%3A%2F%2F127.0.0.1%3A5555%2Fcallback&response_type=code&scope=openid+offline&state=mmysuxebnrkaewtemfwetvva HTTP/1.1
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9
Accept-Encoding: gzip, deflate, br
Accept-Language: ru-RU,ru;q=0.9,en-US;q=0.8,en;q=0.7
Connection: keep-alive
Cookie: _csrf=5eg04kX6X_8EJXOuPOaJTT_E; oauth2_authentication_csrf_insecure=MTY1ODY3MzI1MHxEdi1CQkFFQ180SUFBUkFCRUFBQVB2LUNBQUVHYzNSeWFXNW5EQVlBQkdOemNtWUdjM1J5YVc1bkRDSUFJREprWmpsaE5HUmpNMkZsTlRRelpXTmlPRE0xWW1ZM1ltWmxZMkV3Tm1NM3x6kchEHha7UhxVULLwVYIBazvkAAa1cC7FIjIXsQ2Hqg==; oauth2_consent_csrf_insecure=MTY1ODY3MzI1NXxEdi1CQkFFQ180SUFBUkFCRUFBQVB2LUNBQUVHYzNSeWFXNW5EQVlBQkdOemNtWUdjM1J5YVc1bkRDSUFJRGczWXpObE16WTBZVEExTkRSak1qRTVNRGswWmpnM1pHRmtPVGc0T0dZM3wMeO9p4QWA93GKlKrUxerMQ0Ebo88K3AHboxyDswppZg==
Host: 127.0.0.1:4444
Referer: http://127.0.0.1:5555/
Sec-Fetch-Dest: document
Sec-Fetch-Mode: navigate
Sec-Fetch-Site: same-site
Sec-Fetch-User: ?1
Upgrade-Insecure-Requests: 1
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.5005.115 Safari/537.36 OPR/88.0.4412.85
sec-ch-ua: "Chromium";v="102", "Opera GX";v="88", ";Not A Brand";v="99"
sec-ch-ua-mobile: ?0
sec-ch-ua-platform: "Windows"
```


Response
```
HTTP/1.1 302 Found
Content-Type: text/html; charset=utf-8
Location: http://127.0.0.1:3000/login?login_challenge=2f5d20b9e8f0404aafe01978a8d92a45
Set-Cookie: oauth2_authentication_csrf_insecure=MTY1ODY3MzQyMXxEdi1CQkFFQ180SUFBUkFCRUFBQVB2LUNBQUVHYzNSeWFXNW5EQVlBQkdOemNtWUdjM1J5YVc1bkRDSUFJREJtT1RWaU56VTRaakJrTXpRd05ETmhaamRpTkdGa1pUWTFZemd4T0RJeHzRHl8HKIhX-DQ9s9VRmTTdaD9TIEjXULkOfPkmet6iOQ==; Path=/; HttpOnly; SameSite=Lax
Date: Sun, 24 Jul 2022 14:37:01 GMT
Content-Length: 99


```

## Page: **Please log in**
![alt text](https://www.ory.sh/docs/assets/images/login-endpoint-d8b7426a7ea23b027a042b62f13fc7d8.png)

Addr:
```
http://127.0.0.1:3000/login?login_challenge=2f5d20b9e8f0404aafe01978a8d92a45
```
Request
```
GET /login?login_challenge=2f5d20b9e8f0404aafe01978a8d92a45 HTTP/1.1
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9
Accept-Encoding: gzip, deflate, br
Accept-Language: ru-RU,ru;q=0.9,en-US;q=0.8,en;q=0.7
Connection: keep-alive
Cookie: _csrf=5eg04kX6X_8EJXOuPOaJTT_E; oauth2_consent_csrf_insecure=MTY1ODY3MzI1NXxEdi1CQkFFQ180SUFBUkFCRUFBQVB2LUNBQUVHYzNSeWFXNW5EQVlBQkdOemNtWUdjM1J5YVc1bkRDSUFJRGczWXpObE16WTBZVEExTkRSak1qRTVNRGswWmpnM1pHRmtPVGc0T0dZM3wMeO9p4QWA93GKlKrUxerMQ0Ebo88K3AHboxyDswppZg==; oauth2_authentication_csrf_insecure=MTY1ODY3MzQyMXxEdi1CQkFFQ180SUFBUkFCRUFBQVB2LUNBQUVHYzNSeWFXNW5EQVlBQkdOemNtWUdjM1J5YVc1bkRDSUFJREJtT1RWaU56VTRaakJrTXpRd05ETmhaamRpTkdGa1pUWTFZemd4T0RJeHzRHl8HKIhX-DQ9s9VRmTTdaD9TIEjXULkOfPkmet6iOQ==
Host: 127.0.0.1:3000
Referer: http://127.0.0.1:5555/
Sec-Fetch-Dest: document
Sec-Fetch-Mode: navigate
Sec-Fetch-Site: same-site
Sec-Fetch-User: ?1
Upgrade-Insecure-Requests: 1
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.5005.115 Safari/537.36 OPR/88.0.4412.85
sec-ch-ua: "Chromium";v="102", "Opera GX";v="88", ";Not A Brand";v="99"
sec-ch-ua-mobile: ?0
sec-ch-ua-platform: "Windows"
```

Response
```
HTTP/1.1 200 OK
X-Powered-By: Express
Content-Type: text/html; charset=utf-8
Content-Length: 786
ETag: W/"312-YZXC8bhXRVOW1WeErbrh6cdDsE0"
Date: Sun, 24 Jul 2022 14:37:02 GMT
Connection: keep-alive
Keep-Alive: timeout=5

<!DOCTYPE html>
<html>
    <head>
        <title></title>
    </head>
    <body>
        <h1 id="login-title">Please log in</h1>
        <form action="login" method="POST">
            <input type="hidden" name="_csrf" value="2RMuEd31-1UWbGS40nSC4wgPP1jG8aQwgZBc">
            <input type="hidden" name="challenge" value="2f5d20b9e8f0404aafe01978a8d92a45">
            <table>
                <tr>
                    <td>
                        <input type="email" id="email" name="email" value="" placeholder="email@foobar.com">
                    </td>
                    <td>(it's "foo@bar.com")</td>
                </tr>
                <tr>
                    <td>
                        <input type="password" id="password" name="password">
                    </td>
                    <td>(it's "foobar")</td>
                </tr>
            </table>
            <input type="checkbox" id="remember" name="remember" value="1">
            <label for="remember">Remember me</label>
            <br>
            <input type="submit" id="accept" name="submit" value="Log in">
            <input type="submit" id="reject" name="submit" value="Deny access">
        </form>
    </body>
</html>
```


## Request with redirect: **http://127.0.0.1:3000/login**

Addr:
```
http://127.0.0.1:3000/login
```

Request
```
POST /login HTTP/1.1
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9
Accept-Encoding: gzip, deflate, br
Accept-Language: ru-RU,ru;q=0.9,en-US;q=0.8,en;q=0.7
Cache-Control: max-age=0
Connection: keep-alive
Content-Length: 135
Content-Type: application/x-www-form-urlencoded
Cookie: _csrf=5eg04kX6X_8EJXOuPOaJTT_E; oauth2_consent_csrf_insecure=MTY1ODY3MzI1NXxEdi1CQkFFQ180SUFBUkFCRUFBQVB2LUNBQUVHYzNSeWFXNW5EQVlBQkdOemNtWUdjM1J5YVc1bkRDSUFJRGczWXpObE16WTBZVEExTkRSak1qRTVNRGswWmpnM1pHRmtPVGc0T0dZM3wMeO9p4QWA93GKlKrUxerMQ0Ebo88K3AHboxyDswppZg==; oauth2_authentication_csrf_insecure=MTY1ODY3MzQyMXxEdi1CQkFFQ180SUFBUkFCRUFBQVB2LUNBQUVHYzNSeWFXNW5EQVlBQkdOemNtWUdjM1J5YVc1bkRDSUFJREJtT1RWaU56VTRaakJrTXpRd05ETmhaamRpTkdGa1pUWTFZemd4T0RJeHzRHl8HKIhX-DQ9s9VRmTTdaD9TIEjXULkOfPkmet6iOQ==
Host: 127.0.0.1:3000
Origin: http://127.0.0.1:3000
Referer: http://127.0.0.1:3000/login?login_challenge=2f5d20b9e8f0404aafe01978a8d92a45
Sec-Fetch-Dest: document
Sec-Fetch-Mode: navigate
Sec-Fetch-Site: same-origin
Sec-Fetch-User: ?1
Upgrade-Insecure-Requests: 1
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.5005.115 Safari/537.36 OPR/88.0.4412.85
sec-ch-ua: "Chromium";v="102", "Opera GX";v="88", ";Not A Brand";v="99"
sec-ch-ua-mobile: ?0
sec-ch-ua-platform: "Windows"

_csrf: 2RMuEd31-1UWbGS40nSC4wgPP1jG8aQwgZBc
challenge: 2f5d20b9e8f0404aafe01978a8d92a45
email: foo@bar.com
password: foobar
submit: Log in
```

Response
```
HTTP/1.1 302 Found
X-Powered-By: Express
Location: http://127.0.0.1:4444/oauth2/auth?audience=&client_id=client-auth-code-service-account&login_verifier=03c951ed40ad4e10a47a4bec1e96f44c&max_age=0&nonce=mmbtkvwsmmjbqlquazvyvwps&prompt=&redirect_uri=http%3A%2F%2F127.0.0.1%3A5555%2Fcallback&response_type=code&scope=openid+offline&state=mmysuxebnrkaewtemfwetvva
Vary: Accept
Content-Type: text/html; charset=utf-8
Content-Length: 700
Date: Sun, 24 Jul 2022 14:46:13 GMT
Connection: keep-alive
Keep-Alive: timeout=5


```


## Request with redirect: **http://127.0.0.1:4444/oauth2/auth**

Addr:
```
http://127.0.0.1:4444/oauth2/auth?audience=&client_id=client-auth-code-service-account&login_verifier=03c951ed40ad4e10a47a4bec1e96f44c&max_age=0&nonce=mmbtkvwsmmjbqlquazvyvwps&prompt=&redirect_uri=http%3A%2F%2F127.0.0.1%3A5555%2Fcallback&response_type=code&scope=openid+offline&state=mmysuxebnrkaewtemfwetvva
```

Request
```
GET /oauth2/auth?audience=&client_id=client-auth-code-service-account&login_verifier=03c951ed40ad4e10a47a4bec1e96f44c&max_age=0&nonce=mmbtkvwsmmjbqlquazvyvwps&prompt=&redirect_uri=http%3A%2F%2F127.0.0.1%3A5555%2Fcallback&response_type=code&scope=openid+offline&state=mmysuxebnrkaewtemfwetvva HTTP/1.1
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9
Accept-Encoding: gzip, deflate, br
Accept-Language: ru-RU,ru;q=0.9,en-US;q=0.8,en;q=0.7
Cache-Control: max-age=0
Connection: keep-alive
Cookie: _csrf=5eg04kX6X_8EJXOuPOaJTT_E; oauth2_consent_csrf_insecure=MTY1ODY3MzI1NXxEdi1CQkFFQ180SUFBUkFCRUFBQVB2LUNBQUVHYzNSeWFXNW5EQVlBQkdOemNtWUdjM1J5YVc1bkRDSUFJRGczWXpObE16WTBZVEExTkRSak1qRTVNRGswWmpnM1pHRmtPVGc0T0dZM3wMeO9p4QWA93GKlKrUxerMQ0Ebo88K3AHboxyDswppZg==; oauth2_authentication_csrf_insecure=MTY1ODY3MzQyMXxEdi1CQkFFQ180SUFBUkFCRUFBQVB2LUNBQUVHYzNSeWFXNW5EQVlBQkdOemNtWUdjM1J5YVc1bkRDSUFJREJtT1RWaU56VTRaakJrTXpRd05ETmhaamRpTkdGa1pUWTFZemd4T0RJeHzRHl8HKIhX-DQ9s9VRmTTdaD9TIEjXULkOfPkmet6iOQ==
Host: 127.0.0.1:4444
Referer: http://127.0.0.1:3000/
Sec-Fetch-Dest: document
Sec-Fetch-Mode: navigate
Sec-Fetch-Site: same-site
Sec-Fetch-User: ?1
Upgrade-Insecure-Requests: 1
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.5005.115 Safari/537.36 OPR/88.0.4412.85
sec-ch-ua: "Chromium";v="102", "Opera GX";v="88", ";Not A Brand";v="99"
sec-ch-ua-mobile: ?0
sec-ch-ua-platform: "Windows"

```

Response
```
HTTP/1.1 302 Found
Content-Type: text/html; charset=utf-8
Location: http://127.0.0.1:3000/consent?consent_challenge=e8929ddfb2e24df6aae98f9fec0062dc
Set-Cookie: oauth2_authentication_session_insecure=MTY1ODY3Mzk3M3xEdi1CQkFFQ180SUFBUkFCRUFBQUhmLUNBQUVHYzNSeWFXNW5EQVVBQTNOcFpBWnpkSEpwYm1jTUFnQUF8GOdET2nL9JzCqVNaXmZihsEprAJGixU3pEMWN95UNcc=; Path=/; Expires=Thu, 01 Jan 1970 00:00:01 GMT; Max-Age=0; HttpOnly; SameSite=Lax
Set-Cookie: oauth2_consent_csrf_insecure=MTY1ODY3Mzk3M3xEdi1CQkFFQ180SUFBUkFCRUFBQVB2LUNBQUVHYzNSeWFXNW5EQVlBQkdOemNtWUdjM1J5YVc1bkRDSUFJREk0T1RZeVptTXpNbVE0TmpSaVltUmhNVFl3WlRRME0ySmhZbVEzWkdKanxXTFY8RWCjFcx-Fi7CK4P2wAZvlEkZfepKz8wvOlyCJg==; Path=/; HttpOnly; SameSite=Lax
Date: Sun, 24 Jul 2022 14:46:13 GMT
Content-Length: 103


```


## Page: **An application requests access to your data!**
![alt text](https://www.ory.sh/docs/assets/images/consent-endpoint-31856a0555a6a8438d4603692bdab5d2.png)

Addr:
```
http://127.0.0.1:3000/consent?consent_challenge=e8929ddfb2e24df6aae98f9fec0062dc
```

Request
```
GET /consent?consent_challenge=e8929ddfb2e24df6aae98f9fec0062dc HTTP/1.1
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9
Accept-Encoding: gzip, deflate, br
Accept-Language: ru-RU,ru;q=0.9,en-US;q=0.8,en;q=0.7
Cache-Control: max-age=0
Connection: keep-alive
Cookie: _csrf=5eg04kX6X_8EJXOuPOaJTT_E; oauth2_authentication_csrf_insecure=MTY1ODY3MzQyMXxEdi1CQkFFQ180SUFBUkFCRUFBQVB2LUNBQUVHYzNSeWFXNW5EQVlBQkdOemNtWUdjM1J5YVc1bkRDSUFJREJtT1RWaU56VTRaakJrTXpRd05ETmhaamRpTkdGa1pUWTFZemd4T0RJeHzRHl8HKIhX-DQ9s9VRmTTdaD9TIEjXULkOfPkmet6iOQ==; oauth2_consent_csrf_insecure=MTY1ODY3Mzk3M3xEdi1CQkFFQ180SUFBUkFCRUFBQVB2LUNBQUVHYzNSeWFXNW5EQVlBQkdOemNtWUdjM1J5YVc1bkRDSUFJREk0T1RZeVptTXpNbVE0TmpSaVltUmhNVFl3WlRRME0ySmhZbVEzWkdKanxXTFY8RWCjFcx-Fi7CK4P2wAZvlEkZfepKz8wvOlyCJg==
Host: 127.0.0.1:3000
Referer: http://127.0.0.1:3000/
Sec-Fetch-Dest: document
Sec-Fetch-Mode: navigate
Sec-Fetch-Site: same-site
Sec-Fetch-User: ?1
Upgrade-Insecure-Requests: 1
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.5005.115 Safari/537.36 OPR/88.0.4412.85
sec-ch-ua: "Chromium";v="102", "Opera GX";v="88", ";Not A Brand";v="99"
sec-ch-ua-mobile: ?0
sec-ch-ua-platform: "Windows"

```

Response
```
HTTP/1.1 200 OK
X-Powered-By: Express
Content-Type: text/html; charset=utf-8
Content-Length: 1139
ETag: W/"473-86Rm1hWe+DbegnQMvVo/eVYxfmw"
Date: Sun, 24 Jul 2022 14:46:13 GMT
Connection: keep-alive
Keep-Alive: timeout=5

<!DOCTYPE html>
<html>
    <head>
        <title></title>
    </head>
    <body>
        <h1>An application requests access to your data!</h1>
        <form action="consent" method="POST">
            <input type="hidden" name="challenge" value="e8929ddfb2e24df6aae98f9fec0062dc">
            <input type="hidden" name="_csrf" value="5ZgdvIw3--pNxI9PJ4KbaL2DvpHo0yWahAwQ">
            <p>
                Hi foo@bar.com, application <strong>client-auth-code-service-account</strong>
                wants access resources on your behalf and to:

            </p>
            <input class="grant_scope" type="checkbox" id="openid" value="openid" name="grant_scope">
            <label for="openid">openid</label>
            <br>
            <input class="grant_scope" type="checkbox" id="offline" value="offline" name="grant_scope">
            <label for="offline">offline</label>
            <br>
            <p>Do you want to be asked next time when this application wants to access your data? The application will
not be able to ask for more permissions without your consent.</p>
            <ul></ul>
            <p>
                <input type="checkbox" id="remember" name="remember" value="1">
                <label for="remember">Do not ask me again</label>
            </p>
            <p>
                <input type="submit" id="accept" name="submit" value="Allow access">
                <input type="submit" id="reject" name="submit" value="Deny access">
            </p>
        </form>
    </body>
</html>
```


## Request with redirect: **http://127.0.0.1:3000/consent**

Addr:
```
http://127.0.0.1:3000/consent
```

Request
```
POST /consent HTTP/1.1
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9
Accept-Encoding: gzip, deflate, br
Accept-Language: ru-RU,ru;q=0.9,en-US;q=0.8,en;q=0.7
Cache-Control: max-age=0
Connection: keep-alive
Content-Length: 144
Content-Type: application/x-www-form-urlencoded
Cookie: _csrf=5eg04kX6X_8EJXOuPOaJTT_E; oauth2_authentication_csrf_insecure=MTY1ODY3MzQyMXxEdi1CQkFFQ180SUFBUkFCRUFBQVB2LUNBQUVHYzNSeWFXNW5EQVlBQkdOemNtWUdjM1J5YVc1bkRDSUFJREJtT1RWaU56VTRaakJrTXpRd05ETmhaamRpTkdGa1pUWTFZemd4T0RJeHzRHl8HKIhX-DQ9s9VRmTTdaD9TIEjXULkOfPkmet6iOQ==; oauth2_consent_csrf_insecure=MTY1ODY3Mzk3M3xEdi1CQkFFQ180SUFBUkFCRUFBQVB2LUNBQUVHYzNSeWFXNW5EQVlBQkdOemNtWUdjM1J5YVc1bkRDSUFJREk0T1RZeVptTXpNbVE0TmpSaVltUmhNVFl3WlRRME0ySmhZbVEzWkdKanxXTFY8RWCjFcx-Fi7CK4P2wAZvlEkZfepKz8wvOlyCJg==
Host: 127.0.0.1:3000
Origin: http://127.0.0.1:3000
Referer: http://127.0.0.1:3000/consent?consent_challenge=e8929ddfb2e24df6aae98f9fec0062dc
Sec-Fetch-Dest: document
Sec-Fetch-Mode: navigate
Sec-Fetch-Site: same-origin
Sec-Fetch-User: ?1
Upgrade-Insecure-Requests: 1
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.5005.115 Safari/537.36 OPR/88.0.4412.85
sec-ch-ua: "Chromium";v="102", "Opera GX";v="88", ";Not A Brand";v="99"
sec-ch-ua-mobile: ?0
sec-ch-ua-platform: "Windows"

challenge: e8929ddfb2e24df6aae98f9fec0062dc
_csrf: 5ZgdvIw3--pNxI9PJ4KbaL2DvpHo0yWahAwQ
grant_scope: openid
grant_scope: offline
submit: Allow access
```

Response
```
HTTP/1.1 302 Found
X-Powered-By: Express
Location: http://127.0.0.1:4444/oauth2/auth?audience=&client_id=client-auth-code-service-account&consent_verifier=8ed065333fd94ad59838e023beaa7cfa&max_age=0&nonce=mmbtkvwsmmjbqlquazvyvwps&prompt=&redirect_uri=http%3A%2F%2F127.0.0.1%3A5555%2Fcallback&response_type=code&scope=openid+offline&state=mmysuxebnrkaewtemfwetvva
Vary: Accept
Content-Type: text/html; charset=utf-8
Content-Length: 704
Date: Sun, 24 Jul 2022 14:55:25 GMT
Connection: keep-alive
Keep-Alive: timeout=5


```

## Request with redirect: **http://127.0.0.1:4444/oauth2/auth?**

Addr:
```
http://127.0.0.1:4444/oauth2/auth?audience=&client_id=client-auth-code-service-account&consent_verifier=8ed065333fd94ad59838e023beaa7cfa&max_age=0&nonce=mmbtkvwsmmjbqlquazvyvwps&prompt=&redirect_uri=http%3A%2F%2F127.0.0.1%3A5555%2Fcallback&response_type=code&scope=openid+offline&state=mmysuxebnrkaewtemfwetvva
```

Request
```
GET /oauth2/auth?audience=&client_id=client-auth-code-service-account&consent_verifier=8ed065333fd94ad59838e023beaa7cfa&max_age=0&nonce=mmbtkvwsmmjbqlquazvyvwps&prompt=&redirect_uri=http%3A%2F%2F127.0.0.1%3A5555%2Fcallback&response_type=code&scope=openid+offline&state=mmysuxebnrkaewtemfwetvva HTTP/1.1
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9
Accept-Encoding: gzip, deflate, br
Accept-Language: ru-RU,ru;q=0.9,en-US;q=0.8,en;q=0.7
Cache-Control: max-age=0
Connection: keep-alive
Cookie: _csrf=5eg04kX6X_8EJXOuPOaJTT_E; oauth2_authentication_csrf_insecure=MTY1ODY3MzQyMXxEdi1CQkFFQ180SUFBUkFCRUFBQVB2LUNBQUVHYzNSeWFXNW5EQVlBQkdOemNtWUdjM1J5YVc1bkRDSUFJREJtT1RWaU56VTRaakJrTXpRd05ETmhaamRpTkdGa1pUWTFZemd4T0RJeHzRHl8HKIhX-DQ9s9VRmTTdaD9TIEjXULkOfPkmet6iOQ==; oauth2_consent_csrf_insecure=MTY1ODY3Mzk3M3xEdi1CQkFFQ180SUFBUkFCRUFBQVB2LUNBQUVHYzNSeWFXNW5EQVlBQkdOemNtWUdjM1J5YVc1bkRDSUFJREk0T1RZeVptTXpNbVE0TmpSaVltUmhNVFl3WlRRME0ySmhZbVEzWkdKanxXTFY8RWCjFcx-Fi7CK4P2wAZvlEkZfepKz8wvOlyCJg==
Host: 127.0.0.1:4444
Referer: http://127.0.0.1:3000/
Sec-Fetch-Dest: document
Sec-Fetch-Mode: navigate
Sec-Fetch-Site: same-site
Sec-Fetch-User: ?1
Upgrade-Insecure-Requests: 1
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.5005.115 Safari/537.36 OPR/88.0.4412.85
sec-ch-ua: "Chromium";v="102", "Opera GX";v="88", ";Not A Brand";v="99"
sec-ch-ua-mobile: ?0
sec-ch-ua-platform: "Windows"

```

Response
```
HTTP/1.1 303 See Other
Cache-Control: no-store
Location: http://127.0.0.1:5555/callback?code=YZbwAnNZ8E8jc-YBEIWKPoTTR-UpJ1fvWZfC0ps3JiA.w0-lBbm0VzbvXMSQYeCQJqOhYKSUHxP_CWcW87mR534&scope=openid+offline&state=mmysuxebnrkaewtemfwetvva
Pragma: no-cache
Date: Sun, 24 Jul 2022 14:55:25 GMT
Content-Length: 0


```

## Page: **Data**

Addr:
```
http://127.0.0.1:5555/callback?code=YZbwAnNZ8E8jc-YBEIWKPoTTR-UpJ1fvWZfC0ps3JiA.w0-lBbm0VzbvXMSQYeCQJqOhYKSUHxP_CWcW87mR534&scope=openid+offline&state=mmysuxebnrkaewtemfwetvva
```

Request
```
GET /callback?code=YZbwAnNZ8E8jc-YBEIWKPoTTR-UpJ1fvWZfC0ps3JiA.w0-lBbm0VzbvXMSQYeCQJqOhYKSUHxP_CWcW87mR534&scope=openid+offline&state=mmysuxebnrkaewtemfwetvva HTTP/1.1
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9
Accept-Encoding: gzip, deflate, br
Accept-Language: ru-RU,ru;q=0.9,en-US;q=0.8,en;q=0.7
Cache-Control: max-age=0
Connection: keep-alive
Cookie: _csrf=5eg04kX6X_8EJXOuPOaJTT_E; oauth2_authentication_csrf_insecure=MTY1ODY3MzQyMXxEdi1CQkFFQ180SUFBUkFCRUFBQVB2LUNBQUVHYzNSeWFXNW5EQVlBQkdOemNtWUdjM1J5YVc1bkRDSUFJREJtT1RWaU56VTRaakJrTXpRd05ETmhaamRpTkdGa1pUWTFZemd4T0RJeHzRHl8HKIhX-DQ9s9VRmTTdaD9TIEjXULkOfPkmet6iOQ==; oauth2_consent_csrf_insecure=MTY1ODY3Mzk3M3xEdi1CQkFFQ180SUFBUkFCRUFBQVB2LUNBQUVHYzNSeWFXNW5EQVlBQkdOemNtWUdjM1J5YVc1bkRDSUFJREk0T1RZeVptTXpNbVE0TmpSaVltUmhNVFl3WlRRME0ySmhZbVEzWkdKanxXTFY8RWCjFcx-Fi7CK4P2wAZvlEkZfepKz8wvOlyCJg==
Host: 127.0.0.1:5555
Referer: http://127.0.0.1:3000/
Sec-Fetch-Dest: document
Sec-Fetch-Mode: navigate
Sec-Fetch-Site: same-site
Sec-Fetch-User: ?1
Upgrade-Insecure-Requests: 1
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.5005.115 Safari/537.36 OPR/88.0.4412.85
sec-ch-ua: "Chromium";v="102", "Opera GX";v="88", ";Not A Brand";v="99"
sec-ch-ua-mobile: ?0
sec-ch-ua-platform: "Windows"

```

Response
```
HTTP/1.1 200 OK
Date: Sun, 24 Jul 2022 14:55:25 GMT
Content-Length: 1619
Content-Type: text/html; charset=utf-8

<html>
    <head></head>
    <body>
        <ul>
            <li>
                Access Token: <code>WEJokZq5fXXDsVd1hSVCA-Laxe6AM18PwxXwV_jmycM.0iXX3TXBc8D5VawXqoofQ5iHARd_xl0lB963xOIbDZU</code>
            </li>
            <li>
                Refresh Token: <code>BKf37wspOA8e7Ess4eNS5gX0LDi5SqNA-80vYJNh-mo.nfGldh0_n_AkoVOxd5kos9o7Jtb3y0i39_SgrkgQ-so</code>
            </li>
            <li>
                Expires in: <code>Sun, 24 Jul 2022 15:55:25 UTC</code>
            </li>
            <li>
                ID Token: <code>eyJhbGciOiJSUzI1NiIsImtpZCI6InB1YmxpYzpoeWRyYS5vcGVuaWQuaWQtdG9rZW4iLCJ0eXAiOiJKV1QifQ.eyJhY3IiOiIwIiwiYXRfaGFzaCI6IklwUXowNHc2LU05ZGtlZU0tUWl3eUEiLCJhdWQiOlsiYXV0aC1jb2RlLWNsaWVudCJdLCJhdXRoX3RpbWUiOjE2NTg2NzM5NzMsImV4cCI6MTY1ODY3ODEyNSwiaWF0IjoxNjU4Njc0NTI1LCJpc3MiOiJodHRwOi8vMTI3LjAuMC4xOjQ0NDQvIiwianRpIjoiZGQ3MmRiMGEtMTYyMi00NTRiLTg0ODMtYjk5M2M5YTJjMWYyIiwibm9uY2UiOiJtbWJ0a3Z3c21tamJxbHF1YXp2eXZ3cHMiLCJyYXQiOjE2NTg2NzM0MjEsInNpZCI6ImQ2NTJlMmQ0LWQyYzUtNDIzNy04Y2M1LTk2ODgwYTdmYzYwMiIsInN1YiI6ImZvb0BiYXIuY29tIn0.l87MCdoKDrnEYW3pvNrwWmn3jN11Pam4UrS11eEdFGccKtfg0XmKpdpGNwuIvmr9J2I7CYfMUHxNN-_u_G-tCYNhdh9qxVG1EaMz6Avwg4iEWyEZsRNHVIljLIsXAdzDJxPyxXWfiYiaXXeNF3fP4UawMj_uOARSIFYGanrWwDDrpVDniaHXPviYNfpSKwEOG9joalSI2JgSEHmOqOvGsr6AzHPRMsCgvar7ktJoNS_4wpCoFrPdZJVjp8U6SADXPCreiJCydlYq-kT2hYD2O7PDdNEj05-4gEctN5Tg9t-IM3BOWoMFaUKcB9TPNOg9gBLiPXF82RuThkgjNo4-T4Lz2mZdqPeL2gpr51zMIEeI1Kc8PoVRaOJnB0235Fz4SXVw84P8bpZ2ZUZcSAmObOUK_rH-p-TqEw5HU5hsyTiGJFpmeed-DaLydz1SKcpi4NsqnqDksg5o3nbd_TcbhQUoxYy3NCItNnaGg6cuyvvVHYIPKvckGXj-eS_7y0jgcoUniPZS2mJZOrJW4hogKJvYHaicYub6pEYZRASspLkGBmUU7MA-EiBSbqDX41wqwx8fCqCaXDCqQU5vgf4jj6pd4rC8oPdRTp73Tm8HYvtA9lphm08QMRqqSwckOnIoAjiuP0EXRrl4N0HO20LN-Ugfxe2xgyXFBFLU8r3CcVQ</code>
            </li>
        </ul>
    </body>
</html>
```


## Decode tokens
May decode tokens here: https://jwt.io