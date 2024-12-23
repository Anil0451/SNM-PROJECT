from flask import Flask,request,render_template,redirect,url_for,flash,session,send_file
import mysql.connector
from otp import genotp
from cmail import sendmail
from stoken import encode,decode
from flask_session import Session
from io import BytesIO
import flask_excel as excel
app=Flask(__name__)
excel.init_excel(app)
app.config['SESSION_TYPE']='filesystem'
app.secret_key = 'DRta@1704'
mydb=mysql.connector.connect(host='localhost',user='root',password='Admin',db='snpproject')
@app.route('/')
def home():
    return render_template('welcome.html')
@app.route('/create',methods=['GET','POST'])
def create():
    if request.method=='POST':
            print(request.form)
            userid=request.form['user id']
            username=request.form['user name']
            email=request.form['email']
            password=request.form['password']
            confirmpassword=request.form['confirm password']
            cursor=mydb.cursor()
            cursor.execute('select count(useremail) from users where useremail=%s',[email])
            result=cursor.fetchone()
            print(result)
            if result[0]==0:
                gotp=genotp()
                udata={'username':username,'useremail':email,'password':password,'otp':gotp}
                print(gotp)
                subject='OTP For Simple Notes Manager'
                body=f'otp for registration of Simple notes manager {gotp}'
                sendmail(to=email,subject=subject,body=body)
                flash('OTP has sent to given Mail')
                return redirect(url_for('otp',enudata=encode(data=udata)))
            elif result[0]>0:
                flash('Email already existed')
                return redirect(url_for('login'))
            else:
                return 'something wrong'
    return render_template('create.html')
@app.route('/otp/<enudata>',methods=['GET','POST'])
def otp(enudata):
    if request.method=='POST':
            uotp=request.form['OTP']
            try:
                dudata=decode(data=enudata)
            except Exception as e:
                print(e)
                return 'Something went wrong'
            else:
                if dudata['otp']==uotp:
                    cursor=mydb.cursor()
                    cursor.execute('insert into users(username,useremail,password) values(%s,%s,%s)',[dudata['username'],dudata['useremail'],dudata['password']])
                    mydb.commit()
                    cursor.close()
                    flash('Registration Successfull')
                    return redirect(url_for('login'))
                else:
                    return 'otp was wrong please register again'
    return render_template('otp.html')
@app.route('/login',methods=['GET','POST'])
def login():
    if not session.get('user'):
        if request.method=='POST':
            email=request.form['email']
            password=request.form['password']
            cursor=mydb.cursor(buffered=True)
            cursor.execute('select count(useremail) from users where useremail=%s',[email])
            bdata=cursor.fetchone() #(1,) or (0,)
            if bdata[0]==1:
                cursor.execute('select password from users where useremail=%s',[email])
                bpassword=cursor.fetchone() #(0x31323334000000000000,)
                if password==bpassword[0].decode('utf-8'):
                    session['user']=email
                    print(session)
                    return redirect(url_for('dashboard'))
                else:
                    flash('password was wrong')
                    return redirect(url_for('login'))
            elif bdata[0]==0:
                flash('Email not existed')
                return redirect(url_for('create'))
            else:
                return 'something went wrong'
        return render_template('login.html')
    else:
        return redirect(url_for('dashboard'))
@app.route('/dashboard')
def dashboard():
    if session.get('user'):
         return render_template('dashboard.html')
    else:
        return redirect(url_for('login'))
@app.route('/addnotes',methods=['POST',"GET"])
def addnotes():
    if session.get('user'):

        if request.method=='POST':
            title=request.form['title']
            description=request.form['Description']
            cursor=mydb.cursor(buffered=True)
            cursor.execute('select user_id from users where useremail=%s',[session.get('user')])
            uid=cursor.fetchone()
            print(uid)
            if uid:
                try:
                    cursor.execute('insert into notes(title,ndescription,user_id) values(%s,%s,%s)',[title,description,uid[0]])
                    mydb.commit()
                    cursor.close()
                except mysql.connector.errors.IntegrityError:
                    print(e)
                    flash('Duplicate Title Entry')
                    return redirect(url_for('dashboard'))
                except mysql.connector.errors.ProgrammingError:
                    flash('could not add notes')
                    print(mysql.connector.errors.ProgrammingError)
                    return redirect(url_for('dashboard'))
                else:
                    flash('notes added successfully')
                    return redirect(url_for('dashboard'))
            else:
                return 'something is wrong'
        return render_template('addnotes.html')
    else:
        return redirect(url_for('login'))
@app.route('/view_all_notes')
def view_all_notes():
    if session.get('user'):
        cursor=mydb.cursor(buffered=True)
        cursor.execute('select user_id from users where useremail=%s',[session.get('user')])
        user_id=cursor.fetchone()
        cursor.execute('select nid,title,create_at from notes where user_id=%s',[user_id[0]])
        ndata=cursor.fetchall()
        return render_template('view_all_notes.html',ndata=ndata)
    else:
        return redirect(url_for('login'))
@app.route('/view/<nid>')
def view(nid):
    if session.get('user'):
        try:
            cursor=mydb.cursor(buffered=True)
            cursor.execute('select * from notes where nid=%s',[nid])
            ndata=cursor.fetchone()
        except Exception as e:
            print(e)
            flash('No data found')
            return redirect(url_for('dashboard'))
        else:
            return render_template('view.html',ndata=ndata)
    else:
        return redirect(url_for('login'))
