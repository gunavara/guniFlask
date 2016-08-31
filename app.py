# -*- coding: utf-8 -*-
from flask import Flask, render_template, url_for, request, redirect, session, flash
from functools import wraps
import MySQLdb, gc, datetime
from passlib.hash import sha256_crypt
from MySQLdb import escape_string as thwart
import encodings
#APP CONFIGUTATION
app = Flask(__name__)
app.config['SECRET_KEY'] = 'hard_string'
db = MySQLdb.connect("localhost", "root", "guni123","test")
# SET DATABASE INPUT UTF8------------------------
db.set_character_set('utf8')
# SET DATABASE INPUT UTF8------------------------
cur = db.cursor()

def loginrequired(f):
    @wraps(f)
    def wrap(*args, **kwargs):
        if 'logged_in' in session:
            return f(*args, **kwargs)
        else:
            flash("You need to login first")
            return redirect(url_for('login_page'))
    return wrap 
 
 
@app.route("/")
def index():   
    return render_template('login.html')

@app.route("/dashboard")
@loginrequired
def dashboard():
    username = session['username']
    mydate = datetime.datetime.now()
    date = mydate.strftime("%d")
    month = mydate.strftime("%B")
    year = mydate.strftime("%Y")  
    return render_template("dashboard.html", username=username, date=date, month=month, year=year)

@app.route("/registration")
def registration():
    return render_template("register.html")

@app.route("/register_user", methods=["POST"])
def register_user():
    try:
        if request.method == "POST":                        
            username = request.form['username']
            password = sha256_crypt.encrypt(request.form['password'])
            email = request.form['email']
            x = cur.execute("SELECT * FROM users WHERE username = '%s'" % (thwart(username)))
            if int(x) > 0:
                error = "That username is already taken, please choose another"                
                return render_template('register.html', error=error)                        
            else:
                reguser = "INSERT INTO users (username, password, email) VALUES ('%s', '%s', '%s')" % (username, password, email)                
                cur.execute(reguser)
                db.commit()
                gc.collect()        
                session['logged_in'] = True
                session['username'] = request.form['username']       
                return redirect(url_for("dashboard"))    
            #return render_template("register.html")
    except Exception as e:
        return(str(e))        
    
@app.route("/login", methods=['POST'])   
def login_page():
    error = ''
    try:
        data = cur.execute("SELECT * FROM (users) WHERE (username) = '%s'" % thwart(request.form['username']))    
        data = cur.fetchone()[2]        
        if sha256_crypt.verify(request.form['password'], data):
            session['logged_in'] = True
            session['username'] = request.form['username']
            flash("You are now logged in")
            return redirect(url_for("dashboard"))
        else:
            error = "Invalid credentials, try again."   
        gc.collect()
        return render_template("login.html", error=error)        
    except Exception as e:
        flash(e)
        error = "Please enter your credentials"
        return render_template("login.html", error = error)  
    
@app.route("/logout/")
@loginrequired
def logout():
    session.clear()
    flash("You have been logged out!")
    gc.collect()
    return redirect(url_for('index'))


@app.route("/razhodi", methods=['POST', 'GET'])
@loginrequired
def razhodi():
    username = session['username']
    if request.method == "POST":
        return redirect(url_for('razhodi'))
    else: 
        qry = "SELECT razhod FROM razhodi"
        cur.execute(qry)
        data = cur.fetchall()
        gc.collect()
        
        return render_template("razhodi.html", username=username, data=data)

#DOBAVQNE NA TIP RAZHOD KUM BAZA DANNI
@app.route("/dobavqnenarazhod", methods=['POST', 'GET'])
@loginrequired
def razhod_add():
    try:
        vidrazhod = request.form['razhod']        
        x = cur.execute("SELECT razhod FROM (razhodi) WHERE (razhod) = '%s'" % vidrazhod)                 
        if int(x) > 0:
            error = "Вече има такъв тип разход."                
            return redirect(url_for('razhodi'))
        else:        
            addrazhodqry = ("INSERT INTO razhodi (razhod) VALUES ('%s')" % vidrazhod)
            cur.execute(addrazhodqry)                
            db.commit()
            gc.collect()
            
        return redirect(url_for('razhodi'))
    except Exception as e:
        return(str(e))      

#NOVO PLASHTANE FORMA
@app.route("/plashtane", methods=['POST', 'GET'])
@loginrequired
def novoplashtane():
    username = session['username']
    razhodi = "SELECT razhod FROM razhodi"
    cur.execute(razhodi)
    data = cur.fetchall()
    gc.collect()       
    if request.method == "GET":
        flash("Успешно добавяне")
    return render_template("novoplashtane.html", username=username, data=data)


 
#NOVO PLASHTANE KUM BAZA DANNI
@app.route("/novoplashtane_send", methods=['POST', 'GET'])
@loginrequired
def novoplastane_send():
    if request.method == "POST":
        username = session['username']
        user_id = "SELECT id FROM users WHERE username = '%s'" % username
        cur.execute(user_id)
        data = cur.fetchone()
        user_id = data[0]
        
                
        tiprazhod = request.form['tiprazhod']
        razhod_id = "SELECT id FROM razhodi WHERE razhod = '%s'" % tiprazhod
        cur.execute(razhod_id)
        datarazhod = cur.fetchone()
        razhod_id = datarazhod[0]
        
        razhod_name = "SELECT razhod FROM razhodi WHERE id = '%s'" % razhod_id
        cur.execute(razhod_name)
        razhod_name = cur.fetchone()[0]
        suma = request.form['suma']
        date_posted = datetime.datetime.now()
       
        addplashtane = ("INSERT INTO potrebitelski_razhodi (user_id, user_name, razhod_id, razhod_name, date_posted, suma_razhod) VALUES ('%s', '%s', '%s', '%s', '%s', '%s')" % (user_id, username, razhod_id, razhod_name, date_posted, suma))
        cur.execute(addplashtane)                
        db.commit()
        gc.collect()
        
        return redirect(url_for("novoplashtane"))
    else:
        return "GRESHKA"
    #return redirect(url_for("razhodi", user_id=user_id, razhod_id=razhod_id, suma=suma, username=username))


@app.route("/spravka")
@loginrequired
def spravka():
    username = session['username']
    gc.collect()
    qry = "SELECT * FROM potrebitelski_razhodi"
    cur.execute(qry)
    data = cur.fetchall()
    
    

    return render_template("spravka.html", username=username, data=data)






if __name__ == "__main__":
    import sys
    if sys.version_info.major < 3:
        reload(sys)
        sys.setdefaultencoding('utf8')   
    app.run(debug=True,host='0.0.0.0')