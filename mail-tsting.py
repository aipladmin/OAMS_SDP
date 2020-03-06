from flask import Flask
from flask_mail import Mail, Message
import string
from random import *
import random

app =Flask(__name__)
mail=Mail(app)

app.config['MAIL_SERVER']='smtp.gmail.com'
app.config['MAIL_PORT'] = 465
app.config['MAIL_USERNAME'] = 'developer.websupp@gmail.com'
app.config['MAIL_PASSWORD'] = 'PRLvikramsarabhairoom'
app.config['MAIL_DEFAULT_SENDER'] = 'developer.websupp@gmail.com'
app.config['MAIL_USE_TLS'] = False
app.config['MAIL_USE_SSL'] = True
mail = Mail(app)

@app.route("/")
def index():
	s = "abcdefghijklmnopqrstuvwxyz01234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	passlen = 8
	password =  "".join(random.sample(s,passlen ))
	msg = Message('Verification of Email', sender = 'developer.websupp@gmail.com', recipients = ['parikh.madhav1999@gmail.com'])
	# msg.bodyy = "Hello Flask message sent from Flask-Mail"
	msg.html = ''' <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- If you delete this tag, the sky will fall on your head -->
<meta name="viewport" content="width=device-width" />

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>ZURBemails</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">

<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<!-- Popper JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

<!-- Latest compiled JavaScript -->

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>

<link rel="stylesheet" type="text/css" href="stylesheets/email.css" />
<link rel="stylesheet" type="text/css" 
href="https://googledrive.com/host/1dgE80Mi-QktN66f6LHE38Sh9PI6e-6go/email.css" />
</head>
 
<body bgcolor="#FFFFFF">

<!-- HEADER -->
<table class="head-wrap" bgcolor="#999999">
	<tr>
		<td></td>
		<td class="header container">
			
				<div class="content">
					<table>
					<tr>
						<td><a href="https://imgbb.com/"><img src="https://i.ibb.co/KGz7m4h/logo.jpg" alt="logo" border="0" height="50px"  width="50px"></a></td>
						<!--<td align="right"><h6 class="collapse">Hero</h6></td>-->
					</tr>
				</table>
				</div>
				
		</td>
		<td></td>
	</tr>
</table><!-- /HEADER -->


<!-- BODY -->
<table class="body-wrap">
	<tr>
		<td></td>
		<td class="container" bgcolor="#FFFFFF">

			<div class="content">
			<table>
				<tr>
					<td>
						
						<h3>Welcome, Udham Singh</h3>
						<h3 class="lead">OAMS</h3>
						
						<!-- A Real Hero (and a real human being) 
						<p><img src="http://placehold.it/600x300" /></p> --><!-- /hero -->
						
						<!-- Callout Panel -->
						<!--<p class="callout">
							Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt. <a href="#">Do it Now! &raquo;</a>
						</p>--><!-- /Callout Panel -->
						
						<h3>Please visit this link to verify email.</h3> 
						<a href="#" class="btn btn-info" role="button">Verify Email</a><br/>
						<small>For further queries please contact the email mentioned below.</small></h3>
						<!--<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>-->	
						<!--<a class="btn">Click Me!</a>-->
												
						<br/>
						<br/>							
												
						<!-- social & contact -->
						<table class="social" width="100%">
							<tr>
								<td>
									
									<!--- column 1 -->
									<table align="left" class="column">
										
									</table><!-- /column 1 -->	
									
									<!--- column 2 -->
									<table align="left" class="column">
										<tr>
											<td>				
																			
												<h5 class="">Contact Info:</h5>												
												<p>Phone: <strong>9998234434</strong><br/>
                Email: <strong><a href="emailto:developer.websupp@gmail.com">developer.websupp@gmail.com</a></strong></p>
                
											</td>
										</tr>
									</table><!-- /column 2 -->
									
									<span class="clear"></span>	
									
								</td>
							</tr>
						</table><!-- /social & contact -->
					
					
					</td>
				</tr>
			</table>
			</div>
									
		</td>
		<td></td>
	</tr>
</table><!-- /BODY -->

<!-- FOOTER -->
<table class="footer-wrap">
	<tr>
		<td></td>
		<td class="container">
			
				<!-- content -->
				<div class="content">
				<table>
				<tr>
					<td align="center">
						<p>
							<a href="#">Terms</a> |
							<a href="#">Privacy</a> |
							<a href="#"><unsubscribe>Unsubscribe</unsubscribe></a>
						</p>
					</td>
				</tr>
			</table>
				</div><!-- /content -->
				
		</td>
		<td></td>
	</tr>
</table><!-- /FOOTER -->

</body>
</html>	 '''
	mail.send(msg)
	return "Sent"

if __name__ == '__main__':
   app.run(debug = True)