@app.route('/update_notes/<nid>',methods=['GET','POST'])
def update_notes(nid):
    if session.get('user'):
        cursor=mydb.cursor(buffered=True)
        cursor.execute('select * from notes where nid=%s',[nid])
        ndata=cursor.fetchone()
        if request.method=='POST':
            title=request.form['title']
            description=request.form['Description']
            cursor=mydb.cursor(buffered=True)
            cursor.execute('update notes set title=%s,ndescription=%s where nid=%s',[title,description,nid])
            mydb.commit()
            cursor.close()
            flash('Notes Are Upadated Successfully')
            return redirect(url_for('view',nid=nid))
        return render_template('update_notes.html',ndata=ndata)
    else:
        return redirect(url_for('login'))
@app.route('/delete/<nid>')
def deletenotes(nid):
    if session.get('user'):
        try:
            cursor=mydb.cursor(buffered=True)
            cursor.execute('delete from notes where nid=%s',[nid])
            mydb.commit()
            cursor.close()
        except Exception as e:
            print(e)
            flash('could not delete the notes')
            return redirect(url_for('viewallnotes'))
        else:
            flash('Notes deleted successfully')
            return redirect(url_for('view_all_notes'))
    else:
        return redirect(url_for('login'))
@app.route('/upload_files',methods=['GET','POST'])
def uploadfile():
    if session.get('user'):
        if request.method=='POST':
            filedata=request.files['file']
            fname=filedata.filename
            fdata=filedata.read()
            print(fdata)
            try:
                cursor=mydb.cursor(buffered=True)
                cursor.execute('select user_id from users where useremail=%s',[session.get('user')])
                uid=cursor.fetchone()
                cursor.execute('insert into filedata(filename,fdata,added_by) values(%s,%s,%s)',[fname,fdata,uid[0]])
                mydb.commit()
            except Exception as e:
                print(e)
                flash("can't upload file")
                return redirect(url_for('dashboard'))
            else:
                flash('file upload succesafully')
                return redirect(url_for('dashboard'))
        return render_template('upload_files.html')
    else:
        return redirect(url_for('login'))
@app.route('/allfiles')
def allfiles():
    if session.get('user'):
        try:
            cursor=mydb.cursor(buffered=True)
            cursor.execute('select user_id from users where useremail=%s',[session.get('user')])
            uid=cursor.fetchone()
            cursor.execute('select fid,filename,created_at from filedata where added_by=%s',[uid[0]])
            filesdata=cursor.fetchall()
        except Exception as e:
            print(e)
            flash('No data found')
            return redirect(url_for('dashboard'))
        else:
            return render_template('allfiles.html',filesdata=filesdata)
    else:
        return redirect(url_for('login'))
@app.route('/viewfile/<fid>')
def viewfile(fid):
    try:
        cursor=mydb.cursor(buffered=True)
        cursor.execute('select filename,fdata from filedata where fid=%s',[fid])
        fdata=cursor.fetchone()
        bytes_data=BytesIO(fdata[1])
        return send_file(bytes_data,download_name=fdata[0],as_attachment=False)
    except Exception as e:
        print(e)
        flash("couldn't open file")
        return redirect(url_for('dashboard'))

@app.route('/downloadfile/<fid>')
def downloadfile(fid): 
    try:
        cursor=mydb.cursor(buffered=True)
        cursor.execute('select filename,fdata from filedata where fid=%s',[fid])
        fdata=cursor.fetchone()
        bytes_data=BytesIO(fdata[1])
        return send_file(bytes_data,download_name=fdata[0],as_attachment=True)
    except Exception as e:
        print(e)
        flash("couldn't open file")
        return redirect(url_for('dashboard'))
@app.route('/deletefile/<fid>')
def deletefile(fid):
    try:
        cursor=mydb.cursor(buffered=True)
        cursor.execute('delete from filedata where fid=%s',[fid])
        mydb.commit()
        cursor.close()
    except Exception as e:
        print(e)
        flash('could not delete the file')
        return redirect(url_for('viewallfiles'))
    else:
        flash('file deleted successfully')
        return redirect(url_for('allfiles'))
@app.route('/getexceldata')
def getexceldata():
    try:
        cursor=mydb.cursor(buffered=True)
        cursor.execute('select user_id from users where useremail=%s',[session.get('user')])
        user_id=cursor.fetchone()
        cursor.execute('select nid,title,description,create_at from notes where user_id=%s',[user_id[0]])
        ndata=cursor.fetchall()
    except Exception as e:
        print(e)
        flash('No data found')
        return redirect(url_for('dashboard'))
    else:
        array_data=[list(i) for i in ndata]
        columns=['Notes id','Title','Content','Created_Time']
        array_data.insert(0,columns)
        return excel.make_response_from_array(array_data,'xlsx',filename='notesdata')
@app.route('/search',methods=['GET','POST'])
def search():
    if session.get('user'):
        try:
            if request.method=='POST':
                sdata=request.form['search']
                strg=['A-Za-z0-9']
                pattern=re.compile(f'^{strg}',re.IGNORECASE)
                if (pattern.match(sdata)):
                    cursor=mydb.cursor(buffered=True)
                    cursor.execute('select * from notes where nid like %s or title like %s or description like %s or create_at like %s',[sdata+'%',sdata+'%',sdata+'%',sdata+'%'])
                    sdata=cursor.fetchall()
                    cursor.close()
                    return render_template('dashboard.html',
                    sdata=sdata)
                else:
                    flash('No Data found')
                    return redirect(url_for('dashboard'))
            else:
                return redirect(url_for('dashboard'))
        except Exception as e:
            print (e)
            flash("can't find anything")
            return redirect(url_for('dashboard'))
    else:
        return redirect(url_for('login'))

app.run(use_reloader=True,debug=True)