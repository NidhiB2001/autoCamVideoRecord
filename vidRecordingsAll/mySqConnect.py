import mysql.connector
from mysql.connector import Error

data = []
devc = {'Cam_Devices': data}

def connect():
    """ Connect to MySQL database """
    connection = None
    try:
        connection = mysql.connector.connect(host='localhost',
                                       database='facial',
                                       user='admin',
                                       password='sqlmy')
        if connection.is_connected():
            db_Info = connection.get_server_info()
            print("Connected to MySQL Server version ", db_Info)
            cursor = connection.cursor()
            cursor.execute("select database();")
            record = cursor.fetchone()
            print("You're connected to database: ", record)

            mycursor = connection.cursor()
            mycursor.execute("SELECT * FROM device_master")

            myresult = mycursor.fetchall()
            for x in myresult:
                print('myresult', myresult)
                mycursor.execute(f"SELECT sdc_name FROM sdc_master where sdc_id={x[2]}")
                sdc_name = mycursor.fetchall()
                print('sdc_name>>>,', sdc_name)
                data.append({
                                'device_id': x[0],
                                'tp_id': x[1],
                                'sdc_id': x[2],
                                'device_link': x[5],
                                'sdc_name': sdc_name[0][0]
                            })
                
        if connection.is_connected():
            cursor.close()
            connection.close()
            print("MySQL connection is closed")
        return devc
    except Exception as e:
        print("Error while connecting to MySQL", e)

if __name__ == '__main__':
    connect()
