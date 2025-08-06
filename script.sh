#!/bin/bash

# Path to the file storing the old hash value
OLD_HASH_BIN="/old_hash_bin.txt"
OLD_HASH_SBIN="/old_hash_sbin.txt"

echo "$OLD_HASH_BIN"
# Calculate the current hash of /bin directory
sha256sum /bin/* |awk '{print $1}'> /all_hash_bin
sha256sum /all_hash_bin |awk '{print $1}' > /current_hash_bin

echo "$OLD_HASH_SBIN"
# Calculate the current hash of /sbin directory
sha256sum /sbin/* |awk '{print $1}'> /all_hash_sbin
sha256sum /all_hash_sbin |awk '{print $1}' > /current_hash_sbin

echo " "
# Check if the old hash file exists
if  [ -f "$OLD_HASH_BIN" ] && [ -f "$OLD_HASH_SBIN" ] ; then


modified=false

  # Read the old hash value from the file
#cat "$OLD_HASH_BIN"
  old_hash_bin=$(cat "$OLD_HASH_BIN")
  old_hash_sbin=$(cat "$OLD_HASH_SBIN")
  current_hash_bin=$(cat "/current_hash_bin")
  current_hash_sbin=$(cat "/current_hash_sbin")
  
  

  # Compare the current and old hash values for bin
  if [ -z "$(diff /old_hash_bin.txt /current_hash_bin)" ]; then
    echo "Hash of bin unchanged. No modifications detected."
    echo "Old hash: $old_hash_bin"
    echo "New hash: $current_hash_bin"
   diff -Nur /old_hash_bin.txt /current_hash_bin > /patchbin
 
  else
     modified=true
     echo "Hash of bin changed. Modifications detected."
     echo "Old hash: $old_hash_bin"
     echo "New hash: $current_hash_bin"
    diff -Nur /old_hash_bin.txt /current_hash_bin > /patchbin
  fi

echo " "
   # Compare the current and old hash values for sbin
  if [ -z "$(diff /old_hash_sbin.txt /current_hash_sbin)" ]; then
     echo "Hash of sbin unchanged. No modifications detected."
     echo "Old hash: $old_hash_sbin"
     echo "New hash: $current_hash_sbin"
    diff -Nur /current_hash_sbin /old_hash_sbin.txt > /patchsbin
    
  else
     modified=true
     echo "Hash of sbin changed. Modifications detected."
     echo "Old hash: $old_hash_sbin"
     echo "New hash: $current_hash_sbin"
    diff -Nur /current_hash_sbin /old_hash_sbin.txt > /patchsbin
  fi

else
  # If the old hash file doesn't exist, create it and store the current hash
  sha256sum /all_hash_bin |awk '{print $1}' > "$OLD_HASH_BIN"
  sha256sum /all_hash_sbin |awk '{print $1}'> "$OLD_HASH_SBIN"
  
  echo "Old hash file not found. Created a new one with the current hash."
fi
echo " "



if [ $modified == true ]; then

  echo "CRITICAL: Some files have been modified! Do you want to shutdown the system?(y/n)"
  read Choice
  if [ $Choice = 'y' ]; then
    echo "The System will shutdown in 5 sec."
    sleep 10
    shutdown -h now
  elif [ $Choice = 'n' ]; then
    echo -e "Working on a system that failed an integrity check can have a number of negative effects and impacts\n- Highest Risk: Security breaches, complete system crashes.\n- High Risk: Working with bad data.\n- Medium Risk: System instability.\n- Lower Risk: Wasted time troubleshooting."
    echo " "
    echo "Are you sure you want to proceed working on the system?(y/n)"
    read Sure
    
    if [ $Sure = 'y' ]; then
      echo "BE CAREFULL OF THE CONSEQUENCES!"
    elif [ $Sure = 'n' ]; then
      echo "The System will shutdown in 5 sec"
      sleep 10
      shutdown -h now
    fi
  fi    
elif [ $modified == false ]; then
  echo -e "Integrity check completed, no changes detected.\nThe system is safe."
fi

echo " "
read -n 1 -s -r -p "press any key to continue"
#linux project
#ahmad
