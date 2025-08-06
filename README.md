# linux-integrity-checker

Linux Bash Script for Monitoring /bin and /sbin Integrity
Overview
This project implements a Linux Bash script designed to ensure the integrity of critical system directories: /bin and /sbin. These directories contain essential binaries required for system operation, and unauthorized modifications can pose significant security risks. This tool helps system administrators detect such changes immediately and take necessary action.

Developed as part of the COMP301-A "Introduction to Linux" course under the supervision of Dr. Abbas Madi.

Features
🛡️ Integrity Verification using SHA256 hashing.

⚠️ Detection of Unauthorized Modifications to /bin and /sbin.

🔐 User Prompt for Action if modifications are found (e.g., shutdown).

✅ Automated Hash Storage and Comparison.

🔁 Runs After User Login (can be added to .bashrc or systemd user service).

🌍 Lightweight and Fast.

🌐 Multilingual-friendly Script Output (easily adaptable).

How It Works
Initial Setup:

The script calculates and stores the SHA256 hashes of all files in /bin and /sbin.

These are saved in files: old_hash_bin.txt and old_hash_sbin.txt.

Hash Comparison on Startup:

On each login, the script recalculates hashes and compares them with stored values.

If discrepancies are found, it assumes potential tampering.

User Interaction:

If modification is detected, the user is alerted.

The user can choose to:

Shutdown the system immediately.

Continue with a warning about possible risks.

No Changes Detected:

A success message is displayed to assure the user that the system is intact.

Usage
Clone the repository:

bash
Copy
Edit
git clone https://github.com/yourusername/linux-integrity-checker.git
cd linux-integrity-checker
Make the script executable:

bash
Copy
Edit
chmod +x check_integrity.sh
Run the script manually or add it to your login sequence:

bash
Copy
Edit
./check_integrity.sh
Optionally, configure as a service for automatic checks on startup.
