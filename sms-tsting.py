import requests
from flask import request

hostname = "Your appointment is due in 2 hours.Please visit https://m4120.miloni.pythonanywhere.com/viewappointment for more details"
response = requests.get("http://mobi1.blogdns.com/WebSMSS/SMSSenders.aspx?UserID=SURELA&UserPass=aipl@123456&Message="+str(hostname)+"&MobileNo=7985423490&GSMID=OAMS")
print(response)