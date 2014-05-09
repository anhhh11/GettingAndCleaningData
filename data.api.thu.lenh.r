library(httr)
keyAndSecret = readLines(file('./key'))
myapp <- oauth_app("github",key=keyAndSecret[1],secret=keyAndSecret[2])
token  <- oauth2.0_token(oauth_endpoints("github"),myapp)
?oauth_endpoint
req <- GET("https://api.github.com/rate_limit", config(token = token))
stop_for_status(req)
content(req)>
  