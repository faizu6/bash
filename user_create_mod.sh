#!/bin/bash

echo  "press 1 to create a new user"
echo "press 2 to change password of an existing user"
echo "press 3 to delete a user"
read -p "Please enter number from above choice:" Entry

if [ $Entry -eq 1 ]; then
        read -p "please enter the user name: " user
         if [ -z "$user" ]; then
               echo "username can't be empty"
               exit 1

         else
               cat /etc/passwd | grep -i $user
               if [ $? == 0 ]; then
                   echo "user already exists"

               else
                   useradd $user
                   passwd $user
                   if [ $? == 0 ]; then
                      echo "user successfully created"

                   else
                      echo "please enter a valid password"
                      exit 1
                   fi
               fi
         fi

elif [ $Entry -eq 2 ]; then
        read -p "please enter the user for password change: " existing
         if [ -z "$existing" ]; then
               echo "username can't be empty"
               exit 1

         else
               sudo passwd $exiting
         fi

elif [ $Entry -eq 3 ]; then
        read -p "please enter the user name to be deleted: " user2
         if [ -z "$user2" ]; then
               echo "username can't be empty"
               exit 1
         else
               cat /etc/passwd | grep -i $user2
               RC=$?
               if [ $? == 0 ]; then
                   echo "user found"
                   userdel -r $user2
                   RC=$?
                   if [ $? == 0 ]; then
                         echo "user successfully deleted"
                   else
                         echo "user not deleted"
                         exit 1
                   fi
               else
                   echo "user not found"
                   exit 1
               fi
         fi
else
        echo "use only digit 1 or 2"
        exit 1
fi
