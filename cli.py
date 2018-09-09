import mysql.connector 
import getpass


def cli_main():
    #Configure mysql connection
    cnx = mysql.connector.connect(user='root', password='', host='127.0.0.1', database='eshop')

    try:
        #Instantiate cursor used by the mysql connector. 
        cursor = cnx.cursor()
        while(True):
            #Select the view
            while(True):
                try:
                    view_selection = int(input("Type 0 to exit, 1 for Guest View, 2 for Customer View and 3 for Admin View.\n"))
                    if view_selection in [1, 2, 3]:
                        break
                    elif view_selection == 0:
                        exit()
                    else:
                        continue
                except ValueError:
                    print("Type an integer: 0, 1, 2 or 3!")

            if view_selection == 1:
            # Guest VIEW 
                #Select whether user wants to see any product or reggister as Customer
                try:
                    guest_view_selection = int(input("Type 1 for Products View or 2 for Reggister"))
                except ValueError:
                    print("Type an integer: 1 or 2!")
                if guest_view_selection == 1:
                    product_selection(cursor) 

                elif guest_view_selection == 2:
                    cust_name = input("What is your Name, new Customer?\n")
                    cust_sur_name = input("What is your Surname, new Customer?\n")
                    cust_email = input("What is your E-mail, new Customer?\n")
                    cust_phone = input("What is your phone number?\n")

                    #Inserting new Customer in DB
                    cursor.execute("""INSERT INTO `Customer` VALUES(NULL,"{0}", "{1}", "{2}", "{3}", DEFAULT)""".format(cust_name, cust_sur_name, cust_email, cust_phone))
                    cnx.commit()

            elif view_selection == 2:
            #Customer View 
                #call login funcitons and get the returned dict
                cust_login = customer_login(cursor, "Customer")
                if cust_login['result'] == 'success':
                    customer_view_selection = int(input("Type 1 for Products View or 2 to see Points Available and 3 to place new Order\n"))
                    if customer_view_selection == 1:
                        #Select product from db
                        product_selection(cursor)
                    if customer_view_selection == 2:
                        #See points available
                        cursor.execute("""SELECT `Points Available` FROM `Customer Card` INNER JOIN `Customer` ON `Customer`.`ID`=`Customer Card`.`Customer_id` WHERE  `Customer Card`.`Customer_id`={0}""".format(cust_login['customer_id']))
                        result = cursor.fetchall()
                        print(result)
                    if customer_view_selection == 3:
                        #Place new Order
                        cursor.execute(""" INSERT INTO `Order` VALUES(NULL, {0}, {1}, {2} , {3}, {4}, {5}, {6}, {7}, {8}, {9}, NULL, {10}, NULL)""".format(
                            cust_login['user_id'], input("CPU Model or NULL\n"), input("Motherboard Model or NULL\n"), input("RAM Model or NULL\n"),
                            input("GPU Model or NULL\n"), input("PSU Model or NULL\n"), input("Case Model or NULL\n"), input("SSD Model or NULL\n"),
                            input("HDD Model or NULL\n"), input("External HD Model or NULL\n"), input("If products are gonna be used together type 1 else 0\n")))
                        cnx.commit()
                
            elif view_selection == 3:
            #Admin View
                admin_login = user_login(cursor, "Administrator")
                if admin_login['result'] == 'success':
                    while(True):
                        try:
                            admin_view_selection = int(input("Type 1 to View all Orders, 2 to delete a Customer and 3 to see the Queries\n"))
                            if admin_view_selection in [1, 2, 3]:
                                break
                        except ValueError:
                            print("Type an integer: 1 or 2!")
                    
                    if admin_view_selection == 1:
                    #See all Orders
                        cursor.execute("""select * from `Order`""")
                        result = cursor.fetchall()
                        print(result)

        
    finally:
        cnx.close()

def product_selection(cursor):
    """ User inputs the product and the corrisponding table in db gets printed """
    while(True):
        pruduct_select = input("Which product would you like to see? Type exit to exit products view.\n")
        if pruduct_select in ['CPU', 'GPU', 'RAM', 'Motherboard', 'PSU', 'SSD', 'HDD', 'External HD', 'Case']:
            #selecting product table from DB
            cursor.execute("""select * from `{}` """.format(pruduct_select))
            result = cursor.fetchall()
            print(result)
        elif pruduct_select == 'exit':
            return

def user_login(cursor, type):
    """ User inputs username and pass and returns dictionary containing user ID and whether validation was successful"""
    while(True):
        validation = 0
        #Login 
        #username is his ID and pass is his username field.
        username=input("Type your username\n")
        password = getpass.getpass('Password:\n')
        #check if customer username and pass exists
        cursor.execute("""SELECT * FROM `{1}` WHERE ID={0}""".format(username, type))
        if cursor.fetchall():
            validation += 1
            print("Valid Username")
        cursor.execute("""SELECT * FROM `{2}` WHERE `Name`="{0}" AND `ID`={1}""".format(password, username, type))
        if cursor.fetchall():
            validation += 1
            print("Valid Pass")
        if validation == 2:
            return {'user_id': username, 
                    'result': 'success'}


cli_main()